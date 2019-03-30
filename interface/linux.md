# linux相关


### 1. 端口
```
1)查看系统当前所有被占用端口:
netstat -tln

2)查看8000端口占用情况:
sudo lsof -i:端口号

3)杀死进程:
kill -9 进程号
```


### 2. 软链接
```
创建软连接:
ln -s 目标地址 软链接地址(例:/usr/bin/tools)

删除软连接:
rm -rf 软链接地址

修改软连接:
ln -snf 新目标地址 软链接地址
```


### 3. python包相关
```
查看包版本:
pip freeze | grep tornado
卸载包:
pip uninstall tornado
指定包版本安装:
pip install tornado==4.0.2
```


### 4. 解压缩
- 若文件是以 .tar.gz 结尾，则用 tar -xvf 进行解压缩。
- 若文件是以 .gz 结尾，则用 gzip -d 进行解压缩。
```
linux下.tar.gz/.gz/.zip解压
1)
tar zxvf test.tar.gz
tar xzvf test.tar.gz -C testdir/
2)
gzip -b test.gz
zcat test.gz > test
3)
unzip test.zip
```


### 5. pycharm快捷键
```
1) linux下pycharm快捷键：
ctrl+shift+n	按文件名查找
ctrl+shift+f	全局搜索
ctrl+f		文件内搜索

2) mac下pycharm快捷键：
command+n	按文件名查找
ctrl+shift+f	全局搜索
command+f	文件内搜索
```


### 6. 系统版本相关
```
1) 查看系统位数:(linux及mac)
kaiqigu@bogon:~|⇒  getconf LONG_BIT
64
ubuntu@VM-0-16-ubuntu:~/ying.li/t_练习|
⇒  getconf LONG_BIT
32

2) 查看linux版本信息:
ubuntu@VM-0-16-ubuntu:~/ying.li/t_练习|
⇒  lsb_release -a
No LSB modules are available.
Distributor ID:  Ubuntu
Description:  Ubuntu 16.04.1 LTS
Release:  16.04
Codename:  xenial

3) 查看系统是多少位的:
=> getconf LONG_BIT
64

4) 查看系统版本信息:
=> lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 17.10
Release:        17.10
Codename:	artful
```


### 7. sftp命令
```
1) sftp user@ip
2) help
3) pwd/lpwd
4) ls/lls
5) put xxx [xxx]/put -r xxx [xxx]
6) get xxx [xxx]/get -r xxx [xxx]
7) !command
8) exit/quit/bye
```
