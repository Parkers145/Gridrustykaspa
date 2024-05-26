# Dockerfile Configuration and Management Guide

## Overview

This document provides a comprehensive guide on configuring, managing, and understanding the Dockerfile used in the GridRustyKaspa project. The Dockerfile is used to build a Docker image that includes all necessary components and binaries required for running the Kaspa full node, wallet, and related utilities.

## Table of Contents

1. [Dockerfile Stages](#dockerfile-stages)
   - [Stage 1: Builder](#stage-1-builder)
   - [Stage 2: Runtime](#stage-2-runtime)
2. [Building the Docker Image](#building-the-docker-image)
3. [Running the Docker Container](#running-the-docker-container)
4. [Exposed Ports](#exposed-ports)
5. [Configuration Files and Scripts](#configuration-files-and-scripts)
6. [Zinit Configuration](#zinit-configuration)
7. [Logs and Monitoring](#logs-and-monitoring)
8. [Troubleshooting](#troubleshooting)
9. [Appendix](#appendix)
   - [Useful Commands](#useful-commands)

## Dockerfile Stages

### Stage 1: Builder

The builder stage is responsible for setting up the build environment, installing dependencies, and compiling the binaries.

```dockerfile
FROM rust:latest AS kaspad-builder

ENV PATH="/root/.cargo/bin:$PATH"
ENV PROTOC=/usr/bin/protoc

# Install runtime dependencies
RUN apt-get update && apt-get install -y \
    curl git build-essential libssl-dev pkg-config \
    protobuf-compiler libprotobuf-dev \
    clang-format clang-tidy clang-tools clang clangd libc++-dev \
    libc++1 libc++abi-dev libc++abi1 libclang-dev libclang1 \
    liblldb-dev libllvm-ocaml-dev libomp-dev libomp5 lld lldb llvm-dev \
    llvm-runtime llvm python3-clang

# Update Rust and install wasm-pack
RUN rustup update && cargo install wasm-pack

# Add wasm32 target
RUN rustup target add wasm32-unknown-unknown

# Clone and build rusty-kaspa from kaspanet repository
RUN git clone https://github.com/kaspanet/rusty-kaspa.git /rusty-kaspa

# Install the Web Server to a temporary directory
WORKDIR /rusty-kaspa/wallet/wasm/web
RUN cargo install --root /tmp/basic-http-server basic-http-server

# Debug: List temporary directory to verify the binary installation
RUN ls -l /tmp/basic-http-server/bin

# Build the workspace including kaspad
WORKDIR /rusty-kaspa
RUN cargo build --release --bin kaspad

# Build the Kaspa Wallet
WORKDIR /rusty-kaspa/wallet/native
RUN cargo build --release --bin kaspa-wallet

# Build Rothschild
WORKDIR /rusty-kaspa/rothschild
RUN cargo build --release --bin rothschild

# Build Simpa
WORKDIR /rusty-kaspa/simpa
RUN cargo build --release --bin simpa

# Prep Opencl for GPU miner build
RUN apt-get install -y ocl-icd-opencl-dev
ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/lib:/lib:/usr/lib/x86_64-linux-gnu

# Clone and build GPU miner
WORKDIR /tmp/miner
RUN git clone https://github.com/tmrlvi/kaspa-miner.git
WORKDIR /tmp/miner/kaspa-miner
RUN cargo build --release -p kaspa-miner -p kaspaopencl
```

### Stage 2: Runtime

The runtime stage sets up the environment for running the pre-built binaries, including necessary dependencies and configuration files.

```dockerfile
FROM ubuntu:latest

# Update the package list and upgrade existing packages
RUN apt-get update && apt-get upgrade -y

# Install necessary packages
RUN apt-get install -y \
    openssh-server \
    avahi-daemon \
    avahi-utils \
    ca-certificates \
    curl \
    wget \
    sudo \
    libstdc++6 \
    libgcc1 \
    libc6 \
    libssl3

# Copy the application binary from the build stage
COPY --from=kaspad-builder /tmp/basic-http-server/bin/basic-http-server /usr/local/bin/basic-http-server
COPY --from=kaspad-builder /rusty-kaspa/target/release/kaspad /usr/local/bin/kaspad
COPY --from=kaspad-builder /rusty-kaspa/target/release/kaspa-wallet /usr/local/bin/kaspa-wallet
COPY --from=kaspad-builder /rusty-kaspa/target/release/rothschild /usr/local/bin/rothschild
COPY --from=kaspad-builder /rusty-kaspa/target/release/simpa /usr/local/bin/simpa
COPY --from=kaspad-builder /rusty-kaspa/wallet/wasm/web /app/web
COPY --from=kaspad-builder /tmp/miner/kaspa-miner/target/release/kaspa-miner /usr/local/bin/kaspa-miner
COPY --from=kaspad-builder /tmp/miner/kaspa-miner/target/release/libkaspaopencl.so /usr/local/bin/libkaspaopencl.so

# Create log directory
RUN mkdir -p /var/log

# Install Zinit
RUN curl -fsSL https://github.com/threefoldtech/zinit/releases/download/v0.2.14/zinit -o /usr/local/bin/zinit && chmod +x /usr/local/bin/zinit

# Copy Zinit configurations and start scripts
COPY zinit /etc/zinit

# Copy avahi-daemon configuration
COPY avahi-daemon.conf /etc/avahi/avahi-daemon.conf
COPY kaspa.service /etc/avahi/services/kaspa.service

# Copy SSH init script
COPY ssh-init.sh /usr/local/bin/ssh-init.sh
RUN chmod +x /usr/local/bin/ssh-init.sh
COPY monitor.sh /usr/local/bin/monitor.sh
RUN chmod +x /usr/local/bin/monitor.sh

# Expose necessary ports
EXPOSE 16110 16111 22 4000

# Use Zinit as the init system
ENTRYPOINT ["zinit", "init"]
```

## Building the Docker Image

To build the Docker image, use the following command:

```sh
docker build -t Gridrustykaspa .
```

This command will execute the instructions in the Dockerfile and create an image named `Gridrustykaspa`.

## Running the Docker Container

To run the Docker container, use the following command:

```sh
docker run --privileged -d -p 80:80 -p 16110:16110 -p 16111:16111 -p 22:22 Gridrustykaspa
```

This command will start the container in detached mode, mapping the necessary ports.

## Exposed Ports

- **16110**: Kaspa node peer-to-peer communication.
- **16111**: Kaspa node RPC server.
- **22**: SSH server.
- **4000**: Custom application port (if needed).

## Configuration Files and Scripts

- **`avahi-daemon.conf`**: Configuration for the Avahi daemon.
- **`kaspa.service`**: Service file for the Kaspa node.
- **`ssh-init.sh`**: Script to initialize the SSH server.
- **`monitor.sh`**: Script to monitor services.

## Zinit Configuration

Zinit is used as the process manager within the container. Configuration files for Zinit are located in the `/etc/zinit` directory.

Example Zinit configuration file (`/etc/zinit/kaspad.yaml`):

```yaml
exec: /usr/local/bin/kaspad --config /etc/kaspad/kaspad-config.yaml
log: stdout
```

To manage services using Zinit:

- **Start a service**:

  ```sh
  zinit start <service-name>
  ```

- **Stop a service**:

  ```sh
  zinit stop <service-name>
  ```

- **Restart a service**:

  ```sh
  zinit restart <service-name>
  ```

## Logs and Monitoring

Logs for services managed by Zinit are stored in the `/var/log` directory. To view the logs:

```sh
tail -f /var/log/<service-name>.log
```

## Troubleshooting

Here are some common issues and solutions:

- **Build errors**: Check the Dockerfile syntax and ensure all dependencies are correctly specified.
- **Service not starting**: Verify Zinit configuration files and ensure the binaries are correctly copied to the `/usr/local/bin` directory.
- **Connection issues**: Ensure the correct ports are exposed and mapped.

## Appendix

### Useful Commands

- **Build the Docker image**:

  ```sh
  docker build -t Gridrustykaspa .
  ```

- **Run the Docker container**:

  ```sh
  docker run --privileged -d -p 80:80 -p 16110:16110 -p 16111:16111 -p 22:22 Gridrustykaspa
  ```

- **Check running containers**:

  ```sh
  docker ps
  ```

- **Stop a running container**:

  ```sh
  docker stop <container-id>
  ```

- **Remove a stopped container**:

  ```sh
  docker rm <container-id>
  ```
