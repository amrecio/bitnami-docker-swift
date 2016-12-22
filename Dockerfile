## BUILDING
##   (from project root directory)
##   $ docker build -t bitnami-bitnami-docker-swift .
##
## RUNNING
##   $ docker run -p 80:80 bitnami-bitnami-docker-swift
##

FROM gcr.io/stacksmith-images/minideb-buildpack:jessie-r7

MAINTAINER Bitnami <containers@bitnami.com>

# Install related packages
RUN apt-get update && \
    apt-get install -y clang libedit2 libicu52 libsqlite3-dev libxml2 && \
    apt-get clean && \
    rm -rf /var/lib/apt /var/cache/apt/archives/* /tmp/*

# System packages required
RUN install_packages --no-install-recommends libc6 libtinfo5 zlib1g libuuid1 libstdc++6 libgcc1 libxml2 libcurl3 liblzma5 libidn11 librtmp1 libssh2-1 libssl1.0.0 libgssapi-krb5-2 libkrb5-3 libk5crypto3 libcomerr2 libldap-2.4-2 libbsd0 libgnutls-deb0-28 libhogweed2 libnettle4 libgmp10 libgcrypt20 libkrb5support0 libkeyutils1 libsasl2-2 libp11-kit0 libtasn1-6 libgpg-error0 libffi6 libedit2 libncurses5 libsqlite3-0 python libpython2.7 clang libicu52 libsqlite3-dev

# Swift module
RUN bitnami-pkg install swift-3.0.1-RELEASE-1 --checksum 1359294954925a312310314372d5bfa4b6ec893052ed9cba39ea071d5a5ab79a

ENV PATH=/opt/bitnami/swift/bin:$PATH

RUN chown -R bitnami:bitnami /opt/bitnami/swift

# Swift template
ENV BITNAMI_APP_NAME=swift \
    BITNAMI_IMAGE_VERSION=3.0.1-RELEASE-r2

COPY rootfs/ /

USER bitnami

WORKDIR /app
EXPOSE 80

ENTRYPOINT ["/app-entrypoint.sh"]
CMD ["swift", "app", "start"]
