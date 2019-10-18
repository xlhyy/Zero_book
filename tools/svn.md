# SVN


## 常用命令

```
在建立项目版本库时，可首先建好项目文件夹，并在其中建立trunk, branches, tags三个空的子目录:
    trunk是主分支，是日常开发进行的地方。
    branches是分支。一些阶段性的release版本，这些版本是可以继续进行开发和维护的，则放在branches目录中。又比如为不同用户客制化的版本，也可以放在分支中进行开发。
    tags目录一般是只读的，这里存储阶段性的发布版本，只是作为一个里程碑的版本进行存档。
```

```
1. 从本地导入文件到服务器(第一次初始化导入)
    svn import /Users/kaiqigu/svn/test_dir svn://localhost/mycode/test_dir -m "初始化导入"

2. 检出
    svn checkout svn://localhost/mycode .
    svn checkout/co http://路径(目录或文件的全路径) --username 用户名 --password 密码
  
3. 导出一个干净的不带.svn文件夹的目录树
    svn export -r 1 svn://localhost/mycode
    svn export [-r 版本号] http://路径(目录或文件的全路径) --username 用户名

4. 代码库URL变更
    svn switch (sw)     # 更新工作副本至不同的URL
```


```
5. 查看文件详细信息
    svn info 文件名

6. 查看文件或者目录状态
    svn status/st 文件名
    参数:
        ?: 不在svn的控制中
        M: 内容被修改
        C: 发生冲突
        A: 预定加入到版本库
        K: 被锁定

7. 添加新文件
    svn add 文件名

8. 添加新目录
    svn mkdir newdir 
    或
    svn mkdir -m "文本信息" svn://目录路径

9. 删除文件
    svn delete 文件

10. 删除文件夹
    svn rm 文件夹
    
11. 比较差异
    svn diff 文件名
    svn diff -r 修正版本号m:修正版本号n 文件名
```


```
12. 更新文件
    svn update
    svn update 文件名
    svn update -r 修正版本 文件名

13. 提交
    svn commit/ci -m "提交备注信息文本" [--no-unclock] 文件名
    注释: 保持锁就用–no-unlock
```


```
14. 查看svn版本
    svn --version

15. svn帮助
    svn help        # 全部功能选项
    svn help ci     # 具体功能的说明

16. 查看日志
    svn log 文件名

17. 恢复本地修改
    svn revert 文件名
```


```
18. 不checkout而查看输出特定文件或url的内容
    svn cat svn://文件路径 或 文件路径

19. 查看版本库下的文件和目录列表
    svn list/ls [svn://路径(目录或文件的全路径)]
```

### 未实现

```
20. 加锁/解锁
    svn lock -m "加锁备注信息文本" [--force] 文件名
    svn unlock 文件名

21. 新建分支branchs，在分支上继续开发
    svn mkdir branches 
    svn copy svn://server/trunk svn://server/branches/ep -m “init ep”

22. 该版本完成，打tag，发布版本
    svn mkdir tags 
    svn copy svn://server/trunk svn://server/tags/release-1.0 -m “1.0 released”

23. 合并内容到分支
    svn merge branchA branchB

24. 解决冲突
    svn resolved        # 移除冲突的相关文件，然后让path可以再次提交
```


## 启动svn服务(mac)

```
windows: 一般使用TortoiseSVN来搭建svn环境。
mac: 自带svn的服务器端和客户端功能。
```

### 创建一个mycode仓库

```
svnadmin create /Users/kaiqigu/svn/mycode
```

### 配置svn的用户权限

```
主要是修改/svn/mycode/conf目录下的三个文件

(1) 打开svnserve.conf，将下列配置项前面的#和空格都去掉
# anon-access = read
# auth-access = write
# password-db = passwd
# authz-db = authz
注意: anon-access = read代表匿名访问的时候是只读的，若改为anon-access = none代表禁止匿名访问，需要帐号密码才能访问


(2) 打开passwd，在[users]下面添加帐号和密码，比如:
[users]
ly = 123
帐号是ly，密码是123


(3) 打开authz，配置用户组和权限
我们可以将在passwd里添加的用户分配到不同的用户组里，以后的话，就可以对不同用户组设置不同的权限，没有必要对每个用户进行单独设置权限。
在[groups]下面添加组名和用户名，多个用户之间用逗号(,)隔开

[groups]
topgroup = ly,hh

说明ly和hh都是属于topgroup这个组的，接下来再进行权限配置。
使用[/]代表svn服务器中的所有资源库

[/]
@topgroup = rw

上面的配置说明topgroup这个组中的所有用户对所有资源库都有读写(rw)权限，组名前面要用@
如果是用户名，不用加@，比如ly这个用户有读写权限

[/]
ly = rw

至于其他精细的权限控制，可以参考authz文件中的其他内容
```

### 启动svn服务器

```
在终端输入下列指令：svnserve -d -r /Users/kaiqigu/svn
或者输入：svnserve -d -r /Users/kaiqigu/svn/mycode
没有任何提示就说明启动成功了
```


