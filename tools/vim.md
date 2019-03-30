# vim


### 1. vim下查找
```
vim下查找含有red和blue的行:
red.*blue\|blue.*red
```


### 2. vim编辑错误
```
在vi/vim中输入方向键却被被转化为A B C D
echo "set nocp" >> ~/.vimrc
source ~/.vimrc
```
