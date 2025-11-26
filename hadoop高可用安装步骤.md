# hadoop高可用安装步骤

| 主机名 | IP地址        | 角色          |
| ------ | ------------- | ------------- |
| meta1  | 10.42.221.136 | nn1 + JN + ZK |
| meta2  | 10.42.221.137 | nn2 + JN + ZK |
| meta3  | 10.42.221.138 | JN + ZK       |



Hadoop 3.4.0 高可用集群完整配置和启动脚本流程。

------

# 一、核心配置文件

所有配置文件建议放在 `$HADOOP_HOME/etc/hadoop/` 下，集群各节点保持配置一致（节点名不同的地方会注释）

------

## 1.1 core-site.xml

```xml
<configuration>
  <property>
    <name>fs.defaultFS</name>
    <value>hdfs://mycluster</value>
  </property>

  <!-- ZooKeeper Quorum 地址 -->
  <property>
    <name>ha.zookeeper.quorum</name>
    <value>meta1:2181,meta2:2181,meta3:2181</value>
  </property>
</configuration>
```

------

## 1.2 hdfs-site.xml

```xml
<configuration>
  <!-- 高可用命名服务 -->
  <property>
    <name>dfs.nameservices</name>
    <value>mycluster</value>
  </property>

  <!-- NameNode ID -->
  <property>
    <name>dfs.ha.namenodes.mycluster</name>
    <value>nn1,nn2</value>
  </property>

  <!-- NameNode RPC 地址 -->
  <property>
    <name>dfs.namenode.rpc-address.mycluster.nn1</name>
    <value>meta1:8020</value>
  </property>
  <property>
    <name>dfs.namenode.rpc-address.mycluster.nn2</name>
    <value>meta2:8020</value>
  </property>

  <!-- NameNode HTTP 地址 -->
  <property>
    <name>dfs.namenode.http-address.mycluster.nn1</name>
    <value>meta1:9870</value>
  </property>
  <property>
    <name>dfs.namenode.http-address.mycluster.nn2</name>
    <value>meta2:9870</value>
  </property>

  <!-- 共享编辑日志目录，使用QJM -->
  <property>
    <name>dfs.namenode.shared.edits.dir</name>
    <value>qjournal://meta1:8485;meta2:8485;meta3:8485/mycluster</value>
  </property>

  <!-- 客户端故障转移代理 -->
  <property>
    <name>dfs.client.failover.proxy.provider.mycluster</name>
    <value>org.apache.hadoop.hdfs.server.namenode.ha.ConfiguredFailoverProxyProvider</value>
  </property>

  <!-- fencing机制 -->
  <property>
    <name>dfs.ha.fencing.methods</name>
    <value>sshfence</value>
  </property>
  <property>
    <name>dfs.ha.fencing.ssh.private-key-files</name>
    <value>/root/.ssh/id_rsa</value>
  </property>

  <!-- JournalNode edits目录 -->
  <property>
    <name>dfs.journalnode.edits.dir</name>
    <value>/opt/data/journalnode</value>
  </property>

  <!-- 自动故障转移 -->
  <property>
    <name>dfs.ha.automatic-failover.enabled</name>
    <value>true</value>
  </property>

  <!-- NameNode本地存储目录 -->
  <property>
    <name>dfs.namenode.name.dir</name>
    <value>file:///opt/data/dfs/namenode</value>
  </property>

  <!-- DataNode数据存储目录 -->
  <property>
    <name>dfs.datanode.data.dir</name>
    <value>file:///opt/data/dfs/datanode</value>
  </property>

  <!-- 副本数 -->
  <property>
    <name>dfs.replication</name>
    <value>2</value>
  </property>
</configuration>
```

------

## 1.3 yarn-site.xml

