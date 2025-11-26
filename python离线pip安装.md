# python离线pip安装

### **下载 Python 源代码**

1. 访问 Python 官方网站下载页面：
   https://www.python.org/downloads/source/

2. 下载 Python 3.10.10 的源代码：

   

   ```shell
   wget https://www.python.org/ftp/python/3.10.10/Python-3.10.10.tgz
   ```

3. 解压源代码：

   ```shell
   tar -xzf Python-3.10.10.tgz
   ```

4. 进入源代码目录：

   

   ```shell
   cd Python-3.10.10
   ```

------

### 2. **安装 `zlib` 开发库**

在重新编译 Python 之前，确保系统中已安装 `zlib` 的开发库。

- **Debian/Ubuntu 系统**：

  ```shell
  sudo apt update
  sudo apt install zlib1g-dev
  ```

- **CentOS/RHEL 系统**：

  ```shell
  sudo yum install zlib-devel
  ```

- **Alpine Linux 系统**：

  ```shell
  apk add zlib-dev
  ```

------

### 3. **重新编译 Python**

在 Python 源代码目录中，运行以下命令重新编译 Python：

1. 配置编译选项：

   ```shell
   ./configure --enable-optimizations --with-zlib
   ```

2. 编译 Python：

   ```shell
   make
   ```

3. 安装 Python：

   ```shell
   sudo make install
   ```

------

### 4. **验证 `zlib` 是否可用**

重新编译后，检查 `zlib` 模块是否已正确安装：

```shell
python3 -c "import zlib; print(zlib.__version__)"
```

如果输出版本号，说明 `zlib` 已成功安装。

------

### 5. **重新安装 `pip`**

确保 `zlib` 可用后，重新运行 `get-pip.py`：

```shell
python3 get-pip.py
```

------

### 6. **验证 `pip` 是否安装成功**

运行以下命令检查 `pip` 是否安装成功：

```shell
python3 -m pip --version
```

------

### 7. **清理临时文件（可选）**

如果一切正常，可以删除 Python 源代码目录以释放空间：

```shell
cd ..
rm -rf Python-3.10.10 Python-3.10.10.tgz
```

------

### 总结

- 由于找不到 Python 的源代码目录，需要重新下载 Python 源代码。
- 安装 `zlib` 开发库并重新编译 Python，以解决 `zlib not available` 的问题。
- 重新安装 `pip` 并验证其是否正常工作。