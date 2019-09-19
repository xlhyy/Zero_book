# 结构


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


- =与-eq 及 test命令

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
