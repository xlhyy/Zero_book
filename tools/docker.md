# docker


* docker: [docker入门](https://www.cnblogs.com/pyyu/p/9485268.html)


## 安装docker

```
brew cask install docker
```


## docker命令

```
docker --help
docker --version
docker search mac                           # 搜索所有mac的docker镜像
docker pull centos                          # 获取centos镜像


docker image ls                             # 列出所有的image文件
docker images                               # 列出所有的image文件
    注释:
        REPOSITORY: 来自哪个仓库
        TAG: 标签
        IMAGE ID: 唯一ID
        CREATED: 创建时间
        SIZE: 大小
docker image rm [imagename]                         # 删除image文件


docker run hello-world                              # 使用该镜像创建一个容器并启动(若有命令，则相当于在该容器下直接执行该命令)
docker run -it centos [命令行命令]
docker run --name mydocker -it --rm centos [命令行命令]
docker run -d centos /bin/sh -c "while true;do echo hello centos; sleep 1;done"
    参数:
        --name: 给容器定义一个名称
        -i: 让容器的标准输入保持打开(交互式操作)
        -t: 让docker分配一个伪终端
        -rm: 容器退出后将其删除。也可以不指定参数，手动docker rm，使用-rm可以避免浪费空间
        -d: 后台运行容器


docker rmi imageID                                  # 删除docker镜像
    注意:
        在删除镜像之前先用docker rm删除依赖于这个镜像的所有容器
        docker rm 命令是移除容器
docker save centos > //Users/kaiqigu/dododo/centos.tar.gz     # 导出docker镜像至本地
docker load < /Users/kaiqigu/dododo/centos.tar.gz             # 从本地文件中导入到本地docker镜像库

docker ps                       # 检查docker容器进程
docker ps -a                    # 检查所有运行过的容器
docker logs CONTAINER_ID        # 查看容器内的标准输出
docker logs -f CONTAINER_ID     # 不间断显示容器内的标准输出
docker stop CONTAINER_ID        # 停止容器
docker start CONTAINER_ID       # 启动容器
docker rm CONTAINER_ID          # 删除容器
docker attach CONTAINER_ID      # 容器进入后台后，再次进入容器进行操作

docker commit CONTAINER_ID 新镜像名字    # 创建新的自定义镜像
docker container ls -a                  # 查看容器记录

docker port CONTAINER_ID        # 查看指定容器的端口映射
docker top CONTAINER_ID         # 查看容器内的进程
```


## 后台模式启动docker

```
[root@oldboy_python ~ 15:58:14]#docker run -d centos /bin/sh -c "while true;do echo hello centos; sleep 1;done"
c0283f1077d16a2bf2597e269d51a02815334f7390f18a62ed7a4ba07f351b65

#检查容器进程
[root@oldboy_python ~ 15:58:22]#docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
c0283f1077d1        centos              "/bin/sh -c 'while..."   6 seconds ago       Up 5 seconds                            fervent_turing
```


## 提交创建自定义的镜像

```
1.我们进入交互式的centos容器中，发现没有vim命令
docker run -it centos

2.在当前容器中，安装一个vim
yum install -y vim

3.安装好vim之后，exit退出容器
exit

4.查看刚才安装好vim的容器记录
docker container ls -a

5.提交这个容器，创建新的image
docker commit 059fdea031ba chaoyu/centos-vim

6.查看镜像文件
[root@master /home]docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
chaoyu/centos-vim   latest              fd2685ae25fe        5 minutes ago       348MB
```


## 当利用docker run来创建容器时，docker在后台运行的标准操作包括

```
检查本地是否存在指定的镜像，不存在就从公有仓库下载
利用镜像创建并启动一个容器
分配一个文件系统，并在只读的镜像层外面挂在一层可读写层
从宿主主机配置的网桥接口中桥接一个虚拟接口到容器中去
从地址池配置一个ip地址给容器
执行用户指定的应用程序
执行完毕后容器被终止
```


## 外部访问容器

```
-P 参数会随机映射端口到容器开放的网络端口
[root@oldboy_python ~ 16:31:37]#docker run -d -P training/webapp python app.py

检查映射的端口
#宿主机ip:32768 映射容器的5000端口
[root@oldboy_python ~ 16:34:02]#docker ps -l
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                     NAMES
cfd632821d7a        training/webapp     "python app.py"     21 seconds ago      Up 20 seconds       0.0.0.0:32768->5000/tcp   brave_fermi

查看容器日志信息
#不间断显示log
docker logs -f cfd

也可以通过-p参数指定映射端口
#指定服务器的9000端口，映射到容器内的5000端口
[root@oldboy_python ~ 16:46:13]#docker run -d -p 9000:5000 training/webapp python app.py
c0b5a6278d0f4f2e9b9eba8680451111d8b911b61de0c37ea64cb337aefb854e

访问服务器的9000端口
``` 


## 利用dockerfile定制镜像

```
镜像的定制就是定制每一层所添加的配置、文件。如果可以吧每一层修改、安装、构建、操作的命令都写入到一个脚本，用脚本来构建、定制镜像，这个脚本就是dockerfile。

Dockerfile是一个文本文件，其内包含了一条条的指令(Instruction)，每一条指令 构建一层，因此每一条指令的内容，就是描述该层应当如何构建。
```

```
FROM scratch #制作base image 基础镜像，尽量使用官方的image作为base image
FROM centos #使用base image
FROM ubuntu:14.04 #带有tag的base image

LABEL version=“1.0” #容器元信息，帮助信息，Metadata，类似于代码注释
LABEL maintainer=“yc_uuu@163.com"

#对于复杂的RUN命令，避免无用的分层，多条命令用反斜线换行，合成一条命令！
RUN yum update && yum install -y vim \
    Python-dev #反斜线换行
RUN /bin/bash -c "source $HOME/.bashrc;echo $HOME”

WORKDIR /root #相当于linux的cd命令，改变目录，尽量使用绝对路径！！！不要用RUN cd
WORKDIR /test #如果没有就自动创建
WORKDIR demo #再进入demo文件夹
RUN pwd     #打印结果应该是/test/demo

ADD and COPY 
ADD hello /  #把本地文件添加到镜像中，吧本地的hello可执行文件拷贝到镜像的/目录
ADD test.tar.gz /  #添加到根目录并解压

WORKDIR /root
ADD hello test/  #进入/root/ 添加hello可执行命令到test目录下，也就是/root/test/hello 一个绝对路径
COPY hello test/  #等同于上述ADD效果

ADD与COPY
   - 优先使用COPY命令
    -ADD除了COPY功能还有解压功能
添加远程文件/目录使用curl或wget

ENV #环境变量，尽可能使用ENV增加可维护性
ENV MYSQL_VERSION 5.6 #设置一个mysql常量
RUN yum install -y mysql-server=“${MYSQL_VERSION}” 

------这里需要稍微理解一下了-------中级知识---先不讲

VOLUME and EXPOSE 
存储和网络

RUN and CMD and ENTRYPOINT
RUN：执行命令并创建新的Image Layer
CMD：设置容器启动后默认执行的命令和参数
ENTRYPOINT：设置容器启动时运行的命令

Shell格式和Exec格式
RUN yum install -y vim
CMD echo ”hello docker”
ENTRYPOINT echo “hello docker”

Exec格式
RUN [“apt-get”,”install”,”-y”,”vim”]
CMD [“/bin/echo”,”hello docker”]
ENTRYPOINT [“/bin/echo”,”hello docker”]


通过shell格式去运行命令，会读取$name指令，而exec格式是仅仅的执行一个命令，而不是shell指令
cat Dockerfile
    FROM centos
    ENV name Docker
    ENTRYPOINT [“/bin/echo”,”hello $name”]#这个仅仅是执行echo命令，读取不了shell变量
    ENTRYPOINT  [“/bin/bash”,”-c”,”echo hello $name"]

CMD
容器启动时默认执行的命令
如果docker run指定了其他命令(docker run -it [image] /bin/bash )，CMD命令被忽略
如果定义多个CMD，只有最后一个执行

ENTRYPOINT
让容器以应用程序或服务形式运行
不会被忽略，一定会执行
最佳实践：写一个shell脚本作为entrypoint
COPY docker-entrypoint.sh /usr/local/bin
ENTRYPOINT [“docker-entrypoint.sh]
EXPOSE 27017
CMD [“mongod”]

[root@master home]# more Dockerfile
FROm centos
ENV name Docker
#CMD ["/bin/bash","-c","echo hello $name"]
ENTRYPOINT ["/bin/bash","-c","echo hello $name”]
```


## 发布docker image到仓库

### docker hub公有镜像发布

```
1.docker提供了一个类似于github的仓库dockerhub,
网址https://hub.docker.com/   # 需要注册使用

2.注册docker id后，在linux中登录dockerhub
docker login

注意要保证image的tag是账户名，如果镜像名字不对，需要改一下tag
docker tag centos-vim xlhyy/centos-vim
语法是: docker tag 仓库名 用户名/仓库名


3.推送docker image到dockerhub
docker push xlhyy/centos-vim:latest

4.在dockerhub中检查镜像
https://hub.docker.com/

5.删除本地镜像，测试下载pull 镜像文件
docker pull xlhyy/centos-vim
```

### 发布到私有仓库

* docker: [官方提供的私有仓库docker registry的用法](https://yeasy.gitbooks.io/docker_practice/repository/registry.html)

```
1. 下载registry镜像并且启动私有仓库容器
docker run -d \
    -p 5000:5000 \
    -v /Users/kaiqigu/dododo/docker_test/registry:/var/lib/registry \
    registry
注释:
    (1) 私有仓库会被创建在容器的/var/lib/registry下，因此通过-v参数将镜像文件存储到本地的/Users/kaiqigu/dododo/docker_test/registry下
    (2) 端口映射容器中的5000端口到宿主机的5000端口


2. 检查启动的registry容器
docker ps


3. 测试连接容器
curl 127.0.0.1:5000


4. 修改镜像tag，以docker registry的地址端口开头
docker tag hello-world:latest 127.0.0.1:5000/hello-world:latest


5. 查看docker镜像，找到registry的地址端口开头
docker images


6. 

=================================================

示例:

1.官方提供的私有仓库docker registry用法
https://yeasy.gitbooks.io/docker_practice/repository/registry.html

2.一条命令下载registry镜像并且启动私有仓库容器
私有仓库会被创建在容器的/var/lib/registry下，因此通过-v参数将镜像文件存储到本地的/opt/data/registry下
端口映射容器中的5000端口到宿主机的5000端口
docker run -d \
    -p 5000:5000 \
    -v /opt/data/registry:/var/lib/registry \
    registry

3.检查启动的registry容器
docker ps

4.测试连接容器
telnet 192.168.119.10 5000

5.修改镜像tag,以docker registry的地址端口开头
docker tag hello-world:latest 192.168.119.10:5000/hello-world:latest

6.查看docker镜像，找到registry的镜像
docker images

7.Docker 默认不允许非 HTTPS 方式推送镜像。我们可以通过 Docker 的配置选项来取消这个限制，这里必须写正确json数据
[root@master /]# cat /etc/docker/daemon.json
{"registry-mirrors": ["http://95822026.m.daocloud.io"],
"insecure-registries":["192.168.119.10:5000"]
}
写入到docker服务中，写入到[Service]配置块中，加载此配置文件
[root@master home]# grep 'EnvironmentFile=/etc/docker/daemon.json' /lib/systemd/system/docker.service
EnvironmentFile=-/etc/docker/daemon.json

8.修改了docker配置文件，重新加载docker
systemctl daemon-reload

9.重启docker
systemctl restart docker

10.重启了docker，刚才的registry容器进程挂掉了，因此重新启动它
docker run --privileged=true -d -p 5000:5000 -v /opt/data/registry:/var/lib/registry registry
--privileged=true  docker容器的安全机制：设置特权级运行的容器

11.推送本地镜像
docker push 192.168.119.10:5000/hello-world

12.由于docker registry没有web节目，但是提供了API数据
官网教程：https://docs.docker.com/registry/spec/api/#listing-repositories
curl http://192.168.119.10:5000/v2/_catalog
或者浏览器访问http://192.168.119.10:5000/v2/_catalog

13.删除本地镜像，从私有仓库中下载
docker pull 192.168.119.10:5000/hello-world
```




## 打包flask程序与dockerfile

### 创建需要的文件

```
kaiqigu@bogon:~/dododo/test/t1|⇒  cat Dockerfile 
# Use an official Python runtime as a parent image
FROM python:2.7-slim

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME World

# Run app.py when the container launches
CMD ["python", "app.py"]
```

```
kaiqigu@bogon:~/dododo/test/t1|⇒  cat app.py 
#coding:utf8

from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
	return "hello docker"

if __name__ == "__main__":
	app.run(host="0.0.0.0", port=8080)
```

```
kaiqigu@bogon:~/dododo/test/t1|⇒  cat requirements.txt 
Flask
```

### 构建镜像image

```
docker build -t xlhyy/flask-hello-docker .
```

### 查看创建好的images

```
docker image ls
```

### 启动容器，并映射一个端口供外部访问

```
docker run -d -p 8080:8080 xlhyy/flask-hello-docker
```

### 检查运行的容器

```
docker container ls
```
