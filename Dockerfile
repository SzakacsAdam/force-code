ARG DEBIAN_VERSION=20240904

FROM debian:bookworm-${DEBIAN_VERSION}-slim

ARG INSTALL_SCRIPT_DIR="/opt/install_scripts"
ARG CMD_SCRIPT_DIR="/usr/local/bin"

ENV \
    DEBIAN_FRONTEND="noninteractive" \
    PATH="/usr/local/bin:${PATH}"

COPY install_scripts/ ${INSTALL_SCRIPT_DIR}/
COPY scripts/ ${CMD_SCRIPT_DIR}/

RUN set -eux \
    && apt-get update \
    && apt-get install --yes --no-install-recommends \
        bash \
    && chmod +x ${INSTALL_SCRIPT_DIR}/*.sh \
    && chmod +x ${CMD_SCRIPT_DIR}/*


RUN set -eux \
    && ${INSTALL_SCRIPT_DIR}/commons.sh
RUN set -eux \
    && ${INSTALL_SCRIPT_DIR}/c_cpp.sh
RUN set -eux \
    && ${INSTALL_SCRIPT_DIR}/python.sh
RUN set -eux \
    && ${INSTALL_SCRIPT_DIR}/docker.sh
RUN set -eux \
    && ${INSTALL_SCRIPT_DIR}/javascript.sh
RUN set -eux \
    && ${INSTALL_SCRIPT_DIR}/rust.sh
RUN set -eux \
    && ${INSTALL_SCRIPT_DIR}/go.sh


RUN set -eux \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /work_dir

CMD ["bash"]