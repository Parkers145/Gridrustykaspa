# Basic HTTP Server Configuration and Management Guide

## Overview

The `basic-http-server` is a simple HTTP server used to serve static content. In the context of the GridRustyKaspa project, it is used to serve the web wallet interface and other static files required for web-based interaction with the Kaspa node. This document provides a comprehensive guide on configuring, managing, and interacting with the `basic-http-server` binary.

## Table of Contents

1. [Configuration](#configuration)
   - [Basic HTTP Server Configuration File](#basic-http-server-configuration-file)
2. [Running Basic HTTP Server](#running-basic-http-server)
   - [Starting the Server](#starting-the-server)
   - [Stopping the Server](#stopping-the-server)
   - [Restarting the Server](#restarting-the-server)
3. [Interacting with Basic HTTP Server](#interacting-with-basic-http-server)
   - [Command-Line Interface](#command-line-interface)
4. [Logs and Monitoring](#logs-and-monitoring)
5. [Troubleshooting](#troubleshooting)
6. [Appendix](#appendix)
   - [Useful Commands](#useful-commands)
   - [Configuration Options](#configuration-options)

## Configuration

### Basic HTTP Server Configuration File

The `basic-http-server` binary can be configured using command-line arguments. Below is an example of how to configure it to serve files from the `app/web` directory:

```sh
basic-http-server /path/to/app/web --addr 0.0.0.0:80 --log-level info
```

- **Directory to Serve**: The directory containing the files to be served (`/path/to/app/web`).
- **Address and Port**: The address and port on which the server will listen (`0.0.0.0:80`).
- **Log Level**: Sets the logging level (`info`, `debug`, `warn`, `error`).

## Running Basic HTTP Server

### Starting the Server

To start the `basic-http-server`, use the following command:

```sh
basic-http-server /path/to/app/web --addr 0.0.0.0:80 --log-level info
```

Alternatively, if you are using Zinit for process management, you can start the server using the Zinit configuration file (`basic-http-server.yaml`):

```yaml
exec: /usr/local/bin/basic-http-server /path/to/app/web --addr 0.0.0.0:80 --log-level info
log: stdout
```

Start the service using Zinit:

```sh
zinit start basic-http-server
```

### Stopping the Server

To stop the `basic-http-server`, use the following command:

```sh
zinit stop basic-http-server
```

### Restarting the Server

To restart the `basic-http-server`, use the following command:

```sh
zinit restart basic-http-server
```

## Interacting with Basic HTTP Server

### Command-Line Interface

`basic-http-server` provides a command-line interface for managing the server. Below are some useful commands:

- **Check version**:

  ```sh
  basic-http-server --version
  ```

- **Start in foreground**:

  ```sh
  basic-http-server /path/to/app/web --addr 0.0.0.0:80 --log-level info
  ```

- **Display help**:

  ```sh
  basic-http-server --help
  ```

## Logs and Monitoring

Logs are essential for monitoring the status and activities of the `basic-http-server`. By default, logs are output to `stdout`. You can redirect logs to a file by configuring the `log` option in the Zinit configuration file:

```yaml
log:
  path: "/var/log/basic-http-server.log"
  level: "info"
```

To view the logs:

```sh
tail -f /var/log/basic-http-server.log
```

## Troubleshooting

Here are some common issues and solutions for `basic-http-server`:

- **Server not starting**: Check the command-line arguments for errors and ensure the directory to be served exists and is accessible.
- **Connection issues**: Verify network settings and ensure the server has access to the required ports.
- **Permission errors**: Ensure the user running the server has appropriate permissions to access the directory and bind to the specified port.

## Appendix

### Useful Commands

- **Check server status**:

  ```sh
  curl http://localhost:80
  ```

### Configuration Options

Refer to the `basic-http-server` documentation for a detailed list of all configuration options and their descriptions.
