# SSH Configuration

This document provides detailed information about the SSH configuration used in the Gridrustykaspa project.

## Overview

The SSH server is configured to allow access to the Docker container.

## Configuration Files

### SSH Init Script

**File: `ssh-init.sh`**

```bash
#!/bin/bash

# Create necessary directories
mkdir -p /run/sshd
mkdir -p /root/.ssh

# Copy authorized keys from environment variable
if [ -n "$SSH_AUTHORIZED_KEYS" ]; then
  echo "$SSH_AUTHORIZED_KEYS" > /root/.ssh/authorized_keys
  chmod 600 /root/.ssh/authorized_keys
fi

# Ensure proper permissions and ownership
chown -R root:root /root/.ssh
chmod 700 /root/.ssh
```
