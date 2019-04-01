# 重定向


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



- 重定向错误和数据

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


- 在脚本中重定向输出

    - 临时重定向

    ```
    #!/bin/bash
    
    # 如果有意在脚本中生成错误信息，可以将单独的一行输出重定向到STDERR。
    # 如果需要做的是使用输出重定向符来将输出信息重定向到STDERR文件描述符。
    # 在重定向到文件描述符时，你必须在文件描述符数字之前加一个&:
    # echo "This is an error message" >&2
    
    echo "THis is an error" >&2
    echo "This is normal output"
    
    <<COMMENT
    ⇒  ./01-临时重定向.sh 
    THis is an error
    This is normal output
    
    ⇒  ./01-临时重定向.sh 2> test9
    This is normal output
    ⇒  cat test9
    THis is an error
    COMMENT
    ```

    - 永久重定向

    ```
    #!/bin/bash
    
    <<COMMENT
        如果脚本中有大量数据需要重定向，那重定向每个echo语句就会很繁琐。取而代之，你可以用exec命令告诉shell在脚本执行期间重定向某个特定文件描述符。
    COMMENT
    
    <<EXAMPLE1
    exec 1>testout
    echo "This is a test of redirecting all output"
    echo "from a script to another file."
    echo "Without having to redirect every individual line"
    EXAMPLE1
    
    # 脚本中发给STDOUT的所有输出会被重定向到文件。
    <<COMMENT
    ⇒  ./02-永久重定向.sh 
    
    ⇒  cat testout 
    This is a test of redirecting all output
    from a script to another file.
    Without having to redirect every individual line
    COMMENT
    
    # ------------------------------
    
    exec 2>testerror
    echo "This is the start of the script"
    echo "now redirecting all output to another location"
    
    exec 1>testout
    echo "This output should go to the testout file"
    echo "but this should go to the testerror file" >&2
    
    <<COMMENT
    ⇒  ./02-永久重定向.sh 
    This is the start of the script
    now redirecting all output to another location
    
    ⇒  cat testout 
    This output should go to the testout file
    
    ⇒  cat testerror 
    but this should go to the testerror file
    COMMENT
    
    
    04-在脚本中重定向输出
    #!/bin/bash
    
    exec 0< testfile
    count=1
    
    while read line
    do
        echo "Line #$count: $line"
        count=$[ $count + 1 ]
    done
    ```


- 创建自己的重定向

```
1.创建输出文件描述符
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
2.向文件描述符
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


```
3.创建输入文件描述符
#!/bin/bash

# 可以采用和重定向输出文件描述符同样的方法重定向输入文件描述符。

exec 6<&0
exec 0< testfile

count=1
while read line
do
	echo "Line #$count: $line"
	count=$[ $count + 1 ]
done

exec 0<&6

read -p "Are you done now? " answer
case $answer in
	Y|y) echo "Goodbye" ;;
	N|n) echo "Sorry, this is the end." ;;
esac

<<COMMENT
⇒  ./03-创建输入文件描述符.sh 
Line #1: This is the first line.
Line #2: This is the second line.
Line #3: This is the third line.
Are you done now? y
Goodbye
COMMENT
```


```
4.创建读写文件描述符
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


```
5.关闭文件描述符1)
#!/bin/bash

exec 3> test17file

echo "This is a test line of data" >&3

exec 3>&-	# 关闭文件描述符3

echo "This won't work" >&3

<<COMMENT
⇒  ./05-关闭文件描述符.sh 
./05-关闭文件描述符.sh: 行 9: 3: 错误的文件描述符
COMMENT


2)关闭文件描述符2
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


```
6.列出打开的文件描述符
#!/bin/bash

exec 3> test18file1
exec 6> test18file2
exec 7< testfile

/usr/bin/lsof -a -p $$ -d 0,1,2,3,6,7

