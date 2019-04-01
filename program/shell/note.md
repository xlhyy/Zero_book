# 常用知识点

- hello world

```
#!/bin/bash
# 第一个shell小程序
echo hello world!
```

- 变量

```
#!/bin/bash
# 使用环境变量
echo $PATH
# 自定义变量hello
hello="hello world"
echo $hello
```

- 执行命令的三种方式

```
#!/bin/bash
date
path=$(pwd)
files=`ls -al`
echo "current path: $path"
echo "files: $files"
```

- =与-eq

```
#!/bin/bash

# =用于比较字符串 =和-eq用于比较整数

echo 'hello shell'

# 读入变量
read VAR
echo "VAR is $VAR"

# 计算变量(注意这种写法$[表达式]:用于计算)
echo $[$VAR-5]

# 测试字符串
if test 'hello' = 'helloworld'
then
	echo '字符串相等！'
else
	echo '字符串不相等！'
fi

# 测试整数
if test $VAR = 10
then
	echo '两个数相等！'
else
	echo '两个数不相等！'
fi

# 测试目录
new_dir=./new_dir
if test -d ./new_dir
then
	echo "$new_dir是一个目录"
else
	echo "$new_dir不是个目录"
fi

# 退出
exit
```

- 用户自定义变量

```
#!/bin/bash

# 定义普通变量
CITY='SHENYANG'

# 定义全局变量
export NAME='cdeveloper'

# 定义只读变量
readonly AGE=21

# 打印变量的值
echo $CITY
echo $NAME
echo $AGE

# 删除CITY变量
unset CITY
# 不会输出SHENYANG
echo $CITY
```

- 命令行参数相关

```
#!/bin/bash

# $0: 脚本文件名
# $1-9: 第1-9个命令行参数名
# $#: 命令行参数个数
# $@: 所有命令行参数
# $*: 所有命令行参数
# $$: 执行的进程ID
# $?: 前一个命令的退出状态，可用于获取函数返回值

echo "print $"
echo "\$0=$0"
echo "\$1=$1"
echo "\$2=$2"
echo "\$#=$#"
echo "\$@=$@"
echo "\$*=$*"
echo "\$$=$$"
echo "\$?=$?"
```

- 环境变量

```
#!/bin/bash

# HOME:用户主目录
# PATH:系统环境变量PATH
# TERM:当前终端
# UID:当前用户ID
# PWD:当前工作目录，绝对路径

echo "print env"
echo $HOME
echo $PATH 
echo $TERM
echo $PWD
echo $UID
```

- 获取变量的两种形式

```
#!/bin/bash

# 获取变量的两种形式:
# 	echo "$name"
# 	echo ${name}

m=1
m=$[$m+1]
echo "$m"
echo ${m}

# 注意:+ 号左右不要加空格
let m=$m+1
echo $m

m=$(($m+1))
echo $m

# 注意:此处+号左右必须有空格
m=`expr $m + 1`
echo $m
```

- if

```
#!/bin/bash

read VAR

# 下面这两种判断方法都可以，使用[]注意左右加空格
#if test "$VAR" -eq 10
if [ "$VAR" -eq 10 ]
then
	echo 'true'
else
	echo 'false'
fi
```

- case

```
#!/bin/bash

read NAME
# 格式有点复杂，一定要注意
case "$NAME" in
	1)
		echo 'Ubuntu'
		;;
	2)
		echo 'Red Hat'
		;;
	*)
		echo 'Other'
		;;
esac
```

- for

```
#!/bin/bash

# 普通for循环
# 此处可以有空格，也可以没有空格
#for ((i = 1; i <= 3; i++))
for((i=1;i<=3;i++))
do
	echo $i
done

# VAR依次代表每个元素
for VAR in 1 2 3
do
	echo $VAR
done
```

- while

```
#!/bin/bash

VAR=1

# 如果VAR小于10，就打印出来
# 注意:此处必须有空格
# -eq 等于
# -ne 不等于
# -gt 大于
# -lt 小于
# -ge 大于等于
# -le 小于等于

while [ $VAR -lt 10 ]
do
	echo $VAR
	# VAR自增1
	VAR=$["$VAR"+1]
done
```

- until

```
#!/bin/bash

i=0

# i大于5时，循环结束
# 注意:此处必须有空格
until [[ "$i" -gt 5 ]]
do
	echo "$i"
	i=$["$i"+1]
done
```

- break

```
#!/bin/bash

for VAR in 1 2 3
do
	# 如果VAR等于2就跳出循环
	# 判断条件中有[条件]的形式时，必须要有空格
	if [ "$VAR" -eq 2 ]
	then
		break
	fi
	echo "$VAR"
done
```

