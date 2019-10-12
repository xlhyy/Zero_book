# 从命令输出中提取信息的两种方式


```
# 下面两种方式用于从命令输出中提取信息，并将其赋给变量，方便在脚本中使用。
`xxx`
$(xxx)
```


```
kaiqigu@bogon:~/dododo/test|⇒  pwd
/Users/kaiqigu/dododo/test

kaiqigu@bogon:~/dododo/test|⇒  echo `pwd`
/Users/kaiqigu/dododo/test

kaiqigu@bogon:~/dododo/test|⇒  echo $(pwd)
/Users/kaiqigu/dododo/test

kaiqigu@bogon:~/dododo/test|⇒  a=`pwd`
kaiqigu@bogon:~/dododo/test|⇒  echo ${a}
/Users/kaiqigu/dododo/test

kaiqigu@bogon:~/dododo/test|⇒  a=$(pwd)
kaiqigu@bogon:~/dododo/test|⇒  echo ${a}
/Users/kaiqigu/dododo/test
```

```
kaiqigu@bogon:~|⇒  echo "1+2" | bc
3

kaiqigu@bogon:~|⇒  echo `echo "1+2" | bc`
3

kaiqigu@bogon:~|⇒  echo $(echo "1+2" | bc)
3

kaiqigu@bogon:~|⇒  a=`echo "1+2" | bc`
kaiqigu@bogon:~|⇒  echo ${a}
3

kaiqigu@bogon:~|⇒  a=$(echo "1+2" | bc)
kaiqigu@bogon:~|⇒  echo ${a}           
3
```


```
注意: expr不支持小数，而bc支持，同时bc也对参与运算的符号和数字格式无硬性要求。
```
