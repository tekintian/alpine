FROM alpine:latest
LABEL maintainer="TekinTian tekintian@gmail.com"

RUN sed -i -e 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories && \
  apk update && \
  apk add --no-cache openrc tzdata && \
  cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
  echo "Asia/Shanghai" >  /etc/timezone && \
  apk del tzdata && \
  rm -rf /var/cache/apk/*
