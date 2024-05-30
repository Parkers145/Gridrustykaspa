# Kaspad Configuration and Management Guide

## Overview

Kaspad is the core node implementation for the Kaspa blockchain. It is responsible for validating transactions, maintaining the blockchain state, and participating in the network by relaying blocks and transactions. This document provides a comprehensive guide on configuring, managing, and interacting with the `kaspad` binary within the GridRustyKaspa project.

## Table of Contents

1. [Configuration](#configuration)
   - [Kaspad Configuration File](#kaspad-configuration-file)
2. [Running Kaspad](#running-kaspad)
   - [Starting Kaspad](#starting-kaspad)
   - [Stopping Kaspad](#stopping-kaspad)
   - [Restarting Kaspad](#restarting-kaspad)
3. [Interacting with Kaspad](#interacting-with-kaspad)
   - [Command-Line Interface](#command-line-interface)
   - [API Endpoints](#api-endpoints)
4. [Logs and Monitoring](#logs-and-monitoring)
5. [Troubleshooting](#troubleshooting)
6. [Appendix](#appendix)
   - [Useful Commands](#useful-commands)
   - [Configuration Options](#configuration-options)

## Configuration

### Kaspad Configuration File

The `kaspad` binary can be configured using a YAML file. Below is an example configuration file:

```yaml
network: mainnet
logLevel: info
listen: "0.0.0.0:16110"
rpc:
  address: "0.0.0.0:16111"
  username: "yourusername"
  password: "yourpassword"
database:
  path: "/var/lib/kaspad"
```

- **network**: Specifies the network to connect to (e.g., `mainnet`, `testnet`).
- **logLevel**: Sets the logging level (`debug`, `info`, `warn`, `error`).
- **listen**: The address and port on which `kaspad` listens for peer connections.
- **rpc**: Configuration for the RPC server.
  - **address**: The address and port for the RPC server.
  - **username**: Username for RPC authentication.
  - **password**: Password for RPC authentication.
- **database**: Configuration for the database.
  - **path**: Path to the database files.

## Running Kaspad

### Starting Kaspad

To start `kaspad`, use the following command:

```sh
kaspad --config /path/to/kaspad-config.yaml
```

Alternatively, if you are using Zinit for process management, you can start `kaspad` using the Zinit configuration file (`kaspad.yaml`):

```yaml
exec: /usr/local/bin/kaspad --config /etc/kaspad/kaspad-config.yaml
log: stdout
```

Start the service using Zinit:

```sh
zinit start kaspad
```

### Stopping Kaspad

To stop `kaspad`, use the following command:

```sh
zinit stop kaspad
```

### Restarting Kaspad

To restart `kaspad`, use the following command:

```sh
zinit restart kaspad
```

## Interacting with Kaspad

### Command-Line Interface

`kaspad` provides a command-line interface for managing the node. Below are some useful commands:

- **Check version**:

  ```sh
  kaspad --version
  ```

- **Start in foreground**:

  ```sh
  kaspad --config /path/to/kaspad-config.yaml
  ```

- **Display help**:

  ```sh
  kaspad --help
  ```

### API Endpoints

`kaspad` exposes several API endpoints for interacting with the node. Here are some key endpoints:

- **Get Block Count**:

  ```sh
  curl -u yourusername:yourpassword http://localhost:16111/api/v1/block/count
  ```

- **Get Block by Hash**:

  ```sh
  curl -u yourusername:yourpassword http://localhost:16111/api/v1/block/{blockHash}
  ```

- **Send Raw Transaction**:

  ```sh
  curl -u yourusername:yourpassword -X POST -H "Content-Type: application/json" -d '{"rawTx":"yourrawtransaction"}' http://localhost:16111/api/v1/tx/send
  ```

Refer to the API documentation for a complete list of available endpoints and their usage.

## Logs and Monitoring

Logs are essential for monitoring the status and activities of the `kaspad` node. By default, logs are output to `stdout`. You can redirect logs to a file by configuring the `log` option in the `kaspad.yaml` file:

```yaml
log:
  path: "/var/log/kaspad.log"
  level: "info"
```

To view the logs:

```sh
tail -f /var/log/kaspad.log
```

## Troubleshooting

Here are some common issues and solutions for `kaspad`:

- **Node not starting**: Check the configuration file for errors and ensure all required fields are set correctly.
- **Connection issues**: Verify network settings and ensure the node has access to the required ports.
- **RPC authentication errors**: Ensure the `username` and `password` in the RPC configuration match those used in your API requests.

## Appendix

### Useful Commands

- **Check network status**:

  ```sh
  curl -u yourusername:yourpassword http://localhost:16111/api/v1/network/status
  ```

- **Get peer info**:

  ```sh
  curl -u yourusername:yourpassword http://localhost:16111/api/v1/network/peers
  ```

### Configuration Options

Refer to the `kaspad` documentation for a detailed list of all configuration options and their descriptions.

