# Zinit Configuration

This document provides detailed information about the Zinit configuration used in the Gridrustykaspa project.

## Table of Contents

- [Overview](#overview)
- [Service Configuration](#service-configuration)
  - [Kaspad Service](#kaspad-service)
  - [API Service](#api-service)
  - [Avahi-daemon Service](#avahi-daemon-service)
  - [SSHD Service](#sshd-service)
  - [SSH Init Service](#ssh-init-service)

## Overview

Zinit is used to manage the services in the Gridrustykaspa project. The configuration files are located in the `zinit` directory.

## Service Configuration

### Kaspad Service

**File: `zinit/kaspad.yaml`**

```yaml
name: kaspad
exec: /usr/local/bin/kaspad
oneshot: false
log: stdout
test: /usr/bin/pgrep kaspad
```

### API Service

**File: `zinit/api.yaml`**

```yaml
name: api
exec: /usr/local/bin/api
oneshot: false
log: stdout
test: /usr/bin/pgrep api
```

### Avahi-daemon Service

**File: `zinit/avahi-daemon.yaml`**

```yaml
name: avahi-daemon
exec: /usr/sbin/avahi-daemon -D
oneshot: false
log: stdout
test: /usr/bin/pgrep avahi-daemon
```