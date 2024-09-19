ARG DEBIAN_VERSION=20240904

FROM debian:bookworm-${DEBIAN_VERSION}-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN set -eux \
    && apt-get update \
    && apt-get install --yes --no-install-recoomends \
        bash

CMD ["bash"]