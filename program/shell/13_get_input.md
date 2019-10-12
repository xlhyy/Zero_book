# 获取用户输入


- 以隐藏方式读取用户输入

```
-s 选项可以避免在read命令中输入的数据出现在显示器上 (实际上，数据会被显示，只是read命令会将文本颜色设成跟背景色一样)
```

```
#!/bin/bash

read -s -p "Enter your password: " pass
echo
echo "Is your password really $pass? "
```


- 读取用户输入

```
kaiqigu@bogon:~/dododo/test|⇒  cat tt.sh 
#!/bin/bash

echo -n "enter your name: "
read name
echo "hello ${name}!"


kaiqigu@bogon:~/dododo/test|⇒  ./tt.sh 
enter your name: li
hello li!
```

```
kaiqigu@bogon:~/dododo/test|⇒  cat tt.sh 
#!/bin/bash

read -p "enter your name:" first last
echo "checking data for ${last}, ${first} ..."


kaiqigu@bogon:~/dododo/test|⇒  sh tt.sh 
enter your name:1 2
checking data for 2, 1 ...
```

```
kaiqigu@bogon:~/dododo/test|⇒  cat tt.sh 
#!/bin/bash

read -p "Enter your name: "
echo Hello $REPLY!


kaiqigu@bogon:~/dododo/test|⇒  sh tt.sh 
Enter your name: 123 2131 12313
Hello 123 2131 12313!
```

```
kaiqigu@bogon:~/dododo/test|⇒  cat tt.sh 
#!/bin/bash

read -n1 -p "Do you want to continue [Y/N]? " answer	# -n(限制字符个数)，当达到默认字符个数时，默认按回车
case $answer in
	Y | y) echo
	       echo "continue ..." ;;
	N | n) echo
	       echo "goodbye ~"
	       exit ;;
esac


kaiqigu@bogon:~/dododo/test|⇒  sh tt.sh
Do you want to continue [Y/N]? y
continue ...


kaiqigu@bogon:~/dododo/test|⇒  sh tt.sh
Do you want to continue [Y/N]? n
goodbye ~
```


```
kaiqigu@bogon:~/dododo/test|⇒  cat tt.sh 
#!/bin/bash

read -p "do you want to continue [y/n]? " answer    # 没用-n限制字符个数时，需要按回车确认选择

case ${answer} in
	y | Y) echo "continue ...";;
	n | N) echo "goodbye ~";exit;;
esac


kaiqigu@bogon:~/dododo/test|⇒  sh tt.sh
do you want to continue [y/n]? y
continue ...


kaiqigu@bogon:~/dododo/test|⇒  sh tt.sh
do you want to continue [y/n]? n
goodbye ~
```