<<COMMENT
⇒  ./06-列出打开的文件描述符.sh 
lsof: WARNING: can't stat() tracefs file system /sys/kernel/debug/tracing
      Output information may be incomplete.
      COMMAND     PID    USER   FD   TYPE DEVICE SIZE/OFF    NODE NAME
      06-\xe5   17155 kaiqigu    0u   CHR  136,0      0t0       3 /dev/pts/0
      06-\xe5   17155 kaiqigu    1u   CHR  136,0      0t0       3 /dev/pts/0
      06-\xe5   17155 kaiqigu    2u   CHR  136,0      0t0       3 /dev/pts/0
      06-\xe5   17155 kaiqigu    3w   REG    8,1        0 2360003 /home/kaiqigu/PycharmProjects/Practice_python/07-Shell脚本/xx/15-呈现数据/test18file1
      06-\xe5   17155 kaiqigu    6w   REG    8,1        0 2360007 /home/kaiqigu/PycharmProjects/Practice_python/07-Shell脚本/xx/15-呈现数据/test18file2
      06-\xe5   17155 kaiqigu    7r   REG    8,1       73 2359933 /home/kaiqigu/PycharmProjects/Practice_python/07-Shell脚本/xx/15-呈现数据/testfile
COMMENT

<<COMMENT
lsof	列出打开的文件描述符
-a	用来对其他两个选项的结果执行布尔AND运算
-p	允许指定进程ID(PID)
$$	特殊环境变量$$(shell会将它设为当前PID)
-d	允许指定要显示的文件描述符编号
COMMENT

<<COMMENT
   lsof的默认输出
列		描述
COMMAND		正在运行的命令名的前9个字符
PID		进程的PID
USER		进程属主的登录名
FD		文件描述符号以及访问类型(r代表读，w代表写，u代表读写)
TYPE		文件的类型(CHR代表字符型，BLK代表块型，DIR代表目录，REG代表常规文件)
DEVICE		设备的设备号(主设备号和从设备号)
SIZE		如果有的话，表示文件的大小
NODE		本地文件的节点号
NAME		文件名
COMMENT
```


```
7.阻止命令输出
#!/bin/bash

# 将STDERR重定向到一个叫null文件的特殊文件。
# 应用举例: 当不想显示脚本输出时使用

<<COMMENT
ls -al > /dev/null
ls -al badfile test16 2> /dev/null
COMMENT
```



```
8.创建临时文件
1)创建本地临时文件
#!/bin/bash

mktemp testing.XXXXXX
mktemp testing.XXXXXX
mktemp testing.XXXXXX
mktemp testing.XXXXXX
mktemp testing.XXXXXX

ls -l testing.*

<<COMMENT
⇒  ./01-创建本地临时文件.sh 
testing.lCUZCu
testing.bTsaye
testing.iUafqk
testing.EusN5x
testing.FtjjiI
-rw------- 1 kaiqigu kaiqigu 0 10月  9 20:24 testing.bTsaye
-rw------- 1 kaiqigu kaiqigu 0 10月  9 20:24 testing.EusN5x
-rw------- 1 kaiqigu kaiqigu 0 10月  9 20:24 testing.FtjjiI
-rw------- 1 kaiqigu kaiqigu 0 10月  9 20:24 testing.iUafqk
-rw------- 1 kaiqigu kaiqigu 0 10月  9 20:24 testing.lCUZCu
kaiqigu@kaiqigu-H110-4S:~/PycharmProjects/Practice_python/07-Shell脚本/xx/15-呈现数据/08-创建临时文件|

⇒  ls
01-创建本地临时文件.sh  testing.EusN5x  testing.iUafqk
testing.bTsaye          testing.FtjjiI  testing.lCUZCu
COMMENT


2)创建本地临时文件2
#!/bin/bash

tempfile=$(mktemp test19.XXXXXX)

exec 3> $tempfile

echo "This script writes to temp file $tempfile"

echo "This is the first line" >&3
echo "This is the second line" >&3
echo "This is the last line" >&3

exec 3>&-

echo "Done creating temp file. The contents are:"
cat $tempfile
rm -f $tempfile 2> /dev/null

<<COMMENT
⇒  ./01-创建本地临时文件2.sh 
This script writes to temp file test19.33Fzvw
Done creating temp file. The contents are:
This is the first line
This is the second line
This is the last line
COMMENT

3)在tmp目录创建临时文件
#!/bin/bash

# -t选项会强制mktemp命令来在系统的临时目录来创建该文件。

<<EXAMPLE1
mktemp -t test.XXXXXX
ls -al /tmp/test.*
EXAMPLE1

<<COMMENT
⇒  ./02-在tmp目录创建临时文件.sh 
/tmp/test.H4E9rq
-rw------- 1 kaiqigu kaiqigu 0 10月  9 20:35 /tmp/test.H4E9rq
COMMENT

# ---------------------

tempfile=$(mktemp -t tmp.XXXXXX)

echo "This is a test file." > $tempfile
echo "This is the second line of the test." >> $tempfile

