## 利用python搭建一个局域网文件共享服务器(支持上传和下载)

```
https://www.jianshu.com/p/c17347a07666
```

### 下载功能

```
进入目录

Python2.x的使用
python -m SimpleHTTPServer 8888

Python3.x使用
python -m http.server 8888
```


## nginx设置目录权限

```
https://blog.csdn.net/professorphp/article/details/81699916
```

### 设置密码

```
sudo vi /etc/nginx/htpasswd.user
sudo chmod 777 htpasswd.user
sudo apt install apache2-utils
htpasswd -bc htpasswd.user admin 123
```
