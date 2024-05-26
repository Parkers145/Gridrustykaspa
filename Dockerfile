FROM rust:latest AS kaspad-builder

ENV PATH="/root/.cargo/bin:$PATH"
ENV PROTOC=/usr/bin/protoc

# Install runtime dependencies
RUN apt-get update && apt-get install -y \
    curl git build-essential libssl-dev pkg-config \
    protobuf-compiler libprotobuf-dev \
    clang-format clang-tidy clang-tools clang clangd libc++-dev \
    libc++1 libc++abi-dev libc++abi1 libclang-dev libclang1 \
    liblldb-dev libllvm-ocaml-dev libomp-dev libomp5 lld lldb llvm-dev \
    llvm-runtime llvm python3-clang
	

# Update Rust and install wasm-pack
RUN rustup update && cargo install wasm-pack

# Add wasm32 target
RUN rustup target add wasm32-unknown-unknown

# Clone and build rusty-kaspa from kaspanet repository
RUN git clone https://github.com/kaspanet/rusty-kaspa.git /rusty-kaspa

# Install the Web Server to a temporary directory
WORKDIR /rusty-kaspa/wallet/wasm/web
RUN cargo install --root /tmp/basic-http-server basic-http-server

# Debug: List temporary directory to verify the binary installation
RUN ls -l /tmp/basic-http-server/bin

# Build the workspace including kaspad
WORKDIR /rusty-kaspa
RUN cargo build --release --bin kaspad

# Build the Kaspa Wallet 
WORKDIR /rusty-kaspa/wallet/native 
RUN cargo build --release --bin kaspa-wallet

# Build Rothschild 
WORKDIR /rusty-kaspa/rothschild
RUN cargo build --release --bin rothschild

# Build Simpa 
WORKDIR /rusty-kaspa/simpa 
RUN cargo build --release --bin simpa

# Prep Opencl for gpu miner build
RUN apt-get install -y ocl-icd-opencl-dev
ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/lib:/lib:/usr/lib/x86_64-linux-gnu

# Clone and build GPU miner 
WORKDIR /tmp/miner
RUN git clone https://github.com/tmrlvi/kaspa-miner.git
WORKDIR /tmp/miner/kaspa-miner
RUN cargo build --release -p kaspa-miner -p kaspaopencl

# Stage 2: Runtime
FROM ubuntu:latest

# Update the package list and upgrade existing packages
RUN apt-get update && apt-get upgrade -y

# Install necessary packages
RUN apt-get install -y \
    openssh-server \
	avahi-daemon \
	avahi-utils \
	ca-certificates \
	curl \
	wget \
	sudo \
    libstdc++6 \
    libgcc1 \
    libc6 \
    libssl3 

# Copy the application binary from the build stage
COPY --from=kaspad-builder /tmp/basic-http-server/bin/basic-http-server /usr/local/bin/basic-http-server
COPY --from=kaspad-builder /rusty-kaspa/target/release/kaspad /usr/local/bin/kaspad
COPY --from=kaspad-builder /rusty-kaspa/target/release/kaspa-wallet /usr/local/bin/kaspa-wallet
COPY --from=kaspad-builder /rusty-kaspa/target/release/rothschild /usr/local/bin/rothschild
COPY --from=kaspad-builder /rusty-kaspa/target/release/simpa /usr/local/bin/simpa
COPY --from=kaspad-builder /rusty-kaspa/wallet/wasm/web /app/web
COPY --from=kaspad-builder /tmp/miner/kaspa-miner/target/release/kaspa-miner /usr/local/bin/kaspa-miner
COPY --from=kaspad-builder /tmp/miner/kaspa-miner/target/release/libkaspaopencl.so /usr/local/bin/libkaspaopencl.so


# Create log directory
RUN mkdir -p /var/log

# Install Zinit
RUN curl -fsSL https://github.com/threefoldtech/zinit/releases/download/v0.2.14/zinit -o /usr/local/bin/zinit && chmod +x /usr/local/bin/zinit

# Copy Zinit configurations and start scripts
COPY zinit /etc/zinit

# Copy avahi-daemon configuration
COPY avahi-daemon.conf /etc/avahi/avahi-daemon.conf
COPY kaspa.service /etc/avahi/services/kaspa.service

# Copy SSH init script
COPY ssh-init.sh /usr/local/bin/ssh-init.sh
RUN chmod +x /usr/local/bin/ssh-init.sh
COPY monitor.sh /usr/local/bin/monitor.sh
RUN chmod +x /usr/local/bin/monitor.sh

# Expose necessary ports
EXPOSE  16110 16111 22 4000

# Use Zinit as the init system
ENTRYPOINT ["zinit", "init"]
