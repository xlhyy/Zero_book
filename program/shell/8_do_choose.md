# 结构


- if

```
# 下面这两种判断方法都可以
# if test "$VAR" -eq 10
# if [ ${VAR} -eq 10 ]      # 此处空格格式有要求

kaiqigu@bogon:~/dododo/test|⇒  sh tt.sh 
10
true
kaiqigu@bogon:~/dododo/test|⇒  sh tt.sh
1
false
kaiqigu@bogon:~/dododo/test|⇒  cat tt.sh 
#!/bin/bash

read VAR

if [ ${VAR} -eq 10 ]
then
    echo "true"
else
    echo "false"
fi
```

- case

```
kaiqigu@bogon:~/dododo/test|⇒  sh tt.sh 
1
ubuntu


kaiqigu@bogon:~/dododo/test|⇒  sh tt.sh
2
red cat


kaiqigu@bogon:~/dododo/test|⇒  sh tt.sh
3
other


kaiqigu@bogon:~/dododo/test|⇒  cat tt.sh 
#!/bin/bash

read name

case ${name} in
    1)
	    echo "ubuntu"
		;;
	2)
		echo "red cat"
		;;
	3)
		echo "other"
		;;
esac
```

- for

```
注意: 此处对空格形式无硬性要求
for((i=1;i<=3;i++))
```

```
kaiqigu@bogon:~/dododo/test|⇒  sh tt.sh 
1
2
3
hello
1
2


kaiqigu@bogon:~/dododo/test|⇒  cat tt.sh 
#!/bin/bash

for i in 1 2 3 "hello"
do
    echo ${i}
done


for ((i=1; i<3; i++))
do
    echo ${i}
done
```

- while

```
# 注意:此处空格有格式要求
# while [ ${var} -lt 10 ]

# -eq 等于
# -ne 不等于
# -gt 大于
# -lt 小于
# -ge 大于等于
# -le 小于等于
# 注意: 此处不能用<，>等。


#!/bin/bash

var=1

while [ ${var} -lt 10 ]
do
	echo ${var}
	var=`expr ${var} + 1`
done
```

- until

```
kaiqigu@bogon:~/dododo/test|⇒  sh tt.sh 
0
1
2
3
4
5


kaiqigu@bogon:~/dododo/test|⇒  cat tt.sh 
#!/bin/bash

i=0

until [ ${i} -gt 5 ]      # 对空格有格式要求
do
	echo ${i}
	i=`expr ${i} + 1`
done
```

- break

```
#!/bin/bash

for VAR in 1 2 3
do
	# 如果VAR等于2就跳出循环
	# 判断条件中有[条件]的形式时，必须要有空格
	if [ ${VAR} -eq 2 ]
	then
		break
	fi
	echo ${VAR}
done
```

- continue

```
#!/bin/bash

for VAR in 1 2 3
do
	# 如果VAR等于2，就跳过，直接进入下一次VAR=3的循环
	if [ ${VAR} -eq 2 ]
	then
		continue
	fi
	echo ${VAR}
done
```


- =与-eq 及 test命令

```
=用于比较字符串 =和-eq用于比较整数
注意:
    =与==在只用if不用test的比较时, 没有区别。
    如果使用test则只能用=或-eq, 不能用==。
```


```
kaiqigu@bogon:~/dododo/test|⇒  sh tt.sh 
3
var is 3
-2
字符串不相等
./new_dir目录存在


kaiqigu@bogon:~/dododo/test|⇒  cat tt.sh 
#!/bin/bash

read var
echo "var is ${var}"

echo `expr ${var} - 5`

if test "hello" = "helloworld"
then
	echo "字符串相等"
else
	echo "字符串不相等"
fi


if [[ "hello" = "helloworld" ]]
then
	echo "字符串相等"
else
	echo "字符串不相等"
fi


new_dir=./new_dir
if test -d ./new_dir
then
	echo "${new_dir}目录存在"
else
	echo "${new_dir}目录不存在"
fi

exit
```
