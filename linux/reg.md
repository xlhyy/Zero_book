# 正则表达式


```
kaiqigu@bogon:~/test|⇒  cat test.txt 
aasdasdasdasd

kaiqigu@bogon:~/test|⇒  grep "qe$" test.txt 
qweqwewqe
kaiqigu@bogon:~/test|⇒  grep "\bqe" test.txt
kaiqigu@bogon:~/test|⇒  grep "qe\b" test.txt
qweqwewqe
kaiqigu@bogon:~/test|⇒  grep "qw\b" test.txt
kaiqigu@bogon:~/test|⇒  grep "\bqw" test.txt
qweqwewqe
```

### 知识点

```
^:表示锚定行首，此字符后面的任意内容必须出现在行首，才能匹配。

$:表示锚定行尾，此字符前面的任意内容必须出现在行尾，才能匹配。

^$:表示匹配空行，这里所描述的空行表示"回车"，而"空格"或"tab"等 都不能算作此处所描述的空行。

^abc$:表示abc独占一行时，会被匹配到。

\<或者\b :匹配单词边界，表示锚定词首，其后面的字符必须作为单词首部出现。

\>或者\b :匹配单词边界，表示锚定词尾，其前面的字符必须作为单词尾部出现。

\B: 匹配非单词边界，与\b正好相反。
```
