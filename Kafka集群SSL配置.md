## 一、集群规划（示例）

| 节点名      | IP地址        | 角色              |
| ----------- | ------------- | ----------------- |
| kafka-node1 | 192.168.1.101 | Controller+Broker |
| kafka-node2 | 192.168.1.102 | Broker            |
| kafka-node3 | 192.168.1.103 | Broker            |



Kafka 版本：`3.7.0`（建议使用 3.3+ 版本支持 KRaft）

------

##  二、准备工作

### 1. 下载 Kafka 并解压

```
wget https://downloads.apache.org/kafka/3.7.0/kafka_2.13-3.7.0.tgz
tar -xzf kafka_2.13-3.7.0.tgz
mv kafka_2.13-3.7.0 /opt/kafka
```

### 2. 配置 hosts（所有节点）

```
sudo vim /etc/hosts

# 添加如下行
192.168.1.101 kafka-node1
192.168.1.102 kafka-node2
192.168.1.103 kafka-node3
```

------

##  三、配置 SSL

### 1. 生成自签名 CA 和证书

```bash
#安装openssl
yum install -y openssl
#找到安装路径
find / -name openssl 2>/dev/null
#添加环境变量 profile中
export PATH=$PATH:/usr/local/ssl/bin
#更新profile文件
source /etc/profile
```

在任意一台机器操作即可：

```bash
# 创建 CA 根证书
openssl req -new -x509 -keyout ca-key -out ca-cert -days 1000 -nodes -subj "/CN=Kafka-CA"

# 为每个节点创建 keystore 和证书签名请求 (CSR)
# 替换 NODE 为对应主机名，如 meta1
keytool -genkey -alias meta1 -keystore meta1.keystore.jks \
  -keyalg RSA -storepass password -keypass kunge666 -dname "CN=meta1"

keytool -certreq -alias meta1 \
  -keystore meta1.keystore.jks \
  -file meta1.csr \
  -storepass password \
  -keypass kunge666

# 使用 CA 签署证书
openssl x509 -req -CA ca-cert -CAkey ca-key -in meta1.csr \
  -out meta1-cert-signed -days 10000 -CAcreateserial -sha256

# 导入 CA 和签名证书到 keystore
keytool -import -alias CARoot -keystore meta1.keystore.jks \
  -file ca-cert -storepass password -noprompt

keytool -import -alias meta1 -keystore meta1.keystore.jks \
  -file meta1-cert-signed -storepass password

# 创建 truststore
keytool -import -alias CARoot -keystore meta1.truststore.jks \
  -file ca-cert -storepass password -noprompt
```

将每台节点的 keystore、truststore 分发至各自节点，并放在 `/opt/kafka/ssl/` 目录。

```bash
# 1. 创建目录
mkdir -p /opt/kafka/ssl

# 2. 确认目录权限，假设 root 运行用户是 root
chown root:root /opt/kafka/ssl

# 3. 复制证书文件到该目录，比如从本地或管理机 scp 过去
scp meta1.keystore.jks meta1.truststore.jks root@LZCU-TES-AP01:/opt/kafka/ssl/

# 4. 修改权限
chmod 640 /opt/kafka/ssl/*.jks
chown root:root /opt/kafka/ssl/*.jks
# 5. 分发其他节点
scp root@meta2:/opt/kafka/ssl/meta1.keystore.jks /opt/kafka/ssl/
scp root@meta3:/opt/kafka/ssl/truststore.jks /opt/kafka/ssl/
# 6.给每个节点修改权限
chmod 640 /opt/kafka/ssl/*.jks
chown root:root /opt/kafka/ssl/*.jks
```





openssl req -new -x509 -keyout ca-key -out ca-cert -days 365 -nodes -subj "/CN=Kafka-CA"

| 参数                   | 作用                                                         |
| ---------------------- | ------------------------------------------------------------ |
| `openssl req`          | 启动 OpenSSL 的证书请求子命令（可以创建证书请求或自签证书）  |
| `-new`                 | 创建新的证书请求（CSR）或证书                                |
| `-x509`                | 表示不只是生成 CSR，还要直接创建一个自签名的 X.509 证书（即 CA） |
| `-keyout ca-key`       | 生成的私钥文件保存为 `ca-key`                                |
| `-out ca-cert`         | 生成的自签名证书文件保存为 `ca-cert`                         |
| `-days 365`            | 证书有效期为 365 天                                          |
| `-nodes`               | 不为私钥加密（无密码保护，通常用于测试场景）                 |
| `-subj "/CN=Kafka-CA"` | 指定证书的主题字段（Subject），这里 `CN=Kafka-CA` 表示 Common Name 是 “Kafka-CA” |



keytool -genkey -alias kafka-node1 -keystore kafka-node1.keystore.jks \
  -keyalg RSA -storepass password -keypass password -dname "CN=kafka-node1"

