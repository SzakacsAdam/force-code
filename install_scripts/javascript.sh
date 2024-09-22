#!/usr/bin/env bash

set -eux

install_node_js() {
    apt-get install --yes --no-install-recommends \
        nodejs
}

install_npm() {
    apt-get install --yes --no-install-recommends \
        npm
}

main() {
    apt-get update

    install_node_js
    install_npm
}

main