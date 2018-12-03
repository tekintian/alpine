FROM alpine:latest
LABEL maintainer="TekinTian tekintian@gmail.com"

RUN sed -i -e 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories && \
  apk update && \
  apk add openrc --no-cache && \
  rm -rf /var/cache/apk/*
