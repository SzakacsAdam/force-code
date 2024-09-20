#!/usr/bin/env bash

set -eux

remove_docker_packages() {
    local packages=(
        docker.io
        docker-doc
        docker-compose
        podman-docker
        containerd runc
    )
    for pkg in "${packages[@]}"; do
        apt-get remove "$pkg"
    done
}

setup_docker() {
    local docker_url="https://download.docker.com/linux/debian"
    local docker_gpg_key_url="${docker_url}/gpg"
    local docker_apt_source="/etc/apt/sources.list.d/docker.list"
    local apt_keyring_dir="/etc/apt/keyrings"
    local docker_keyring="$apt_keyring_dir/docker.asc"
    local os_codename
    os_codename=$(grep VERSION_CODENAME /etc/os-release | cut -d '=' -f 2)

    apt-get install --yes --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

    install -m 0755 -d ${apt_keyring_dir}
    curl -fsSL ${docker_gpg_key_url} -o ${docker_keyring}
    chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=$docker_keyring] ${docker_url} \
      $os_codename stable" | tee "$docker_apt_source" > /dev/null
    apt-get update

}

install_docker_packages() {
    local docker_packages=(
        docker-ce
        docker-ce-cli
        containerd.io
        docker-buildx-plugin
        docker-compose-plugin
        docker-scan-plugin
    )
    apt-get install -y "${docker_packages[@]}"
}

main() {
    remove_docker_packages
    setup_docker
    install_docker_packages
}

main