```xml
<configuration>
  <property>
    <name>yarn.resourcemanager.ha.enabled</name>
    <value>true</value>
  </property>

  <property>
    <name>yarn.resourcemanager.cluster-id</name>
    <value>yarn-cluster</value>
  </property>

  <property>
    <name>yarn.resourcemanager.ha.rm-ids</name>
    <value>rm1,rm2</value>
  </property>

  <property>
    <name>yarn.resourcemanager.hostname.rm1</name>
    <value>meta1</value>
  </property>

  <property>
    <name>yarn.resourcemanager.hostname.rm2</name>
    <value>meta2</value>
  </property>

  <property>
    <name>yarn.resourcemanager.address.rm1</name>
    <value>meta1:8032</value>
  </property>

  <property>
    <name>yarn.resourcemanager.address.rm2</name>
    <value>meta2:8032</value>
  </property>

  <property>
    <name>yarn.resourcemanager.scheduler.address.rm1</name>
    <value>meta1:8030</value>
  </property>

  <property>
    <name>yarn.resourcemanager.scheduler.address.rm2</name>
    <value>meta2:8030</value>
  </property>

  <property>
    <name>yarn.resourcemanager.resource-tracker.address.rm1</name>
    <value>meta1:8031</value>
  </property>

  <property>
    <name>yarn.resourcemanager.resource-tracker.address.rm2</name>
    <value>meta2:8031</value>
  </property>

  <property>
    <name>yarn.resourcemanager.webapp.address.rm1</name>
    <value>meta1:8088</value>
  </property>

  <property>
    <name>yarn.resourcemanager.webapp.address.rm2</name>
    <value>meta2:8088</value>
  </property>

  <!-- 自动故障转移 -->
  <property>
    <name>yarn.resourcemanager.ha.automatic-failover.enabled</name>
    <value>true</value>
  </property>

  <property>
    <name>yarn.resourcemanager.zk-address</name>
    <value>meta1:2181,meta2:2181,meta3:2181</value>
  </property>
</configuration>
```

------

## 1.4 mapred-site.xml

```
<configuration>
  <property>
    <name>mapreduce.framework.name</name>
    <value>yarn</value>
  </property>
</configuration>
```

------

## 1.5 hadoop-env.sh

```bash
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
```



# 二、ZooKeeper 配置

三台机器上均需安装 ZooKeeper，配置文件 `$ZOOKEEPER_HOME/conf/zoo.cfg`：

```properties
tickTime=2000
dataDir=/var/lib/zookeeper
clientPort=2181
initLimit=5
syncLimit=2
server.1=meta1:2888:3888
server.2=meta2:2888:3888
server.3=meta3:2888:3888
```

------

# 三、JournalNode 配置

三台机器上需要配置 JournalNode 数据目录：

```bash
mkdir -p /opt/data/journalnode
chown -R $(whoami) /opt/data/journalnode
```

启动 JournalNode：

```bash
$HADOOP_HOME/sbin/hadoop-daemon.sh start journalnode
```

------

# 四、目录权限准备（所有机器）

```bash
mkdir -p /opt/data/dfs/namenode
mkdir -p /opt/data/dfs/datanode
chown -R $(whoami) /opt/data/dfs
```

------

# 五、格式化和启动步骤

> **只在主 NameNode（meta1）操作：**

1. 格式化 NameNode 和 ZKFC：

```bash
hdfs namenode -format
hdfs zkfc -formatZK
```

1. 启动 NameNode：

```bash
hdfs --daemon start namenode
```

1. 启动 ZK Failover Controller：

```bash
hdfs --daemon start zkfc
```

> **在备 NameNode（meta2）操作：**

1. 执行 Standby NameNode 初始化：

```bash
hdfs namenode -bootstrapStandby
```

1. 启动 Standby NameNode 和 ZKFC：

```bash
hdfs --daemon start namenode
hdfs --daemon start zkfc
```

------

# 六、启动 DataNode 和 YARN 服务（所有节点）

```bash
hdfs --daemon start datanode
yarn --daemon start resourcemanager   # 只在 rm1 和 rm2
yarn --daemon start nodemanager       # 所有节点
```

------

# 七、验证集群状态

```bash
hdfs haadmin -getServiceState nn1  # 应该显示 active 或 standby
hdfs haadmin -getServiceState nn2

hdfs dfsadmin -report

yarn rmadmin -getServiceState rm1
yarn rmadmin -getServiceState rm2
```

