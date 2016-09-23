## BUILDING
##   (from project root directory)
##   $ docker build -t bitnami-bitnami-docker-swift .
##
## RUNNING
##   $ docker run -p 80:80 bitnami-bitnami-docker-swift
##

FROM gcr.io/stacksmith-images/ubuntu-buildpack:14.04-r10

MAINTAINER Bitnami <containers@bitnami.com>

# Install related packages
RUN apt-get update && \
    apt-get install -y clang libedit2 libicu52 libsqlite3-dev libxml2 && \
    apt-get clean

# Install related packages
RUN bitnami-pkg install python-2.7.12rc1-0 --checksum 2c56021761411358b949fa0c962d61875d70f5b092fc937dceea1b52ce8440d5

# Swift module
RUN bitnami-pkg install swift-3.0-RELEASE-0 --checksum 260203f5915cd861c47adc6b9f2fb261702be9bebfcd82b056b7c15c50894043

ENV PATH=/opt/bitnami/python/bin:$PATH
ENV PATH=/opt/bitnami/swift/bin:$PATH

RUN chown -R bitnami:bitnami /opt/bitnami/swift

# Swift template
ENV BITNAMI_APP_NAME=swift \
    BITNAMI_IMAGE_VERSION=3.0-RELEASE-r0

COPY rootfs/ /

USER bitnami

WORKDIR /app
EXPOSE 80

ENTRYPOINT ["/app-entrypoint.sh"]
CMD ["swift", "app", "start"]
