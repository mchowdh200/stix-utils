FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    clang \
    libclang-dev \
    curl \
    git \
    pkg-config \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Rust toolchain
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

ENV PATH="/root/.cargo/bin:${PATH}"

WORKDIR /app

# TODO instead, pull the git repo https://github.com/zhengxinchang/excord-lr
RUN git clone https://github.com/zhengxinchang/excord-lr


# Build the project
RUN cd excord-lr && cargo build --release

# Copy the built executable(s) to PATH
RUN cp excord-lr/target/release/excord-lr /usr/local/bin/

CMD ["/bin/bash"]
