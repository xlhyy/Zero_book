# 逻辑运算符


### 与或非(平时使用&&和||，用双大括号就可以，当连接多个条件时不用加大括号)

```
例:
kaiqigu@bogon:~/dododo/test|⇒  [[ 3 > 1 ]] && [[ 3 > 1 ]]   
kaiqigu@bogon:~/dododo/test|⇒  [[ 3 && 1 ]]
```

```
与: "-a"或"&&"
或: "-o"或"||"
非: "!"

注意:
"&&"与"-a" 及 "||"与"-o"有所不同,"&&"和"||"有短路功能，
当在判断条件中使用"-a"或"-o"时只能用"单大括号"括起，
挡在判断条件中使用"&&"或"||"时只能用"双大括号"括起。
```

```
kaiqigu@bogon:~/dododo/test|⇒  if [ 1 -a 2 ];then echo "true";fi
true
kaiqigu@bogon:~/dododo/test|⇒  if [[ 1 && 2 ]];then echo "true";fi
true
kaiqigu@bogon:~/dododo/test|⇒  if [[ 1 -a 2 ]];then echo "true";fi
zsh: parse error: condition expected: 1
kaiqigu@bogon:~/dododo/test|⇒  if [ 1 && 2 ];then echo "true";fi 
[: ']' expected
```


### 大于小于(平时使用>和<，用双大括号就可以)

```
大于: "-gt"或">"
小于: "-lt"或"<"

注意:
在shell中，"-gt"或者"-lt"只能用于比较两个数字的大小，当我们想要比较两个字符的ASCII值时，则必须使用">"或者"<"，
而且需要注意，当使用"双中括号"进行判断时候，">"或"<"不用转义即可正常使用，当使用"单中括号"进行判断时，">"或"<"需要转义后才能正常使用。
```

