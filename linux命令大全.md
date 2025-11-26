# linux命令大全

#### 1.查找某个进程的父进程

当进程kill不了，可能是父进程导致的

```bash
pstree -p | grep 391628
```

