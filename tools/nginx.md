# nginx


### 1. nginx配置不生效
```
1)nginx配置不生效，页面一直是默认页面welcome to nginx:
将nginx.conf文件里
# include /etc/nginx/conf.d/*.conf;
# include /etc/nginx/sites-enabled/*;
这两行注释掉。
```


### 2. nginx命令
```
常用命令:
ps -ef | grep 进程名		查看指定进程

service nginx start		开启服务
service nginx status		状态
service nginx stop		停止服务

sudo nginx -s stop		快速关机
sudo nginx -s quit		优雅关机
sudo nginx -s reload		重新加载配置文件
sudo nginx -s reopen		重新打开日志文件

sudo nginx -t			检查配置(同时输出配置文件所在位置)
sudo nginx -c 文件名		使用指定的配置文件而不是conf目录下的nginx.conf

注:
nginx -t
nginx -s reload

若出现错误:
nginx:[error] open() "/run/nginx.pid" failed (2: No such file or directory)
解决方法:
nginx -c /etc/nginx/nginx.conf
nginx -s reload
```

