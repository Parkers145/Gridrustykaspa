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

The `kaspad` binary can be configured using a .toml file.

```toml
# Directory for application data
appdir = "/app"

# Directory for log files
logdir = "/var/log"

# Disable logging to files
nologfiles = false

# Enable unsafe RPC commands
unsaferpc = false

# Verbose WebSocket RPC
wrpc-verbose = false

# Logging verbosity level
loglevel = "debug"

# Enable UTXO index
utxoindex = true

# Reset the database before starting the node
reset-db = false

# Target number of outbound peers
outpeers = 8

# Maximum number of inbound peers
maxinpeers = 125

# Maximum number of RPC clients
rpcmaxclients = 100

# Maximum tracked addresses
max-tracked-addresses = 1000

# Enable unsynced mining
enable-unsynced-mining = false

# Enable mainnet mining
enable-mainnet-mining = false

# Use the test network
testnet = false

# Use the development test network
devnet = false

# Use the simulation test network
simnet = false

# Run as an archival node
archival = false

# Enable sanity checks
sanity = false

# Auto-confirm prompts
yes = false

# Enable performance metrics
perf-metrics = false

# Interval for performance metrics in seconds
perf-metrics-interval-sec = 60

# Block template cache lifetime
block-template-cache-lifetime = 60

# Disable UPnP
disable-upnp = false

# Connect only to specified peers at startup
# connect = ["10.0.0.1", "1.2.3.4"]

# Add peers to connect with at startup
# addpeer = ["192.168.1.2:12345"]

# Add an interface and port to listen for connections
listen = "0.0.0.0:16111"

# Disable DNS seed
nodnsseed = false

# Disable gRPC server
nogrpc = false

# External IP address
# externalip = "192.168.1.3"

# Number of asynchronous threads
# async-threads = 4

# RAM scale factor
ram-scale = 1.0
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

by default after building the configuration file is located at 
```
/etc/kaspa/kaspa-config.toml
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

