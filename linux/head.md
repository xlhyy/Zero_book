### head


```
head命令用于显示文件的开头的内容。在默认情况下，head命令显示文件的头10行内容。
```


- 语法
```
head(选项)(参数)
```


- 选项
```
-n<数字>：指定显示头部内容的行数；
-c<字符数>：指定显示头部内容的字符数；
-v：总是显示文件名的头信息；
-q：不显示文件名的头信息。
```


- 参数
```
文件列表：指定显示头部内容的文件列表。
```


- 例子
```
kaiqigu@kaiqigu-H110-4S:~/PycharmProjects/test/xiande|
⇒  head -n 1 linux_head_web.txt
http://man.linuxde.net/head

kaiqigu@kaiqigu-H110-4S:~/PycharmProjects/test/xiande|
⇒  head -n 1 -v linux_head_web.txt
==> linux_head_web.txt <==
http://man.linuxde.net/head
```
