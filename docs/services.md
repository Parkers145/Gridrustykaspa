# Services Configuration Guide

## Overview

This document provides a comprehensive guide on the YAML configuration files located in the Zinit directory within the GridRustyKaspa repository. These configuration files are used by Zinit, a process manager, to manage the various services required by the GridRustyKaspa project.

## Table of Contents

1. [Introduction to Zinit](#introduction-to-zinit)
2. [Service Configuration Files](#service-configuration-files)
   - [Avahi Daemon](#avahi-daemon)
   - [Basic HTTP Server](#basic-http-server)
   - [Kaspad](#kaspad)
   - [Monitor](#monitor)
   - [SSH Initialization](#ssh-initialization)
   - [SSHD](#sshd)
3. [Managing Services with Zinit](#managing-services-with-zinit)
4. [Logs and Monitoring](#logs-and-monitoring)
5. [Troubleshooting](#troubleshooting)

## Introduction to Zinit

Zinit is a process manager used to manage services within the Docker container. It ensures that services are started, stopped, and restarted as needed, and provides logging and monitoring capabilities.

## Service Configuration Files

### Avahi Daemon

The `avahi-daemon.yaml` file configures the Avahi Daemon service, which facilitates service discovery on the local network.

```yaml
exec: /usr/local/bin/avahi-daemon --config /etc/avahi/avahi-daemon.conf
log: stdout
```

- **exec**: The command to execute the Avahi Daemon with the specified configuration file.
- **log**: Specifies that logs should be output to `stdout`.

### Basic HTTP Server

The `basic-http-server.yaml` file configures the Basic HTTP Server service, which serves static content for the web wallet interface.

```yaml
exec: /usr/local/bin/basic-http-server /app/web --addr 0.0.0.0:80 --log-level info
log: stdout
```

- **exec**: The command to execute the Basic HTTP Server, specifying the directory to serve and the address to bind to.
- **log**: Specifies that logs should be output to `stdout`.

### Kaspad

The `kaspad.yaml` file configures the Kaspad service, which is the core node implementation for the Kaspa blockchain.

```yaml
exec: /usr/local/bin/kaspad --config /etc/kaspad/kaspad-config.yaml
log: stdout
```

- **exec**: The command to execute Kaspad with the specified configuration file.
- **log**: Specifies that logs should be output to `stdout`.

### Monitor

The `monitor.yaml` file configures the monitoring service, which checks the status of various services.

```yaml
exec: /usr/local/bin/monitor.sh
log: /var/log/monitor.log
```

- **exec**: The command to execute the monitoring script.
- **log**: Specifies the log file for the monitoring service.

### SSH Initialization

The `ssh-init.yaml` file configures the SSH initialization service, which sets up the SSH server.

```yaml
exec: /usr/local/bin/ssh-init.sh
log: stdout
```

- **exec**: The command to execute the SSH initialization script.
- **log**: Specifies that logs should be output to `stdout`.

### SSHD

The `sshd.yaml` file configures the SSH Daemon service, which provides SSH access to the container.

```yaml
exec: /usr/sbin/sshd -D
log: stdout
```

- **exec**: The command to execute the SSH Daemon in the foreground.
- **log**: Specifies that logs should be output to `stdout`.

## Managing Services with Zinit

Zinit provides commands to manage the services defined in the YAML configuration files. Below are some common commands:

- **Start a service**:

  ```sh
  zinit start <service-name>
  ```

- **Stop a service**:

  ```sh
  zinit stop <service-name>
  ```

- **Restart a service**:

  ```sh
  zinit restart <service-name>
  ```

- **Check the status of a service**:

  ```sh
  zinit status <service-name>
  ```

## Logs and Monitoring

Logs for services managed by Zinit are specified in the YAML configuration files. They can be viewed using standard tools like `tail`:

```sh
tail -f /var/log/<service-name>.log
```

## Troubleshooting

Here are some common issues and solutions for managing services with Zinit:

- **Service not starting**: Check the YAML configuration file for errors and ensure the specified command is correct.
- **Logs not appearing**: Verify the log path specified in the YAML configuration file and ensure Zinit has permission to write to the log file.
- **Service crashing**: Check the service logs for error messages and verify the configuration and environment.

