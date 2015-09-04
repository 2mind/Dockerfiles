FROM alpine:3.2
MAINTAINER SHS <shs@overstack.ru>

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk update && apk upgrade \
    apk add curl bash jq tar gzip ca-certificates consul && \
    rm -rf /var/cache/apk/* /usr/local/src/*
