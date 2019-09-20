# 文件IO


```
kaiqigu@bogon:~/dododo/test|⇒  cat haha 
123
qwe
---------------------------------------
kaiqigu@bogon:~/dododo/test|⇒  cat test_1.py 
# coding: utf-8

import os, sys

filename = sys.argv[1]
if not os.path.exists(filename):
    exit(1)

f = open(filename, 'r')

count = 1

for i in f:
	print count, i
	count += 1
---------------------------------------
kaiqigu@bogon:~/dododo/test|⇒  python test_1.py haha
1 123

2 qwe

```


```
kaiqigu@bogon:~/dododo/test|⇒  python test.py haha
请输入字符串: "213\neqwe"
213
eqwe
---------------------------------------
kaiqigu@bogon:~/dododo/test|⇒  cat test.py 
#coding:utf-8

import sys
import os

if len(sys.argv) < 2:
	sys.exit(1)
filename = sys.argv[1]

ac = os.path.abspath('.')
cc = os.path.join(ac, filename)

input_str = input("请输入字符串: ")

f = open(cc, "w+")
f.write(input_str)

f = open(cc, "w+")
print f.read()

f.close()
---------------------------------------
kaiqigu@bogon:~/dododo/test|⇒  cat haha 
213
eqwe%  
```
