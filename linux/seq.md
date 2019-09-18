# seq

```
seq命令可以输出连续的数字，或者输出固定间隔的数字，或者输出指定格式的字符串。
```

### 知识点

```
kaiqigu@bogon:~|⇒  seq 1 5
1
2
3
4
5
kaiqigu@bogon:~|⇒  seq 1 2 5 
1
3
5


-s:指定输出的分隔符，默认为\n，即默认为回车换行。
kaiqigu@bogon:~|⇒  seq -s "+" 1 5             
1+2+3+4+5+%                                                                                   kaiqigu@bogon:~|⇒  seq -s "`echo -e "\t"`" 1 5
1	2	3	4	5	%                                                     kaiqigu@bogon:~|⇒  seq -s "  " 1 5            
1  2  3  4  5  %                                                                              kaiqigu@bogon:~|⇒  seq -s "\t" 1 5
1	2	3	4	5	% 


-w:指定为定宽输出，以最大值的位数为标准宽度。
kaiqigu@bogon:~|⇒  seq -w 99 103
099
100
101
102
103


-f:按照指定的格式输出生成的数字，默认格式为%g。
kaiqigu@bogon:~|⇒  seq -f "%g" 8 11
8
9
10
11
kaiqigu@bogon:~|⇒  seq -f "%02g" 8 11
08
09
10
11
kaiqigu@bogon:~|⇒  seq -f "%2g" 8 11 
 8
 9
10
11
kaiqigu@bogon:~|⇒  seq -f "dir%g" 1 5
dir1
dir2
dir3
dir4
dir5
```

### 实例

```
kaiqigu@bogon:~/test|⇒  mkdir $(seq -f "dir%g" 1 2) 
kaiqigu@bogon:~/test|⇒  ls
dir1 dir2
kaiqigu@bogon:~/test|⇒  seq -f "dir%g" 3 4 | xargs mkdir
kaiqigu@bogon:~/test|⇒  ls
dir1 dir2 dir3 dir4
```