![GridRustyKaspa](./images/header.png)

# GridRustyKaspa

## Overview

GridRustyKaspa is a comprehensive project that provides a full implementation of the Kaspa blockchain, along with associated tools and utilities. This repository includes everything needed to run a Kaspa node, manage wallets, mine Kaspa, and interact with the blockchain through various services. It also supports deploying these components on the ThreeFold Grid using .flist files.

## Table of Contents

1. [Introduction](#introduction)
2. [Building the Docker Image](#building-the-docker-image)
3. [Running the Docker Container](#running-the-docker-container)
4. [Configuration Files](#configuration-files)
5. [Documentation](#documentation)
6. [Exposed Ports](#exposed-ports)
7. [Logs and Monitoring](#logs-and-monitoring)
8. [Converting Docker Image to .flist](#converting-docker-image-to-flist)
9. [Troubleshooting](#troubleshooting)
10. [Contributing](#contributing)
11. [License](#license)

## Introduction

GridRustyKaspa aims to provide a robust and scalable implementation of the Kaspa blockchain. This project includes the following components:

- **Kaspad**: The core node implementation for the Kaspa blockchain.
- **Kaspa Wallet**: A command-line tool for managing Kaspa wallets.
- **Kaspa Miner**: A tool for mining Kaspa cryptocurrency.
- **Rothschild**: Utility for managing and monitoring Kaspa node operations.
- **Simpa**: Simulation and testing tool for the Kaspa network.
- **Basic HTTP Server**: Serves static content for the web wallet interface.
- **Avahi Daemon**: Facilitates service discovery on a local network.

## Building the Docker Image

To build the Docker image, navigate to the root directory of the GridRustyKaspa repository and run the following command:

```sh
docker build -t gridrustykaspa .
```

This command will create a Docker image named `gridrustykaspa`.

## Running the Docker Container

To run the Docker container, use the following command:

```sh
docker run --privileged -d -p 80:80 -p 16110:16110 -p 16111:16111 -p 22:22 gridrustykaspa
```

This command will start the container in detached mode, mapping the necessary ports.

## Configuration Files

The repository includes several configuration files for different components:

- **`avahi-daemon.conf`**: Configuration for the Avahi daemon.
- **`kaspa.service`**: Systemd service file for running the Kaspa node.
- **`ssh-init.sh`**: Script to initialize the SSH server.
- **`monitor.sh`**: Script to monitor services.

## Documentation

Detailed documentation for each component and process is available in the `docs/` directory:

- [Avahi Daemon](docs/avahi.md)
- [Basic HTTP Server](docs/basic-http-server.md)
- [Conversion to .flist](docs/conversion.md)
- [Dockerfile](docs/dockerfile.md)
- [Kaspad](docs/kaspad.md)
- [Kaspa Miner](docs/kaspa-miner.md)
- [Kaspa Wallet](docs/kaspa-wallet.md)
- [Rothschild](docs/rothschild.md)
- [Services](docs/services.md)
- [Simpa](docs/simpa.md)
- [SSH](docs/ssh.md)
- [Zinit](docs/zinit.md)

## Exposed Ports

- **16110**: Kaspa node peer-to-peer communication.
- **16111**: Kaspa node RPC server.
- **22**: SSH server.
- **80**: HTTP server for the web wallet interface.
- **4000**: Custom application port (if needed).

## Logs and Monitoring

Logs for services managed by Zinit are stored in the `/var/log` directory. To view the logs, use the following command:

```sh
tail -f /var/log/<service-name>.log
```

## Converting Docker Image to .flist

To convert the Docker image to a .flist file for deployment on the ThreeFold Grid, follow the detailed instructions in the [Conversion Guide](docs/conversion.md).

## Troubleshooting

Common issues and solutions are documented in the [Troubleshooting Guide](docs/troubleshooting.md).

## Contributing

We welcome contributions to the GridRustyKaspa project. Please refer to the [Contributing Guide](docs/contributing.md) for more details.


