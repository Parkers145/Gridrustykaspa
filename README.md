### README.md


# Gridrustykaspa

This repository contains the setup for deploying a Kaspa full node and web wallet on a Threefold micro VM using Docker and Zinit for process management.

## Table of Contents

- [Overview](#overview)
- [Repository Structure](#repository-structure)
- [Getting Started](#getting-started)
- [Building and Running](#building-and-running)
- [API Documentation](#api-documentation)
- [Zinit Configuration](#zinit-configuration)
- [Avahi Configuration](#avahi-configuration)
- [SSH Configuration](#ssh-configuration)
- [License](#license)

## Overview

Gridrustykaspa is a Docker-based deployment that includes:

- Rusty Kaspa node (`kaspad`)
- Custom API built with Actix Web
- Avahi for mDNS
- Zinit for managing services
- OpenSSH server

## Repository Structure

```
Gridrustykaspa/
├── Dockerfile
├── avahi-daemon.conf
├── kaspa.service
├── ssh-init.sh
├── README.md
├── zinit/
│   ├── kaspad.yaml
│   ├── api.yaml
│   ├── avahi-daemon.yaml
│   ├── sshd.yaml
│   └── ssh-init.yaml
├── api/
│   ├── Cargo.toml
│   └── src/
│       ├── main.rs
│       ├── auth.rs
│       └── handlers/
│           ├── mod.rs
│           ├── wallet.rs
│           └── node.rs
└── docs/
    ├── api.md
    ├── zinit.md
    ├── avahi.md
    ├── ssh.md
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
docker build -t grustrkaspad .
```

### Running the Docker Container

```sh
docker run --privileged -d -p 80:80 -p 16110:16110 -p 16111:16111 -p 22:22 grustrkaspad
```

## API Documentation

For detailed API documentation, refer to [API Documentation](docs/api.md).

## Zinit Configuration

For detailed information on Zinit configuration, refer to [Zinit Configuration](docs/zinit.md).

## Avahi Configuration

For detailed information on Avahi configuration, refer to [Avahi Configuration](docs/avahi.md).

## SSH Configuration

For detailed information on SSH configuration, refer to [SSH Configuration](docs/ssh.md).


