#!/usr/bin/env bash

set -eux

pre_inst() {
    apt-get install --yes --no-install-recommends \
        coreutils \
        curl \
        tar \
        ca-certificates \
        build-essential \
        gcc
}

install_go() {
    local go_version="1.23.1"
    local os
    local arch
    os=$(uname | tr '[:upper:]' '[:lower:]')
    arch=$(uname -m)
    if [[ "${arch}" == "x86_64" ]]; then
        arch="amd64"
    elif [[ "${arch}" == "aarch64" ]]; then
        arch="arm64"
    elif [[ "${arch}" == "i686" || "${arch}" == "i386" ]]; then
        arch="386"
    fi
    local go_tarball="go${go_version}.${os}-${arch}.tar.gz"

    curl -LO "https://go.dev/dl/${go_tarball}"
    tar -C /usr/local -xzf "${go_tarball}"

    echo "export PATH=\$PATH:/usr/local/go/bin" >> "${HOME}/.bashrc"
    echo "export GOPATH=\${HOME}/go" >> "${HOME}/.bashrc"
    source "${HOME}/.bashrc"
}

main() {
    apt-get update

    pre_inst
    install_go
}

main