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
nginx -t
nginx -s reload

若出现错误:
nginx:[error] open() "/run/nginx.pid" failed (2: No such file or directory)
解决方法:
nginx -c /etc/nginx/nginx.conf
nginx -s reload
```
