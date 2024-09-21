#!/usr/bin/env bash

set -eux

install_basic() {
    apt-get install --yes --no-install-recommends \
        build-essential \
        cmake\
        make
}

install_c_cpp() {
    apt-get install --yes --no-install-recommends \
        gcc \
        g++
}

install_tools() {
    apt-get install --yes --no-install-recommends \
        clang \
        lldb \
        pkg-config \
        automake
}

main() {
    install_basic
    install_c_cpp
    install_tools
}

main
