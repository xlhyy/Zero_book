# 常用的变量处理及字符串操作

```
1. 获取变量的长度(字符串长度)
2. 对变量值进行截取(截取字符串)
3. 替换变量值中的某段字符
4. 删除变量值中的某段字符
5. 对变量值进行大小写转换
6. 当变量值为空时，对变量进行一些操作
```


## 获取变量长度

```
kaiqigu@bogon:~/dododo/test|⇒  s="qweqweqwe" 
kaiqigu@bogon:~/dododo/test|⇒  echo ${#s}
9
kaiqigu@bogon:~/dododo/test|⇒  echo ${s}
qweqweqwe
```


## 截取变量

### 从指定位置截取字符串，截取到字符串的末尾

```
从指定位置截取字符串，截取到字符串的末尾

kaiqigu@bogon:~/dododo/test|⇒  website="www.zsythink.net"
kaiqigu@bogon:~/dododo/test|⇒  echo ${website:4}
zsythink.net
```

```
从倒数第4个字符开始截取，直到字符串的末尾

kaiqigu@bogon:~/dododo/test|⇒  website="www.zsythink.net"
kaiqigu@bogon:~/dododo/test|⇒  echo ${website:0-4}
.net
kaiqigu@bogon:~/dododo/test|⇒  echo ${website: -4}
.net

注意:上述例子中"0-4"中的"0"可以使用"空格"代替。
```


### 从指定位置截取字符串，并且截取指定的长度

```
kaiqigu@bogon:~/dododo/test|⇒  website="www.zsythink.net"
kaiqigu@bogon:~/dododo/test|⇒  echo ${website:4:8}       
zsythink
kaiqigu@bogon:~/dododo/test|⇒  echo ${website:0-9:5}
think
```


### 掐头去尾截取 - 掐头截取

```
掐头截取:
(1)打印时删除字符串中从左向右第一个遇到的char，以及其左侧的字符。
${var#*char}

(2)打印时删除字符串中从左向右最后一个遇到的char，以及其左侧的字符。
${var##*char}
```

```
(1)
kaiqigu@bogon:~/dododo/test|⇒  website="www.zsythink.net"
kaiqigu@bogon:~/dododo/test|⇒  echo ${website#*.}        
zsythink.net
kaiqigu@bogon:~/dododo/test|⇒  echo ${website#*zs}
ythink.net

(2)
kaiqigu@bogon:~/dododo/test|⇒  echo ${website##*.}
net
kaiqigu@bogon:~/dododo/test|⇒  echo ${website##*zs}
ythink.net
```


### 掐头去尾截取 - 去尾截取

```
去尾截取:
(1)打印时删除字符串中从右向左第一个遇到的char，以及其右侧的字符。
${var%char*}

(2)打印时删除字符串中从右向左最后一个遇到的char，以及其右侧的字符。
${var%%char*}
```

```
(1)
kaiqigu@bogon:~/dododo/test|⇒  website="www.zsythink.net"
kaiqigu@bogon:~/dododo/test|⇒  echo ${website%z*}
www.
kaiqigu@bogon:~/dododo/test|⇒  echo ${website%sy*}
www.z

(2)
kaiqigu@bogon:~/dododo/test|⇒  echo ${website%%t*}
www.zsy
kaiqigu@bogon:~/dododo/test|⇒  echo ${website%%sy*}
www.z
```


## 替换变量中的字符串

### 替换字符串中遇到的第一个特定字符

```
kaiqigu@bogon:~/dododo/test|⇒  s="www.abc.www.def" 
kaiqigu@bogon:~/dododo/test|⇒  echo ${s/www/linux}
linux.abc.www.def
```


### 替换字符串中遇到的所有特定字符

```
kaiqigu@bogon:~/dododo/test|⇒  s="www.abc.www.def" 
kaiqigu@bogon:~/dododo/test|⇒  echo ${s//www/linux} 
linux.abc.linux.def
```


### 对行首或行尾的字符串进行替换

