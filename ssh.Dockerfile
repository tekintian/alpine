FROM alpine:latest
LABEL maintainer="TekinTian tekintian@gmail.com"

RUN sed -i -e 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories \
	&& apk add --no-cache --virtual .build-deps \
	    wget \
		unzip \
	\
	&& cd /tmp/ \
	&& wget https://github.com/tekintian/alpine/raw/master/zoneinfo.zip -O zoneinfo.zip \
	&& unzip zoneinfo.zip \
	&& mkdir -p /usr/share/zoneinfo \
	&& mv zoneinfo/* /usr/share/zoneinfo/ \
	&& rm -rf /etc/localtime \
	&& mkdir -p /usr/share/zoneinfo/Asia \
	&& ln -s /usr/share/zoneinfo/PRC /etc/localtime \
	&& ln -s /usr/share/zoneinfo/PRC /usr/share/zoneinfo/Asia/Shanghai \
	&& echo "Asia/Shanghai" >  /etc/timezone \
	\
	#install openssh-server
	&& apk add openrc openssh-server --no-cache \
	&& rc-update add sshd \
	&& mkdir -p /run/openrc \
    && touch /run/openrc/softlevel \
    && sed -i "s@^#Port.*@&\nPort 22@" /etc/ssh/sshd_config \
    && sed -i "s@^#PasswordAuthentication yes@&\nPasswordAuthentication yes@" /etc/ssh/sshd_config \
    && sed -i "s@^#PermitRootLogin.*@&\nPermitRootLogin yes@" /etc/ssh/sshd_config \
	&& rm -rf /var/cache/apk/* \
	&& apk del .build-deps

#设置默认入口程序
ENTRYPOINT ["/bin/sh"]

EXPOSE 22
WORKDIR /home