FROM bitnami/minideb-extras:jessie-r22
LABEL maintainer "Bitnami <containers@bitnami.com>"

ENV BITNAMI_PKG_CHMOD="-R g+rwX" \
    HOME="/"

# Install required system packages and dependencies
RUN bitnami-pkg unpack redis-4.0.2-1 --checksum 263ffd64c6d99b9a68d911d6e263e05d4e96f6c1288c1b38a042e504a954129e

RUN install_packages build-essential ca-certificates curl git libbz2-1.0 libc6 libncurses5 libreadline6 libsqlite3-0 libssl1.0.0 libtinfo5 pkg-config unzip wget zlib1g

RUN wget -nc -P /tmp/bitnami/pkg/cache/ https://downloads.bitnami.com/files/stacksmith/python-2.7.14-0-linux-x64-debian-8.tar.gz && \
    echo "2ad513d9d4d4e2c2f98d96448617b5ab3c5dd48dc2e3cb02080ecc7215039ffa  /tmp/bitnami/pkg/cache/python-2.7.14-0-linux-x64-debian-8.tar.gz" | sha256sum -c - && \
    tar -zxf /tmp/bitnami/pkg/cache/python-2.7.14-0-linux-x64-debian-8.tar.gz -P --transform 's|^[^/]*/files|/opt/bitnami|' --wildcards '*/files' && \
    rm -rf /tmp/bitnami/pkg/cache/python-2.7.14-0-linux-x64-debian-8.tar.gz


COPY rootfs /

ENV ALLOW_EMPTY_PASSWORD="no" \
    BITNAMI_APP_NAME="python-redis" \
    BITNAMI_IMAGE_VERSION="1" \
    PATH="/opt/bitnami/python/bin:/opt/bitnami/redis/bin:$PATH" \
    REDIS_MASTER_HOST="" \
    REDIS_MASTER_PASSWORD="" \
    REDIS_MASTER_PORT_NUMBER="6379" \
    REDIS_PASSWORD="" \
    REDIS_REPLICATION_MODE=""

EXPOSE 6379
EXPOSE 8000

WORKDIR /app

USER 1001
ENTRYPOINT ["/app-entrypoint.sh"]
CMD ["/run.sh"]

