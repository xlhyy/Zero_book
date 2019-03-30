# git


### 1. git clone报错
```
使用git clone操作时，报错Permissions 0644 for ‘/root/.ssh/id_rsa’ are too open:
如果出现 Permissions 0644 for ‘/root/.ssh/id_rsa’ are too open. 等错误显示了，原来只要把权限降到0600就ok了
输入命令
chmod 0600 /root/.ssh/id_rsa
然后就可以密钥登陆了。
```


### 2. 添加验证key密码
```
执行ssh-add时出现Could not open a connection to your authentication agent
解决方法:
先执行  eval `ssh-agent`(是～键上的那个`),再执行 ssh-add ~/.ssh/rsa成功。
ssh-add -l 就有新加的rsa了。
```


### 3. tag相关
```
查看tag:
git tag
git tag -l "t3*"
推tag:
git push --tags
git push origin test_tag
打tag:
git tag xxxx
删除tag:
git tag -d test_tag  //本地删除tag
```
