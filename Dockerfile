## BUILDING
##   (from project root directory)
##   $ docker build -t bitnami-bitnami-docker-swift .
##
## RUNNING
##   $ docker run -p 80:80 bitnami-bitnami-docker-swift
##
## CONNECTING
##   Lookup the IP of your active docker host using:
##     $ docker-machine ip $(docker-machine active)
##   Connect to the container at DOCKER_IP:80
##     replacing DOCKER_IP for the IP of your active docker host

FROM gcr.io/stacksmith-images/ubuntu-buildpack:14.04-r8

MAINTAINER Bitnami <containers@bitnami.com>

# Install related packages
RUN apt-get update && \
    apt-get install -y clang libedit2 libicu52 libsqlite3-dev libxml2 && \
    apt-get clean

# Install related packages
RUN bitnami-pkg install python-2.7.12rc1-0 --checksum 2c56021761411358b949fa0c962d61875d70f5b092fc937dceea1b52ce8440d5

# Swift module
RUN bitnami-pkg install swift-3.0-PREVIEW-6-0 --checksum 36e3739c1a22bec70a4f256ff82aab10fc1996f89d85a050fe6b9cb072b3fb94

ENV PATH=/opt/bitnami/python/bin:$PATH
ENV PATH=/opt/bitnami/swift/bin:$PATH

RUN chown -R bitnami:bitnami /opt/bitnami/swift

## STACKSMITH-END: Modifications below this line will be unchanged when regenerating

# Swift template
ENV BITNAMI_APP_NAME=swift \
    BITNAMI_IMAGE_VERSION=3.0-PREVIEW-6

COPY rootfs/ /

USER bitnami

WORKDIR /app
EXPOSE 80

ENTRYPOINT ["/app-entrypoint.sh"]
CMD ["swift", "app", "start"]
