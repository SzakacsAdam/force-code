#!/usr/bin/env bash
# TODO FINISH
set -eux

install_zsh() {
    apt-get install --yes --no-install-recommends \
        curl \
        zsh \
        zplug
}

install_ohmyzsh() {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    chsh -s "$(which zsh)"
}

main() {
    apt-get update

    install_zsh
    install_ohmyzsh
}
