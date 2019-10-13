FROM alpine:3.6
LABEL maintainer="TekinTian tekintian@gmail.com"

RUN sed -i -e 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/' /etc/apk/repositories \
	&& apk add --no-cache --virtual .build-deps \
	    wget \
		unzip \
	\
	&& cd /tmp/ \
	&& wget https://github.com/tekintian/alpine/raw/master/zoneinfo.zip -O zoneinfo.zip --no-check-certificate \
	&& unzip zoneinfo.zip \
	&& mkdir -p /usr/share/zoneinfo \
	&& mv zoneinfo/* /usr/share/zoneinfo/ \
	&& rm -rf /etc/localtime \
	&& mkdir -p /usr/share/zoneinfo/Asia \
	&& ln -s /usr/share/zoneinfo/PRC /etc/localtime \
	&& ln -s /usr/share/zoneinfo/PRC /usr/share/zoneinfo/Asia/Shanghai \
	&& echo "Asia/Shanghai" >  /etc/timezone \
	&& rm -rf /var/cache/apk/* \
	&& apk del .build-deps