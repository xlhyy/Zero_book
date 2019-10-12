# shift移动参数


```
kaiqigu@bogon:~/dododo/sfile|⇒  cat a2.sh 
#!/bin/bash

echo "all params: $*"
echo "old first param: $1"
shift 2
echo "new first param: $1"


kaiqigu@bogon:~/dododo/sfile|⇒  sh a2.sh a b c d
all params: a b c d
old first param: a
new first param: c
```
