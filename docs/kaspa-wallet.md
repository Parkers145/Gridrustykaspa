# Kaspa Wallet Configuration and Management Guide

## Overview

`kaspa-wallet` is a command-line tool for managing Kaspa wallets. It allows users to create and manage wallet addresses, check balances, and send transactions on the Kaspa network. This document provides a comprehensive guide on configuring, managing, and interacting with the `kaspa-wallet` binary within the GridRustyKaspa project.

## Table of Contents

1. [Configuration](#configuration)
   - [Kaspa Wallet Configuration File](#kaspa-wallet-configuration-file)
2. [Running Kaspa Wallet](#running-kaspa-wallet)
   - [Starting the Wallet](#starting-the-wallet)
   - [Stopping the Wallet](#stopping-the-wallet)
   - [Restarting the Wallet](#restarting-the-wallet)
3. [Interacting with Kaspa Wallet](#interacting-with-kaspa-wallet)
   - [Command-Line Interface](#command-line-interface)
4. [Logs and Monitoring](#logs-and-monitoring)
5. [Troubleshooting](#troubleshooting)
6. [Appendix](#appendix)
   - [Useful Commands](#useful-commands)
   - [Configuration Options](#configuration-options)

## Configuration

### Kaspa Wallet Configuration File

The `kaspa-wallet` binary can be configured using command-line arguments or a configuration file. Below is the configuration file packaged with this build:

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

- **rpc**: Configuration for the RPC server.
  - **address**: The address of the Kaspa node's RPC server.
  - **username**: Username for RPC authentication.
  - **password**: Password for RPC authentication.
- **wallet**: Configuration for the wallet.
  - **data-dir**: Directory to store wallet data.
  - **log-level**: Sets the logging level (`debug`, `info`, `warn`, `error`).

## Running Kaspa Wallet

### Starting the Wallet

To start `kaspa-wallet`, use the following command:

```sh
kaspa-wallet --config /path/to/kaspa-wallet-config.yaml
```

Alternatively, if you are using Zinit for process management, you can start the wallet using the Zinit configuration file (`kaspa-wallet.yaml`):

```yaml
exec: /usr/local/bin/kaspa-wallet --config /etc/kaspa-wallet/kaspa-wallet-config.yaml
log: stdout
```

Start the service using Zinit:

```sh
zinit start kaspa-wallet
```

### Stopping the Wallet

To stop `kaspa-wallet`, use the following command:

```sh
zinit stop kaspa-wallet
```

### Restarting the Wallet

To restart `kaspa-wallet`, use the following command:

```sh
zinit restart kaspa-wallet
```

## Interacting with Kaspa Wallet

### Command-Line Interface

`kaspa-wallet` provides a command-line interface for managing the wallet. Below are some useful commands:

- **Check version**:

  ```sh
  kaspa-wallet --version
  ```

- **Start in foreground**:

  ```sh
  kaspa-wallet --config /path/to/kaspa-wallet-config.yaml
  ```

- **Display help**:

  ```sh
  kaspa-wallet --help
  ```

- **Create a new wallet**:

  ```sh
  kaspa-wallet create --data-dir /path/to/wallet/data
  ```

- **Check wallet balance**:

  ```sh
  kaspa-wallet balance --data-dir /path/to/wallet/data
  ```

- **Send a transaction**:

  ```sh
  kaspa-wallet send --to recipientAddress --amount amount --data-dir /path/to/wallet/data
  ```

### API Endpoints

In addition to the CLI, `kaspa-wallet` can interact with the Kaspa node via API endpoints. Here are some key endpoints:

- **Get Wallet Info**:

  ```sh
  curl -u yourusername:yourpassword http://localhost:16110/api/v1/wallet/info
  ```

- **Get Transaction History**:

  ```sh
  curl -u yourusername:yourpassword http://localhost:16110/api/v1/wallet/transactions
  ```

- **Send Transaction**:

  ```sh
  curl -u yourusername:yourpassword -X POST -H "Content-Type: application/json" -d '{"to":"recipientAddress","amount":amount}' http://localhost:16110/api/v1/wallet/send
  ```

Refer to the API documentation for a complete list of available endpoints and their usage.

## Logs and Monitoring

Logs are essential for monitoring the status and activities of the `kaspa-wallet`. By default, logs are output to `stdout`. You can redirect logs to a file by configuring the `log` option in the Zinit configuration file:

```yaml
log:
  path: "/var/log/kaspa-wallet.log"
  level: "info"
```

To view the logs:

```sh
tail -f /var/log/kaspa-wallet.log
```

## Troubleshooting

Here are some common issues and solutions for `kaspa-wallet`:

- **Wallet not starting**: Check the configuration file for errors and ensure all required fields are set correctly.
- **Connection issues**: Verify network settings and ensure the wallet has access to the Kaspa node's RPC server.
- **RPC authentication errors**: Ensure the `username` and `password` in the RPC configuration match those used in your API requests.

## Appendix

### Useful Commands

- **Check wallet status**:

  ```sh
  kaspa-wallet status --data-dir /path/to/wallet/data
  ```

- **Get wallet address**:

  ```sh
  kaspa-wallet address --data-dir /path/to/wallet/data
  ```

### Configuration Options

Refer to the `kaspa-wallet` documentation for a detailed list of all configuration options and their descriptions.

