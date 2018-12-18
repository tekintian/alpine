FROM alpine:latest
LABEL maintainer="TekinTian tekintian@gmail.com"

#set TimeZone
ARG TZ="Asia/Shanghai"
ENV TZ ${TZ}

RUN sed -i -e 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories && \
  apk update && \
  apk add openrc --no-cache && \
  ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime && \
  echo ${TZ} > /etc/timezone && \
  rm -rf /var/cache/apk/*
