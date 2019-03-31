#!/bin/bash

read -s -p "Enter your password: " pass	# -s选项可以避免在read命令中输入的数据出现在显示器上(实际上，数据会被显示，只是read命令会将文本颜色设成跟背景色一样)
echo
echo "Is your password really $pass? "