| 参数                                 | 说明                                                         |
| ------------------------------------ | ------------------------------------------------------------ |
| `-genkey`                            | 命令类型：生成一对密钥（公钥+私钥）并存储到 keystore         |
| `-alias kafka-node1`                 | 此密钥对的别名，方便以后引用                                 |
| `-keystore kafka-node1.keystore.jks` | 要创建的 keystore 文件名，格式为 JKS（Java KeyStore）        |
| `-keyalg RSA`                        | 使用的加密算法，这里使用 RSA                                 |
| `-storepass password`                | keystore 的访问密码                                          |
| `-keypass password`                  | 此别名对应的密钥对的密码（通常与 storepass 相同）            |
| `-dname "CN=kafka-node1"`            | 证书的主题信息，这里只指定了 Common Name 为 `kafka-node1`，后续签发证书时会作为用户名 |



keytool -certreq -alias kafka-node1 -keystore kafka-node1.keystore.jks \
  -file kafka-node1.csr -storepass password

| 参数                                 | 说明                                          |
| ------------------------------------ | --------------------------------------------- |
| `-certreq`                           | 指定生成证书签名请求（CSR）                   |
| `-alias kafka-node1`                 | keystore 中使用的密钥对的别名                 |
| `-keystore kafka-node1.keystore.jks` | keystore 文件                                 |
| `-file kafka-node1.csr`              | 生成的 CSR 文件名，将保存为 `kafka-node1.csr` |
| `-storepass password`                | keystore 的访问密码                           |



#### Keystore 是什么？

`keystore` 是 Java 中用于存储加密密钥、证书（如 SSL 证书）等敏感信息的**受保护的数据库文件**，常用于网络通信中的加密认证场景，比如：

- **HTTPS / SSL 证书配置**
- **Kafka 启用 SSL 通信**
- **Java 应用安全通信**
- **Flink / Hadoop / Spark 配置 SSL**

它是一个文件，里面可以存储：

- 私钥（Private Key）
- 公钥（Public Key）
- 数字证书（如 X.509）
- 证书链
- 信任的根证书（可选）

它通常是一个 `.jks` 文件（Java KeyStore），也可能是 `.p12`（PKCS12 格式）



------

##  四、配置 KRaft 模式 + SSL + ACL

**元数据存储**

```bash
mkdir -p /opt/kafka/data
chown -R root:root /opt/kafka/data
chmod 700 /opt/kafka/data
```

以 kafka-node1 为例，编辑 `config/kraft/server.properties`：

```properties
# 基本配置
node.id=1
process.roles=broker,controller
controller.quorum.voters=1@meta1:9093,2@meta2:9093,3@meta3:9093
listeners=SSL://meta1:9093,CONTROLLER://meta1:9094
advertised.listeners=SSL://meta1:9093
listener.security.protocol.map=CONTROLLER:PLAINTEXT,SSL:SSL
log.dirs=/opt/kafka/data
inter.broker.listener.name=SSL
controller.listener.names=CONTROLLER
metadata.log.dir=/opt/kafka/meta
num.network.threads=3
num.io.threads=8

# SSL 配置
ssl.keystore.location=/opt/kafka/ssl/meta1.keystore.jks
ssl.keystore.password=password
ssl.key.password=kunge666
ssl.truststore.location=/opt/kafka/ssl/meta1.truststore.jks
ssl.truststore.password=password
ssl.client.auth=required

# 启用 ACL + 认证机制
#authorizer.class.name=kafka.security.authorizer.AclAuthorizer --这是zookeeper认证模式
#这是kraft模型权限认证
authorizer.class.name=org.apache.kafka.metadata.authorizer.StandardAuthorizer 
super.users=User:admin
allow.everyone.if.no.acl.found=false
```

其余节点 node.id 改为 `2`, `3`，并替换 `listeners`, `keystore` 文件即可。

------

##  五、格式化元数据目录（首次）

创建

只需在 **每个节点执行一次**：

```bash
/opt/kafka/bin/kafka-storage.sh format -t $(/opt/kafka/bin/kafka-storage.sh random-uuid) -c /opt/kafka/config/kraft/server.properties
```

------

## 六、启动 Kafka 集群

每个节点：

```bash
cd /opt/kafka
bin/kafka-server-start.sh config/kraft/server.properties
```

------

## 七、创建 ACL 认证用户

创建topic

```
/opt/kafka/bin/kafka-topics.sh --create --topic test-topic --partitions 3 --replication-factor 3 --bootstrap-server meta1:9092,meta2:9092,meta3:9092
```



默认 Kafka 使用 `SSL` 证书中 CN 字段作为用户名认证。

如果你想模拟用户管理，也可以使用 SASL_PLAINTEXT + ACL，但这里我们用 SSL 本身的认证。

例如，客户端配置了如下 truststore 和 keystore，且 CN 为 `client-user`，你就需要给他授权：

```bash
授权某用户读写 test 主题
bin/kafka-acls.sh --authorizer-properties zookeeper.connect=localhost:2181 \
  --add --allow-principal "User:client-user" --operation Read --operation Write --topic test
```

