#!/bin/sh

mkdir -p /var/run/sshd
mkdir -p /root/.ssh
touch /root/.ssh/authorized_keys

chmod 700 /root/.ssh
chmod 644 /root/.ssh/authorized_keys