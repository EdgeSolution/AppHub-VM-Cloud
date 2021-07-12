# Introduction In English(英文说明)
## 1. buy cloud VM in cloud， for Example, alibaba cloud or microsoft azure
Requirement for AppHub：
CPU >= 1vCPU
Memory >= 2G
Storage >= 20G
Image: Ubuntu 18.04 64-bit or new

## 2.Open the following port: 
 8080, 30001, 30002, 1883, 5432, 5500, 5901, 9191, 9000 

## 3.login VM, install package: git, docker and docker-compose
Install git 
$ sudo apt update && apt install git 

Install docker compose
$ curl  -sSL  https://get.daocloud.io/docker | sh                 
$ apt  install  docker-compose                               

Check docker and docker-compose version
$ docker version  			
$ docker-compose  version  	


## 4. dowonload AppHub install file:
$ git clone https://github.com/EdgeSolution/AppHub-VM-Cloud.git

## 5. Install AppHub Server and run server
$ cd AppHub-VM-Cloud /              
$ chmod +x  start.sh                 
$./start.sh   

it will download AppHub docker image from docker hub, may be 10 ~ 20 minute, please wait it complete. 
After finished, you can access AppHub Server in browser as follows:
http://ServerIP:8080

# 中文说明（Introduction In Chinese）

部署到云端虚拟机步骤
## 1．	首先需要在平台上上申请一个基于Ubuntu 18.04 x64系统的虚拟机
我们已经有验证过阿里云和微软Azure云
建议配置
CPU >= 1vCPU
Memory >= 2G
Storage >= 20G
Image: Ubuntu 18.04 64-bit 或者更高版本

## 2．	开放如下的端口：
8080, 30001, 30002, 1883, 5432, 5500, 5901, 9191, 9000

## 3．	远程登录该VM，安装一些必须的工具：git, docker, docker-compose
$ sudo apt update && apt install git 
$ curl  -sSL  https://get.daocloud.io/docker | sh                 
$ sudo apt  install  docker-compose                               
安装完成后，使用下面的命令检查版本，确认安装正确。
a)	$ docker version                     
b)	$ docker-compose  version  


## 4．	使用git命令下载AppHub的安装文件
$ git clone https://github.com/EdgeSolution/AppHub-VM-Cloud.git


## 5．	安装和启动AppHub
当你通过git下载到安装文件后，ECS会生成“AppHub-VM-Cloud” 目录，进入该目前，执行 start.sh 脚本。
$ cd AppHub-VM-Cloud /              
$ chmod +x  start.sh                 
$./start.sh                                          
start.sh会完成AppHub服务器的安装和启动，因为安装过程是在线安装，需要从网络上下载AppHub docker镜像，根据网络速度不同，大约需要10~20分钟的时间完成安装，请耐心等待。
当安装完成后，就会自动启动，你就可以通过浏览器访问AppHub的服务了
http://ServerIP:8080
SeverIP就是VM对外的公网IP地址。

理论上，上述方法同样适用在各种云平台上安装AppHub，目前我们已经验证适用Azure和阿里云VM。
| Release version  | DockerHub |    docker tag    |
| :------------------- | :-------------- | :----------|
|     V1.0.0         | edgesolution/apphub-manager:v1.0.0<br />edgesolution/apphub-mosquitto:v1.0<br />edgesolution/apphub-novnc:v1.0 | eidevice/androiddm-javaenv-slim-dev:v3.3.9 <br />edgesolution/apphub-mosquitto:v1.0<br />edgesolution/apphub-novnc:v1.5<br /> |