KRaft 模式下不再用 Zookeeper，所以改为如下方式（配置在 server.properties 中的 authorizer）：

```bash
bin/kafka-acls.sh --bootstrap-server kafka-node1:9093 \
  --add --allow-principal "User:client-user" --operation Read --operation Write --topic test
```

------

## 八、客户端配置（生产者 / 消费者）

客户端需配置：

```properties
security.protocol=SSL
ssl.truststore.location=/path/to/truststore.jks
ssl.truststore.password=password
ssl.keystore.location=/path/to/keystore.jks
ssl.keystore.password=password
ssl.key.password=password
```

如果你使用 Java、Python、Kafka Console 工具等都支持这些配置。

------

## 九、验证 ACL 效果

1. 未授权用户将被拒绝连接或访问。
2. 授权用户可以正常使用 `kafka-console-producer.sh` 和 `kafka-console-consumer.sh`。

------

如你需要完整部署脚本、systemd 启动配置、带 Docker 的版本、或者希望支持 SASL/SCRAM 用户名密码方式，也可以告诉我，我可继续帮你定制。

是否需要我：

- 帮你生成完整的脚本
- 提供 Docker/K8s 版本
- 或搭配 Kafka UI 工具（如 Kafka Eagle、AKHQ）？



# （ JKS → PEM → Python 代码 ）

```bash
# keystore（含私钥 + 客户端证书）
keytool -importkeystore \
  -srckeystore unified.keystore.jks \
  -destkeystore nginx.keystore.p12 \
  -deststoretype PKCS12 \
  -srcstorepass 123456 \
  -deststorepass 123456

# truststore（含 CA 根证书）
keytool -importkeystore \
  -srckeystore unified.truststore.jks \
  -destkeystore nginx.truststore.p12 \
  -deststoretype PKCS12 \
  -srcstorepass 123456 \
  -deststorepass 123456
```

### 第 2 步：提取 PEM 文件（供 Python 使用）

```
# 提取 client key（私钥）
openssl pkcs12 -in nginx.keystore.p12 -nocerts -nodes -out kafka-client.key -passin pass:123456

# 提取 client crt（客户端证书）
openssl pkcs12 -in nginx.keystore.p12 -clcerts -nokeys -out kafka-client.crt -passin pass:123456

# 提取 CA 根证书（PEM 格式）
openssl pkcs12 -in nginx.truststore.p12 -nokeys -cacerts -out ca-cert.pem -passin pass:123456
```

执行完后你会得到这 3 个关键文件：

```bash
kafka-client.key      # 客户端私钥
kafka-client.crt      # 客户端证书
ca-cert.pem           # Kafka 集群 CA 根证书
```

------

###  第 3 步：Python Kafka 生产者示例（SSL + ACL）

```
from kafka import KafkaProducer
import ssl

ssl_context = ssl.create_default_context(
    purpose=ssl.Purpose.SERVER_AUTH,
    cafile='ca-cert.pem'
)
ssl_context.load_cert_chain(
    certfile='kafka-client.crt',
    keyfile='kafka-client.key'
)

producer = KafkaProducer(
    bootstrap_servers=['kafka1:9093', 'kafka2:9093', 'kafka3:9093'],
    security_protocol='SSL',
    ssl_context=ssl_context,
    value_serializer=lambda v: v.encode('utf-8'),
    client_id='client1'
)

producer.send('topic1', value='Hello, SSL + ACL')
producer.flush()
print("发送成功")
```

------

###  第 4 步：Python Kafka 消费者示例（SSL + ACL）

```
python复制编辑from kafka import KafkaConsumer
import ssl

ssl_context = ssl.create_default_context(
    purpose=ssl.Purpose.SERVER_AUTH,
    cafile='ca-cert.pem'
)
ssl_context.load_cert_chain(
    certfile='kafka-client.crt',
    keyfile='kafka-client.key'
)

consumer = KafkaConsumer(
    'topic1',
    bootstrap_servers=['kafka1:9093', 'kafka2:9093', 'kafka3:9093'],
    security_protocol='SSL',
    ssl_context=ssl_context,
    auto_offset_reset='earliest',
    enable_auto_commit=True,
    group_id='test-group',
    value_deserializer=lambda v: v.decode('utf-8'),
    client_id='client1'
)

for msg in consumer:
    print("收到消息:", msg.value)
```

------

###  ACL 配置要点回顾

确认你的 ACL 授权是针对客户端证书中 CN 的：

```
bash复制编辑# 查看客户端证书 CN
openssl x509 -in kafka-client.crt -noout -subject
```

输出示例：

```
ini
subject=CN = client1
```

则你的 ACL 权限必须设置为：

```
# 允许 client1 生产 topic1
kafka-acls.sh --bootstrap-server kafka1:9093 \
  --add --allow-principal "User:client1" --producer --topic topic1

# 允许 client1 消费 topic1
kafka-acls.sh --bootstrap-server kafka1:9093 \
  --add --allow-principal "User:client1" --consumer --topic topic1 --group test-group
```