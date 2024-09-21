#!/usr/bin/env bash

set -eux

install_core_apps() {
    apt-get install --yes --no-install-recommends \
        coreutils \
        build-essential \
        software-properties-common \
        ca-certificates \
        openssl \
        apt-transport-https \
        lsb-release
}

install_common_tools() {
    apt-get install --yes --no-install-recommends \
        curl \
        wget \
        jq \
        openssh-client \
        gnupg \
        make
}

install_text_related() {
    apt-get install --yes --no-install-recommends \
        nano \
        sed \
        gawk \
        grep
}

install_network_tools() {
    apt-get install --yes --no-install-recommends \
        net-tools \
        nmap \
        telnet \
        dnsutils \
        netcat-traditional \
        netcat-openbsd \
        traceroute \
        tcpdump \
        iperf3
}

install_file_related() {
    apt-get install --yes --no-install-recommends \
        mc \
        tree \
        rsync \
        unzip \
        zip
}

install_system_monitoring_tools() {
    apt-get install --yes --no-install-recommends \
        htop \
        iotop \
        iftop \
        sysstat \
        glances \
        nmon
}

install_git () {
    apt-get install --yes --no-install-recommends \
        git
    git config --global --add safe.directory '*'
}

main() {
    apt-get update

    install_core_apps
    install_common_tools
    install_text_related
    install_network_tools
    install_file_related
    install_system_monitoring_tools
    install_git
}

main