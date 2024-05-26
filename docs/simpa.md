# Simpa Configuration and Management Guide

## Overview

`simpa` is a simulation and testing tool for the Kaspa network. It allows developers to create test scenarios, simulate network conditions, and validate the behavior of the Kaspa node under different circumstances. This document provides a comprehensive guide on configuring, managing, and interacting with the `simpa` binary within the GridRustyKaspa project.

## Table of Contents

1. [Configuration](#configuration)
   - [Simpa Configuration File](#simpa-configuration-file)
2. [Running Simpa](#running-simpa)
   - [Starting Simpa](#starting-simpa)
   - [Stopping Simpa](#stopping-simpa)
   - [Restarting Simpa](#restarting-simpa)
3. [Interacting with Simpa](#interacting-with-simpa)
   - [Command-Line Interface](#command-line-interface)
4. [Logs and Monitoring](#logs-and-monitoring)
5. [Troubleshooting](#troubleshooting)
6. [Appendix](#appendix)
   - [Useful Commands](#useful-commands)
   - [Configuration Options](#configuration-options)

## Configuration

### Simpa Configuration File

The `simpa` binary can be configured using command-line arguments or a configuration file. Below is an example configuration file:

```yaml
network:
  address: "http://localhost:16110"
  username: "yourusername"
  password: "yourpassword"
simpa:
  data-dir: "/path/to/simpa/data"
  log-level: "info"
  scenario: "default_scenario"
```

- **network**: Configuration for the Kaspa network.
  - **address**: The address of the Kaspa node's RPC server.
  - **username**: Username for RPC authentication.
  - **password**: Password for RPC authentication.
- **simpa**: Configuration for the Simpa tool.
  - **data-dir**: Directory to store Simpa data.
  - **log-level**: Sets the logging level (`debug`, `info`, `warn`, `error`).
  - **scenario**: The test scenario to run.

## Running Simpa

### Starting Simpa

To start `simpa`, use the following command:

```sh
simpa --config /path/to/simpa-config.yaml
```

Alternatively, if you are using Zinit for process management, you can start the tool using the Zinit configuration file (`simpa.yaml`):

```yaml
exec: /usr/local/bin/simpa --config /etc/simpa/simpa-config.yaml
log: stdout
```

Start the service using Zinit:

```sh
zinit start simpa
```

### Stopping Simpa

To stop `simpa`, use the following command:

```sh
zinit stop simpa
```

### Restarting Simpa

To restart `simpa`, use the following command:

```sh
zinit restart simpa
```

## Interacting with Simpa

### Command-Line Interface

`simpa` provides a command-line interface for managing the simulation and testing operations. Below are some useful commands:

- **Check version**:

  ```sh
  simpa --version
  ```

- **Start in foreground**:

  ```sh
  simpa --config /path/to/simpa-config.yaml
  ```

- **Display help**:

  ```sh
  simpa --help
  ```

- **Run a specific scenario**:

  ```sh
  simpa run --scenario /path/to/scenario.yaml --config /path/to/simpa-config.yaml
  ```

### API Endpoints

In addition to the CLI, `simpa` can interact with the Kaspa node via API endpoints. Here are some key endpoints:

- **Get Simulation Status**:

  ```sh
  curl -u yourusername:yourpassword http://localhost:16110/api/v1/simpa/status
  ```

- **Start Simulation**:

  ```sh
  curl -u yourusername:yourpassword -X POST -H "Content-Type: application/json" -d '{"scenario":"scenario_name"}' http://localhost:16110/api/v1/simpa/start
  ```

Refer to the API documentation for a complete list of available endpoints and their usage.

## Logs and Monitoring

Logs are essential for monitoring the status and activities of the `simpa`. By default, logs are output to `stdout`. You can redirect logs to a file by configuring the `log` option in the Zinit configuration file:

```yaml
log:
  path: "/var/log/simpa.log"
  level: "info"
```

To view the logs:

```sh
tail -f /var/log/simpa.log
```

## Troubleshooting

Here are some common issues and solutions for `simpa`:

- **Tool not starting**: Check the configuration file for errors and ensure all required fields are set correctly.
- **Connection issues**: Verify network settings and ensure the tool has access to the Kaspa node's RPC server.
- **RPC authentication errors**: Ensure the `username` and `password` in the RPC configuration match those used in your API requests.
- **Scenario not found**: Ensure the scenario file path is correct and the file exists.

## Appendix

### Useful Commands

- **Check simulation status**:

  ```sh
  simpa status --config /path/to/simpa-config.yaml
  ```

- **Run a specific scenario**:

  ```sh
  simpa run --scenario /path/to/scenario.yaml --config /path/to/simpa-config.yaml
  ```

### Configuration Options

Refer to the `simpa` documentation for a detailed list of all configuration options and their descriptions.