- continue

```
#!/bin/bash

for VAR in 1 2 3
do
	# 如果VAR等于2，就跳过，直接进入下一次VAR=3的循环
	if [ "$VAR" -eq 2 ]
	then
		continue
	fi
	echo "$VAR"
done
```

- 定义函数

```
#!/bin/bash

function hello_world()
{
	echo 'hello world func'
	echo "$1" "$2"
	return 1
}

hello()
{
	echo 'hello func'
}

# 直接用函数名调用hello函数
hello
result="$?"
echo "$result"

echo '----------'
# 使用[函数名 函数参数]来传递参数
hello_world 1 2
result="$?"
echo "$result"

echo '----------'
# 使用[FUN=`函数名 函数参数`]来直接调用
FUN=`hello_world 'a' 'b'`
result="$?"
echo "$result"
echo "$FUN" # 当给FUN赋值`函数 参数`时，执行echo "$FUN"，相当于直接执行函数 参数，以此来调用函数

# hello func
# 0
#
# hello world func
# 1 2
# 1
#
# 1
# hello world func
# a b
```

- 获取返回值

```
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

- 定义全局变量

```
#!/bin/bash

# 局部变量(本地变量)
# 全局变量(环境变量):
#	1.常见系统环境变量
#	2.自定义环境变量

# local一般用于局部变量声明，多在函数内部使用
# export将自定义变量设定为系统环境变量(全局变量)

fun()
{
	local x=1
	echo $x
}

fun
```

- 单引号与双引号

```
#!/bin/bash

# 总结：
# 单引号与双引号的区别在于:
# 单引号内若存在变量，存在的变量当作字符串不会被解析，原样输出；
# 而双引号中若存在变量，该变量会被解析出其具体的值再加入到字符串中；
# 1.不加引号可以直接定义内容包含数字，字符串，路径名等，适合定义数字
# 2.单引号适合于纯定义字符串
# 3.而双引号适合于字符串的内容中包含有变量的内容的定义
# (习惯:
# 数字以及不带空格的简单字符串不加引号，其他长的特别有空格的字符串加双引号；
# 遇到"$变量名"，但不想解析的加单引号，但一般出现$都是为了解析变量，所以单引号较少使用；)

A=192.168.1.1
B='192.168.1.2'
C="192.168.1.3"
echo "A=$A"
echo "B=$B"
echo "C=${C}"

A=192.168.1.1-$B
B='192.168.1.2-$B'
C="192.168.1.3-$B"
echo "A="$A""
echo "B=$B"
echo "C=${C}"

ETT=123
echo '$ETT' # 打印$ETT(单引号不解析)
echo "$ETT" # 打印123(双引号解析)
awk 'BEGIN {print '$ETT'}' # 打印123(使用awk时，单引号解析)
awk 'BEGIN {print "$ETT"}' # 打印$ETT(使用awk时，双引号不解析)
```

- 调试

```
#!/bin/bash

for VAR in 1 2 3
do
	if [ $VAR -eq 2 ]
	then
		continue
	fi
	echo $VAR
done

#调试:(在命令行输入以下命令)
#
#1.检查是否有语法错误:
#sh -n test.sh
#2.执行并调试Shell脚本:
#sh -x test.sh

#调试结果:
#
# kaiqigu@kaiqigu-H110-4S:~/PycharmProjects/test/xiande/shell|
# ⇒  sh -n test.sh   
# kaiqigu@kaiqigu-H110-4S:~/PycharmProjects/test/xiande/shell|
# ⇒  sh -x test.sh   
# + [ 1 -eq 2 ]
# + echo 1
# 1
# + [ 2 -eq 2 ]
# + continue
# + [ 3 -eq 2 ]
# + echo 3
# 3
#其中带有+表示的是Shell调试器的输出,不带+表示我们程序的输出。
```

- echo选项

```
#!/bin/bash

# echo -n 不换行输出

echo -n 123
echo 456

# echo -e 处理特殊字符:(若字符串中出现以下字符，则特别加以处理，而不会将它当成一般文字输出)
# \a 发出警告声
# \b 删除前一个字符
# \c 最后不加上换行符号
# \f 换行但光标仍旧停留在原来的位置
# \n 换行且光标移至行首
# \r 光标移至行首，但不换行
# \t 插入tab
# \v 与\f相同
# \  插入\字符
# \nnn 插入nnn(八进制)所代表的ASCII字符

echo -e "a\bdddd"
echo -e "a\ndddd"
```

- 执行其他shell脚本

```
exec ./othershell.sh
```
