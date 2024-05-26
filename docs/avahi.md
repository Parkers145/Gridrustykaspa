# Avahi Configuration and Management Guide

## Overview

Avahi is a system that facilitates service discovery on a local network using the mDNS/DNS-SD protocol suite. It allows programs to publish and discover services and hosts running on a local network with no specific configuration. This document provides a comprehensive guide on configuring, managing, and interacting with the `avahi` binary within the GridRustyKaspa project.

## Table of Contents

1. [Configuration](#configuration)
   - [Avahi Configuration File](#avahi-configuration-file)
2. [Running Avahi](#running-avahi)
   - [Starting Avahi](#starting-avahi)
   - [Stopping Avahi](#stopping-avahi)
   - [Restarting Avahi](#restarting-avahi)
3. [Interacting with Avahi](#interacting-with-avahi)
   - [Command-Line Interface](#command-line-interface)
4. [Logs and Monitoring](#logs-and-monitoring)
5. [Troubleshooting](#troubleshooting)
6. [Appendix](#appendix)
   - [Useful Commands](#useful-commands)
   - [Configuration Options](#configuration-options)

## Configuration

### Avahi Configuration File

The `avahi` binary can be configured using a configuration file. Below is an example configuration file (`avahi-daemon.conf`):

```ini
[server]
host-name=avahi
domain-name=local
use-ipv4=yes
use-ipv6=no

[publish]
publish-addresses=yes
publish-hinfo=yes
publish-workstation=yes

[reflector]
enable-reflector=yes

[rlimits]
rlimit-nproc=3
rlimit-nofile=30
rlimit-core=0
```

- **server**: Basic server settings.
  - **host-name**: Host name for the Avahi server.
  - **domain-name**: Domain name for the Avahi server.
  - **use-ipv4**: Enable or disable IPv4 support.
  - **use-ipv6**: Enable or disable IPv6 support.
- **publish**: Settings for publishing services.
  - **publish-addresses**: Publish IP addresses.
  - **publish-hinfo**: Publish host information.
  - **publish-workstation**: Publish workstation status.
- **reflector**: Reflector settings.
  - **enable-reflector**: Enable or disable the reflector.
- **rlimits**: Resource limits for the Avahi daemon.
  - **rlimit-nproc**: Maximum number of processes.
  - **rlimit-nofile**: Maximum number of open files.
  - **rlimit-core**: Maximum core file size.

## Running Avahi

### Starting Avahi

To start the Avahi daemon, use the following command:

```sh
avahi-daemon --config /path/to/avahi-daemon.conf
```

Alternatively, if you are using Zinit for process management, you can start the Avahi daemon using the Zinit configuration file (`avahi-daemon.yaml`):

```yaml
exec: /usr/local/bin/avahi-daemon --config /etc/avahi/avahi-daemon.conf
log: stdout
```

Start the service using Zinit:

```sh
zinit start avahi-daemon
```

### Stopping Avahi

To stop the Avahi daemon, use the following command:

```sh
zinit stop avahi-daemon
```

### Restarting Avahi

To restart the Avahi daemon, use the following command:

```sh
zinit restart avahi-daemon
```

## Interacting with Avahi

### Command-Line Interface

`avahi` provides a command-line interface for managing the daemon and its services. Below are some useful commands:

- **Check version**:

  ```sh
  avahi-daemon --version
  ```

- **Start in foreground**:

  ```sh
  avahi-daemon --config /path/to/avahi-daemon.conf
  ```

- **Display help**:

  ```sh
  avahi-daemon --help
  ```

- **Browse for services**:

  ```sh
  avahi-browse -a
  ```

- **Publish a service**:

  ```sh
  avahi-publish -s <service-name> <service-type> <port> [<txt-record> ...]
  ```

## Logs and Monitoring

Logs are essential for monitoring the status and activities of the Avahi daemon. By default, logs are output to `stdout`. You can redirect logs to a file by configuring the `log` option in the Zinit configuration file:

```yaml
log:
  path: "/var/log/avahi-daemon.log"
  level: "info"
```

To view the logs:

```sh
tail -f /var/log/avahi-daemon.log
```

## Troubleshooting

Here are some common issues and solutions for the Avahi daemon:

- **Daemon not starting**: Check the configuration file for errors and ensure all required fields are set correctly.
- **Service not discovered**: Verify network settings and ensure mDNS is enabled on the network.
- **High CPU usage**: Check for network loops or excessive service advertisements.

## Appendix

### Useful Commands

- **Browse for services**:

  ```sh
  avahi-browse -a
  ```

- **Publish a service**:

  ```sh
  avahi-publish -s <service-name> <service-type> <port> [<txt-record> ...]
  ```

- **Unpublish a service**:

  ```sh
  avahi-unpublish -s <service-name>
  ```

### Configuration Options

Refer to the Avahi documentation for a detailed list of all configuration options and their descriptions.

