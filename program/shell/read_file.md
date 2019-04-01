# 从文件中读取


```
#!/bin/bash

<<COMMENT
    每次调用read命令，它都会从文件中读取一行文本。当文件中再没有内容时，read命令会退出并返回非零推出状态码
    while循环会持续通过read命令处理文件中的行，直到read命令以非零退出状态码运行
COMMENT

count=1
cat test | while read line
do
	echo "Line $count: $line"
	count=$[ $count + 1 ]
done

echo "Finished processing the file"

<<COMMENT
Line 1: The quick brown dog jumps over the lazy fox.
Line 2: This is a test, this is only a test.
Line 3: O Romeo, Romeo! wherefore art thou Romeo?
Line 4: 
Finished processing the file
COMMENT
```
