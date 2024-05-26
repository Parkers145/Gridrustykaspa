# Rothschild Configuration and Management Guide

## Overview

`rothschild` is a utility for managing and monitoring Kaspa node operations. It provides additional tools and interfaces for debugging, monitoring, and controlling the node's behavior. This document provides a comprehensive guide on configuring, managing, and interacting with the `rothschild` binary within the GridRustyKaspa project.

## Table of Contents

1. [Configuration](#configuration)
   - [Rothschild Configuration File](#rothschild-configuration-file)
2. [Running Rothschild](#running-rothschild)
   - [Starting Rothschild](#starting-rothschild)
   - [Stopping Rothschild](#stopping-rothschild)
   - [Restarting Rothschild](#restarting-rothschild)
3. [Interacting with Rothschild](#interacting-with-rothschild)
   - [Command-Line Interface](#command-line-interface)
4. [Logs and Monitoring](#logs-and-monitoring)
5. [Troubleshooting](#troubleshooting)
6. [Appendix](#appendix)
   - [Useful Commands](#useful-commands)
   - [Configuration Options](#configuration-options)

## Configuration

### Rothschild Configuration File

The `rothschild` binary can be configured using command-line arguments or a configuration file. Below is an example configuration file:

```yaml
network:
  address: "http://localhost:16110"
  username: "yourusername"
  password: "yourpassword"
rothschild:
  data-dir: "/path/to/rothschild/data"
  log-level: "info"
monitor:
  enable: true
  interval: 10 # in seconds
  alert-email: "alert@example.com"
```

- **network**: Configuration for the Kaspa network.
  - **address**: The address of the Kaspa node's RPC server.
  - **username**: Username for RPC authentication.
  - **password**: Password for RPC authentication.
- **rothschild**: Configuration for the Rothschild utility.
  - **data-dir**: Directory to store Rothschild data.
  - **log-level**: Sets the logging level (`debug`, `info`, `warn`, `error`).
- **monitor**: Monitoring configuration.
  - **enable**: Enable or disable monitoring.
  - **interval**: Monitoring interval in seconds.
  - **alert-email**: Email address to send alerts.

## Running Rothschild

### Starting Rothschild

To start `rothschild`, use the following command:

```sh
rothschild --config /path/to/rothschild-config.yaml
```

Alternatively, if you are using Zinit for process management, you can start the utility using the Zinit configuration file (`rothschild.yaml`):

```yaml
exec: /usr/local/bin/rothschild --config /etc/rothschild/rothschild-config.yaml
log: stdout
```

Start the service using Zinit:

```sh
zinit start rothschild
```

### Stopping Rothschild

To stop `rothschild`, use the following command:

```sh
zinit stop rothschild
```

### Restarting Rothschild

To restart `rothschild`, use the following command:

```sh
zinit restart rothschild
```

## Interacting with Rothschild

### Command-Line Interface

`rothschild` provides a command-line interface for managing the node operations. Below are some useful commands:

- **Check version**:

  ```sh
  rothschild --version
  ```

- **Start in foreground**:

  ```sh
  rothschild --config /path/to/rothschild-config.yaml
  ```

- **Display help**:

  ```sh
  rothschild --help
  ```

- **Check node status**:

  ```sh
  rothschild status --config /path/to/rothschild-config.yaml
  ```

- **Restart node**:

  ```sh
  rothschild restart --config /path/to/rothschild-config.yaml
  ```

### API Endpoints

In addition to the CLI, `rothschild` can interact with the Kaspa node via API endpoints. Here are some key endpoints:

- **Get Node Status**:

  ```sh
  curl -u yourusername:yourpassword http://localhost:16110/api/v1/node/status
  ```

- **Restart Node**:

  ```sh
  curl -u yourusername:yourpassword -X POST http://localhost:16110/api/v1/node/restart
  ```

- **Get Node Logs**:

  ```sh
  curl -u yourusername:yourpassword http://localhost:16110/api/v1/node/logs
  ```

Refer to the API documentation for a complete list of available endpoints and their usage.

## Logs and Monitoring

Logs are essential for monitoring the status and activities of the `rothschild`. By default, logs are output to `stdout`. You can redirect logs to a file by configuring the `log` option in the Zinit configuration file:

```yaml
log:
  path: "/var/log/rothschild.log"
  level: "info"
```

To view the logs:

```sh
tail -f /var/log/rothschild.log
```

## Troubleshooting

Here are some common issues and solutions for `rothschild`:

- **Utility not starting**: Check the configuration file for errors and ensure all required fields are set correctly.
- **Connection issues**: Verify network settings and ensure the utility has access to the Kaspa node's RPC server.
- **RPC authentication errors**: Ensure the `username` and `password` in the RPC configuration match those used in your API requests.
- **Email alerts not sent**: Verify the email configuration and ensure the server has access to the email service.

## Appendix

### Useful Commands

- **Check node status**:

  ```sh
  rothschild status --config /path/to/rothschild-config.yaml
  ```

- **Restart node**:

  ```sh
  rothschild restart --config /path/to/rothschild-config.yaml
  ```

- **Get node logs**:

  ```sh
  rothschild logs --config /path/to/rothschild-config.yaml
  ```

### Configuration Options

Refer to the `rothschild` documentation for a detailed list of all configuration options and their descriptions.

