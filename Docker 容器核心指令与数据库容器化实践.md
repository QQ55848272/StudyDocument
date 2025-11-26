Docker 容器核心指令与数据库容器化实践

敲上瘾

于 2025-09-05 10:55:26 发布

阅读量5.6k
 收藏 90

点赞数 89
CC 4.0 BY-SA版权
分类专栏： 开发工具 Docker linux系统 文章标签： docker 容器 服务器 linux dubbo eureka 运维

linux系统
同时被 3 个专栏收录
33 篇文章
订阅专栏

Docker
6 篇文章
订阅专栏

开发工具
5 篇文章
订阅专栏
文章目录
概念简介
什么是容器？
为什么需要容器？
容器生命周期
容器指令
1. 指令清单
2. 命令详解
容器的模式
MySQL与Redis容器化部署
1.MYSQL容器安装
2.Redis容器安装
概念简介
什么是容器？
  容器是一种标准的软件单元，它将代码及其所有依赖关系打包在一起，从而使应用能够从一个计算环境快速、可靠地运行到另一个计算环境。您可以把它想象成一个轻量化的、标准化的“软件集装箱”。
  镜像跑起来后就是容器，就像C++中类实例化后就是对象一样。镜像本身是只读的。当从一个镜像启动一个容器时，Docker会在镜像的所有层之上添加一个可写的容器层。

容器与容器之间，容器与外部环境是隔离的
一个容器的资源是有限制的
为什么需要容器？
提高资源利用率：提高资源利用率，使用容器能实现在一台服务器运行各种系统。
环境标准化：用同一个镜像实例化的容器使得开发、测试、预发布和生产环境中完全一致地运行。
资源弹性伸缩：可以根据实际情况灵活控制资源的分配。
差异化环境： 一个复杂的应用可能包含多个服务（微服务架构），这些服务可能依赖于不同的、甚至冲突的语言运行时和库版本，把这些服务部署到不同容器，每个容器都拥有独立的用户空间和依赖项，能实现彼此完全隔离，互不干扰。
沙箱安全：当一个容器崩了，宿主机和其他容器依旧正常
启动速度快：容器本质是主机操作系统上的一个隔离进程，无需启动整个操作系统内核。因此其启动速度极快，可以达到毫秒到秒级。
容器生命周期
创建状态：docker create
运行状态：docker start
暂停状态：docker pause
停止状态：docker stop
删除状态：docker rm

容器指令
1. 指令清单
以下内容都附带了锚点，点击即可跳转到相应位置进行学习。

docker create：创建容器，但不运行
docker run：创建并运行容器
docker attach：与运行的容器进行交互
docker commit：将容器运行状态导出成镜像（类似快照）
docker cp：容器和宿主机之间的资源拷贝
docker diff：容器中文件的增删改
docker exec：运行的容器中执行指令
docker export：保存容器导出镜像tar（不保留元数据）
docker import：从tar文件中导出镜像
docker container inspect：查看容器详细信息（不带container参数时自动识别镜像，容器）
docker kill：杀死容器
docker logs：查看容器日志
docker ps：查看那些容器在运行
docker pause：暂停容器，剥夺cpu时间片
docker port：查看端口映射
docker container prune：删除已停止的容器
docker rename：修改容器名字
docker restart：重启容器
docker rm：删除容器
docker start：启动容器
docker stats：显示容器资源配置情况
docker stop：停止运行的容器
docker top：查看容器中运行的进程信息，支持ps指令参数
docker pause：暂停容器中启动的所有进程
docker unpause：启动容器中所有被暂停的进程
docker update：更新容器配置
docker wait：阻塞运行直到容器停止，然后打印出它的退出码
2. 命令详解
docker run
功能： 创建一个新的容器并运行一个命令
语法：

docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
AI生成项目
shell
1
别名：docker container run

关键参数：

