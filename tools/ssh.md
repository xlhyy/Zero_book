### ssh

```
最基本用法: ssh命令用于远程登录上linux主机。
常用格式: ssh [-l login_name] [-p port] [user@]hostname

1) 不指定用户，默认使用root账号登录：
ssh 192.168.0.11

2) 指定用户：
ssh -l root 192.168.0.11
ssh root@192.168.0.11

3) 如果修改过ssh登录端口的可以：
ssh -p 12333 192.168.0.11
ssh -l root -p 12333 192.168.0.11
ssh -p 12333 root@192.168.0.11

例：
ssh admin@$host /usr/local/bin/supervisorctl -u user -p 123 $cmd all
```
