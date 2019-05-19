# Alpine Docker Container for China User

Change the mirror to mirrors.aliyun.com
Add default time zone for Asia/Shanghai,
For more info about [TIME ZONE](https://timezonedb.com/time-zones) 
 [Alpine Linux Setting the time zone](https://wiki.alpinelinux.org/wiki/Setting_the_timezone)

tekintian/alpine:latest  安装了openrc 管理工具的 Alpine Docker 镜像

mini install with aliyun cdn

tekintian/alpine:3.9
tekintian/alpine:3.8
tekintian/alpine:3.7
tekintian/alpine:3.6

集成了SSH服务端的alpine 3.8 docker images:
tekintian/alpine:ssh

暴露端口 22 ，  -p /yourlocaldir:/home 将本地文件夹/yourlocaldir 映射到alpine容器 /home文件夹

docker run -it -d --name alpine -p 22:22 -v /yourlocaldir:/home  tekintian/alpine:3.9-ssh

设置SSH登录密码
~~~shell
docker exec -it alpine sh
#设置ROOT用户密码
passwd
~~~


## Alpine Linux 包管理

  ```shell
  apk update
  apk search
  apk add
  apk info
  apk upgrade
  apk del
  ```

- Alpine Linux服务管理
  rc-update
  rc-status
  rc-service
  openrc

## 常用的RC系列命令

  1.安装软件包实例

  ```
  # 安装SSHD服务
  apk add --no-cache openssh-server
  # 增加服务到系统启动时运行，下例为sshd
  rc-update add sshd boot
  
  # 安装 nodejs
  apk add --no-cache nodejs
  
  #安装Nginx软件并更新到最新，
  apk add --update nginx   
  
  #手工启动Nginx
  /etc/init.d/nginx  
  
  #将Nginx添加到启动服务中，下次开机自动运行
  rc-update add nginx
  
  # 重启服务
  rc-service nginx restart
  
  # 列出所有服务
  rc-status -a
  ```


运行一个alpine镜像，并安装 openssh

```shell
docker run -it --rm alpine /bin/ash
# 更新源
# apk update
# 安装openssh
# apk add openssh
```

```shell
更新国内源

# Alpine的源文件为：
/etc/apk/repositories，

# 本镜像默认的源地址为：http://dl-cdn.alpinelinux.org/

更换阿里云为中国科技大学的源CDN:
sed -i -e 's/mirrors.aliyun.com/mirrors.ustc.edu.cn/' /etc/apk/repositories


#可以编辑源文件 /etc/apk/repositories，
#采用国内阿里云的源，文件内容为：
https://mirrors.aliyun.com/alpine/v3.9/main/
https://mirrors.aliyun.com/alpine/v3.9/community/

 

# 如果采用中国科技大学的源，文件内容为：
https://mirrors.ustc.edu.cn/alpine/v3.9/main/
https://mirrors.ustc.edu.cn/alpine/v3.9/community/

```

/Bitbucket/tools/Alpine

- 容器build
~~~shell
docker build -f ssh.Dockerfile -t tekintian/alpine:3.9-ssh .
docker build -f 3.9rc.Dockerfile -t tekintian/alpine:3.9rc .

docker build -f Dockerfile -t tekintian/alpine .

docker build -f 3.9.Dockerfile -t tekintian/alpine:3.9 .
docker build -f 3.8.Dockerfile -t tekintian/alpine:3.8 .
docker build -f 3.7.Dockerfile -t tekintian/alpine:3.7 .
docker build -f 3.6.Dockerfile -t tekintian/alpine:3.6 .

~~~

## Support 技术支持

​	需要其他的特定环境或则模块支持，可联系定制开发容器 ， Email: tekintian@gmail.com  QQ:932256355



如果您觉得本项目对您有用，请打赏支持开发，谢谢！

![donate](donate.png)