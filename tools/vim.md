# vim


## vim下查找

```
vim下查找含有red和blue的行:
red.*blue\|blue.*red
```


## vim编辑错误

```
在vi/vim中输入方向键却被被转化为A B C D
echo "set nocp" >> ~/.vimrc
source ~/.vimrc
```


## vim快捷键

```
1. vim复制时保留原有格式
进入vim后，按Esc，输入 :set paste
执行后也可以关闭它 :set nopaste
如果想看它的详细情况，还可以 :h paste

2. vim的tab键设定
文件: sudo vi /etc/vim/vimrc

set tabstop=a       设置一个tab的长度显示为a个空格长度

set softtabsstop=b  表示在编辑模式的时候按退格键(Backspace)的时候退回缩进的长度，当使用expandtab时特别有用。

set shiftwidth=c    设置在编辑模式(vim进入后的默认模式)下使用(>>或<<)缩进代码时所占的空白位的长度(一般设置成跟softtabstop一样)

set expandtab       将tab所占的空白位用空格填充
set noexpandtab     用制表符表示一个缩进

3. 查找
/xxx(?xxx)  搜索匹配xxx的字符串，/表示向下查找，?表示向上查找，xxx可以时正规表达式
*(#)        匹配光标所在单词
g*(g#)      匹配包含光标所在单词的所有字符串
gd          本命令查找与光标所在单词相匹配的单词, 并将光标停留在文档的非注释段中第一次出现这个单词的地方
%           本命令查找与光标所在处相匹配的反括号, 包括 () [] {}

4. 快速移动光标
w(e)    移动光标到下一个单词
b       移动光标到上一个单词

0       移动光标到本行最开头
$       移动光标到本行结尾处

gg      移动光标到文档首行
G       移动光标到文档尾行

H       移动光标到屏幕的首行
M       移动光标到屏幕的中间一行
L       移动光标到屏幕的尾行

5. 拷贝，删除与粘贴
yw      拷贝从当前光标到光标所在单词结尾的内容
dw      删除

y0      拷贝从当前光标到光标所在行首的内容
d0      删除

y$      拷贝从当前光标到光标所在行尾的内容        
d$      删除

yfa     拷贝从当前光标到光标后面的第一个a字符之间的内容
dfa     删除
     
6. TAB
<<          光标所在行向左移动一个tab
>>          光标所在行向右移动一个tab
5>>         光标后5行向右移动一个tab
:12,24>     12-14行的数据都向右移动一个tab
:12,24>>    12-14行的数据都向右移动两个tab
```