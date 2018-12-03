# Alpine Docker Container for China User

更换了国内源，和安装了openrc 管理工具的 Alpine Docker 镜像





- Alpine Linux 包管理

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

- 常用的RC系列命令

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
# 国内用户建议先先替换alpine的源为aliyun, 否则很慢！！ 
# sed -i -e 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories
# 更新源
# apk update
# 安装openssh
# apk add openssh
```

```shell
更新国内源

# Alpine的源文件为：
/etc/apk/repositories，

# 默认的源地址为：http://dl-cdn.alpinelinux.org/


#可以编辑源文件 /etc/apk/repositories，
#采用国内阿里云的源，文件内容为：
https://mirrors.aliyun.com/alpine/v3.6/main/
https://mirrors.aliyun.com/alpine/v3.6/community/

 

# 如果采用中国科技大学的源，文件内容为：
https://mirrors.ustc.edu.cn/alpine/v3.6/main/
https://mirrors.ustc.edu.cn/alpine/v3.6/community/

```



