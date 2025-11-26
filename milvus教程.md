# docker教程

```
apt install docker.io

wget -O /usr/local/sbin/docker-compose https://lxkjyum.luxsan-ict.com/

chmod 777 /usr/local/sbin/docker-compose
```



## docker安装

## Oracle Linux 7.9 安装 Docker CE 步骤

### ✅ 1. 卸载旧版本（如果有）

```bash
sudo yum remove docker \
                docker-client \
                docker-client-latest \
                docker-common \
                docker-latest \
                docker-latest-logrotate \
                docker-logrotate \
                docker-engine
```

------

### ✅ 2. 安装依赖工具

```bash
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
```

------

### ✅ 3. 添加 Docker 官方 Yum 源

```bash
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
```

> 💡 虽然是 CentOS 源，但 Oracle Linux 与 CentOS 7 兼容，可直接使用。

------

### ✅ 4. 安装 Docker 引擎

```bash
sudo yum install -y docker-ce docker-ce-cli containerd.io
```

------

### ✅ 5. 启动 Docker 并设置开机自启

```bash
sudo systemctl start docker
sudo systemctl enable docker
```

------

### ✅ 6. 验证安装

```bash
docker version
docker run hello-world
```

##  注意事项

- 如果你网络访问 Docker 官方源速度慢，可以替换为阿里云镜像：

  ```bash
  sudo tee /etc/docker/daemon.json <<-'EOF'
  {
    "registry-mirrors": ["https://<你的加速器地址>.mirror.aliyuncs.com"]
  }
  EOF
  sudo systemctl daemon-reexec
  sudo systemctl restart docker
  ```

## Docker安装应用

##  Milvus 服务

Milvus **不能单独运行**，它依赖以下组件：

- `etcd`（元数据）
- `minio`（对象存储）
- `milvus` 本体容器

因此，推荐使用 `docker-compose` 来一次性启动所有组件。

------

## 🧩 一键部署：创建 `docker-compose.yml`

### ✅ 1. 创建配置文件

在你的任意目录下创建一个文件：

```
bash复制编辑mkdir -p ~/milvus && cd ~/milvus
vim docker-compose.yml
```

把以下内容粘贴进去：

```yml
version: '3.5'

services:
  etcd:
    image: quay.io/coreos/etcd:v3.5.5
    container_name: etcd
    environment:
      - ETCD_AUTO_COMPACTION_RETENTION=1
      - ETCD_QUOTA_BACKEND_BYTES=4294967296
      - ALLOW_NONE_AUTHENTICATION=yes
    command: 
       etcd
       --advertise-client-urls http://0.0.0.0:2379 
       --listen-client-urls http://0.0.0.0:2379
    ports:
      - "2379:2379"

  minio:
    image: minio/minio:RELEASE.2023-09-23T03-47-50Z
    container_name: minio
    command: server /data --console-address ":9001"
    environment:
      MINIO_ROOT_USER: minioadmin
      MINIO_ROOT_PASSWORD: minioadmin
    ports:
      - "9000:9000"
      - "9001:9001"

  milvus:
    image: milvusdb/milvus:v2.4.4
    container_name: milvus
    command: ["milvus", "run", "standalone"]
    ports:
      - "19530:19530"
      - "9091:9091"
    depends_on:
      - etcd
      - minio
    environment:
      ETCD_ENDPOINTS: etcd:2379
      MINIO_ADDRESS: minio:9000
      MINIO_ACCESS_KEY: minioadmin
      MINIO_SECRET_KEY: minioadmin
      DATA_PATH: /var/lib/milvus/data

  attu:
    image: zilliz/attu
    container_name: attu
    ports:
      - "8089:3000"
    environment:
      - MILVUS_URL=milvus:19530
      - PUBLIC_PATH=/ 
    depends_on:
      - milvus
```

------

### ✅ 2. 启动 Milvus 全家桶

```bash
docker-compose up -d
```

这将会启动三个容器：`etcd`、`minio` 和 `milvus`。

------

### ✅ 3. 验证服务是否启动成功

```bash
docker ps
```

你应该会看到：

```bash
CONTAINER ID   IMAGE                        ...   NAMES
xxxxxxxxxxxx   milvusdb/milvus:v2.4.4      ...   milvus
xxxxxxxxxxxx   quay.io/coreos/etcd:v3.5.5  ...   etcd
xxxxxxxxxxxx   minio/minio:RELEASE...      ...   minio
```

------

### ✅ 4. 测试连接（Python 可选）

安装 SDK：

```
pip install pymilvus
```

测试代码：

```python
from pymilvus import connections
connections.connect("default", host="localhost", port="19530")
print("Connected to Milvus!")
```

### ✅ 5.docker开启关闭应用命令

```
docker-compose down
docker-compose up -d
```



## 运行程式

```bash
 pip install pymilvus==2.4.4
 pip install sentence-transformers==2.2.2
 pip install huggingface-hub==0.10.1 transformers==4.25.1

```