访问 Web UI：

- NameNode: `http://meta1:9870` 或 `http://meta2:9870`
- ResourceManager: `http://meta1:8088` 或 `http://meta2:8088`

------

# 八、启动顺序总结脚本

**hadoop集群停止脚本**

```bash
#!/bin/bash

nn1=meta1
nn2=meta2
jn_nodes=("meta1" "meta2" "meta3")
nm_nodes=("meta1" "meta2" "meta3")
rm_nodes=("meta1" "meta2" )

echo "=== 停止 YARN NodeManager ==="
for host in "${nm_nodes[@]}"; do
  echo "Stopping NodeManager on $host"
  ssh "-> $host" "yarn --daemon stop nodemanager"
done

echo "=== 停止 YARN ResourceManager ==="
for host in "${rm_nodes[@]}"; do
  echo "Stopping DataNode on $host"
  ssh "$host" "yarn --daemon stop resourcemanager"
done

echo "=== 停止 ZK Failover Controller (ZKFC) ==="
ssh "$nn1" "hdfs --daemon stop zkfc"
echo "-> Stopping ZK Failover Controller on $nn1"
ssh "$nn2" "hdfs --daemon stop zkfc"
echo "-> Stopping ZK Failover Controller on $nn2"
echo "=== 停止 HDFS DataNode ==="
for host in "${nm_nodes[@]}"; do
  echo "Stopping DataNode on $host"
  ssh "$host" "hdfs --daemon stop datanode"
done

echo "=== 停止 HDFS NameNode ==="
ssh "$nn1" "hdfs --daemon stop namenode"
echo "-> Stopping HDFS NameNode on $nn1"
ssh "$nn2" "hdfs --daemon stop namenode"
echo "-> Stopping HDFS NameNode on $nn2"
echo "=== 停止 JournalNode ==="
for host in "${jn_nodes[@]}"; do
  echo "Stopping JournalNode on $host"
  ssh "$host" "hdfs --daemon stop journalnode"
done

echo "=== Hadoop 集群已停止 ==="
```

**hadoop集群启动脚本**

```bash
#!/bin/bash
HADOOP_BIN="/opt/hadoop/bin"
nn1=meta1
nn2=meta2
jn_nodes=("meta1" "meta2" "meta3")
nm_nodes=("meta1" "meta2" "meta3")
rm_nodes=("meta1" "meta2" )

echo "=== 启动 JournalNode ==="
for host in "${jn_nodes[@]}"; do
  echo " -> $host : journalnode"
  ssh "$host" "$HADOOP_BIN/hdfs --daemon start journalnode"
done

echo "=== 启动 HDFS NameNode ==="
ssh "$nn1" "$HADOOP_BIN/hdfs --daemon start namenode"
echo "--> $nn1 启动NameNode "
ssh "$nn2" "$HADOOP_BIN/hdfs --daemon start namenode"
echo "--> $nn2 启动NameNode "
echo "=== 启动 HDFS DataNode ==="
for host in "${nm_nodes[@]}"; do
  echo " -> $host : DataNode"
  ssh "$host" "$HADOOP_BIN/hdfs --daemon start datanode"
done

echo "=== 启动 ZK Failover Controller (ZKFC) ==="
ssh "$nn1" "$HADOOP_BIN/hdfs --daemon start zkfc"
echo "--> $nn1 启动 ZK Failover Controller"
ssh "$nn2" "$HADOOP_BIN/hdfs --daemon start zkfc"
echo "--> $nn2 启动 ZK Failover Controller"

echo "=== 启动 YARN ResourceManager ==="
for host in "${rm_nodes[@]}"; do
  echo " -> $host : 启动 YARN ResourceManager"
  ssh "$host" "$HADOOP_BIN/yarn --daemon start resourcemanager"
done
echo "=== 启动 YARN NodeManager ==="
for host in "${nm_nodes[@]}"; do
  echo " -> $host : nodemanager"
  ssh "$host" "$HADOOP_BIN/yarn --daemon start nodemanager"
done

echo "===  hadoop集群启动完成 ==="
```

