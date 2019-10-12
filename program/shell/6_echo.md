# echo选项


### echo -n

```
# echo -n 不换行输出

kaiqigu@bogon:~/dododo/test|⇒  echo -n 123;echo 456
123456

kaiqigu@bogon:~/dododo/test|⇒  cat tt.sh 
#!/bin/bash

echo "aaa"
echo "bbb"

echo -n "aaa"
echo "bbb"
kaiqigu@bogon:~/dododo/test|⇒  ./tt.sh 
aaa
bbb
aaabbb

注意: 此处使用sh执行则无法实现，直接执行可执行文件可以实现。
```


### echo -e

```
# echo -e 处理特殊字符:(若字符串中出现以下字符，则特别加以处理，而不会将它当成一般文字输出)
# \a 发出警告声
# \b 删除前一个字符
# \c 最后不加上换行符号
# \f 换行但光标仍旧停留在原来的位置
# \n 换行且光标移至行首
# \r 光标移至行首，但不换行
# \t 插入tab
# \v 与\f相同
# \  插入\字符
# \nnn 插入nnn(八进制)所代表的ASCII字符

echo -e "a\bdddd"
echo -e "a\ndddd"
```

### 输出特殊字符需要用\符号转义

```
kaiqigu@bogon:~/dododo/test|⇒  echo "\"hello\""
"hello"
```
