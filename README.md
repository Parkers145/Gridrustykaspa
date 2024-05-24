### README.md

# Rusty Kaspa Docker Deployment

This repository provides a Docker configuration for a zero-configuration deployment of the Rusty Kaspa node, web GUI wallet, and mining interface. This setup includes a web server for the wallet interface, NGINX as a reverse proxy, and Supervisor to manage services.

## Goals

- **Zero Configuration Deployment**: Simplify the deployment process for Rusty Kaspa.
- **Web GUI Wallet**: Provide a user-friendly web interface for managing Kaspa wallets.
- **GUI Mining**: Enable graphical user interface for mining operations.

## Repository

For more information about Rusty Kaspa, visit the [Rusty Kaspa GitHub repository](https://github.com/kaspanet/rusty-kaspa).

## Implementation

### Dockerfile Overview

The Dockerfile sets up the following components:
- **Rusty Kaspa Node**: Runs the main Kaspa node.
- **Web Wallet Server**: Serves the wallet interface using `basic-http-server`.
- **NGINX**: Acts as a reverse proxy to route requests to the web wallet and API.
- **Supervisor**: Manages and monitors the services to ensure they are always running.

### Build and Run

To build and run the Docker container, execute the following commands:

```sh
docker build -t my-kaspad-server .
docker run -d -p 80:80 -p 22:22 -p 4000:4000 my-kaspad-server
```

### Accessing Services

- **Web Interface**: Accessible at `http://localhost`.
- **API**: Accessible through NGINX proxy at `http://localhost/api`.
- **SSH**: Accessible on port 22.

### Service Logs

To view the logs for the running services, use the following commands:

- **Kaspad Logs**:
  ```sh
  docker exec -it <container_id> tail -f /var/log/kaspad.out.log
  ```

- **NGINX Logs**:
  ```sh
  docker exec -it <container_id> tail -f /var/log/nginx.out.log
  ```

- **Basic HTTP Server Logs**:
  ```sh
  docker exec -it <container_id> tail -f /var/log/basic-http-server.out.log
  ```

### Accessing the Web Interface

- **Web Wallet**: Visit `http://localhost` in your web browser.
- **Mining GUI**: Accessible through the web interface if implemented.

## To Do List

1. **Fix Web Servers**: Resolve the "refused to connect" issue with the web servers.
2. **Determine Additional Applications**: Identify if other applications need to run alongside the current setup.
3. **Implement GPU Mining**: Explore the possibility of adding GPU mining support and integrating it with the web interface.
4. **Syncing Issue**: Investigate why Kaspad takes 8 minutes to start syncing and optimize the process.
5. **SSHD Configuration**: Modify SSHD settings to be more secure and grid-ready, avoiding password-based SSH access.

## Entry Point

The entry point for the Docker container is set to:
```sh
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf -n
```

This ensures Supervisor starts and manages all the necessary services.

---

This README provides a comprehensive guide to deploying and managing the Rusty Kaspa node and associated services using Docker. For more detailed information and updates, refer to the [Rusty Kaspa GitHub repository](https://github.com/kaspanet/rusty-kaspa).
