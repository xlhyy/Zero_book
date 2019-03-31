### shell脚本常用知识点


```
1. basename(获取路径中 去除目录后剩下的名字)
kaiqigu@kaiqigu-H110-4S:~|⇒  basename /home/kaiqigu/PycharmProjects 
PycharmProjects
kaiqigu@kaiqigu-H110-4S:~|⇒  basename ./PycharmProjects/Superhero1
Superhero1
kaiqigu@kaiqigu-H110-4S:~|⇒  basename ./PycharmProjects/Superhero1/backend/run.py
run.py

2. dirname(获取路径中 目录)
kaiqigu@kaiqigu-H110-4S:~|⇒  dirname /home/kaiqigu/PycharmProjects 
/home/kaiqigu
kaiqigu@kaiqigu-H110-4S:~|⇒  dirname ./PycharmProjects/Superhero1/backend/run.py
./PycharmProjects/Superhero1/backend

3. 版本号格式判断
# example r0.00.00.00
reg="^r[0-9]\.[0-9]{1,2}\.[0-9]{1,2}\.[0-9]{1,2}$"

if [ ! `echo $tag | grep -E $reg` ]; then
    echo "version error example r0.0.0.0"
    exit 1
fi

4. 获取当前文件的工作路径
kaiqigu@kaiqigu-H110-4S:~|⇒  echo $(cd "$(dirname "$0")"; pwd)
/home/kaiqigu

5. rm -rf 路径
    删除一个目录中的一个或多个文件或目录，它也可以将某个目录及其下的所有文件及子目录均删除。

rm的参数:
-f：强制删除，忽略不存在的文件，从不给出提示。
-i：交互模式删除文件，删除文件前给出提示。
-r：递归的删除目录下面文件以及子目录下文件。
-R：递归的删除目录下面文件以及子目录下文件。
-v：显示运行时详细信息。

6. linux中grep命令的用法
grep命令的常用格式: grep [选项] "模式" [文件]

1)常用选项
-E	开启扩展的正则表达式
-i	忽略大小写
-v	反过来，只打印没有匹配的，而匹配的反而不打印
-n	显示行号
-w	被匹配的文本只能是单词，而不能是单词中的某一部分，比如可以使用-w来避免搜索like时匹配到liker
-c	现实有多少行被匹配，比如使用-cv选项是显示有多少行没有被匹配到
-o	只显示被模式匹配到的字符串
--color	将匹配到的内容以颜色高亮显示
-A n	显示匹配到的字符串所在的行及其后n行
-B n	显示匹配到的字符串所在的行及其前n行
-C n	显示匹配到的字符串所在的行及其前后各n行

2)模式部分
=1=直接输入要匹配的字符串
=2=使用基本正则表达式
.		任意一个字符
[abc]		匹配一个字符，这个字符必须是abc中的一个
[a-zA-Z]	匹配一个字符，这个字符必须是a-z或A-Z中的一个
[^123]		匹配一个字符，这个字符是除了1,2,3以外的所有字符
----------
[A-Za-z]	[[:alpha:]]
[0-9]		[[:digit:]]
[A-Za-z0-9]	[[:alnum:]]
tab,space等空白符 [[:space:]]
[A-Z]		[[:upper:]]
[a-z]		[[:lower:]]
标点符号	[[:punct:]]

=3=匹配次数
\{m,n\}		匹配其前面出现的字符至少m次，至多n次
\?		匹配其前面出现的内容0次或1次，等价于\{0,1\}
*		匹配其前面出现的内容任意次，等价于\{0,\}

=4=位置锚定
^		锚定行首
$		锚定行尾，技巧:"^$"用于匹配空白行
\b或\<		锚定单词的词首，如"\blike"会匹配到liker
\b或\>		锚定单词的词尾，如"\blike\b"会匹配到like
\B		与\b作用相反

=5=分组及引用
\(string\)	将string作为一个整体方便后面引用
	\1:引用第1个左括号及其对应的右括号所匹配的内容
	\2:引用第2个左括号及其对应的右括号所匹配的内容
	\n:引用第n个左括号及其对应的右括号所匹配的内容
例: grep "^\([[:alpha:]]\).*\1$" tools.sh
作用: 以相同字母开始并结尾的行(因为 \([[:alpha:]]\) 与 \1 相同)

3)扩展的正则表达式(注意要使用拓展的正则表达式要加-E选项,或者直接使用egrep)
=1=匹配字符
与正则表达式一样

=2=匹配次数
*	和基本正则表达式一样
?	与基本正则表达式相比没有\
{m,n}	与基本正则表达式相比没有\
+	匹配其前面的字符至少一次，相当于{1,}

=3=位置锚定
和基本正则表达式一样

=4=分组及引用
(string)		相比基本正则表达式没有\
	\1	引用部分和基本正则表达式一样
	\n	引用部分和基本正则表达式一样

=5=或者
比如a|b,(C|c)at

注1：默认情况下，正则表达式的匹配工作在贪婪模式下，也就是说它会尽可能长地去匹配，比如某一行有字符串 abacb，如果搜索内容为 "a.*b" 那么会直接匹配 abacb这个串，而不会只匹配ab或acb。

注2：所有的正则字符，如 [ 、* 、( 等，若要搜索 * ，而不是想把 * 解释为重复先前字符任意次，可以使用 \* 来转义。

7. 不将注释打印
cat tools.sh | grep -v '^#'
例:
#!/bin/bash

HOSTS=`cat pub_android_srv.txt | grep -v '^#'`

cmd=$1

for host in $HOSTS
do
    echo $host
    if [ "x$cmd" == "xrestart" ];then
        sleep 1
    fi
    ssh admin@$host /usr/local/bin/supervisorctl -u user -p 123 $cmd all
done

8. rsync
/usr/bin/rsync --dry-run -aI --progress --recursive --exclude='upload_xls' --exclude='.git' --exclude='logs' --exclude='test/local_config.py' $temp_dir "admin@$THOST:/data/sites/genesis_backend/"

/usr/bin/rsync -aI --progress --recursive --exclude='upload_xls' --exclude='.git' --exclude='logs' --exclude='test/local_config.py' $temp_dir "admin@${host}:/data/sites/genesis_backend/"

9. 输出格式化日期
⇒  date +"%F %T"   
2018-10-11 21:20:39

例:
d=`date  +"%F %T"`
```
