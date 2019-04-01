# 正则表达式爬虫

- 正则表达式进行匹配的流程


- 正则表达式函数

```
1.re.match(pattern, string, flags=0)
作用：尝试从字符串的起始位置匹配一个模式，如果不是起始位置匹配成功的话，match()就返回None。
2.re.search(pattern, string, flags=0)
作用：扫描整个字符串并返回第一个成功的匹配。

re.match与re.search的区别：
re.match只匹配字符串的开始，如果字符串开始不符合正则表达式，则匹配失败，函数返回None；而re.search匹配整个字符串，直到找到一个匹配。

3.re.sub(pattern, repl, string, count=0, flags=0)
作用：用于替换字符串中的匹配项
参数：
pattern : 正则中的模式字符串。
repl : 替换的字符串，也可为一个函数。
string : 要被查找替换的原始字符串。
count : 模式匹配后替换的最大次数，默认 0 表示替换所有的匹配。
4.re.compile(pattern[, flags])
作用：用于编译正则表达式，生成一个正则表达式（Pattern）对象。 
参数：
pattern : 一个字符串形式的正则表达式
flags : 可选，表示匹配模式，比如忽略大小写，多行模式等，具体参数为：
re.I(re.IGNORECASE): 忽略大小写（括号内是完整写法，下同）
re.M(MULTILINE): 多行模式，改变'^'和'$'的行为
re.S(DOTALL): 匹配包括换行(\n)的任意字符，改变'.'的行为
re.L(LOCALE): 使预定字符类 \w \W \b \B \s \S 取决于当前区域设定
re.U(UNICODE): 使预定字符类 \w \W \b \B \s \S \d \D 取决于unicode定义的字符属性
re.X(VERBOSE): 详细模式。这个模式下正则表达式可以是多行，忽略空白字符，并可以加入注释。

5.split(string[, maxsplit]) | re.split(pattern, string[, maxsplit]): 
作用：按照能够匹配的子串将string分割后返回列表。maxsplit用于指定最大分割次数，不指定将全部分割。 
6.findall(string[, pos[, endpos]]) | re.findall(pattern, string[, flags]): 
作用：搜索string，以列表形式返回全部能匹配的子串。 
7.sub(repl, string[, count]) | re.sub(pattern, repl, string[, count]): 
作用：使用repl替换string中每一个匹配的子串后返回替换后的字符串。
参数： 
repl：当repl是一个字符串时，可以使用\id或\g<id>、\g<name>引用分组，但不能使用编号0。 当repl是一个方法时，这个方法应当只接受一个参数（Match对象），并返回一个字符串用于替换（返回的字符串中不能再引用分组）。 
count：用于指定最多替换次数，不指定时全部替换。 
8.subn(repl, string[, count]) |re.sub(pattern, repl, string[, count]): 
作用：返回 (sub(repl, string[, count]), 替换次数)。 
```


- Python支持的正则表达式元字符和语法：


```
#糗事百科，正则表达式
import urllib.request
import time
import random
import re

headers = {
    # 'Host':'www.qiushibaike.com',
    # 'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
    # 'Accept-Encoding': 'gzip, deflate',
    # 'Accept-Language': 'en-US,en;q=0.5',
    # 'Connection': 'keep-alive',
	# 'Referer': 'https://www.qiushibaike.com/hot/',
	'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36'
}

req = urllib.request.Request('https://www.qiushibaike.com/hot/', headers=headers) # 构造Request请求
response = urllib.request.urlopen(req) # 发送请求
html = response.read().decode('utf-8')
namepattern = re.compile(r'<div.*?class="author clearfix">.*?<a.*?>.*?<h2>(.*?)</h2>.*?</a>', re.S)
names = re.findall(namepattern, html)
print([x.strip() for x in names])
contentpattern = re.compile(r'<a.*?class="contentHerf".*?>.*?<div.*?>.*?<span>(.*?)</span>.*?</div>', re.S)
contents = re.findall(contentpattern, html)
for str in [x.strip() for x in [y.replace('<br/>', '\n') for y in contents]]:
	print('-----------------------------')
	print(str)
```
