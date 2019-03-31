#!/bin/bash

<<COMMENT
⇒  ./06-获取所有命令行参数.sh a b c d

$* Parameter #1 = a b c d

$@ Parameter #1 = a
$@ Parameter #2 = b
$@ Parameter #3 = c
$@ Parameter #4 = d
COMMENT

echo
count=1
for param in "$*"
do
	echo "\$* Parameter #$count = $param"
	count=$[ $count + 1 ]
done

echo
count=1
for param in "$@"
do
	echo "\$@ Parameter #$count = $param"
	count=$[ $count + 1 ]
done

