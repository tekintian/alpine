#
# This is the alpine linux with glibc-i18n
# 带有glibc的alpine linux,  glibc为alpine系统运行java的必备库
# @author tekintian
# @url http://github.com/tekintian/alpin
# @glibcVersion  https://github.com/sgerrand/alpine-pkg-glibc/releases
# @jreVersion  https://www.java.com/en/download/manual.jsp
#
FROM alpine:3.9
LABEL maintainer="TekinTian tekintian@gmail.com"
ENV  LANG=C.UTF-8

RUN sed -i -e 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/' /etc/apk/repositories \
	&& apk update \
	&& apk add libstdc++ curl ca-certificates bash java-cacerts \
	&& apk add --no-cache --virtual .build-deps \
	    wget \
		unzip \
	\
	&& cd /tmp/ \
	&& wget http://192.168.2.8/zoneinfo.zip -O zoneinfo.zip --no-check-certificate \
	&& unzip zoneinfo.zip \
	&& mkdir -p /usr/share/zoneinfo \
	&& mv zoneinfo/* /usr/share/zoneinfo/ \
	&& rm -rf /etc/localtime \
	&& mkdir -p /usr/share/zoneinfo/Asia \
	&& ln -s /usr/share/zoneinfo/PRC /etc/localtime \
	&& ln -s /usr/share/zoneinfo/PRC /usr/share/zoneinfo/Asia/Shanghai \
	&& echo "Asia/Shanghai" >  /etc/timezone \
	&& wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
	&& cd /tmp/ \
	# 官方下载地址,网上太慢 https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.31-r0/glibc-2.31-r0.apk
	&& wget http://192.168.2.8/java/glibc-2.31-r0.apk \
	&& wget http://192.168.2.8/java/glibc-i18n-2.31-r0.apk \
	&& wget http://192.168.2.8/java/glibc-bin-2.31-r0.apk \
	&& apk add glibc-2.31-r0.apk glibc-bin-2.31-r0.apk glibc-i18n-2.31-r0.apk \
	# && /usr/glibc-compat/bin/localedef -i zh_CN -f UTF-8 zh_CN.UTF-8 \
	&&  ( /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 C.UTF-8 || true ) \
    && echo "export LANG=C.UTF-8" > /etc/profile.d/locale.sh \
    && /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib \
	&& rm -rf /tmp/* \
	&& rm -rf /var/cache/apk/* \
	&& apk del .build-deps