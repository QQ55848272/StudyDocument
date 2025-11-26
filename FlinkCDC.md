# FlinkCDC

学习 Flink CDC（Change Data Capture）是掌握实时数据处理和数据同步的核心技能之一，特别适合从事数据中台、实时数仓、湖仓一体、数据同步等场景。

下面是我为你整理的一份 **Flink CDC 学习路线图（基础 → 实战 → 优化）**，分阶段、有实操、有源码、有项目。

------

## 一、学习目标总览

| 阶段     | 目标                                         |
| -------- | -------------------------------------------- |
| 入门理解 | 理解 Flink CDC 是什么、解决什么问题          |
| 环境搭建 | 快速部署可运行的 Flink CDC 作业              |
| 基础开发 | 能基于 YAML 或 Java 编写简单的同步作业       |
| 实战项目 | 完成 MySQL → Kafka、MySQL → Doris 等同步     |
| 进阶优化 | 掌握容错机制、数据一致性、断点续传、分区策略 |
| 二次开发 | 了解源码、可自定义 CDC 逻辑或 Connector      |



------

##  二、学习路线图（详细阶段）

###  第一阶段：基础入门

目标：知道 Flink CDC 是做什么的、适用哪些场景

| 学习点                       | 推荐方式                                                     |
| ---------------------------- | ------------------------------------------------------------ |
| 什么是 CDC？与全量同步区别？ | 阅读 Debezium、Flink CDC 原理介绍                            |
| Flink CDC 支持哪些数据源？   | [官网](https://nightlies.apache.org/flink/flink-cdc-docs-master/zh) |
| 使用模式有哪些？             | Java 编程模式、YAML Pipeline 模式                            |
| Kafka、MySQL binlog 原理     | 简要理解（可跳过深入）                                       |



 推荐资源：

- Flink CDC 中文文档：https://nightlies.apache.org/flink/flink-cdc-docs-master/zh
- 必懂概念：**binlog / 增量同步 / watermark / offset checkpoint**

------

### 第二阶段：搭建环境 & YAML 快速实战

 目标：能跑通一个完整的 Flink CDC 作业（如 MySQL → Kafka）

| 内容                   | 操作方式                                                     |
| ---------------------- | ------------------------------------------------------------ |
| 克隆 Flink CDC 源码    | `git clone https://github.com/apache/flink-cdc`              |
| 构建 CLI 工具          | `cd flink-cdc-dist && mvn clean package`                     |
| 启动测试环境           | `cdtools/cdcup` + `docker-compose up`                        |
| 运行示例作业           | `flink-cdc pipeline run -f pipeline-example/mysql-to-kafka.yaml` |
| 修改自己的表名 / Topic | 修改 YAML 文件即可                                           |



 实战模板：

```ymal
pipeline.name: mysql_to_kafka
sources:
  mysql_source:
    type: mysql-cdc
    hostname: localhost
    port: 3306
    username: root
    password: 123456
    database-name: mydb
    table-name: mytable
sinks:
  kafka_sink:
    type: kafka
    topic: mytopic
    bootstrap.servers: localhost:9092
links:
  - source: mysql_source
    sink: kafka_sink
```

------

### 第三阶段：Java 开发实战

目标：能用 Java 写出 Flink CDC 程序并打包运行

| 内容                                   | 技术点                           |
| -------------------------------------- | -------------------------------- |
| 创建 Maven 工程                        | 引入 Flink + CDC Connector       |
| 使用 `MySqlSource`、`PostgreSqlSource` | 代码开发                         |
| 自定义 Sink，如 KafkaSink、DorisSink   | 实战开发                         |
| 打包 fat jar                           | 使用 `maven-shade-plugin`        |
| 提交到 Flink 集群运行                  | `flink run -c MainClass xxx.jar` |



推荐：使用 Flink 1.17 + Flink CDC 3.x

------

### 第四阶段：常见场景实战

目标：掌握多个主流数据同步场景

| 场景                 | 说明                      |
| -------------------- | ------------------------- |
| MySQL → Kafka        | 最常用场景，用于数据解耦  |
| MySQL → Doris        | 用于实时数仓              |
| PostgreSQL → Kafka   | PostgreSQL 支持 slot 同步 |
| MySQL → Hudi/Iceberg | 实现湖仓一体架构          |
| Oracle → Kafka/Doris | 企业数据库迁移必备        |



 可查阅：Flink CDC 官方 pipeline-example 中的 YAML 示例。

------

###  第五阶段：进阶与优化

 目标：掌握 Flink CDC 在生产环境中的性能与容错控制

| 优化点                        | 技术细节                                |
| ----------------------------- | --------------------------------------- |
| Checkpoint、State TTL         | 保障断点续传与状态恢复                  |
| exactly-once 与 at-least-once | 配置 sink 端一致性语义                  |
| 分区读取（split）优化         | large table 切分                        |
| snapshot+binlog 过程理解      | 明确初始与增量流程                      |
| 监控与告警                    | 集成 Flink Metrics、Prometheus、Grafana |



------

### 第六阶段：源码学习 / 二次开发

目标：能理解底层原理，修改 CDC 行为或开发自定义 Connector

| 学习点                     | 涉及模块                                          |
| -------------------------- | ------------------------------------------------- |
| Debezium 如何解析 binlog？ | `flink-cdc-connectors/mysql`                      |
| 如何定制数据格式？         | 自定义 `DebeziumDeserializationSchema`            |
| 状态保存在哪里？           | Flink 状态后端 + offset 机制                      |
| 如何开发自定义 Sink？      | 实现 `SinkFunction` 或使用 `DataStream#addSink()` |



------

## 三、学习建议

- **建议先 YAML，后 Java，最后源码**
-  学习过程中结合实际项目，如数据中台、实时数仓
- 如果接入的是 PostgreSQL / Oracle，注意其特殊性（如 WAL / LogMiner）
- 推荐从 “MySQL → Kafka → 下游消费” 入手搭建你的第一个链路

###  附送：学习资料整理

| 类型            | 链接                                                        |
| --------------- | ----------------------------------------------------------- |
| 官方文档        | https://nightlies.apache.org/flink/flink-cdc-docs-master/zh |
| GitHub          | https://github.com/apache/flink-cdc                         |
| B站教程         | 搜索“Flink CDC 实战”、“Flink CDC 3.0”                       |
| 本地测试 Docker | `cdtools/cdcup`                                             |
| YAML 模板示例   | `pipeline-example/` 目录                                    |



# FlinkCDC环境需求

##  Flink CDC 3.0 的两种使用方式（都需要 Flink 支持）

| 模式               | 说明                                                   | 是否需要 Flink 集群 |
| ------------------ | ------------------------------------------------------ | ------------------- |
| Java 编程模式      | 自己写 Java 代码，调用 MySqlSource/PostgreSqlSource 等 | 必须                |
| YAML Pipeline 模式 | 用 YAML 文件配置任务，通过 `flink-cdc` CLI 提交        | 必须                |



------

## 所需 Flink 集群类型（任选其一）

你可以用以下任意方式搭建 Flink 环境来运行 CDC：

| 环境方式             | 说明                                                      |
| -------------------- | --------------------------------------------------------- |
| 本地 standalone 集群 | 一台机器上运行 Flink jobmanager/taskmanager，适合开发测试 |
| Docker               | Flink + MySQL + Kafka 一键启动（`cdtools/cdcup`）         |
| YARN                 | 生产环境最常见部署方式，支持资源隔离                      |
| Kubernetes           | 大型实时数仓架构下主流方案                                |
| Flink SQL Gateway    | 如果你只跑 SQL 任务，也可接入 Flink Gateway，但仍需要集群 |



------

##  YAML 模式举例（仍需 Flink）

```bash
# 启动 Flink standalone 集群
./bin/start-cluster.sh

# 启动任务
./flink-cdc pipeline run -f mysql-to-kafka.yaml
```

实际上，`flink-cdc` CLI 工具是帮你生成并提交一个 Flink 作业，它通过 REST 或 RPC 将任务提交给集群。

------

## 如何准备 Flink 集群？

如果你只是学习或测试，可以使用：

```bash
wget https://dlcdn.apache.org/flink/flink-1.17.1/flink-1.17.1-bin-scala_2.12.tgz
tar -xzf flink-*.tgz
cd flink-*/bin
./start-cluster.sh
```

访问：http://localhost:8081 查看 Web UI。

------

## 总结

| 问题                              | 回答                                               |
| --------------------------------- | -------------------------------------------------- |
| Flink CDC 3.x 需要 Flink 集群吗？ | ✅ 是，必须依赖 Flink 作业引擎                      |
| 是否可以脱离 Flink 单独运行？     | ❌ 不可以，本质上它是 Flink 作业                    |
| 本地怎么快速体验？                | 启动本地 Flink 集群，或用 `cdtools/cdcup` 一键部署 |



------

 如果你希望我：

- 帮你搭一个本地 Flink 集群（或 Docker 一键环境）
- 给你一个完整的 Flink CDC 3.0 + YAML + Flink 集群运行流程

我可以直接帮你生成命令和配置文件，要吗？



#  Flink 1.17 Standalone 集群部署教程

------

## 1. 环境准备

- **操作系统**：Linux (CentOS/Ubuntu 等) 推荐

- **JDK**：Java 11+，确保环境变量 `JAVA_HOME` 配置正确

  ```bash
  sudo yum install java-11-openjdk-devel
  ```

  

- **用户权限**：建议使用非 root 用户，或者有 sudo 权限

- **网络配置**：确保各节点间网络通畅，主机名能互相解析（多节点部署）

------

## 2. 下载 Flink 1.17

```bash
wget https://archive.apache.org/dist/flink/flink-1.17.1/flink-1.17.1-bin-scala_2.12.tgz
tar -xzvf flink-1.17.1-bin-scala_2.12.tgz
mv flink-1.17.1 flink
```

------

## 3. 配置 Flink 环境变量（可选）

在 `~/.bashrc` 或 `/etc/profile` 加入：

```bash
export FLINK_HOME=/path/to/flink
export PATH=$PATH:$FLINK_HOME/bin
export JAVA_HOME=/path/to/java
```

执行 `source ~/.bashrc` 使配置生效。

**多版本jdk情况下**

在conf目录下创建 flink-env.sh 文件

```bash
#!/bin/bash
# Flink environment variables
 
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
export PATH=$JAVA_HOME/bin:$PATH
```



------

## 4. 配置 Flink 集群

### 4.1 配置 `conf/flink-conf.yaml`



```
env.java.home: /usr/lib/jvm/java-11-openjdk
```

编辑 `$FLINK_HOME/conf/flink-conf.yaml`，最重要的参数：

```yaml
################################################################################
#  Licensed to the Apache Software Foundation (ASF) under one
#  or more contributor license agreements.  See the NOTICE file
#  distributed with this work for additional information
#  regarding copyright ownership.  The ASF licenses this file
#  to you under the Apache License, Version 2.0 (the
#  "License"); you may not use this file except in compliance
#  with the License.  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
# limitations under the License.
################################################################################


#==============================================================================
# Common
#==============================================================================

# The external address of the host on which the JobManager runs and can be
# reached by the TaskManagers and any clients which want to connect. This setting
# is only used in Standalone mode and may be overwritten on the JobManager side
# by specifying the --host <hostname> parameter of the bin/jobmanager.sh executable.
# In high availability mode, if you use the bin/start-cluster.sh script and setup
# the conf/masters file, this will be taken care of automatically. Yarn
# automatically configure the host name based on the hostname of the node where the
# JobManager runs.




jobmanager.rpc.address: meta1

# The RPC port where the JobManager is reachable.

jobmanager.rpc.port: 6123

# The host interface the JobManager will bind to. By default, this is localhost, and will prevent
# the JobManager from communicating outside the machine/container it is running on.
# On YARN this setting will be ignored if it is set to 'localhost', defaulting to 0.0.0.0.
# On Kubernetes this setting will be ignored, defaulting to 0.0.0.0.
#
# To enable this, set the bind-host address to one that has access to an outside facing network
# interface, such as 0.0.0.0.

jobmanager.bind-host: 0.0.0.0


# The total process memory size for the JobManager.
#
# Note this accounts for all memory usage within the JobManager process, including JVM metaspace and other overhead.

jobmanager.memory.process.size: 1600m

# The host interface the TaskManager will bind to. By default, this is localhost, and will prevent
# the TaskManager from communicating outside the machine/container it is running on.
# On YARN this setting will be ignored if it is set to 'localhost', defaulting to 0.0.0.0.
# On Kubernetes this setting will be ignored, defaulting to 0.0.0.0.
#
# To enable this, set the bind-host address to one that has access to an outside facing network
# interface, such as 0.0.0.0.

taskmanager.bind-host: 0.0.0.0

# The address of the host on which the TaskManager runs and can be reached by the JobManager and
# other TaskManagers. If not specified, the TaskManager will try different strategies to identify
# the address.
#
# Note this address needs to be reachable by the JobManager and forward traffic to one of
# the interfaces the TaskManager is bound to (see 'taskmanager.bind-host').
#
# Note also that unless all TaskManagers are running on the same machine, this address needs to be
# configured separately for each TaskManager.

taskmanager.host: localhost

# The total process memory size for the TaskManager.
#
# Note this accounts for all memory usage within the TaskManager process, including JVM metaspace and other overhead.

taskmanager.memory.process.size: 1728m

# To exclude JVM metaspace and overhead, please, use total Flink memory size instead of 'taskmanager.memory.process.size'.
# It is not recommended to set both 'taskmanager.memory.process.size' and Flink memory.
#
# taskmanager.memory.flink.size: 1280m

# The number of task slots that each TaskManager offers. Each slot runs one parallel pipeline.

taskmanager.numberOfTaskSlots: 1

# The parallelism used for programs that did not specify and other parallelism.

parallelism.default: 1

# The default file system scheme and authority.
# 
# By default file paths without scheme are interpreted relative to the local
# root file system 'file:///'. Use this to override the default and interpret
# relative paths relative to a different file system,
# for example 'hdfs://mynamenode:12345'
#
# fs.default-scheme

#==============================================================================
# High Availability
#==============================================================================

# The high-availability mode. Possible options are 'NONE' or 'zookeeper'.
#
# high-availability.type: zookeeper

# The path where metadata for master recovery is persisted. While ZooKeeper stores
# the small ground truth for checkpoint and leader election, this location stores
# the larger objects, like persisted dataflow graphs.
# 
# Must be a durable file system that is accessible from all nodes
# (like HDFS, S3, Ceph, nfs, ...) 
#
# high-availability.storageDir: hdfs:///flink/ha/

# The list of ZooKeeper quorum peers that coordinate the high-availability
# setup. This must be a list of the form:
# "host1:clientPort,host2:clientPort,..." (default clientPort: 2181)
#
# high-availability.zookeeper.quorum: localhost:2181


# ACL options are based on https://zookeeper.apache.org/doc/r3.1.2/zookeeperProgrammers.html#sc_BuiltinACLSchemes
# It can be either "creator" (ZOO_CREATE_ALL_ACL) or "open" (ZOO_OPEN_ACL_UNSAFE)
# The default value is "open" and it can be changed to "creator" if ZK security is enabled
#
# high-availability.zookeeper.client.acl: open

#==============================================================================
# Fault tolerance and checkpointing
#==============================================================================

# The backend that will be used to store operator state checkpoints if
# checkpointing is enabled. Checkpointing is enabled when execution.checkpointing.interval > 0.
#
# Execution checkpointing related parameters. Please refer to CheckpointConfig and ExecutionCheckpointingOptions for more details.
#
# execution.checkpointing.interval: 3min
# execution.checkpointing.externalized-checkpoint-retention: [DELETE_ON_CANCELLATION, RETAIN_ON_CANCELLATION]
# execution.checkpointing.max-concurrent-checkpoints: 1
# execution.checkpointing.min-pause: 0
# execution.checkpointing.mode: [EXACTLY_ONCE, AT_LEAST_ONCE]
# execution.checkpointing.timeout: 10min
# execution.checkpointing.tolerable-failed-checkpoints: 0
# execution.checkpointing.unaligned: false
#
# Supported backends are 'hashmap', 'rocksdb', or the
# <class-name-of-factory>.
#
# state.backend.type: hashmap

# Directory for checkpoints filesystem, when using any of the default bundled
# state backends.
#
# state.checkpoints.dir: hdfs://namenode-host:port/flink-checkpoints

# Default target directory for savepoints, optional.
#
# state.savepoints.dir: hdfs://namenode-host:port/flink-savepoints

# Flag to enable/disable incremental checkpoints for backends that
# support incremental checkpoints (like the RocksDB state backend). 
#
# state.backend.incremental: false

# The failover strategy, i.e., how the job computation recovers from task failures.
# Only restart tasks that may have been affected by the task failure, which typically includes
# downstream tasks and potentially upstream tasks if their produced data is no longer available for consumption.

jobmanager.execution.failover-strategy: region

#==============================================================================
# Rest & web frontend
#==============================================================================

# The port to which the REST client connects to. If rest.bind-port has
# not been specified, then the server will bind to this port as well.
#
#rest.port: 8081

# The address to which the REST client will connect to
#
rest.address: meta1

# Port range for the REST and web server to bind to.
#
rest.bind-port: 8083

# The address that the REST & web server binds to
# By default, this is localhost, which prevents the REST & web server from
# being able to communicate outside of the machine/container it is running on.
#
# To enable this, set the bind address to one that has access to outside-facing
# network interface, such as 0.0.0.0.
#
rest.bind-address: 0.0.0.0

# Flag to specify whether job submission is enabled from the web-based
# runtime monitor. Uncomment to disable.

#web.submit.enable: false

# Flag to specify whether job cancellation is enabled from the web-based
# runtime monitor. Uncomment to disable.

#web.cancel.enable: false

#==============================================================================
# Advanced
#==============================================================================

# Override the directories for temporary files. If not specified, the
# system-specific Java temporary directory (java.io.tmpdir property) is taken.
#
# For framework setups on Yarn, Flink will automatically pick up the
# containers' temp directories without any need for configuration.
#
# Add a delimited list for multiple directories, using the system directory
# delimiter (colon ':' on unix) or a comma, e.g.:
#     /data1/tmp:/data2/tmp:/data3/tmp
#
# Note: Each directory entry is read from and written to by a different I/O
# thread. You can include the same directory multiple times in order to create
# multiple I/O threads against that directory. This is for example relevant for
# high-throughput RAIDs.
#
# io.tmp.dirs: /tmp

# The classloading resolve order. Possible values are 'child-first' (Flink's default)
# and 'parent-first' (Java's default).
#
# Child first classloading allows users to use different dependency/library
# versions in their application than those in the classpath. Switching back
# to 'parent-first' may help with debugging dependency issues.
#
# classloader.resolve-order: child-first

# The amount of memory going to the network stack. These numbers usually need 
# no tuning. Adjusting them may be necessary in case of an "Insufficient number
# of network buffers" error. The default min is 64MB, the default max is 1GB.
# 
# taskmanager.memory.network.fraction: 0.1
# taskmanager.memory.network.min: 64mb
# taskmanager.memory.network.max: 1gb

#==============================================================================
# Flink Cluster Security Configuration
#==============================================================================

# Kerberos authentication for various components - Hadoop, ZooKeeper, and connectors -
# may be enabled in four steps:
# 1. configure the local krb5.conf file
# 2. provide Kerberos credentials (either a keytab or a ticket cache w/ kinit)
# 3. make the credentials available to various JAAS login contexts
# 4. configure the connector to use JAAS/SASL

# The below configure how Kerberos credentials are provided. A keytab will be used instead of
# a ticket cache if the keytab path and principal are set.

# security.kerberos.login.use-ticket-cache: true
# security.kerberos.login.keytab: /path/to/kerberos/keytab
# security.kerberos.login.principal: flink-user

# The configuration below defines which JAAS login contexts

# security.kerberos.login.contexts: Client,KafkaClient

#==============================================================================
# ZK Security Configuration
#==============================================================================

# Below configurations are applicable if ZK ensemble is configured for security

# Override below configuration to provide custom ZK service name if configured
# zookeeper.sasl.service-name: zookeeper

# The configuration below must match one of the values set in "security.kerberos.login.contexts"
# zookeeper.sasl.login-context-name: Client

#==============================================================================
# HistoryServer
#==============================================================================

# The HistoryServer is started and stopped via bin/historyserver.sh (start|stop)

# Directory to upload completed jobs to. Add this directory to the list of
# monitored directories of the HistoryServer as well (see below).
#jobmanager.archive.fs.dir: hdfs:///completed-jobs/

# The address under which the web-based HistoryServer listens.
#historyserver.web.address: 0.0.0.0

# The port under which the web-based HistoryServer listens.
#historyserver.web.port: 8082

# Comma separated list of directories to monitor for completed jobs.
#historyserver.archive.fs.dir: hdfs:///completed-jobs/

# Interval in milliseconds for refreshing the monitored directories.
#historyserver.archive.fs.refresh-interval: 10000
```

### 4.2 配置 `conf/masters`

填写 JobManager 节点（单机写一行 localhost）：

```makefile
meta1:8083
```

### 4.3 配置 `conf/workers`

填写所有 TaskManager 节点 hostname 或 IP（单机写 localhost）：

```makefile
meta1
meta2
meta3
```

------

## 5. 启动集群

```bash
./start-cluster.sh
```

### 5.1 启动 JobManager

```bash
$FLINK_HOME/bin/jobmanager.sh start
```

### 5.2 启动 TaskManager

```bash
$FLINK_HOME/bin/taskmanager.sh start
```

如果多节点，分别在各个 TaskManager 节点启动此命令。

------

## 6. 验证集群状态

访问 Flink Web UI：

```bash
http://meta1:8083
```

可以看到集群概况，TaskManager 节点是否注册成功。

------

## 7. 提交作业

比如提交你的 Flink CDC 作业：

```bash
$FLINK_HOME/bin/flink run -c com.example.YourJob /path/to/your-flink-cdc-job.jar
```

------

## 8. 停止集群

```bash
$FLINK_HOME/bin/jobmanager.sh stop
$FLINK_HOME/bin/taskmanager.sh stop
```

------

## 多机部署要点

- 各节点间 SSH 免密登录方便管理
- 确保防火墙放通 RPC 和 WebUI 端口
- `jobmanager.rpc.address` 需填 JobManager 的主机名或 IP
- `masters` 和 `workers` 文件分别列出对应节点



# SQL Server安装

## 安装 SQL Server 的 Docker 步骤（以 Linux 为例）

### 1. 拉取官方 SQL Server 镜像（以 `2019` 为例）

```bash
docker pull mcr.microsoft.com/mssql/server:2019-latest
```

> ARM 架构（如 Mac M1/M2 芯片）：

```bash
docker pull mcr.microsoft.com/azure-sql-edge
```

------

### 2. 运行容器

```bash
docker run -e "ACCEPT_EULA=Y" \
           -e "MSSQL_SA_PASSWORD=Fashion687415157" \
           -p 1433:1433 \
           --name sqlserver \
           -d mcr.microsoft.com/mssql/server:2019-latest
```

参数说明：

- `ACCEPT_EULA=Y`：接受许可协议
- `MSSQL_SA_PASSWORD`：设置管理员密码（必须包含大小写+数字+特殊字符，长度 ≥ 8）
- `-p 8086:1433`：将容器的 SQL Server 端口映射到主机
- `--name sqlserver`：容器名
- `-d`：后台运行

------

### 3. 验证容器是否运行成功

```
docker ps
```

------

### 4. 使用 SQL Server 客户端连接

可以使用以下方式连接数据库：

#### 方式一：使用 sqlcmd 工具（在容器内）

```bash
docker exec -it sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "YourStrong!Passw0rd"
```

#### 方式二：使用图形工具连接（如 DBeaver / DataGrip / Azure Data Studio）

- 主机名：`localhost`（或实际服务器 IP）
- 端口：`1433`
- 用户名：`SA`
- 密码：`YourStrong!Passw0rd`

**如果确认不需要旧容器，可以先删除**

```bash
docker stop sqlserver
docker rm sqlserver
```

------

##  常见问题

###  报错：无法连接，端口未开放？

请确认：

- 防火墙放通 `1433`
- 使用 `docker ps` 确认容器正在运行
- 使用 `docker logs sqlserver` 查看日志是否初始化成功

------

##  可选：挂载数据卷

```bash
docker run -e "ACCEPT_EULA=Y" \
           -e "MSSQL_SA_PASSWORD=Fashion687415157" \
           -p 1433:1433 \
           -v /your/local/data:/var/opt/mssql \
           --name sqlserver \
           -d mcr.microsoft.com/mssql/server:2019-latest
```

------

需要我帮你准备一个 `docker-compose.yml` 启动 SQL Server 吗？如果你用的是其他数据库（如 MySQL / PostgreSQL / Doris），请告诉我数据库类型。



# SQL Server CDC示例

## 一、前置准备

### 1. SQL Server 示例表

```sql
CREATE TABLE dbo.source_user (
  id INT PRIMARY KEY,
  name VARCHAR(100),
  age INT,
  update_time DATETIME
);
```

### 2. Doris 示例表（通过 JDBC 或 MySQL 客户端）

```sql
CREATE TABLE test.doris_user (
  id INT,
  name STRING,
  age INT,
  update_time DATETIME
)
UNIQUE KEY(id)
DISTRIBUTED BY HASH(id) BUCKETS 3
PROPERTIES (
  "replication_allocation" = "tag.location.default: 1"
);
```

------

## 二、启动 Flink SQL 环境

你可以使用以下方式之一：

- Flink SQL CLI: 下载 Flink、解压后执行 `./bin/sql-client.sh`
- 使用 Flink 集群 + 提交 jar 任务
- 使用 `Flink CDC Studio`（选配）

------

## 三、创建 SQL Server CDC 表

```sql
CREATE TABLE sqlserver_user (
  id INT,
  name STRING,
  age INT,
  update_time TIMESTAMP(3),
  PRIMARY KEY (id) NOT ENFORCED
) WITH (
  'connector' = 'sqlserver-cdc',
  'hostname' = '10.0.0.1',
  'port' = '1433',
  'username' = 'sa',
  'password' = 'Fashion687415157',
  'database-name' = 'naster',
  'table-name' = 'dbo.source_user'
);
```

------

## 四、创建 Doris Sink 表

```sql
CREATE TABLE doris_user (
  id INT,
  name STRING,
  age INT,
  update_time TIMESTAMP(3),
  PRIMARY KEY (id) NOT ENFORCED
) WITH (
  'connector' = 'doris',
  'fenodes' = 'doris-fe-host:8030',
  'table.identifier' = 'doris_db.doris_user',
  'username' = 'root',
  'password' = 'your_doris_password',
  'sink.label-prefix' = 'flink_cdc_sync'
);
```

------

## 五、开始同步任务

```sql
INSERT INTO doris_user
SELECT * FROM sqlserver_user;
```

------



## 脚本模式

```sql
-- job.sql
CREATE TABLE sqlserver_user (
  id INT,
  name STRING,
  age INT,
  update_time TIMESTAMP(3),
  PRIMARY KEY (id) NOT ENFORCED
) WITH (
  'connector' = 'sqlserver-cdc',
  'hostname' = '10.42.226.95',
  'port' = '8086',
  'username' = 'sa',
  'password' = 'Fashion687415157',
  'database-name' = 'flinkcdc',
  'schema-name' = 'dbo',
  'table-name' = 'source_user'
);

CREATE TABLE doris_user (
  id INT,
  name STRING,
  age INT,
  update_time TIMESTAMP(3),
  PRIMARY KEY (id) NOT ENFORCED
) WITH (
  'connector' = 'doris',
  'fenodes' = '10.42.221.116:8030',
  'table.identifier' = 'ods.doris_user',
  'username' = 'root',
  'password' = 'root!qaz'
);

INSERT INTO doris_user
SELECT * FROM sqlserver_user;
```



**启动脚本**

```bash
./bin/sql-client.sh -f /opt/FlinkJob/user_cdc.sql
```



## 六、说明

- Doris Sink 使用的是 Flink 1.17 兼容的 `doris-flink-connector`，确保你引入了以下 jar：

  - `flink-connector-doris-*.jar`
  - `flink-sql-connector-sqlserver-cdc-2.x.jar`

- SQL Server 表需要开启 CDC：

  ```sql
  EXEC sys.sp_cdc_enable_db;
  EXEC sys.sp_cdc_enable_table   
      @source_schema = N'dbo',   
      @source_name   = N'source_user',   
      @role_name     = NULL;
  ```



## 确认 CDC 启用成功

你可以分别执行下面的查询：

### 1. 查看数据库是否启用了 CDC：

```sql
SELECT name, is_cdc_enabled
FROM sys.databases
WHERE name = '你的数据库名';
```

如果 `is_cdc_enabled = 1`，说明数据库级别已启用 CDC。

------

### 2. 查看表是否启用了 CDC：

```sql
SELECT name, is_tracked_by_cdc
FROM sys.tables
WHERE name = '你的表名';
```

如果 `is_tracked_by_cdc = 1`，说明表级别也启用了。

------

## 七、依赖说明（本地 SQL CLI 模式下）

请将以下 JAR 放到 `FLINK_HOME/lib` 目录：

1. `flink-sql-connector-sqlserver-cdc-2.x.jar`
    下载地址：https://nightlies.apache.org/flink/flink-cdc-connectors/
2. `doris-flink-connector-1.17-*.jar`
    下载地址：https://github.com/apache/doris-flink-connector



```
./bin/sql-client.sh \
  --restoreState hdfs://meta1:8020/doris_user/f286497a49c176e7f6c2d656a6b60eee/chk-182
```



```bash
./bin/sql-client.sh embedded \
-restoreState hdfs://meta1:8020/doris_user/f286497a49c176e7f6c2d656a6b60eee/chk-182 \
-update \
-f ./jobs/sqlserver-kafka.sql
```

```sql
SET 'execution.savepoint.path' = 'hdfs://meta1:8020/doris_user/f286497a49c176e7f6c2d656a6b60eee';
```



```sql
 ./bin/sql-client.sh embedded --restorePath hdfs://meta1:8020/doris_user/62ec8e568f3a28843b99a0a2e440b28e/chk-30 -f jobs/sqlserver-kafka.sql
```



```sql
sql-client.sh embedded -s hdfs://<hdfsPath>/savepoint_<timestamp> -f your_sql_file.sql
```



停止任务保存checkpoint

```sql
./bin/flink stop \
  --savepointPath hdfs://meta1:8020/doris_user/d5dcee245f73e1a408098ac1e8f56112 \
  d5dcee245f73e1a408098ac1e8f56112
```



启动checkpoint任务

```sql
./bin/sql-client.sh embedded \
  -Dexecution.savepoint.path=hdfs://meta1:8020/doris_user/43888d8dce083c6564347ef47978d929/chk-11 \
  -f jobs/sqlserver-kafka.sql
```



把这条命令写成一个 **shell 脚本**：

```bash
#!/bin/bash
SAVEPOINT_PATH=$1

./bin/sql-client.sh embedded \
  -Dexecution.savepoint.path=${SAVEPOINT_PATH} \
  -f jobs/sqlserver-kafka.sql
```

然后：

```bash
sh restore.sh hdfs://meta1:8020/doris_user/xxx/savepoint-xxx
```