echo "The temp file is located at: $tempfile"
cat $tempfile
rm -f $tempfile

<<COMMENT
⇒  ./02-在tmp目录创建临时文件.sh 
The temp file is located at: /tmp/tmp.Gs7urb
This is a test file.
This is the second line of the test.
COMMENT

4)创建临时目录
#!/bin/bash

tempdir=$(mktemp -d dir.XXXXXX)
cd $tempdir
tempfile1=$(mktemp temp.XXXXXX)
tempfile2=$(mktemp temp.XXXXXX)
exec 7> $tempfile1
exec 8> $tempfile2

echo "Sending data to directory $tempdir"
echo "This is a test line of data for $tempfile1" >&7
echo "This is a test line of data for $tempfile2" >&8

<<COMMENT
⇒  ./03-创建临时目录.sh 
Sending data to directory dir.mATru9

⇒  cd dir.mATru9 

⇒  ls -al
总用量 16
drwx------ 2 kaiqigu kaiqigu 4096 10月  9 20:44 .
drwxr-xr-x 3 kaiqigu kaiqigu 4096 10月  9 20:44 ..
-rw------- 1 kaiqigu kaiqigu   44 10月  9 20:44 temp.p6UMgG
-rw------- 1 kaiqigu kaiqigu   44 10月  9 20:44 temp.PHY3MF

⇒  cat temp.p6UMgG 
This is a test line of data for temp.p6UMgG

⇒  cat temp.PHY3MF 
This is a test line of data for temp.PHY3MF
COMMENT
```



```
9.记录消息
#!/bin/bash

# 将输出同时发送到显示器和日志文件，使用特殊的tee命令即可。
# tee命令相当于管道的一个T型接口。它将从STDIN过来的数据同时发往两处。一处是STDOUT，另一处是tee命令行指定的文件名。

<<COMMENT
⇒  who | tee testfile
kaiqigu  tty2         2018-10-08 09:32 (/dev/tty2)

⇒  cat testfile 
kaiqigu  tty2         2018-10-08 09:32 (/dev/tty2)

⇒  date | tee -a testfile 
2018年 10月 09日 星期二 20:51:11 CST

⇒  cat testfile 
kaiqigu  tty2         2018-10-08 09:32 (/dev/tty2)
2018年 10月 09日 星期二 20:51:11 CST
COMMENT
# -a 将数据追加到文件中

# ------------------------

tempfile=test22file

echo "This is the start of the test" | tee $tempfile
echo "This is the second line of the test" | tee -a $tempfile
echo "This is the end of the test" | tee -a $tempfile

<<COMMENT
⇒  ./09-记录消息.sh 
This is the start of the test
This is the second line of the test
This is the end of the test

⇒  cat test22file 
This is the start of the test
This is the second line of the test
This is the end of the test
COMMENT

# 利用这个方法，既能将数据保存在文件中，也能将数据显示在屏幕上。
```


```
10.实例
#!/bin/bash

outfile='members.sql'
IFS=','
while read lname fname address city state zip
do
	cat >> $outfile << EOF
	INSERT INTO members (lname,fname,address,city,state,zip) VALUES ('$lname','$fname','
	$address','$city','$state','$zip');
EOF
done < ${1}

<<COMMENT
⇒  cat members.csv 
Blum,Richard,123 Main St.,Chicago,IL,60601
Blum,Barbara,123 Main St.,Chicago,IL,60601
Bresnahan,Christine,456 Oak Ave.,Columbus,OH,43201
Bresnahan,Timothy,456 Oak Ave.,Columbus,OH,43201

⇒  ./10-实例.sh members.csv 

⇒  cat members.sql 
	INSERT INTO members (lname,fname,address,city,state,zip) VALUES ('Blum','Richard','
	123 Main St.','Chicago','IL','60601');
	INSERT INTO members (lname,fname,address,city,state,zip) VALUES ('Blum','Barbara','
	123 Main St.','Chicago','IL','60601');
	INSERT INTO members (lname,fname,address,city,state,zip) VALUES ('Bresnahan','Christine','
	456 Oak Ave.','Columbus','OH','43201');
	INSERT INTO members (lname,fname,address,city,state,zip) VALUES ('Bresnahan','Timothy','
	456 Oak Ave.','Columbus','OH','43201');
COMMENT

# Shell中通常将EOF与 << 结合使用，表示后续的输入作为子命令或子Shell的输入，直到遇到EOF为止，再返回到主调Shell。
```
