ARG DEBIAN_VERSION=20240904

FROM debian:bookworm-${DEBIAN_VERSION}-slim

ARG INSTALL_SCRIPT_DIR="/opt/install_scripts"

ENV DEBIAN_FRONTEND=noninteractive

COPY install_scripts/ ${INSTALL_SCRIPT_DIR}/

RUN set -eux \
    && apt-get update \
    && apt-get install --yes --no-install-recommends \
        bash \
    && chmod +x ${INSTALL_SCRIPT_DIR}/*.sh


RUN set -eux \
    && ${INSTALL_SCRIPT_DIR}/install_commons.sh
RUN set -eux \
    && ${INSTALL_SCRIPT_DIR}/install_c_cpp.sh
RUN set -eux \
    && ${INSTALL_SCRIPT_DIR}/install_python.sh
RUN set -eux \
    && ${INSTALL_SCRIPT_DIR}/install_docker.sh


RUN set -eux \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /work_dir

CMD ["bash"]