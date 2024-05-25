### SSHD Service

**File: `zinit/sshd.yaml`**

```yaml
name: sshd
exec: /usr/sbin/sshd -D
oneshot: false
log: stdout
test: /usr/bin/pgrep sshd
after: ssh-init
```

### SSH Init Service

**File: `zinit/ssh-init.yaml`**

```yaml
name: ssh-init
exec: /usr/bin/ssh-init.sh
oneshot: true
log: stdout
```
```