# azkaban远程调度任务

在Azkaban中远程执行服务器脚本且不使用免密登录（即使用账户密码），虽然存在安全风险，但在某些限制环境下可能是必要的。以下是安全实施方法：

### 核心方法：使用`sshpass`工具

https://sourceforge.net/projects/sshpass/ 可以在命令行中直接传递密码（非交互式）

#### 步骤1: 在Azkaban Executor服务器安装sshpass

bash

```
# Ubuntu/Debian
sudo apt-get install sshpass

# CentOS/RHEL
sudo yum install sshpass
```

#### 步骤2: 创建包含密码的执行脚本（并严格设置权限）

bash

```
#!/bin/bash
# remote_executor.sh

# 安全提示：此方法密码可见，建议仅在安全环境中使用
REMOTE_HOST="your.remote.host"
REMOTE_USER="username"
REMOTE_PASSWORD="yourpassword"  # 实际使用时可从加密文件读取
REMOTE_SCRIPT="/path/to/script.sh"

# 使用sshpass执行远程命令
sshpass -p "$REMOTE_PASSWORD" ssh -o StrictHostKeyChecking=no -o LogLevel=ERROR ${REMOTE_USER}@${REMOTE_HOST} "bash ${REMOTE_SCRIPT}"
```

#### 步骤3: 设置脚本权限（重要！）

bash

```
chmod 700 remote_executor.sh
chown azkaban:azkaban remote_executor.sh
```

#### 步骤4: Azkaban Job配置

properties

```
# remote_job.job
type=command
command=sh remote_executor.sh
```

### 高级安全方案：使用环境变量传递密码（推荐）

#### 1. 创建安全凭证文件（仅Azkaban管理员可访问）

bash

```
sudo mkdir /etc/azkaban_secure
sudo nano /etc/azkaban_secure/remote_credentials
```

文件内容（格式）：

ini

```
REMOTE_HOST=your.remote.host
REMOTE_USER=username
REMOTE_PASSWORD=yourpassword
```

#### 2. 修改脚本读取凭证文件

bash

```
#!/bin/bash
# remote_executor_secure.sh

# 加载凭证（确保文件权限仅azkaban用户可读）
source /etc/azkaban_secure/remote_credentials

sshpass -p "$REMOTE_PASSWORD" ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} "bash /path/to/script.sh"
```

#### 3. 设置严格权限

bash

```
sudo chown root:azkaban /etc/azkaban_secure/remote_credentials
sudo chmod 640 /etc/azkaban_secure/remote_credentials
```

### 备选方案：使用expect脚本

如果系统不允许安装sshpass，可以用expect：

#### expect脚本示例 (remote.exp)

expect

```
#!/usr/bin/expect -f

set REMOTE_HOST "your.remote.host"
set REMOTE_USER "username"
set PASSWORD "yourpassword"
set REMOTE_SCRIPT "/path/to/script.sh"

spawn ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} "bash ${REMOTE_SCRIPT}"
expect "password:"
send "${PASSWORD}\r"
expect eof
```

#### Azkaban执行脚本包装

bash

```
#!/bin/bash
# remote_expect_wrapper.sh

expect /path/to/remote.exp
```

### 安全强化建议

1. **最小权限原则**：

   - 在目标服务器创建专用账号，赋予最小权限
   - 禁止此账号使用密码登录，仅允许IP白名单（但矛盾点，需平衡）

2. **密码轮换机制**：

   - 定期（建议每周）更新脚本中的密码
   - 使用密钥托管系统（如HashiCorp Vault）

3. **加密密码存储**：

   bash

   ```
   # 使用openssl加密密码文件
   echo "password" | openssl enc -aes-256-cbc -pbkdf2 -out secret.dat
   
   # 脚本中解密使用
   REMOTE_PASSWORD=$(openssl enc -d -aes-256-cbc -pbkdf2 -in secret.dat)
   ```

4. **日志脱敏**：

   bash

   ```
   # 在脚本开头禁用命令回显
   set +x
   ```

5. **网络层保护**：

   - 使用VPN或私有网络连接
   - 限制目标服务器的SSH访问来源IP

### Azkaban项目最终结构

