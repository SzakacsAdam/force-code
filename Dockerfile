ARG DEBIAN_VERSION=20240904

FROM debian:bookworm-${DEBIAN_VERSION}-slim

ARG INSTALL_SCRIPT_DIR="/opt/install_scripts"

ENV DEBIAN_FRONTEND=noninteractive

RUN set -eux \
    && apt-get update \
    && apt-get install --yes --no-install-recommends \
        bash

COPY install_scripts/ ${INSTALL_SCRIPT_DIR}/

RUN set -eux \
    && chmod +x ${INSTALL_SCRIPT_DIR}/*.sh \
    && ${INSTALL_SCRIPT_DIR}/install_commons.sh \
    && ${INSTALL_SCRIPT_DIR}/install_python.sh \
    && ${INSTALL_SCRIPT_DIR}/install_docker.sh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /work_dir

CMD ["bash"]