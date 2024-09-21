#!/usr/bin/env bash

set -eux

# Python EnvVars
export PYTHONFAULTHANDLER=1
export PYTHONUNBUFFERED=1
export PYTHONHASHSEED=random
export PYTHONDONTWRITEBYTECODE=1
# Pip EnvVars
export PIP_NO_CACHE_DIR=1
export PIP_DISABLE_PIP_VERSION_CHECK=1
export PIP_DEFAULT_TIMEOUT=100
export PIP_ROOT_USER_ACTION="ignore"


install_python3() {
    apt-get install --yes --no-install-recommends \
        software-properties-common \
        python3-launchpadlib \
        curl \
        gpg-agent
    add-apt-repository ppa:deadsnakes/ppa
    apt update
    apt-get install --yes --no-install-recommends \
        python3 \
        python3-pip \
        python3-venv \
        python3-dev
}

install_poetry() {
    # Poetry EnvVars
    export POETRY_HOME="/opt/poetry"
    export POETRY_VERSION="1.8.3"
    export POETRY_VIRTUALENVS_CREATE=false
    export POETRY_NO_INTERACTION=1
    export POETRY_CACHE_DIR="/var/cache/pypoetry"

    curl -sSL https://install.python-poetry.org | python3 -
    ${POETRY_HOME}/bin/poetry self add poetry-plugin-export
    ${POETRY_HOME}/bin/poetry self add poetry-plugin-bundle
    echo "export PATH=\$PATH:${POETRY_HOME}/bin" >> "${HOME}/.bashrc"
}

install_pipx() {
    apt-get install --yes --no-install-recommends \
        pipx
    pipx ensurepath
}

install_pyenv() {
    apt-get install --yes --no-install-recommends \
        make \
        build-essential \
        libssl-dev \
        zlib1g-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        wget \
        curl \
        llvm \
        libncurses5-dev \
        libncursesw5-dev \
        xz-utils \
        tk-dev \
        libffi-dev \
        liblzma-dev

    curl https://pyenv.run | bash
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> "${HOME}/.bashrc"
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> "${HOME}/.bashrc"
    echo 'eval "$(pyenv init -)"' >> "${HOME}/.bashrc"
    source "${HOME}/.bashrc"
}

install_pyenv_pythons() {
    local py_versions=(
        "2.7"
        "3.5"
        "3.6"
        "3.7"
        "3.8"
        "3.9"
        "3.10"
        "3.11"
        "3.12"
    )

    if ! command -v pyenv &> /dev/null; then
        install_pyenv
    fi
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"

    for py_version in "${py_versions[@]}"; do
        pyenv install "${py_version}"
    done
}

main() {
    apt-get update

    install_python3
    install_poetry
    install_pipx
    install_pyenv
#    install_pyenv_pythons
}

main
