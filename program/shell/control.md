### 控制脚本


### 处理信号


- 01-生成信号
```
#!/bin/bash

# ^C终端进程 生成SIGINT信号
# ^Z暂停进程 生成SIGTSTP信号
# ps命令将已停止作业的状态为显示为T。这说明命令要么被跟踪，要么被停止了。

<<COMMENT
⇒  sleep 100
^C

⇒  sleep 100
^Z
[1]  + 21963 suspended  sleep 100

⇒  ps -l 
F S   UID   PID  PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
0 S  1000  3262  2535  0  80   0 -  6243 wait   pts/0    00:00:00 bash
0 S  1000  3273  3262  0  80   0 -  3627 wait   pts/0    00:00:00 tp_to_practice.
0 S  1000  3274  3273  0  80   0 - 12792 sigsus pts/0    00:00:08 zsh
0 T  1000 21963  3274  0  80   0 -  2286 signal pts/0    00:00:00 sleep
4 R  1000 22063  3274  0  80   0 -  8809 -      pts/0    00:00:00 ps

⇒  kill -9 21963
[1]  + 21963 killed     sleep 100              
COMMENT
```


- 02-捕获信号
```
#!/bin/bash

# trap命令允许你来指定shell脚本要监看并从shell中拦截的Linux信号。
# 如果脚本收到了trap命令中列出的信号，该信号不再由shell处理，而是交由本地处理。
# trap命令的格式是: trap commands signals

# 例: 使用trap命令来忽略SIGINT信号，并控制脚本的行为。
trap "echo ' Sorry! I have trapped Ctrl-C'" SIGINT

echo This is a test script

count=1
while [ $count -le 10 ]
do
	echo "Loop #$count"
	sleep 1
	count=$[ $count + 1 ]
done

echo "This is the end of the test script"

<<COMMENT
⇒  ./02-捕获信号.sh 
This is a test script
Loop #1
Loop #2
Loop #3
^C Sorry! I have trapped Ctrl-C
Loop #4
Loop #5
Loop #6
^C Sorry! I have trapped Ctrl-C
Loop #7
Loop #8
^C Sorry! I have trapped Ctrl-C
Loop #9
Loop #10
This is the end of the test script
COMMENT
```


- 03-捕获脚本退出
```
#!/bin/bash

# 除了在shell脚本中捕获信号，也可以在shell脚本退出时进行捕获。这是在shell完成任务时执行命令的一种简便方法。
# 要捕获shell脚本的退出，只要在trap命令后加上EXIT信号就行。

trap "echo Goodbye..." EXIT

count=1
while [ $count -le 5 ]
do
	echo "Loop #$count"
	sleep 1
	count=$[ $count + 1 ]
done

<<COMMENT
⇒  ./03-捕获脚本退出.sh 
Loop #1
Loop #2
Loop #3
Loop #4
Loop #5
Goodbye...
COMMENT
```

- 04-修改或移除捕获
```
1
#!/bin/bash

# 要想在脚本中的不同位置进行不同的捕获处理，只需重新使用带有新选项trap命令。
trap "echo ' Sorry... Ctrl-C is trapped.'" SIGINT
count=1
while [ $count -le 5 ]
do
	echo "Loop #$count"
	sleep 1
	count=$[ $count + 1 ]
done

trap "echo ' I modified the trap!'" SIGINT
count=1
while [ $count -le 5 ]
do
	echo "Second Loop #$count"
	sleep 1
	count=$[ $count + 1 ]
done

<<COMMENT
⇒  ./04-修改或移除捕获.sh
Loop #1
Loop #2
^C Sorry... Ctrl-C is trapped.
Loop #3
Loop #4
^C Sorry... Ctrl-C is trapped.
Loop #5
Second Loop #1
Second Loop #2
^C I modified the trap!
Second Loop #3
Second Loop #4
^C I modified the trap!
Second Loop #5
COMMENT
```


```
2
#!/bin/bash

# 删除已设置好的捕获。只需要在trap命令与希望恢复默认行为的信号列表之间加上两个破折号就行了。

trap "echo ' Sorry... Ctrl-C is trapped.'" SIGINT
count=1
while [ $count -le 5 ]
do
	echo "Loop #$count"
	sleep 1
	count=$[ $count + 1 ]
done

trap -- SIGINT
echo "I just removed the trap"
count=1
while [ $count -le 5 ]
do
	echo "Second Loop #$count"
	sleep 1
	count=$[ $count + 1 ]
done

<<COMMENT
⇒  ./04-修改或移除捕获2.sh 
Loop #1
Loop #2
Loop #3
Loop #4
^C Sorry... Ctrl-C is trapped.
Loop #5
I just removed the trap
Second Loop #1
Second Loop #2
^C
COMMENT
```


