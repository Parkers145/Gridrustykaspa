# Avahi Configuration

This document provides detailed information about the Avahi configuration used in the Gridrustykaspa project.

## Overview

Avahi is used for mDNS to advertise the Kaspa service on the local network.

## Configuration Files

### avahi-daemon.conf

**File: `avahi-daemon.conf`**

```ini
[server]
host-name=kaspa
domain-name=local
use-ipv4=yes
use-ipv6=yes
allow-interfaces=eth0

[reflector]
enable-reflector=no

[publish]
publish-hinfo=yes
publish-workstation=yes
publish-addresses=yes
publish-domain=yes

[rlimits]
rlimit-as=204800000
rlimit-core=0
rlimit-data=4194304
rlimit-fsize=0
rlimit-nofile=300
rlimit-stack=4194304
rlimit-nproc=3
```

### kaspa.service

**File: `kaspa.service`**

```xml
<?xml version="1.0" standalone='no'?>
<!DOCTYPE service-group SYSTEM "avahi-service.dtd">

<service-group>
  <name replace-wildcards="yes">Kaspa Node on %h</name>
  <service>
    <type>_http._tcp</type>
    <port>80</port>
  </service>
</service-group>
```
