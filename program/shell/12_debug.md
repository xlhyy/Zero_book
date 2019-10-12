# 调试


```
调试:(在命令行输入以下命令)

1.检查是否有语法错误:
    sh -n test.sh
2.执行并调试Shell脚本:
    sh -x test.sh
```


```
kaiqigu@bogon:~/dododo/test|⇒  cat tt.sh 
#!/bin/bash

for VAR in 1 2 3
do
	if [ ${VAR} -eq 2 ]
	then
		continue
	fi
	echo ${VAR}
done


kaiqigu@bogon:~/dododo/test|⇒  sh -n tt.sh 


kaiqigu@bogon:~/dododo/test|⇒  sh -x tt.sh 
+ for VAR in 1 2 3
+ '[' 1 -eq 2 ']'
+ echo 1
1
+ for VAR in 1 2 3
+ '[' 2 -eq 2 ']'
+ continue
+ for VAR in 1 2 3
+ '[' 3 -eq 2 ']'
+ echo 3
3


注意: 其中带有+表示的是Shell调试器的输出,不带+表示我们程序的输出。
```
