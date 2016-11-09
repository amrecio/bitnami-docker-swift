## BUILDING
##   (from project root directory)
##   $ docker build -t bitnami-bitnami-docker-swift .
##
## RUNNING
##   $ docker run -p 80:80 bitnami-bitnami-docker-swift
##

FROM gcr.io/stacksmith-images/minideb-buildpack:jessie-r2

MAINTAINER Bitnami <containers@bitnami.com>

# Install related packages
RUN apt-get update && \
    apt-get install -y clang libedit2 libicu52 libsqlite3-dev libxml2 && \
    apt-get clean

# Install related packages
RUN bitnami-pkg install python-2.7.12-1 --checksum 1ab49b32453c509cf6ff3abb9dbe8a411053e3b811753a10c7a77b4bc19606df

# Swift module
RUN bitnami-pkg install swift-3.0.1-RELEASE-0 --checksum 4ae1a8804910f5f265133edf2897d86b9aac3daacbe51ab30bd29bd2a12acce7

ENV PATH=/opt/bitnami/python/bin:$PATH
ENV PATH=/opt/bitnami/swift/bin:$PATH

RUN chown -R bitnami:bitnami /opt/bitnami/swift

# Swift template
ENV BITNAMI_APP_NAME=swift \
    BITNAMI_IMAGE_VERSION=3.0.1-RELEASE-r0

COPY rootfs/ /

USER bitnami

WORKDIR /app
EXPOSE 80

ENTRYPOINT ["/app-entrypoint.sh"]
CMD ["swift", "app", "start"]
