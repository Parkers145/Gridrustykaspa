![GridRustyKaspa](./images/header.png)

This repository contains the setup for deploying a Kaspa full node and web wallet on a Threefold micro VM using Docker and Zinit for process management.

## Table of Contents

- [Overview](#overview)
- [Repository Structure](#repository-structure)
- [Getting Started](#getting-started)
- [Building and Running](#building-and-running)
- [Zinit Configuration](#zinit-configuration)
- [Avahi Configuration](#avahi-configuration)
- [SSH Configuration](#ssh-configuration)
- [Kaspad Configuration](#kaspad-configuration)
- [Kaspa-wallet Configuration](#kaspa-wallet-configuration)
- [Kaspa-miner Configuration](#kaspa-miner-configuration)
- [Rothschild Configuration](#rothschild-configuration)
- [Simpa Configuration](#simpa-configuration)
- [basic-http-server Configuration](#basic-http-server-configuration)

# Overview

Gridrustykaspa is a Docker-based deployment that includes:

- Rusty Kaspa node (`kaspad`)
- Avahi for mDNS
- Zinit for managing services
- OpenSSH server

## kaspa binaries included in runtime 

This section provides an overview of the binaries copied into Stage 2 of the Docker build for the Gridrustykaspa project. Each binary's functionality is explained to help users understand its purpose within the container.

### Binaries

1. **kaspad**
   - **Path:** `/usr/local/bin/kaspad`
   - **Description:** `kaspad` is the main node implementation for the Kaspa blockchain. It is responsible for validating transactions, maintaining the blockchain state, and participating in the network by relaying blocks and transactions. It is the core component that ensures the blockchain's integrity and functionality.

2. **kaspa-wallet**
   - **Path:** `/usr/local/bin/kaspa-wallet`
   - **Description:** `kaspa-wallet` is a command-line tool for managing Kaspa wallets. It allows users to create and manage wallet addresses, check balances, and send transactions on the Kaspa network. It provides essential functionalities for interacting with the blockchain from a user's perspective.

3. **rothschild**
   - **Path:** `/usr/local/bin/rothschild`
   - **Description:** `rothschild` is a utility for managing and monitoring Kaspa node operations. It provides additional tools and interfaces for debugging, monitoring, and controlling the node's behavior. It is especially useful for developers and operators who need to manage multiple nodes or require advanced control features.

4. **simpa**
   - **Path:** `/usr/local/bin/simpa`
   - **Description:** `simpa` is a simulation and testing tool for the Kaspa network. It allows developers to create test scenarios, simulate network conditions, and validate the behavior of the Kaspa node under different circumstances. It is used primarily for development and testing purposes.

5. **basic-http-server**
   - **Path:** `/usr/local/bin/basic-http-server`
   - **Description:** `basic-http-server` is a simple HTTP server used to serve static content. In the context of Gridrustykaspa, it is used to serve the web wallet interface and other static files required for the web-based interaction with the Kaspa node. It provides an easy way to expose web content from within the container.

6. **kaspa-miner**
   - **Path:** `/usr/local/bin/kaspa-miner`
   - **Description:** `kaspa-miner` is a mining client for the Kaspa blockchain. It performs the computational work required to find new blocks, contributing to the network's security and decentralization. The miner can utilize CPU and GPU resources to perform hash calculations, and it includes features for configuring mining intensity and managing mining operations.

## Repository Structure

```
├── Dockerfile
├── README.md
├── avahi-daemon.conf
├── docs
│   ├── avahi.md
│   ├── basic-http-server.md
│   ├── kaspa-miner.md
│   ├── kaspa-wallet.md
│   ├── kaspad.md
│   ├── rothschild.md
│   ├── simpa.md
│   ├── ssh.md
│   └── zinit.md
├── images
│   └── header.png
├── kaspa.service
├── monitor.sh
├── ssh-init.sh
└── zinit
    ├── avahi-daemon.yaml
    ├── basic-http-server.yaml
    ├── kaspad.yaml
    ├── monitor.yaml
    ├── ssh-init.yaml
    └── sshd.yaml

```

## Getting Started

### Prerequisites

- Docker
- Git

### Cloning the Repository

```sh
git clone https://github.com/parkers145/Gridrustykaspa.git
cd Gridrustykaspa
```

## Building and Running

### Building the Docker Image

```sh
docker build -t Gridrustykaspa .
```

### Running the Docker Container

```sh
docker run --privileged -d -p 80:80 -p 16110:16110 -p 16111:16111 -p 22:22 Gridrustykaspa 
```

## Zinit Configuration

For detailed information on Zinit configuration, refer to [Zinit Configuration](docs/zinit.md).

## Avahi Configuration

For detailed information on Avahi configuration, refer to [Avahi Configuration](docs/avahi.md).

## SSH Configuration

For detailed information on SSH configuration, refer to [SSH Configuration](docs/ssh.md).

## Kaspad Configuration 

For detailed information on kaspad configuration, refer to [kaspad Configuration](docs/kaspad.md).

## Kaspa-wallet Configuration 

For detailed information on kaspa-wallet configuration, refer to [kaspa-wallet Configuration](docs/kaspad.md).

## Kaspa-miner Configuration 

For detailed information on kaspa-miner configuration, refer to [kaspa-wallet Configuration](docs/kaspa-miner.md).

## Rothschild Configuration 

For detailed information on kaspa-miner configuration, refer to [rothschild Configuration](docs/rothschild.md)

## Simba Configuration 

For detailed information on kaspa-miner configuration, refer to [simba Configuration](docs/simba.md)

## basic-http-server Configuration

For detailed information on kaspa-miner configuration, refer to [basic-http-server Configuration](docs/basic-http-server.md)



