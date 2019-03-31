#!/bin/bash

<<EXAMPLE1
echo -n "Enter your name: "	# -n输入不换行
read name
echo "Hello $name, welcome to my program."
EXAMPLE1

<<COMMENT
⇒  ./11-获取用户输入.sh   
Enter your name: li
Hello li, welcome to my program.
COMMENT

# ---------------------------

<<EXAMPLE2
read -p "Please enter your age: " age	# -p允许直接在read命令行指定提示符
days=$[ $age * 365 ]
echo "That makes you over $days days old! "
EXAMPLE2

<<COMMENT
⇒  ./11-获取用户输入.sh 
Please enter your age: 10
That makes you over 3650 days old! 
COMMENT

# ---------------------------

<<EXAMPLE3
read -p "Enter your name: " first last
echo "Checking data for $last, $first..."
EXAMPLE3

<<COMMENT
⇒  ./11-获取用户输入.sh
Enter your name: li1 li2  
Checking data for li2, li1...
COMMENT

# ---------------------------

<<EXAMPLE4
# 也可以在read命令行中不指定变量。如果是这样，read命令会将它收到的任何数据都放进特殊环境变量REPLY中。
read -p "Enter your name: "
echo
echo Hello $REPLY, welcome to my program.
EXAMPLE4

<<COMMENT
⇒  ./11-获取用户输入.sh    
Enter your name: 123

Hello 123, welcome to my program.
COMMENT

# ---------------------------

read -n1 -p "Do you want to continue [Y/N]? " answer	# -n(字符个数)
case $answer in
	Y | y) echo
	       echo "fine, continue on ..." ;;
	N | n) echo
	       echo OK, goodbye!
	       exit ;;
esac
echo "This is the end of the script"

<<COMMENT
⇒  ./11-获取用户输入.sh
Do you want to continue [Y/N]? y
fine, continue on ...
This is the end of the script

⇒  ./11-获取用户输入.sh
Do you want to continue [Y/N]? n
OK, goodbye!
COMMENT

