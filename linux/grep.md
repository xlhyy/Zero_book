# grep


```
⇒  cat test.txt 
Hello world
hhhsssqqq
haha hehe
emmm

1)----------------------------------------------
⇒  cat test.txt | grep -c h     #匹配行数  
2

2)----------------------------------------------
⇒  cat test.txt | grep -i h     #忽略大小写匹配      
Hello world
hhhsssqqq
haha hehe

3)----------------------------------------------
⇒  cat test.txt | grep -l h     #打印出匹配到'字符串'内容的文件清单             (标准输入)
⇒  cat test.txt | grep -l haha
(标准输入)
⇒  grep -l haha test.txt 
test.txt

4)----------------------------------------------
⇒  cat test.txt | grep -n ss     #在匹配的行前面打印行号
2:hhhsssqqq

5)----------------------------------------------
⇒  cat test.txt | grep -v ss     #只显示不匹配的行      
Hello world
haha hehe
emmm

6)----------------------------------------------
⇒  cat test.txt | grep -w ha     #全字匹配的搜索
⇒  cat test.txt | grep -w haha
haha hehe

7)----------------------------------------------
⇒  cat test.txt | grep -A 1 s     #输出匹配到'字符串'内容的行和后1行
hhhsssqqq
haha hehe

8)----------------------------------------------
⇒  cat test.txt | grep -B 1 s     #输出匹配到'字符串'内容的行和前1行
Hello world
hhhsssqqq

9)----------------------------------------------
⇒  cat test.txt | grep -C 1 s     #输出匹配到'字符串'内容的行和前后1行
Hello world
hhhsssqqq
haha hehe
```
