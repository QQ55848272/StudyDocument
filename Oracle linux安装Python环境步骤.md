# Linux 安装Python环境 

##  步骤一：安装编译依赖

**centos 安装编译依赖（使用 yum）**

```bash
sudo yum groupinstall -y "Development Tools"
sudo yum install -y gcc make wget openssl-devel bzip2-devel \
libffi-devel zlib-devel readline-devel sqlite-devel \
xz-devel tk-devel gdbm-devel uuid-devel libuuid-devel \
libnsl2-devel ncurses-devel libdb-devel
```

  **Ubuntu安装编译依赖   （使用 apt）**

```bash
sudo apt update
sudo apt install -y \
  wget build-essential \
  zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev \
  libssl-dev libreadline-dev libffi-dev libsqlite3-dev \
  libbz2-dev liblzma-dev uuid-dev libgdbm-compat-dev \
  libdb-dev tk-dev
```



------

##  步骤二：下载并解压 Python 3.12 源码

```bash
cd /usr/local/src
sudo wget https://www.python.org/ftp/python/3.12.0/Python-3.12.0.tgz
sudo tar -xzf Python-3.12.0.tgz
cd Python-3.12.0
```

------

##  步骤三：配置并编译安装

```bash
sudo ./configure --enable-optimizations --prefix=/usr/local/python3.12
sudo make -j$(nproc) 

(make：编译命令，按照 Makefile 的规则构建项目（此处是编译 Python）。

-j$(nproc)：指定使用多少个“并发任务”编译。

-j：make 的参数，表示允许并行执行多个编译任务（默认是单线程）。

$(nproc)：这是一个 shell 命令，表示“获取当前系统的 CPU 核心数量”。)

sudo make install   
```

这将 Python 3.12 安装到 `/usr/local/python3.12`，**不会影响系统自带 Python**。



## 步骤四：添加软链接（不影响系统 Python）

```bash
sudo ln -sf /usr/local/python3.12/bin/python3.12 /usr/bin/python3.12
sudo ln -sf /usr/local/python3.12/bin/pip3.12 /usr/bin/pip3.12
```

验证：

```bash
python3.12 --version
pip3.12 --version
```

------

## （可选）创建虚拟环境

```bash
python3.12 -m venv ~/py312env
source ~/py312env/bin/activate
```

------

##  （可选）清理安装文件

```bash
sudo rm -rf /usr/local/src/Python-3.12.0*
```







# 如果安装失败

### 1. 清理并重新配置编译

进入源码目录，执行：

```bash
sudo make clean
sudo make distclean
```

重新配置：

```bash

sudo ./configure --enable-optimizations --prefix=/usr/local/python3.12
```

------

###  2. 确保安装所有依赖（用 yum 安装）

再次确认你的依赖是齐全的（哪怕之前已装过，再运行也没事）：

```bash
sudo yum groupinstall -y "Development Tools"
sudo yum install -y gcc make wget openssl-devel bzip2-devel \
libffi-devel zlib-devel readline-devel sqlite-devel \
xz-devel tk-devel gdbm-devel uuid-devel libuuid-devel \
libnsl2-devel ncurses-devel libdb-devel
```

------

###  3. 删除残留安装（如果有）

如果之前执行过 `make install`，清理下：

```bash
sudo rm -rf /usr/local/python3.12
sudo rm -f /usr/bin/python3.12
sudo rm -f /usr/bin/pip3.12
```

------

###  4. 重新编译并安装

```bash
sudo make -j$(nproc)
sudo make install
```