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
    echo "export PATH=\$PATH:${POETRY_HOME}/bin" >> "${HOME}/.bashrc"
}

main() {
    install_python3
    install_poetry
}
main
