FROM alpine:latest
LABEL maintainer="TekinTian tekintian@gmail.com"

COPY /zoneinfo /usr/share/

RUN sed -i -e 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories && \
  apk update && \
  apk add --no-cache openrc && \
  rm -rf /etc/localtime && \
  mkdir -p /usr/share/zoneinfo/Asia && \
  ln -s /usr/share/zoneinfo/PRC /etc/localtime && \
  ln -s /usr/share/zoneinfo/PRC /usr/share/zoneinfo/Asia/Shanghai && \
  echo "Asia/Shanghai" >  /etc/timezone && \
  rm -rf /var/cache/apk/*
