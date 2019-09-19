# 变量


## 创建变量

```
变量名=变量值
```


## 引用变量

```
${变量名}
有时{}可以省略

kaiqigu@bogon:~/test|⇒  t=pig  
kaiqigu@bogon:~/test|⇒  echo ${t}
pig
kaiqigu@bogon:~/test|⇒  echo ${t}s
pigs
```


## 撤销变量/函数名

```
unset 变量名

kaiqigu@bogon:~/test|⇒  echo ${t} 
pig
kaiqigu@bogon:~/test|⇒  unset t
kaiqigu@bogon:~/test|⇒  echo ${t}


unset -f 函数名
```


## 本地变量(局部变量)

```
local 变量名=变量值
```


## 环境变量

```
export 变量名=变量值

或

变量名=变量值
export 变量名
```


## 只读变量

```
可以理解为是一个只读常量。

readonly 变量名=变量值

只读变量不可unset，想要只读变量失效需要退出当前shell。

环境只读变量: export readonly 变量名=变量值
```


## 特殊变量

```
$#    获取参数个数
$@    获取所有参数
$*    获取所有参数
$$    执行的进程ID
$?    查看命令执行或函数的返回值
${0}  文件名
${1}  第一个参数
${2}
${3}

kaiqigu@bogon:~/test|⇒  cat argv.sh 
#!/bin/bash
echo "0arg is" ${0}
echo "1arg is" ${1}
echo "arg num is" $#
echo "args are" $*
echo "args are" $@

kaiqigu@bogon:~/test|⇒  sh argv.sh a b c d
0arg is argv.sh
1arg is a
arg num is 4
args are a b c d
args are a b c d
```

### $?

```
(1)可以查看命令执行的返回值
kaiqigu@bogon:~/Desktop|⇒  cd
kaiqigu@bogon:~|⇒  echo $?
0
kaiqigu@bogon:~|⇒  cd asdasd
cd: no such file or directory: asdasd
kaiqigu@bogon:~|⇒  echo $?
1

此时0为命令执行成功，非0为命令执行失败。
```

```
(2)可以查看函数的返回值
#!/bin/bash

hello()
{
	echo "hello fun"
	return 1
}

hello
# $?可用于获取前一个函数的返回值，这里结果是1
echo $?
```