-d：后台运行容器，并返回容器 ID
-i：以交互模式运行容器，通常与 -t 同时使用
-t：为容器重新分配一个伪输入终端，通常与 -i 同时使用
-P：随机端口映射，容器内部端口随机映射到主机的端口
-p：指定端口映射，格式为：主机(宿主)端口:容器端口
--name="nginx-lb"：为容器指定一个名称
-h "mars"：指定容器的 hostname
-e username="ritchie"：设置环境变量
--cpuset-cpus="0-2" or --cpuset-cpus="0,1,2"：绑定容器到指定 CPU 运行
-m：设置容器使用内存最大值
--network="bridge"：指定容器的网络连接类型
--link=[]：添加链接到另一个容器
--volume, -v：绑定一个卷
--rm：shell 退出的时候自动删除容器
示例：
到官网找到centos7
查看宿主机版本：cat /etc/*release*
将centos:7拉取到本地：docker pull centos:7
运行centos:7：docker run centos:7

这里执docker run不带任何选项看上去没有任何效果，其实这个容器已经被打开了但因为没交互所以退出了。
使用docker ps -a可以看到历史执行过的容器

添加-it选项以交互形式运行容器，如下：

注意：通常不会单独使用-i或-t选项，需要两个一起使用，即-it（常用于交互式容器）

接下来我们运行一个nginx:1.24.0容器，如果本地没有会自动从服务器拉取。

使用docker ps查看运行状态

  当我们在浏览器中直接访问服务器（宿主机）时，访问的是宿主机本身的服务（如果有的话）。Docker容器拥有独立的网络命名空间，外网无法直接访问容器内的Nginx服务。需要通过端口映射将宿主机的端口与容器的端口进行绑定。例如，将宿主机的7070端口映射到容器Nginx的80端口后，当访问宿主机IP的7070端口时，流量会被自动转发到容器内部的80端口，从而访问到容器中的Nginx服务。
如下-p选项的使用：



-P是绑定随机端口，后面不用带任何信息，该选项很少使用，如：docker run -P -d nginx:1.24.0

--name选项改变容器名字，使用新起的容器名与其交互会变得很方便。

-h：改变容器主机名

-e：添加容器的环境变量

-m：设置容器使用内存最大值，如下给限定容器内存使用500MB
docker run -d -m 500m --name mynginx3 nginx:1.24.0
docker stats mynginx3


-rm选项：shell 退出的时候自动删除容器，使用docker ps -a是查不到的。
如：docker run -it --name=mycentos4 -rm centos:7

docker create
功能：创建一个新的容器但不启动
语法：

docker create [OPTIONS] IMAGE [COMMAND] [ARG...]
AI生成项目
shell
1
别名：docker container create
关键参数：和run的关键参数相同

docker ps
功能： 列出运行的容器信息
语法：

docker ps [OPTIONS]
AI生成项目
shell
1
别名：docker container ls, docker container list, docker container ps

关键参数：

-a：显示所有的容器，包括未运行的。
-f：根据条件过滤显示的内容。
--format：指定返回值的模板文件。如 json 或者 table
-l：显示 latest 的容器。
-n：列出最近创建的 n 个容器。
--no-trunc：不截断输出。
-q：静默模式，只显示容器编号。
-s：显示总的文件大小。
docker logs
功能：查看容器日志
语法：

docker logs [OPTIONS] CONTAINER
AI生成项目
shell
1
别名：docker container logs
关键参数：

-f, --follow: 跟踪日志输出
--since: 显示某个开始时间的所有日志
-t, --timestamps: 显示时间戳
-n, --tail: 仅列出最新 N 条容器日志


docker attach
功能：连接到正在运行中的容器。
语法：

docker attach [OPTIONS] CONTAINER
AI生成项目
bash
1
别名：docker container attach
关键参数：

--sig-proxy：是否将所有信号代理，默认是 true，如果设置为 false，退出的话不会影响容器，否则退出会导致容器退出。
示例：docker attach --sig-proxy myweb1

如上不加--sig-proxy参数的话ctrl+c会直接停止容器

docker exec
功能：在容器中执行命令
语法：

docker exec [OPTIONS] CONTAINER COMMAND [ARG...]
AI生成项目
shell
1
别名：docker container exec

关键参数：

-d: 分离模式:在后台运行
-i: 即使没有附加也保持STDIN打开
-t: 分配一个伪终端
-e: 设置环境变量
-u, --user: 指定用户 “<name|uid>[:<group|gid>]”
-w, --workdir: 指定工作目录
示例：
不带bash可以一次性交互

docker stop
功能：停止启动的容器
语法：

docker start [OPTIONS] CONTAINER [CONTAINER...]
AI生成项目
shell
1
别名：docker container start

docker start
功能：启动停止的容器
语法：

docker start [OPTIONS] CONTAINER [CONTAINER...]
AI生成项目
shell
1
别名：docker container start


docker restart
功能：重启容器
语法：

docker restart [OPTIONS] CONTAINER [CONTAINER...]
AI生成项目
shell
1
别名：docker container restart
关键参数：

-s: 发送信号
docker kill
功能：强制退出容器
语法：

docker kill [OPTIONS] CONTAINER [CONTAINER...]
AI生成项目
shell
1
别名：docker container kill
关键参数：

-s: 发送的信号
注意：docker stop发送的是SIGTERM信号，docker kill发送的是SIGKILL信号
docker top
功能：查看容器中运行的进程信息，支持 ps 命令参数。
语法：

docker top CONTAINER [ps OPTIONS]
AI生成项目
shell
1
别名： docker container top
示例：

docker stats
功能：显示容器资源的使用情况，包括：CPU、内存、网络I/O等。
语法：

docker stats [OPTIONS] [CONTAINER...]
AI生成项目
shell
1
别名：docker container stats
关键参数：

-a, --all: 显示所有的容器，包括未运行的。
--format: 指定返回值的模板文件。如 table.json
--no-stream: 展示当前状态就直接退出了，不再实时更新。
--no-trunc: 不截断输出。
示例：

docker stats myweb2
AI生成项目
shell
1
输出结果：


CONTAINER ID与 NAME: 容器 ID 与名称。
CPU %与 MEM %: 容器使用的 CPU 和内存的百分比。
MEM USAGE / LIMIT: 容器正在使用的总内存，以及允许使用的内存总量。
NET I/O: 容器通过其网络接口发送和接收的数据量。
BLOCK I/O: 容器从主机上的块设备读取和写入的数据量。
PIDs: 容器创建的进程或线程数。
docker container inspect
功能：查看容器详细信息
语法：

docker container inspect [OPTIONS] CONTAINER [CONTAINER...]
AI生成项目
shell
1
关键参数：

-f: 指定返回值的模板文件。如 table、json
-s: 显示总的文件大小。
注：docker inspect会自动检查是镜像还是容器然后显示相应信息

docker port
功能： 用于列出指定的容器的端口映射，或者查找将 PRIVATE_PORT NAT 到面向公众的端口。
语法：

docker port CONTAINER [PRIVATE_PORT[/PROTO]]
AI生成项目
shell
1
别名：docker container port
示例：


docker cp
功能：在容器和宿主机之间拷贝文件
语法：

docker cp [OPTIONS] CONTAINER:SRC_PATH DEST_PATH  
docker cp [OPTIONS] SRC_PATH - CONTAINER:DEST_PATH
AI生成项目
shell
1
2
别名：docker container cp
示例：

浏览器访问效果：

注意：容器之间不能互相拷贝，只能先拷贝到宿主机，再由宿主机拷贝到另一个容器。
docker diff
功能：检查容器里文件结构的更改
语法：

docker diff CONTAINER
AI生成项目
shell
1
别名：docker container diff
示例：


C：修改
A：新增
docker commit
功能：从容器创建一个新的镜像。
语法：

  docker commit [OPTIONS] CONTAINER [REPOSITORY[:TAG]]
AI生成项目
shell
1
关键参数

-a: 提交的镜像作者；
-c: 使用 Dockerfile 指令来创建镜像；可以修改启动指令；
-m: 提交时的说明文字；
-p: 在 commit 时，将容器暂停。
注意：在容器里添加或修改的文件也会被提交到镜像
示例：自定义镜像制作

docker pause
功能：暂停容器中所有的进程。
语法

docker pause CONTAINER [CONTAINER...]
AI生成项目
shell
1
别名： docker container pause

docker unpause
功能：恢复容器中所有的进程。
语法：

  docker unpause CONTAINER [CONTAINER...]
AI生成项目
shell
1
别名： docker container unpause

docker rm
功能：删除停止的容器
语法：

  docker rm [OPTIONS] CONTAINER [CONTAINER...]
AI生成项目
shell
1
别名：docker container rm
关键参数：

-f:通过 SIGKILL 信号强制删除一个运行中的容器。
docker export
功能：导出容器内容为 tar 文件
语法：

docker export [OPTIONS] CONTAINER
AI生成项目
shell
1
别名：docker container export

关键参数：

-o:写入到文件。
示例：


docker import
功能：从归档文件中创建镜像。

语法：

docker import [OPTIONS] file[URL] - [REPOSITORY[:TAG]]
AI生成项目
shell
1
别名：docker image import
关键参数：

-c: 应用 docker 指令创建镜像；
-m: 提交时的说明文字；
示例：

注意：export，import会丢失元数据，save，load更为常用。

docker wait
功能：阻塞运行直到容器停止，然后打印出它的退出代码。
语法：

docker wait CONTAINER [CONTAINER...]
AI生成项目
shell
1
别名：docker container wait

docker rename
功能：重命名容器
语法：

docker rename CONTAINER NEW_NAME
AI生成项目
shell
1
别名：docker container rename
示例：


docker container prune
功能：删除所有停止的容器
语法：

docker container prune [OPTIONS]
AI生成项目
shell
1
关键参数：

-f, --force: 不提示是否进行确认
示例：

docker update
功能：更新容器配置
语法：

docker update [OPTIONS] CONTAINER [CONTAINER...]
AI生成项目
shell
1
别名：docker container update

关键参数：

--cpus: cpu 数量
--cpuset-cpus :使用哪些 cpu
--memory:内存限制
--memory-swap :交换内存
--cpu-period :是用来指定容器对 CPU 的使用要在多长时间内做一次重新分配
--cpu-quota :是用来指定在这个周期内，最多可以有多少时间用来跑这个容器
容器的模式
交互模式

attached：前台模式，将容器附加到主线程，例如执行一个nginx容器：docker attach 容器名，每次刷新网页都会在前台打印日志。
所以ctl+c等发送信号会使容器直接退出，除非添加--sig-proxy=false字段

detached模式：后台运行，即-d选项，即使退出ssh容器也不会断开
注：attached附加到detached模式的容器下ctl+c也会使程序退出

interactive模式：交互模式，与容器进行bash命令行交互，可以在run启动容器时添加-it选项，或在容器运行后exce时添加-it选项进行交互。
run启动的交互模式执行exit退出容器后容器停止，因此这种交互模式很少使用。
容器运行后使用exec交互时exit退出容器不会是容器停止。

MySQL与Redis容器化部署
1.MYSQL容器安装
在官网docker hub找到mysql版本，比如我们使用mysql:5.7版本
直接run创建并运行容器（如果没有镜像会自动拉取）

拉取创建并运行容器：
docker run --name=qsy_mysql -e MYSQL_ROOT_PASSWORD=a@123456 -p 7306:3306 -d mysql:5.7
AI生成项目
shell
1
与容器交互：
docker exec -it qsy_mysql bash
AI生成项目
shell
1
登陆MySQL：
mysql -u root -p
AI生成项目
shell
1

也可在可视化工具远程连接数据库

2.Redis容器安装
同样到docker hub搜索redis版本，例如使用redis:7

拉取创建并启动redis：
docker run --name myredis -d -p 45446:6379 redis:7
AI生成项目
shell
1
与redis容器进行交互：
docker exec -it myredis bash
AI生成项目
shell
1
登陆redis
redis-cli
