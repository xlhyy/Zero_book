# 重定向


```
文件描述符0:  stdin
文件描述符1:  stdout
文件描述符2:  stderr
```

## 重定向错误/输出/输入

- 重定向错误

```
kaiqigu@bogon:~/dododo/sfile|⇒  ls -al a1.sh a2.sh a3.sh
ls: a3.sh: No such file or directory
-rw-r--r--  1 kaiqigu  staff  215 Oct 11 10:09 a1.sh
-rw-r--r--  1 kaiqigu  staff   98 Oct 11 10:45 a2.sh


kaiqigu@bogon:~/dododo/sfile|⇒  ls -al a1.sh a2.sh a3.sh 2> err_info 
-rw-r--r--  1 kaiqigu  staff  215 Oct 11 10:09 a1.sh
-rw-r--r--  1 kaiqigu  staff   98 Oct 11 10:45 a2.sh


kaiqigu@bogon:~/dododo/sfile|⇒  cat err_info 
ls: a3.sh: No such file or directory
```

- 重定向错误和输出

```
kaiqigu@bogon:~/dododo/sfile|⇒  ls -al a1.sh a2.sh a3.sh 2> err_info2 1> show_info2


kaiqigu@bogon:~/dododo/sfile|⇒  cat err_info2 
ls: a3.sh: No such file or directory


kaiqigu@bogon:~/dododo/sfile|⇒  cat show_info2 
-rw-r--r--  1 kaiqigu  staff  215 Oct 11 10:09 a1.sh
-rw-r--r--  1 kaiqigu  staff   98 Oct 11 10:45 a2.sh


kaiqigu@bogon:~/dododo/sfile|⇒  ls -al a1.sh a2.sh a3.sh &> data_info2      


kaiqigu@bogon:~/dododo/sfile|⇒  cat data_info2 
ls: a3.sh: No such file or directory
-rw-r--r--  1 kaiqigu  staff  215 Oct 11 10:09 a1.sh
-rw-r--r--  1 kaiqigu  staff   98 Oct 11 10:45 a2.sh
```

```
kaiqigu@bogon:~/dododo/sfile|⇒  cat b1.sh    
#!/bin/bash

exec 3> b1_3_out

echo "content 1."
echo "content 2." >&3
echo "content 3."


kaiqigu@bogon:~/dododo/sfile|⇒  sh b1.sh 
content 1.
content 3.


kaiqigu@bogon:~/dododo/sfile|⇒  cat b1_3_out 
content 2.
```

```
kaiqigu@bogon:~/dododo/sfile|⇒  cat b2.sh 
#!/bin/bash

# 下面两条不等于3> b2_out，而是相互独立的
exec 3>&1
exec 1> b2_out

echo "content 1."

exec 1>&3  # 这是一种在脚本中临时重定向输出，然后恢复默认输出设置的常用方法。

echo "content 2."


kaiqigu@bogon:~/dododo/sfile|⇒  sh b2.sh 
content 2.


kaiqigu@bogon:~/dododo/sfile|⇒  cat b2_out 
content 1.
```


- 重定向输入

```
kaiqigu@bogon:~/dododo/sfile|⇒  cat b3.sh  
#!/bin/bash

filename=$1

exec 0< ${filename}

while read line
do
	echo "read: ${line}."
done


kaiqigu@bogon:~/dododo/sfile|⇒  cat test 
content1
content2
content3


kaiqigu@bogon:~/dododo/sfile|⇒  sh b3.sh test 
read: content1.
read: content2.
read: content3.
```

```
kaiqigu@bogon:~/dododo/sfile|⇒  cat b4.sh 
#!/bin/bash

filename=$1

exec 3< ${filename}

while read line <&3
do
	echo "read: ${line}"
done


kaiqigu@bogon:~/dododo/sfile|⇒  cat test 
content1
content2
content3


kaiqigu@bogon:~/dododo/sfile|⇒  sh b4.sh test 
read: content1
read: content2
read: content3
```


## 创建读写文件描述符

```
用同一个文件描述符对同一个文件进行读写
由于是对同一个文件进行数据读写，shell会维护一个内部指针，指明在文件中的当前位置。任何读或写都会从文件指针上次的位置开始。
```

```
kaiqigu@bogon:~/dododo/sfile|⇒  cat b5.sh 
#!/bin/bash

filename=$1

exec 3<> ${filename}

read line <&3

echo "read: ${line}"
echo "this is a test line." >&3


kaiqigu@bogon:~/dododo/sfile|⇒  cat test2 
this is the first line.
this is the second line.
this is the third line.


kaiqigu@bogon:~/dododo/sfile|⇒  sh b5.sh test2 
read: this is the first line.


kaiqigu@bogon:~/dododo/sfile|⇒  cat test2 
this is the first line.
this is a test line.
ne.
this is the third line.


kaiqigu@bogon:~/dododo/sfile|⇒  cat test3 
this is the first line.
this line.
this is the third line.


kaiqigu@bogon:~/dododo/sfile|⇒  sh b5.sh test3
read: this is the first line.


kaiqigu@bogon:~/dododo/sfile|⇒  cat test3 
this is the first line.
this is a test line.
e third line.
```

## 关闭文件描述符

```
kaiqigu@bogon:~/dododo/sfile|⇒  cat b6.sh 
#!/bin/bash

exec 3> b6_out

echo "test line." >&3

exec 3>&-	# 关闭文件描述符3

echo "test line2." >&3


kaiqigu@bogon:~/dododo/sfile|⇒  sh b6.sh 
b6.sh: line 9: 3: Bad file descriptor


kaiqigu@bogon:~/dododo/sfile|⇒  cat b6_out 
test line.
```

```
kaiqigu@bogon:~/dododo/sfile|⇒  cat b7.sh 
#!/bin/bash

exec 3> b7_out
echo "this is a test line." >&3
exec 3>&-

cat b7_out

exec 3> b7_out	# 会覆盖已有文件的内容
echo "new line." >&3


kaiqigu@bogon:~/dododo/sfile|⇒  sh b7.sh 
this is a test line.


kaiqigu@bogon:~/dododo/sfile|⇒  cat b7_out 
new line.
```


## 阻止命令输出

```
ls -al > /dev/null                      # 当不想显示脚本输出时使用
ls -al badfile test16 2> /dev/null      # 不显示错误信息
```
