# 算术运算


### bc(常用) (支持整数和小数运算)

```
支持小数运算
注意:在使用"除法"时，需要指定小数点精度，否则运算结果中不会包含小数，使用scale指定小数点精度。
```

```
kaiqigu@bogon:~/test|⇒  echo "1.3+2.4" | bc
3.7
kaiqigu@bogon:~/test|⇒  echo "1.3+2.333" | bc
3.633
kaiqigu@bogon:~/test|⇒  echo "5+7" | bc
12
kaiqigu@bogon:~/test|⇒  echo "5*7.2" | bc
36.0
kaiqigu@bogon:~/test|⇒  echo "8.3-3" | bc
5.3
kaiqigu@bogon:~/test|⇒  echo "8/3" | bc
2
kaiqigu@bogon:~/test|⇒  echo "scale=3; 8/3" | bc
2.666

kaiqigu@bogon:~/dododo/test|⇒  b=`echo "1+3.9" | bc`
kaiqigu@bogon:~/dododo/test|⇒  echo ${b}
4.9
```

```
kaiqigu@bogon:~/test|⇒  cat argv.sh 
#!/bin/bash
a=3
b=4
bc <<< "${a}+${b}"
echo "${a}+${b}" | bc

kaiqigu@bogon:~/test|⇒  sh argv.sh 
7
7
```


### $[算数表达式] (只支持整数运算)

```
kaiqigu@bogon:~/PycharmProjects/Superhero1_server_doc|
⇒  a=1          
kaiqigu@bogon:~/PycharmProjects/Superhero1_server_doc|
⇒  b=2
kaiqigu@bogon:~/PycharmProjects/Superhero1_server_doc|
⇒  echo $[$a+$b]
3
kaiqigu@bogon:~/PycharmProjects/Superhero1_server_doc|
⇒  echo $[2*3]
6
kaiqigu@bogon:~/PycharmProjects/Superhero1_server_doc|
⇒  echo $[2/3]
0
kaiqigu@bogon:~/PycharmProjects/Superhero1_server_doc|
⇒  echo $[2-3]
-1
```


### $((算数表达式)) (只支持整数运算)

```
kaiqigu@bogon:~/PycharmProjects/Superhero1_server_doc|
⇒  echo $((2-3))
-1
kaiqigu@bogon:~/PycharmProjects/Superhero1_server_doc|
⇒  echo $((2*3))
6
kaiqigu@bogon:~/PycharmProjects/Superhero1_server_doc|
⇒  echo $((2+3))
5
kaiqigu@bogon:~/PycharmProjects/Superhero1_server_doc|
⇒  echo $((2/3))
0
kaiqigu@bogon:~/PycharmProjects/Superhero1_server_doc|
⇒  a=1
kaiqigu@bogon:~/PycharmProjects/Superhero1_server_doc|
⇒  b=2
kaiqigu@bogon:~/PycharmProjects/Superhero1_server_doc|
⇒  echo $((${a}*${b}))
2
```


### let (只支持整数运算)

```
kaiqigu@bogon:~|⇒  let a=1+2
kaiqigu@bogon:~|⇒  echo ${a}
3
```


### expr (只支持整数运算)

```
kaiqigu@bogon:~|⇒  expr 1+2
1+2
kaiqigu@bogon:~|⇒  expr 1 + 2
3
kaiqigu@bogon:~|⇒  expr 5 \* 2
10
kaiqigu@bogon:~|⇒  expr 5 * 2 
expr: syntax error
kaiqigu@bogon:~|⇒  expr 5 / 2
2
kaiqigu@bogon:~|⇒  b=`expr 5 / 2`
kaiqigu@bogon:~|⇒  echo ${b}
2

```
