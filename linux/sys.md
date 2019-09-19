# 系统相关


-  查看系统位数:(linux及mac)

```
kaiqigu@bogon:~|⇒  getconf LONG_BIT
64
ubuntu@VM-0-16-ubuntu:~/ying.li/t_练习|
⇒  getconf LONG_BIT
32
```


- 查看linux版本信息

```
ubuntu@VM-0-16-ubuntu:~/ying.li/t_练习|
⇒  lsb_release -a
No LSB modules are available.
Distributor ID:  Ubuntu
Description:  Ubuntu 16.04.1 LTS
Release:  16.04
Codename:  xenial
```


- 查看系统是多少位的

```
=> getconf LONG_BIT
64
```


- 查看系统版本信息

```
=> lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 17.10
Release:        17.10
Codename:	artful
```


- 查看内核版本

```
⇒  uname -r
4.13.0-46-generic
```
