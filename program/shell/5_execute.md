# 执行命令的三种方式


```
#!/bin/bash

data
# 下面两种方式用于从命令输出中提取信息，并将其赋给变量，方便在脚本中使用。
echo `data`
echo $(data)
```


```
kaiqigu@bogon:~/dododo/test|⇒  expr 1 + 2
3
kaiqigu@bogon:~/dododo/test|⇒  echo `expr 1 + 2` 
3
kaiqigu@bogon:~/dododo/test|⇒  echo $(expr 1 + 2)
3
```
