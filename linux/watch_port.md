# 查看端口占用情况


```
1)查看系统当前所有被占用端口:
netstat -tln

2)查看8000端口占用情况:
sudo lsof -i:端口号

3)杀死进程:
kill -9 进程号
```