text

```
your_project/
├── lib/                       （可选：存放加密/解密工具）
├── jobs/
│   ├── remote_job.job
│   └── scripts/
│       ├── remote_executor.sh （主执行脚本）
│       └── remote_script.sh   （假如此脚本要同步到远程）
└── encrypt_secret.dat         （加密的凭证）
```

> 注意：Azkaban执行时会解压ZIP包，所有脚本路径需相对路径引用

通过以上方法，在满足必须使用密码的前提下尽量提升了安全性。但长期建议向SSH密钥方式迁移。

# Azkaban 远程调度脚本使用账户密码方案（非免密登录）

当无法使用SSH免密登录时，可以通过以下安全可靠的方法在Azkaban中实现远程脚本调度：

## 完整解决方案 - 使用sshpass工具

### 1. 安装sshpass工具（在Azkaban Executor服务器）

bash

```
# Ubuntu/Debian
sudo apt-get install sshpass

# CentOS/RHEL
sudo yum install sshpass
```

### 2. 创建安全脚本目录结构

text

```
azkaban_remote_project/
├── config/
│   └── credentials.cfg
├── scripts/
│   └── execute_remote.sh
└── remote_tasks/
    ├── remote_task.job
    └── remote_script.sh
```

### 3. 创建凭证配置文件（安全存储密码）

`config/credentials.cfg` - **权限设置：600**

properties

```
# 远程服务器凭证配置
REMOTE_HOST=your.server.ip
REMOTE_PORT=22
REMOTE_USER=username
REMOTE_PASSWORD=yourpassword123
REMOTE_SCRIPT_PATH=/path/to/your/script.sh
```

### 4. 创建远程执行脚本

```
scripts/execute_remote.sh
```

bash

```
#!/bin/bash
# 加载凭证配置
source $(dirname "$0")/../config/credentials.cfg

# 安全传递参数（仅调试模式下显示）
if [[ "$AZKABAN_DEBUG" == "true" ]]; then
  echo "[DEBUG] Connecting to $REMOTE_USER@$REMOTE_HOST:$REMOTE_PORT"
else
  set +x  # 禁用命令回显
fi

# 使用sshpass执行远程命令
sshpass -p "$REMOTE_PASSWORD" ssh -p $REMOTE_PORT -o StrictHostKeyChecking=no $REMOTE_USER@$REMOTE_HOST "bash $REMOTE_SCRIPT_PATH"

# 检查执行状态
EXIT_CODE=$?
if [ $EXIT_CODE -ne 0 ]; then
  echo "远程脚本执行失败! 退出码: $EXIT_CODE" >&2
  exit $EXIT_CODE
fi
```

**重要设置：**

- 脚本权限：`chmod 700 scripts/execute_remote.sh`
- 避免密码在日志中泄露：禁用命令回显

### 5. 创建Azkaban任务文件

```
remote_tasks/remote_task.job
```

properties

```
type=command
command=sh ${azkaban.flow.working.dir}/scripts/execute_remote.sh
```

### 6. 打包部署到Azkaban

bash

```
cd azkaban_remote_project
zip -r remote_workflow.zip ./*
```

将ZIP文件上传到Azkaban工作流

## 备选方案 - 使用Python Paramiko库

如果无法安装sshpass，可以使用Python实现：

### 1. 创建Python执行脚本

```
scripts/execute_remote.py
```

python

```
import paramiko
import sys
import os

# 从环境变量获取凭证
host = os.getenv('REMOTE_HOST')
port = int(os.getenv('REMOTE_PORT', 22))
username = os.getenv('REMOTE_USER')
password = os.getenv('REMOTE_PASSWORD')
script_path = os.getenv('REMOTE_SCRIPT_PATH')

# 安全函数执行远程命令
def execute_remote_command():
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    
    try:
        client.connect(hostname=host, port=port, 
                      username=username, password=password,
                      timeout=15)
        
        stdin, stdout, stderr = client.exec_command(f"bash {script_path}")
        
        # 实时读取输出（不会暴露密码）
        while not stdout.channel.exit_status_ready():
            if stdout.channel.recv_ready():
                print(stdout.channel.recv(1024).decode(), end='')
                
        exit_code = stdout.channel.recv_exit_status()
        return exit_code
        
    except Exception as e:
        print(f"SSH连接错误: {str(e)}", file=sys.stderr)
        return 255
    finally:
        client.close()

if __name__ == "__main__":
    exit_code = execute_remote_command()
    sys.exit(exit_code)
```

