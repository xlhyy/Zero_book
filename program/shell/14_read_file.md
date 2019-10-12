# 从文件中读取


```
每次调用read命令，它都会从文件中读取一行文本。当文件中再没有内容时，read命令会退出并返回非零推出状态码
while循环会持续通过read命令处理文件中的行，直到read命令以非零退出状态码运行
```

```
kaiqigu@bogon:~/dododo/sfile|⇒  cat test 
content1
content2
content3


kaiqigu@bogon:~/dododo/sfile|⇒  cat a1.sh 
#!/bin/bash

count=1

cat test | while read line
do
	echo "line ${count}: ${line}"
	count=`expr ${count} + 1`
done

count=1

while read line
do
	echo "line ${count}: ${line}"
	count=`expr ${count} + 1`
done < test


kaiqigu@bogon:~/dododo/sfile|⇒  sh a1.sh
line 1: content1
line 2: content2
line 3: content3
line 1: content1
line 2: content2
line 3: content3
```

