# nginx


## nginx配置不生效

```
1)nginx配置不生效，页面一直是默认页面welcome to nginx:
将nginx.conf文件里
# include /etc/nginx/conf.d/*.conf;
# include /etc/nginx/sites-enabled/*;
这两行注释掉。
```


## nginx命令

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


## nginx配置访问路径

```
proxy_pass 代理转发，不过要注意的是url后面时候有跟/这个，如果有的话就是绝对的根目录，没有的话就是相对路径，并把匹配到的带上。
```

### 实例

```
比如访问：http://127.0.0.1/proxy/test.html
```

```
第一种情况：
　　location /proxy/{
　　　　proxy_pass http://www.baidu.com/;
　　}
结果：http://www.baidu.com/test.html


第二种情况：
　　location /proxy/{
　　　　proxy_pass http://www.baidu.com; #这次不带 /
　　}
结果：http://www.baidu.com/proxy/test.html


第三种情况：
　　location /proxy/{
　　　　proxy_pass http://www.baidu.com/seowen/;
　　}
结果：http://www.baidu.com/seowen/test.html


第四种情况：
　　location /proxy/{
　　　　proxy_pass http://www.baidu.com/seowen; #这次不带 /
　　}
结果： http://www.baidu.com/seowentest.html
```


## nginx配置访问密码

```
⇒  htpasswd -c /usr/local/etc/nginx/.htpassed test_admin
New password: 
Re-type new password: 
Adding password for user test_admin

添加如下认证配置(示例):
location /test/ {
        auth_basic "suibian";
        auth_basic_user_file /usr/local/etc/nginx/.htpassed;
        proxy_pass https://www.baidu.com/;
}
```


## 错误解决

### [alert] kill(189, 1) failed (3: No such process)

```
[root@localhost/]# nginx -s reload
nginx: [alert] kill(189, 1) failed (3: No such process)  杀死189进程，可是并没有
[root@localhost /]# whereis ngnix
ngnix:[root@localhost/]# 
[root@localhost /]# find / -name nginx 
/usr/local/src/nginx/sbin/nginx
[root@localhost /]# find / -name nginx.conf
/usr/local/src/nginx/conf/nginx.conf
[root@localhost /]# /usr/local/src/nginx/sbin/nginx -c /usr/local/src/nginx/conf/nginx.conf
[root@localhost/]# nginx -s reload               
```

### open() “/usr/local/nginx/html/favicon.ico” failed (2: No such file or directory)

```
只需要关闭 favicon.ico 的 log:

    location  /favicon.ico {
        log_not_found off;
        access_log off;
    } 
```
