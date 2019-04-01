# crontab


- /etc/crontab与crontab -e命令区别

```
1)
crontab -e是某个用户的周期计划任务(配置文件: /var/spool/cron/crontabs/kaiqigu)
/etc/crontab是系统的周期任务(配置文件: /etc/crontab)

2) 不管用crontab -e还是/etc/crontab都不需要重新启动crond服务

3) 区别:
格式不同:
crontab -e:	minute hour day month week command
/etc/crontab:	m h dom mon dow user command
适用范围不同:
/etc/crontab这种方法只有root用户能用
crontab -e这种方法所有用户都可以使用
```


- crontab系统周期任务

```
service cron start	//启动服务
service cron stop	//关闭服务
service cron restart	//重启服务
service cron reload	//重新载入配置
service cron status	//查看状态
```


- crontab用户周期任务

```
crontab -l	//查看当前用户的定时任务
crontab -e	//编辑当前用户的定时任务
crontab -r	//删除当前用户的所有定时任务
```
