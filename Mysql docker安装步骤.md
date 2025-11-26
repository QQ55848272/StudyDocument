## Mysql docker安装步骤

docker-compose.yml

```yaml
version: '3.8'

services:
  mysql:
    image: mysql:8.0
    container_name: mysql-server
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: your_password
      MYSQL_DATABASE: mydb
      MYSQL_USER: user
      MYSQL_PASSWORD: user_password
    ports:
      - "3306:3306"
    volumes:
      - /opt/mysql/data:/var/lib/mysql
    command:
      --default-authentication-plugin=mysql_native_password
```

### 使用步骤：

1. 确保宿主机 `/opt/mysql/data` 目录存在并且有权限：

```bash
mkdir -p /opt/mysql/data
chmod 755 /opt/mysql/data
```

1. 将上面的内容保存为 `docker-compose.yml`。
2. 启动 MySQL：

```bash
docker-compose up -d
```

1. 查看容器状态：

```bash
docker-compose ps
```

1. 连接 MySQL：

```bash
mysql -h 127.0.0.1 -P 3306 -u root -p
```

### 允许 root 用户远程登录

默认 MySQL 的 `root` 用户只允许本地登录，远程登录会拒绝。你需要给 `root` 用户授权允许远程访问。

进入 MySQL 容器：

```bash
docker exec -it mysql-server mysql -uroot -p
```

输入 root 密码登录后，执行：

```sql
-- 允许 root 从任意IP连接
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'your_password';

-- 刷新权限
FLUSH PRIVILEGES;
```

> 注意把 `'your_password'` 改成你真实的 root 密码。

1. **确认防火墙和端口**

确认 MySQL 端口 3306 在宿主机开放，防火墙允许访问。

```bash
firewall-cmd --list-all
firewall-cmd --add-port=3306/tcp --permanent
firewall-cmd --reload
```

（如果是离线环境，防火墙配置可能也要检查）

1. **确认 MySQL 容器端口映射正确**

`docker-compose.yml` 中端口映射 `"3306:3306"` 必须正确。

------

### 额外提醒

- 使用 `root` 用户远程连接生产环境风险较大，建议创建专门的用户并授权：

```sql
CREATE USER 'hadoopuser'@'10.69.32.60' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'hadoopuser'@'10.69.32.60' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```

- 如果修改用户失败，确认你 MySQL 版本和认证插件，可能需要指定 `mysql_native_password`。