### 2. 修改Azkaban任务文件

```
remote_tasks/remote_task.job
```

properties

```
type=command
command=python ${azkaban.flow.working.dir}/scripts/execute_remote.py

# 通过Azkaban传递环境变量
env.REMOTE_HOST=your.server.ip
env.REMOTE_PORT=22
env.REMOTE_USER=username
env.REMOTE_PASSWORD=yourpassword123
env.REMOTE_SCRIPT_PATH=/path/to/your/script.sh
```

## 安全增强措施

### 1. 凭证加密存储

bash

```
# 加密凭证文件
openssl enc -aes-256-cbc -salt -in credentials.cfg -out credentials.enc -pass pass:YourSecretKey

# 修改执行脚本中的加载方式
sshpass -p "$(openssl enc -d -aes-256-cbc -in ${azkaban.flow.working.dir}/config/credentials.enc -pass pass:YourSecretKey | grep REMOTE_PASSWORD | cut -d= -f2)" ssh ...
```

### 2. 网络层安全防护

- 限制源IP访问（在远程服务器配置）

  bash

  ```
  # /etc/ssh/sshd_config
  AllowUsers username@azkaban_ip
  AllowTcpForwarding no
  PermitRootLogin no
  ```

- 更改SSH端口

  bash

  ```
  Port 22222
  ```

### 3. 在远程服务器上配置只读脚本权限

bash

```
sudo mkdir -p /opt/azkaban_scripts
sudo nano /opt/azkaban_scripts/deploy.sh
sudo chown root:root /opt/azkaban_scripts/deploy.sh
sudo chmod 755 /opt/azkaban_scripts/deploy.sh  # 只读执行权限
```

## 完整工作流程图

mermaid

```
graph TD
    A[Azkaban 启动任务] --> B[加载环境变量/配置]
    B --> C{使用密码登录？}
    C -->|是| D[通过sshpass执行命令]
    C -->|否| E[尝试Python方案]
    D --> F[执行远程脚本]
    E --> F
    F --> G[捕获执行状态]
    G -->|成功| H[记录日志]
    G -->|失败| I[发送告警]
    H --> J[结束任务]
    I --> J
```

## 最佳实践建议

1. **最小权限原则**：

   - 创建专用远程账号并限制权限：

     bash

     ```
     sudo useradd -r -s /bin/bash azkaban_agent
     sudo passwd azkaban_agent  # 设置密码
     sudo visudo
     # 添加：azkaban_agent ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart app.service
     ```

2. **密码定期轮换**：

   - 创建脚本自动更新密码：

     bash

     ```
     # 生成随机密码
     NEW_PASS=$(openssl rand -base64 16)
     
     # 更新远程服务器密码
     sshpass -p "$OLD_PASS" ssh azkaban_agent@server "echo -e '$NEW_PASS\n$NEW_PASS' | sudo passwd azkaban_agent"
     
     # 更新配置
     sed -i "s/REMOTE_PASSWORD=.*/REMOTE_PASSWORD=$NEW_PASS/" credentials.cfg
     ```

3. **安全审计**：

   - 记录所有远程执行操作：

     bash

     ```
     # 在远程脚本开头添加
     echo "$(date) - Executed by Azkaban user ${REMOTE_USER}" >> /var/log/azkaban_audit.log
     ```

4. **超时控制**：

   - 设置SSH超时参数：

     bash

     ```
     sshpass -p "$password" ssh -o ConnectTimeout=15 -o ServerAliveInterval=60 ...
     ```

5. **敏感信息遮蔽**：

   python

   ```
   # 在Python脚本中安全打印日志
   safe_log = command.replace(password, '*******')
   print(f"Executing: {safe_log}")
   ```

通过这些方法，可以在不使用SSH免密登录的情况下，安全可靠地实现Azkaban的远程脚本调度功能。