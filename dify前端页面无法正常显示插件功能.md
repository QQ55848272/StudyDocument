```bash

```

1.在etc目录下创建pip.conf文件

2.在文件中写入

```conf
[global]
index-url = http://lzyum.luxsan-ict.com:8200/repository/lzpypi/simple
trusted-host = lzyum.luxsan-ict.com
```

3.保存并测试是否生效：pip install -r requirements.txt

