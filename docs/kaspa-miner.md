# Kaspa Miner Configuration and Management Guide

## Overview

`kaspa-miner` is a command-line tool for mining Kaspa cryptocurrency. It provides functionalities to connect to the Kaspa network, participate in mining activities, and manage mining operations. This document provides a comprehensive guide on configuring, managing, and interacting with the `kaspa-miner` binary within the GridRustyKaspa project.

## Table of Contents

1. [Configuration](#configuration)
   - [Kaspa Miner Configuration File](#kaspa-miner-configuration-file)
2. [Running Kaspa Miner](#running-kaspa-miner)
   - [Starting the Miner](#starting-the-miner)
   - [Stopping the Miner](#stopping-the-miner)
   - [Restarting the Miner](#restarting-the-miner)
3. [Interacting with Kaspa Miner](#interacting-with-kaspa-miner)
   - [Command-Line Interface](#command-line-interface)
4. [Logs and Monitoring](#logs-and-monitoring)
5. [Troubleshooting](#troubleshooting)
6. [Appendix](#appendix)
   - [Useful Commands](#useful-commands)
   - [Configuration Options](#configuration-options)

## Configuration

### Kaspa Miner Configuration File

The `kaspa-miner` binary can be configured using command-line arguments or a configuration file. Below is an example configuration file:

```yaml
network:
  address: "http://localhost:16110"
  username: "yourusername"
  password: "yourpassword"
miner:
  data-dir: "/path/to/miner/data"
  log-level: "info"
gpu:
  enable: true
  type: "cuda" # or "opencl"
  device: 0
```

- **network**: Configuration for the Kaspa network.
  - **address**: The address of the Kaspa node's RPC server.
  - **username**: Username for RPC authentication.
  - **password**: Password for RPC authentication.
- **miner**: Configuration for the miner.
  - **data-dir**: Directory to store miner data.
  - **log-level**: Sets the logging level (`debug`, `info`, `warn`, `error`).
- **gpu**: GPU mining configuration.
  - **enable**: Enable or disable GPU mining.
  - **type**: Type of GPU to use (`cuda` or `opencl`).
  - **device**: GPU device index.

## Running Kaspa Miner

### Starting the Miner

To start `kaspa-miner`, use the following command:

```sh
kaspa-miner --config /path/to/kaspa-miner-config.yaml
```

Alternatively, if you are using Zinit for process management, you can start the miner using the Zinit configuration file (`kaspa-miner.yaml`):

```yaml
exec: /usr/local/bin/kaspa-miner --config /etc/kaspa-miner/kaspa-miner-config.yaml
log: stdout
```

Start the service using Zinit:

```sh
zinit start kaspa-miner
```

### Stopping the Miner

To stop `kaspa-miner`, use the following command:

```sh
zinit stop kaspa-miner
```

### Restarting the Miner

To restart `kaspa-miner`, use the following command:

```sh
zinit restart kaspa-miner
```

## Interacting with Kaspa Miner

### Command-Line Interface

`kaspa-miner` provides a command-line interface for managing the mining operations. Below are some useful commands:

- **Check version**:

  ```sh
  kaspa-miner --version
  ```

- **Start in foreground**:

  ```sh
  kaspa-miner --config /path/to/kaspa-miner-config.yaml
  ```

- **Display help**:

  ```sh
  kaspa-miner --help
  ```

- **Create a new configuration file**:

  ```sh
  kaspa-miner config --create --output /path/to/kaspa-miner-config.yaml
  ```

### API Endpoints

In addition to the CLI, `kaspa-miner` can interact with the Kaspa node via API endpoints. Here are some key endpoints:

- **Get Mining Status**:

  ```sh
  curl -u yourusername:yourpassword http://localhost:16110/api/v1/miner/status
  ```

- **Submit Mining Result**:

  ```sh
  curl -u yourusername:yourpassword -X POST -H "Content-Type: application/json" -d '{"result":"miningresult"}' http://localhost:16110/api/v1/miner/submit
  ```

Refer to the API documentation for a complete list of available endpoints and their usage.

## Logs and Monitoring

Logs are essential for monitoring the status and activities of the `kaspa-miner`. By default, logs are output to `stdout`. You can redirect logs to a file by configuring the `log` option in the Zinit configuration file:

```yaml
log:
  path: "/var/log/kaspa-miner.log"
  level: "info"
```

To view the logs:

```sh
tail -f /var/log/kaspa-miner.log
```

## Troubleshooting

Here are some common issues and solutions for `kaspa-miner`:

- **Miner not starting**: Check the configuration file for errors and ensure all required fields are set correctly.
- **Connection issues**: Verify network settings and ensure the miner has access to the Kaspa node's RPC server.
- **RPC authentication errors**: Ensure the `username` and `password` in the RPC configuration match those used in your API requests.
- **GPU not detected**: Ensure the correct GPU drivers are installed and the `gpu` configuration in the configuration file is correct.

## Appendix

### Useful Commands

- **Check mining status**:

  ```sh
  kaspa-miner status --config /path/to/kaspa-miner-config.yaml
  ```

- **Submit mining result**:

  ```sh
  kaspa-miner submit --result miningresult --config /path/to/kaspa-miner-config.yaml
  ```

### Configuration Options

Refer to the `kaspa-miner` documentation for a detailed list of all configuration options and their descriptions.