```
kaiqigu@bogon:~/dododo/test|⇒  s="www.abc.www.def"  
kaiqigu@bogon:~/dododo/test|⇒  echo ${s/#www/linux}
linux.abc.www.def
kaiqigu@bogon:~/dododo/test|⇒  echo ${s/%def/linux}
www.abc.www.linux
```


## 删除变量中的字符串


### 删除变量中遇到的第一个特定字符

```
kaiqigu@bogon:~/dododo/test|⇒  s="www.abc.www.def" 
kaiqigu@bogon:~/dododo/test|⇒  echo ${s/abc.}      
www.www.def
```


### 删除变量中遇到的所有特定字符

```
kaiqigu@bogon:~/dododo/test|⇒  s="www.abc.www.def"
kaiqigu@bogon:~/dododo/test|⇒  echo ${s//www.}
abc.def
```


### 对行首或行尾的字符串进行删除

```
kaiqigu@bogon:~/dododo/test|⇒  s="www.abc.www.def"
kaiqigu@bogon:~/dododo/test|⇒  echo ${s/#www}     
.abc.www.def
kaiqigu@bogon:~/dododo/test|⇒  echo ${s/%def}
www.abc.www.
```


## 字符串大小写转换

```
kaiqigu@bogon:~/dododo/test|⇒  s=$(echo {a..k};echo {L..Z})
kaiqigu@bogon:~/dododo/test|⇒  echo ${s}                   
a b c d e f g h i j k
L M N O P Q R S T U V W X Y Z
```

```
kaiqigu@bogon:~/dododo/test|⇒  echo ${s} | tr '[a-z]' '[A-Z]'
A B C D E F G H I J K
L M N O P Q R S T U V W X Y Z
kaiqigu@bogon:~/dododo/test|⇒  echo ${s} | tr '[A-Z]' '[a-z]'
a b c d e f g h i j k
l m n o p q r s t u v w x y z
```


## 当变量值为空或者非空时操作变量

### ${var:=value}

```
上述语法表示如果var为空，则返回value, 并将value赋值给var,如果var不为空，则返回var本身的值。
var不为空时，var值不会被改变，var为空时，var的值会被设置成指定值。


kaiqigu@bogon:~/dododo/test|⇒  echo ${test:="abc"}   
abc
kaiqigu@bogon:~/dododo/test|⇒  echo ${test}       
abc
```


### ${var:-value}

```
上述语法表示如果var为空，则返回value，如果var不为空，则返回var的值。
无论var是否为空，var本身的值不会改变。


kaiqigu@bogon:~/dododo/test|⇒  echo ${testvar2}      

kaiqigu@bogon:~/dododo/test|⇒  echo ${testvar2:-"ttt"}
ttt
kaiqigu@bogon:~/dododo/test|⇒  echo ${testvar2}       

```


### ${var:+value}

```
上述语法表示如果var不为空，则返回value，如果var为空，则返回空值。
无论var是否为空，var本身的值不会改变。


kaiqigu@bogon:~/dododo/test|⇒  echo ${testvar} 
aaa
kaiqigu@bogon:~/dododo/test|⇒  echo ${testvar:+"abc"}
abc
kaiqigu@bogon:~/dododo/test|⇒  echo ${testvar}       
aaa
```


### ${var:?error_ info}

```
上述语法表示如果var为空，那么在当前终端打印error_ info, 如果var的值不为空，则返回var的值。
无论var是否为空，var本身的值都不会改变。


kaiqigu@bogon:~/dododo/test|⇒  echo ${testvar3}      

kaiqigu@bogon:~/dododo/test|⇒  echo ${testvar3:?"var is null"}
zsh: testvar3: "var is null"
```


### 补充

```
(1)
kaiqigu@bogon:~/dododo/test|⇒  if [ -z "$testvar" ];then testvar="test";fi
kaiqigu@bogon:~/dododo/test|⇒  echo ${testvar}
test

(2)
kaiqigu@bogon:~/dododo/test|⇒  testvar="aaa"    
kaiqigu@bogon:~/dododo/test|⇒  echo ${testvar="test"}
aaa

(1)与(2)用法相同。
```
