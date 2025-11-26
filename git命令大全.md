# git命令大全

### 1.确认当前远程仓库地址

```bash
git remote -v
```



### 2.想替换远程地址

第一步：先删除原来的远程地址：

```bash
git remote remove origin
```

第二歩：然后重新添加新的远程地址：

```bash
git remote add origin http://lzgit.luxsan-ict.com/liukun/metaapp.git
```



###  3.git add 

**意思：** 把当前目录下所有文件都“准备好”，提交到 Git 的暂存区。

 类比：就像你往快递箱里放东西，准备寄出。

------

### 4.git commit -m "initial commit"

**意思：** 把刚刚 `add` 的所有文件作为一次“快照”提交到 Git 本地仓库，并加一个备注（这里是 `"initial commit"`）。

📸 类比：你给打包好的快递拍了张照片，备注说：“第一次寄出”。

------

### 5. git branch -M main

**意思：** 把当前分支命名为 `main`。有些老项目默认叫 `master`，但现在一般统一用 `main`。

📛 类比：你给当前的快递路线贴了个标签：“主分支 main”。

------

### 6.git push -u origin main

**意思：** 把你刚刚的代码和提交记录上传到 GitLab 的远程仓库（也叫 origin），并且以后默认推送到 `main` 分支。

📤 类比：你把快递真正寄出去了，而且以后会自动寄到这个地址 unless 你改。