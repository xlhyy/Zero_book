# supervisor


- 命令

```
sudo service supervisor start 		启动supervisor服务(-c 按照指定配置文件启动)
sudo service supervisor stop		停止supervisor服务

(注: 可通过supervisorctl进入交互模式(客户端)，或直接在命令行进行操作。)
supervisorctl start program_name	启动指定进程
supervisorctl start all
supervisorctl restart program_name
supervisorctl stop program_name		停止指定进程
supervisorctl stop all
supervisorctl reload			载入最新的配置文件
supervisorctl update			重启配置文件修改过的程序
supervisorctl status			查看状态
supervisorctl help			查看帮助
supervisorctl tail -f program_name	查看该进程的日志
```


- 常见问题处理

```
1.
unix:///tmp/supervisor.sock refused connection
supervisord -c /etc/supervisord.conf 

2.
Unlinking stale socket /tmp/supervisor.sock
unlink /tmp/supervisor.sock

3.
⇒  supervisorctl 
Server requires authentication
Username:user
Password:

test_process:00                  FATAL     unknown error making dispatchers for '00': EACCES
supervisor> 

解决方案:
    supervisord启动test_process:00失败。原因，权限问题， 曾一次执行supervisord时加了sudo，结果gunicorn的生成日志所有者变为root， 导致后边普通用户执行不了。删除该日志，并且删除/tmp下的sock文件，重启之。
```
