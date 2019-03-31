#!/bin/bash

# 当参数中有-ab这种形式时会报错。若想正常工作可以使用getopt命令

# 1.处理简单选项
<<EXAMPLE1
echo
while [ -n "$1" ]
do
	case "$1" in
		-a) echo "Found the -a option" ;;
		-b) echo "Found the -b option" ;;
		-c) echo "Found the -c option" ;;
		 *) echo "$1 is not an option" ;;
	esac
	shift
done
EXAMPLE1

<<COMMENT
⇒  ./08-处理选项.sh -a -b -c -d

Found the -a option
Found the -b option
Found the -c option
-d is not an option
COMMENT


# 2.分离参数和选项
<<COMMENT
shell用双破折号来表明选项列表结束。在破折号之后，就可以放心地将剩下的命令行参数当作参数。
COMMENT

<<EXAMPLE2
echo
while [ -n "$1" ]
do
	case "$1" in
		-a) echo "Found the -a option" ;;
		-b) echo "Found the -b option" ;;
		-c) echo "Found the -c option" ;;
		--) shift
			break ;;
		 *) echo "$1 is not an option" ;;
	esac
	shift
done
count=1
for param in $@
do
	echo "Parameter #$count: $param"
	count=$[ $count + 1 ]
done
EXAMPLE2

<<COMMENT
⇒  ./08-处理选项.sh -a -b -c test1 test2 test3

Found the -a option
Found the -b option
Found the -c option
test1 is not an option
test2 is not an option
test3 is not an option

⇒  ./08-处理选项.sh -a -b -c -- test1 test2 test3

Found the -a option
Found the -b option
Found the -c option
Parameter #1: test1
Parameter #2: test2
Parameter #3: test3
COMMENT


# 3.处理带值的选项
echo
while [ -n "$1" ]
do
	case "$1" in
		-a) echo "Found the -a option" ;;
		-b) param="$2"
		    echo "Found the -b option, with parameter value $param"
		    shift ;;
		-c) echo "Found the -c option" ;;
		--) shift
		    break ;;
		 *) echo "$1 is not an option" ;;
	esac
	shift
done

count=1
for param in "$@"
do
	echo "Parameter #$count: $param"
	count=$[ $count + 1 ]
done

<<COMMENT
⇒  ./08-处理选项.sh -a -b test1 -d

Found the -a option
Found the -b option, with parameter value test1
-d is not an option
COMMENT

