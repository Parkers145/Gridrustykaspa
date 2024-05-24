# Use the official Ubuntu base image
FROM ubuntu:22.04

# Set environment variables to non-interactive for apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Update and install prerequisites
RUN apt-get update && apt-get install -y \
    curl git build-essential libssl-dev pkg-config \
    protobuf-compiler libprotobuf-dev \
    clang-format clang-tidy clang-tools clang clangd libc++-dev \
    libc++1 libc++abi-dev libc++abi1 libclang-dev libclang1 \
    liblldb-dev libllvm-ocaml-dev libomp-dev libomp5 lld lldb llvm-dev \
    llvm-runtime llvm python3-clang \
    nginx openssh-server \
    supervisor

# Install Rust toolchain
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Set environment variables for Rust
ENV PATH=/root/.cargo/bin:$PATH

# Update Rust and install wasm-pack
RUN rustup update && cargo install wasm-pack

# Add wasm32 target
RUN rustup target add wasm32-unknown-unknown

# Clone the repository for Rusty-Kaspa
RUN git clone https://github.com/kaspanet/rusty-kaspa /root/rusty-kaspa

# Navigate to the web wallet directory and install the basic-http-server
RUN cd /root/rusty-kaspa/wallet/wasm/web && cargo install basic-http-server

# Configure NGINX using a heredoc
RUN rm /etc/nginx/sites-enabled/default && \
    cat > /etc/nginx/sites-available/default <<EOF
server {
    listen 80;
    server_name localhost;
    root /root/rusty-kaspa/wallet/wasm/web;
    index index.html;
    location / {
        try_files \$uri /index.html;
    }
    location /api/ {
        proxy_pass http://localhost:4000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

# Configure SSH server
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    echo 'root:yourpassword' | chpasswd

# Create Supervisor configuration directory
RUN mkdir -p /etc/supervisor/conf.d

# Create Supervisor configuration file for kaspad using heredoc
RUN cat > /etc/supervisor/conf.d/kaspad.conf <<EOF
[program:kaspad]
command=/root/.cargo/bin/cargo run --release --bin kaspad
directory=/root/rusty-kaspa
autostart=true
autorestart=true
stderr_logfile=/var/log/kaspad.err.log
stdout_logfile=/var/log/kaspad.out.log
user=root
EOF

# Create Supervisor configuration file for nginx using heredoc
RUN cat > /etc/supervisor/conf.d/nginx.conf <<EOF
[program:nginx]
command=nginx -g "daemon off;"
autostart=true
autorestart=true
stderr_logfile=/var/log/nginx.err.log
stdout_logfile=/var/log/nginx.out.log
user=root
EOF

# Create Supervisor configuration file for basic-http-server using heredoc
RUN cat > /etc/supervisor/conf.d/basic-http-server.conf <<EOF
[program:basic-http-server]
command=/root/.cargo/bin/basic-http-server /root/rusty-kaspa/wallet/wasm/web
directory=/root/rusty-kaspa/wallet/wasm/web
autostart=true
autorestart=true
stderr_logfile=/var/log/basic-http-server.err.log
stdout_logfile=/var/log/basic-http-server.out.log
user=root
EOF

# Expose ports
EXPOSE 80 22 4000

# Start Supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf", "-n"]
