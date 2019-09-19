# 调试


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
