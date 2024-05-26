#### Overview of Zinit

Zinit is a lightweight PID 1 replacement written in Rust using Tokio for asynchronous I/O. It manages and monitors services, ensuring they are up and running at all times, supports service dependencies during the boot process, and provides a simple command line interface to manage services.

### Detailed Analysis

#### Key Components

1. **Cargo Configuration**
   - `Cargo.toml`: Defines dependencies and metadata for the Zinit project.
   - `Cargo.lock`: Ensures the consistency of dependencies.

2. **Source Files**
   - `main.rs`: The entry point for the Zinit application. It defines the command-line interface and the main event loop.
   - `api.rs`: Defines the API for interacting with Zinit via a Unix socket.

3. **API Protocol**
   - A simple line protocol is used for communication over a Unix socket located at `/var/run/zinit.sock`.
   - Commands include `list`, `status <service>`, `start <service>`, `stop <service>`, `forget <service>`, `monitor <service>`, `kill <service>`, `shutdown`, `reboot`, and `log [snapshot]`.

4. **Service Management**
   - Zinit monitors services defined in YAML configuration files located in `/etc/zinit`.
   - Each service configuration includes fields such as `exec`, `test`, `oneshot`, `after`, `signal`, `log`, and `env`.
   - Services can be controlled using commands like `start`, `stop`, `restart`, `status`, `kill`, `monitor`, `forget`, and `list`.

5. **Logging**
   - Zinit provides a logging mechanism using a ring buffer. Logs can be accessed using the `log` command via the Unix socket.



# Zinit Configuration and Management

## Overview

Zinit is a lightweight PID 1 replacement written in Rust using Tokio for asynchronous I/O. It ensures that configured services are always up and running, supports service dependencies during the boot process, and provides a command line interface to manage services.

## Configuration

Zinit uses YAML configuration files to define services. These files are located in `/etc/zinit` by default.

### Example Service Configuration

```yaml
exec: "command to start the service"
test: "command to test if the service is running"
oneshot: false
after:
  - dependent_service
signal:
  stop: SIGTERM
log: stdout
env:
  ENV_VAR: value
```

- **exec**: Command to start the service.
- **test**: Command to test if the service is running.
- **oneshot**: If true, the service will not be restarted automatically.
- **after**: List of services that must be running before this service starts.
- **signal**: Signal to send when stopping the service.
  - **stop**: Signal to send when stopping the service (default is SIGTERM).
- **log**: Log output (null, ring, stdout).
- **env**: Environment variables to set for the service.

## Managing Services

### Starting Zinit

To start Zinit as the init process:

```sh
zinit init
```

### Adding a New Service

1. Create a YAML configuration file for the service in `/etc/zinit`.

2. Monitor the new service:

```sh
zinit monitor <service-name>
```

### Controlling Services

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

- **Forget a service**:

```sh
zinit forget <service-name>
```

- **List all services**:

```sh
zinit list
```

- **View logs**:

```sh
zinit log [snapshot]
```

## Controlling Zinit with nc

Zinit uses a simple line protocol, so you can control it using `nc`:

```sh
sudo nc -U /var/run/zinit.sock
```

### Example Commands with nc

- List services:

```sh
echo "list" | sudo nc -U /var/run/zinit.sock
```

- Check status of a service:

```sh
echo "status <service-name>" | sudo nc -U /var/run/zinit.sock
```

## Conclusion

Zinit provides a robust and simple way to manage services in a Linux environment. By using Zinit's configuration files and commands, you can ensure that your services are always running and properly managed.

For more detailed information, refer to the [implementation](docs/implementation.md) and [protocol](docs/protocol.md) documentation.
