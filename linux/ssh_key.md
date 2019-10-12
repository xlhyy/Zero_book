# 密钥


- 生成密钥

```
ssh-keygen -t rsa
```


- 生成文件(私钥和公钥)

```
cat /home/kaiqigu/.ssh/id_rsa
cat /home/kaiqigu/.ssh/id_rsa.pub
```


- 将公钥交给远程服务器，实现免密登陆

```
ssh-copy-id -i ~/.ssh/id_rsa.pub admin@192.168.1.44
```


- 各用户公钥在远程服务器的位置

```
用户会把别人的公钥放在家目录的.ssh目录下的authorized_keys或known_hosts文件中。
```
