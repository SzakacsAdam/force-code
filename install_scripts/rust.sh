#!/usr/bin/env bash

set -eux

pre_inst() {
    apt-get install --yes --no-install-recommends \
        curl \
        build-essential \
        gcc \
        pkg-config \
        libssl-dev \
        libclang-dev \
        ca-certificates
}

install_rust_up() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "${HOME}/.cargo/env"
}

main() {
    apt-get update

    pre_inst
    install_rust_up
}

main