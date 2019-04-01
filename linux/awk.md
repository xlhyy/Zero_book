# awk


- AWK是一种处理文本文件的语言，是一个强大的文本分析工具。

- awk '{[pattern] action}' {filenames}

```
⇒  cat log.txt
2 this is a test
3 Are you like awk
This's a test
10 There are orange,apple,mongo

⇒  awk '{print $1,$4}' log.txt
2 a
3 like
This's
10 orange,apple,mongo

⇒  awk '{printf "%-8s %-10s\n",$1,$4}' log.txt
2        a         
3        like      
This's             
10       orange,apple,mongo

```