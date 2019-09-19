# 重定向


```
文件描述符0:  stdin
文件描述符1:  stdout
文件描述符2:  stderr
```

## 重定向错误/输出/输入

- 重定向错误

```
#!/bin/bash

<<COMMENT
⇒  ls -al badfile 2> test4
⇒  cat test4 
ls: 无法访问'badfile': 没有那个文件或目录

⇒  ls -al test badtest test2 2> test5
-rw-r--r-- 1 kaiqigu kaiqigu 231 10月  9 10:43 test2
⇒  cat test5
ls: 无法访问'test': 没有那个文件或目录
ls: 无法访问'badtest': 没有那个文件或目录

    该命令生成的任何错误信息都会保存在输出文件中。用这种方法，shell会只重定向错误信息，而非普通数据。
    ls命令的正常STDOUT输出仍然会发送到默认的STDOUT文件描述符，也就是显示器。由于该命令将文件描述符2的输出(STDERR)重定向到了一个输出文件，shell会将生成的所有错误信息直接发送到指定的重定向文件中。
COMMENT
```

- 重定向错误和输出

```
#!/bin/bash

<<COMMENT
⇒  ls -al test test2 test3 badtest 2> test6 1> test7
⇒  cat test6
ls: 无法访问'test': 没有那个文件或目录
ls: 无法访问'badtest': 没有那个文件或目录
⇒  cat test7
-rw-r--r-- 1 kaiqigu kaiqigu 231 10月  9 10:43 test2
-rw-r--r-- 1 kaiqigu kaiqigu   0 10月  9 10:49 test3

⇒  ls -al test test2 test3 badtest &> test7
⇒  cat test7
ls: 无法访问'test': 没有那个文件或目录
ls: 无法访问'badtest': 没有那个文件或目录
-rw-r--r-- 1 kaiqigu kaiqigu 231 10月  9 10:43 test2
-rw-r--r-- 1 kaiqigu kaiqigu   0 10月  9 10:49 test3
COMMENT
```

```
#!/bin/bash

exec 3>test13out

echo "This should display on the monitor"
echo "and this should be stored in the file" >&3
echo "Then this should be back on the monitor"

<<COMMENT
⇒  ./01-创建输出文件描述符.sh 
This should display on the monitor
Then this should be back on the monitor

⇒  cat test13out 
and this should be stored in the file
COMMENT
```

```
#!/bin/bash

exec 3>&1
exec 1>test14out

echo "This should store in the output file"
echo "along with this line."

exec 1>&3	# 在向STDOUT(现在指向一个文件)发送一些输出之后，脚本将STDOUT重定向到文件描述符3的当前位置(现在仍然是显示器)。这意味着STDOUT又指向了它原来的位置。
		# 这是一种在脚本中临时重定向输出，然后恢复默认输出设置的常用方法。

echo "Now things should be back to normal"

<<COMMENT
⇒  ./02-重定向文件描述符.sh 
Now things should be back to normal

⇒  cat test14out 
This should store in the output file
along with this line.
COMMENT
```


- 重定向输入

```
kaiqigu@bogon:~/test|⇒  cat testfile 
This is the first line.
This is a test line
ine.
This is the third line.

kaiqigu@bogon:~/test|⇒  cat test.sh 
#!/bin/sh

exec 0< testfile

while read line
do
    echo "Read: $line"
done

kaiqigu@bogon:~/test|⇒  sh test.sh 
Read: This is the first line.
Read: This is a test line
Read: ine.
Read: This is the third line.
```

```
kaiqigu@bogon:~/test|⇒  cat testfile 
This is the first line.
This is a test line
ine.
This is the third line.

kaiqigu@bogon:~/test|⇒  cat test.sh 
#!/bin/sh

exec 0< testfile

while read line <&0
do
    echo "Read: $line"
done

kaiqigu@bogon:~/test|⇒  sh test.sh 
Read: This is the first line.
Read: This is a test line
Read: ine.
Read: This is the third line.
```


## 创建读写文件描述符

```
#!/bin/bash

# 用同一个文件描述符对同一个文件进行读写

# 由于是对同一个文件进行数据读写，shell会维护一个内部指针，指明在文件中的当前位置。任何读或写都会从文件指针上次的位置开始。

exec 3<> testfile
read line <&3

echo "Read: $line"
echo "This is a test line" >&3

<<COMMENT
⇒  cat testfile 
This is the first line.
This is the second line.
This is the third line.

⇒  ./04-创建读写文件描述符.sh 
Read: This is the first line.

⇒  cat testfile 
This is the first line.
This is a test line
ine.
This is the third line.
COMMENT
```

## 关闭文件描述符

```
#!/bin/bash

exec 3> test17file

echo "This is a test line of data" >&3

exec 3>&-	# 关闭文件描述符3

echo "This won't work" >&3

<<COMMENT
⇒  ./05-关闭文件描述符.sh 
./05-关闭文件描述符.sh: 行 9: 3: 错误的文件描述符
COMMENT
```

```
#!/bin/bash

exec 3> test17file
echo "This is a test line of data" >&3
exec 3>&-

cat test17file

exec 3> test17file	# 会覆盖已有文件的内容
echo "This'll be bad" >&3

<<COMMENT
⇒  ./05-关闭文件描述符2.sh
This is a test line of data

⇒  cat test17file 
This'll be bad
COMMENT
```


## 阻止命令输出

```
#!/bin/bash

# 将STDERR重定向到一个叫null文件的特殊文件。
# 应用举例: 当不想显示脚本输出时使用

<<COMMENT
ls -al > /dev/null
ls -al badfile test16 2> /dev/null
COMMENT
```
