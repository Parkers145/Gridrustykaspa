# Stage 1: Build Stage for Rusty-Kaspa and API
FROM rust:latest AS builder

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/root/.cargo/bin:$PATH"
ENV PROTOC=/usr/bin/protoc

# Install build dependencies
RUN apt-get update && apt-get install -y \
    git cmake libssl-dev pkg-config libclang-dev \
    protobuf-compiler libprotobuf-dev

# Clone and build rusty-kaspa from kaspanet repository
RUN git clone https://github.com/kaspanet/rusty-kaspa.git /rusty-kaspa

# Clone and build the API from your GitHub repository
RUN git clone --branch api https://github.com/parkers145/Gridrustykaspa.git /rusty-kaspa/Gridrustykaspa

# Update Cargo.toml to include API in workspace
RUN sed -i '/\[workspace\]/a members = ["Gridrustykaspa/api"]' /rusty-kaspa/Cargo.toml

# Build the whole workspace including kaspad and API
WORKDIR /rusty-kaspa
RUN cargo build --release

# Stage 2: Runtime Stage
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install runtime dependencies
RUN apt-get update && apt-get install -y \
    openssh-server avahi-daemon avahi-utils libnss-mdns ca-certificates curl wget sudo && \
    rm -rf /var/lib/apt/lists/*

# Copy built binaries from builder stage
COPY --from=builder /rusty-kaspa/target/release/kaspad /usr/local/bin/kaspad
COPY --from=builder /rusty-kaspa/Gridrustykaspa/api/target/release/api /usr/local/bin/api

# Install Zinit
RUN curl -fsSL https://github.com/threefoldtech/zinit/releases/download/v0.2.0/zinit-x86_64-unknown-linux-gnu.tar.gz | tar -xz -C /usr/local/bin

# Copy Zinit configurations and start scripts
COPY zinit /etc/zinit

# Copy avahi-daemon configuration
COPY avahi-daemon.conf /etc/avahi/avahi-daemon.conf
COPY kaspa.service /etc/avahi/services/kaspa.service

# Copy SSH init script
COPY ssh-init.sh /usr/bin/ssh-init.sh
RUN chmod +x /usr/bin/ssh-init.sh

# Expose necessary ports
EXPOSE 80 16110 16111 22

# Use Zinit as the init system
CMD ["zinit", "init"]