- linux信号
```
		Linux信号
信号		值		描述
1		SIGHUP		挂起进程
2		SIGINT		终止进程
3		SIGQUIT		停止进程
9		SIGKILL		无条件终止进程
15		SIGTEAM		尽可能终止进程
17		SIGSTOP		无条件停止进程，但不是终止进程
18		SIGTSTP		停止或暂停进程，但不终止进程
19		SIGCONT		继续运行停止的进程
```


- 以后台模式运行脚本
```
#### 1
#!/bin/bash

count=1
while [ $count -le 10 ]
do
	sleep 1
	count=$[ $count + 1 ]
done

<<COMMENT
⇒  ./01-后台运行脚本.sh &
[1] 22652

⇒  
[1]  + 22652 done       ./01-后台运行脚本.sh
COMMENT
```


```
#### 2
#!/bin/bash

echo "Start the test script"
count=1
while [ $count -le 5 ]
do
	echo "Loop #$count"
	sleep 5
	count=$[ $count + 1 ]
done

echo "Test script is complete"


#1) 当后台进程运行时，它仍然会使用终端显示器来显示STDOUT和STDERR消息
<<COMMENT
⇒  ./01-后台运行脚本2.sh &
[1] 23636
Start the test script                                                                                                                                   
Loop #1
⇒  Loop #2
Loop #3
Loop #4
Loop #5

⇒  Test script is complete

[1]  + 23636 done       ./01-后台运行脚本2.sh

# ---------------------------------------------------

⇒  ./01-后台运行脚本2.sh &
[1] 23660
Start the test script                                                                                                                                   
Loop #1
⇒  Loop #2

⇒  Loop #3
Loop #4
Loop #5
Test script is complete

[1]  + 23660 done       ./01-后台运行脚本2.sh
COMMENT
```


```
#2)在显示输出的同时，仍然可以运行命令
<<COMMENT
⇒  ./01-后台运行脚本2.sh &
[1] 23892
Start the test script                                                                   
Loop #1

⇒  ls -al
总用量 16
drwxr-xr-x 2 kaiqigu kaiqigu 4096 10月 10 10:58 .
drwxr-xr-x 4 kaiqigu kaiqigu 4096 10月 10 10:20 ..
-rw-r--r-- 1 kaiqigu kaiqigu    0 10月 10 10:55 01-后台运行脚本
-rwxr-xr-x 1 kaiqigu kaiqigu  207 10月 10 10:55 01-后台运行脚本1.sh
-rwxr-xr-x 1 kaiqigu kaiqigu 1055 10月 10 10:58 01-后台运行脚本2.sh

⇒  Loop #2
Loop #3
Loop #4
Loop #5
Test script is complete

[1]  + 23892 done       ./01-后台运行脚本2.sh
COMMENT
# 最好将后台运行脚本的STDOUT和STDERR进行重定向，避免这种杂乱的输出。
```


- 运行多个后台作业
```
#!/bin/bash

# 每次启动新作业时，Linux系统都会为其分配一个新的作业号和PID。通过ps命令，可以看到所有脚本处于运行状态。
# 在终端会话中使用后台进程时一定要小心。注意，在ps命令的输出中，每一个后台进程都和终端会话(pts/0)终端联系在一起。如果终端会话推出，那么后台进程也会随之退出。


### 在非控制台下运行脚本
#!/bin/bash

# nohup命令可以解除终端与进程的关联，进程也就不再同STDOUT和STDERR联系在一起。
# 为了保存该命令产生的输出，nohup命令会自动将STDOUT和STDERR的消息重定向到一个名为nohup.out的文件中。

<<COMMENT
⇒  nohup ./test1.sh 
nohup: 忽略输入并把输出追加到'nohup.out'

⇒  cat nohup.out 
This is a test script
Loop 1
Loop 2
Loop 3
Loop 4
Loop 5
Loop 6
Loop 7
Loop 8
Loop 9
Loop 10
This is the end of the test script
COMMENT
```
