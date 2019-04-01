# 爬虫练习题


```
练习1：使用正则表达式匹配字符串，进行“中国天气网”数据爬取
示例代码
import urllib.request
import time,random,re

# url是字符串
# urllib.request.urlopen('http://www.weather.com.cn/weather1d/101070101.shtml') #url可以是字符串，或者request

# url是request
req = urllib.request.Request('http://www.weather.com.cn/weather1d/101070101.shtml') #构造Request请求（Request类的实例对象）
response = urllib.request.urlopen(req) #发送请求

print(response.status) #状态码
res = response.read().decode('utf-8') #读html页面
# time.sleep(random.randint(1,5))
# print(res)
tem_match = re.search(r'''<p.*?class="tem">.*?\s+<span>(.+)</span><em>°C</em>.*?\s+</p>''',str(res))
win_match = re.search(r'''<p.*?class="win">.*?\s+.*?\s+<span.*?class="".*?title="(.+)">(.+)</span>''',str(res))

tem = tem_match.group(1)+"℃"
print(tem)
win_dir = win_match.group(1)
win_level = win_match.group(2)
win = win_dir+":"+win_level
print(win)
运行结果

代码优化
# _*_ coding: utf-8 _*_
# @time     : 2018/5/2 15:11
# @Author   : liying
# @FileName : test_2.py
# @Software : PyCharm

import urllib.request
import lxml.etree,re

headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36",
}

req = urllib.request.Request("http://www.weather.com.cn/weather1d/101070101.shtml", headers=headers)
response = urllib.request.urlopen(req)
html = response.read().decode('utf-8')

obj_pattern = re.compile(r'<div.*?class="t">.*?<ul.*?class="clearfix">.*?<li>(.*?)<li>(.*?)</li>',re.S)
obj = [re.search(obj_pattern,html).group(1),re.search(obj_pattern,html).group(2)]
# print(obj[0])
# print(obj[1])

for i in obj:
    day_pattern = re.compile(r'<h1>(.*?)</h1>',re.S)
    wea_pattern = re.compile(r'<p.*?class="wea".*?>(.*?)</p>',re.S)
    tem_pattern = re.compile(r'<p.*?class="tem".*?>.*?<span>(.*?)</span>',re.S)
    win_pattern1 = re.compile(r'<p.*?class="win".*?>.*?<span.*?title="(.*?)">',re.S)
    win_pattern2 = re.compile(r'<p.*?class="win".*?>.*?<span.*?>(.*?)</span>',re.S)
    day = re.findall(day_pattern, i)
    wea = re.findall(wea_pattern, i)
    tem = re.findall(tem_pattern, i)
    win = re.findall(win_pattern1, i)+re.findall(win_pattern2, i)

    sun_pattern = re.compile('<p.*?class="sun sunUp".*?>.*?<span.*?>(.*?)</span>',re.S)
    if re.findall(sun_pattern, i) != []:
        sun = re.findall(sun_pattern,i)
    else:
        sun_pattern = re.compile('<p.*?class="sun sunDown".*?>.*?<span.*?>(.*?)</span>',re.S)
        sun = re.findall(sun_pattern, i)
    print("时间：",day[0])
    print("天气：",wea[0])
    print("温度：",tem[0]+"℃")
    print("风向：",win[0]+win[1])
    print(sun[0])
    print("="*20)
运行结果
```

```
练习2：使用正则表达式匹配字符串，进行“糗事百科网”数据爬取
示例代码
import urllib.request
import time,random,re

headers = {
    "User-Agent":"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36",
}

temp = ""

req = urllib.request.Request("https://www.qiushibaike.com/hot/%s"%temp,headers=headers) #构造Request请求（Request类的实例对象）
response = urllib.request.urlopen(req) #发送请求

print("状态码:",response.status) #状态码
res = response.read().decode('utf-8') #读html页面
# print(res)

text = {}

admin_match = re.findall(r'''<h2>\s+(.+)\s+</h2>''',str(res))
content_match = re.findall(r'''<div.*?class="content">\s+<span>\s+\s+(.+)\s+</span>''',str(res))
pageNum_match = re.search(r'''<span.*?class="page-numbers">\s+(.+)\s+</span>\s+.*\s+.*\s+\s+.*\s+.*\s+.*\s+<span class="next">\s+下一页\s+</span>''',str(res)).group(1)

print("共有%d个用户"%len(admin_match))
for i in range(len(admin_match)):
    text[admin_match[i]] = content_match[i]
    #待处理问题:匿名用户名字取不到的问题

    # print(admin_match[i]+":\n"+content_match[i])
    # print("="*30)
    pass
print("共有%d页"%int(pageNum_match))
print(text)
运行结果


方法优化
```


```
练习3：使用XPath匹配字符串，进行“糗事百科网”数据爬取
示例代码
import urllib.request
import lxml.etree

headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36",
}

req = urllib.request.Request("https://www.qiushibaike.com/hot", headers=headers) #构造请求
response = urllib.request.urlopen(req) #发送请求
html = response.read() #html是字符串
htmltree = lxml.etree.HTML(html)
#XML被设计用来描述数据，其焦点是数据的内容。HTML被设计用来显示数据，其焦点是数据的外观。
#个人理解：当针对的是单纯的字符串时，采用XML;
#        当针对的是读取的完整的网页代码组成的字符串时，采用HTML;
divs = htmltree.xpath('//div[starts-with(@id, "qiushi_tag_")]')
print(divs)
for div in divs:
    if div.xpath('.//div[@class="author clearfix"]/a/h2/text()') != []:
        print(div.xpath('.//div[@class="author clearfix"]/a/h2/text()')[0])
    else:
        print("匿名用户")
    print('\n'.join(div.xpath('.//div[@class="content"]/span[1]/text()')))
    # span[1]为查找指定路径下的第一个span
    # 若写为print(div.xpath('//div[@class="content"]/span/text()'))，则找出的是全部符合条件的
    # 加上.之后代表当前路径下的
运行结果
```

```
练习4：使用XPath匹配字符串，进行“中国天气网”数据爬取
示例代码
# _*_ coding: utf-8 _*_
# @time     : 2018/5/2 11:23
# @Author   : liying
# @FileName : test_2.py
# @Software : PyCharm

import urllib.request
import lxml.etree

headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36",
}

req = urllib.request.Request("http://www.weather.com.cn/weather1d/101070101.shtml", headers=headers)
response = urllib.request.urlopen(req)
html = response.read()
htmltree = lxml.etree.HTML(html)

obj = htmltree.xpath('//div[@class="t"]/ul[@class="clearfix"]/li')

for i in obj:
    day_status = i.xpath('.//h1/text()')
    wea_status = i.xpath('.//p[@class="wea"]/text()')
    tem_status = i.xpath('.//p[@class="tem"]/span/text()')+i.xpath('.//p[@class="tem"]/em/text()')
    win_status = i.xpath('.//p[@class="win"]//span/@title')+i.xpath('.//p[@class="win"]//span/text()')
    if i.xpath('.//p[@class="sun sunUp"]/span/text()') != []:
        sun_status = i.xpath('.//p[@class="sun sunUp"]/span/text()')
    else:
        sun_status = i.xpath('.//p[@class="sun sunDown"]/span/text()')
    print("时间：",day_status[0])
    print("天气：",wea_status[0])
    print("温度：","".join(tem_status))
    print("风向：","".join(win_status))
    print(sun_status[0])
    print("="*20)
运行结果
```

```
知识点补充

示例代码
# _*_ coding: utf-8 _*_
# @time     : 2018/5/2 17:43
# @Author   : liying
# @FileName : test_4.py
# @Software : PyCharm

import lxml.etree

bookstore = '''
        <bookstore>
            <book>
                <title lang="eng">Harry Potter</title>
                <price>29.99</price>
            </book>
            <book>
                <title lang="zh">XPATH 学习</title>
                <price>29.99</price>
            </book>
            <book>
                <title lang="zh">PYTHON 核心编程</title>
                <price>29.99</price>
            </book>
        </bookstore>
        '''

booktree = lxml.etree.XML(bookstore)
print(lxml.etree.tostring(booktree)) #转换成字符串
print(booktree.xpath('/bookstore/*')) #bookstore的所有子节点
print(booktree.xpath('/bookstore/book/title[@lang="eng"]/text()')) #返回titles属性为lang="eng"的文本列表
print(booktree.xpath('/bookstore/book/title/text()')) #返回所有title内的文本列表
print(booktree.xpath('/bookstore/book/title/@lang')) #返回全部title的lang属性列表
print(booktree.xpath('/bookstore/book')) #返回所有book组成的列表
print(booktree.xpath('/bookstore/book[3]/*'))
print(booktree.xpath('/bookstore/book[2]/title/text()'))
运行结果
```

```
知识点补充：string()
XML例子：

<book>
    <author>Tom <em>John</em> cat</author>
    <pricing>
        <price>20</price>
        <discount>0.8</discount>
    </pricing>
</book>
text()
经常在XPath表达式的最后看到text()，它仅仅返回所指元素的文本内容。

let $x := book/author/text()
return $x
返回的结果是Tom cat，其中的John不属于author直接的节点内容。

string()
string()函数会得到所指元素的所有节点文本内容，这些文本讲会被拼接成一个字符串。

let $x := book/author/string()
return $x
返回的内容是“Tom John cat”
day3
BeautifulSoup对象类型
BeautifulSoup将复杂HTML文档转换成一个复杂的树形结构,每个节点都是Python对象,所有对象可以归纳为4种: 
1)Tag： Tag 对象与XML或HTML原生文档中的标签对应。Tag都有名字和属性，可以通过tag.name和tag.attrs访问，其中tag.attrs是全部属性组成的字典；
2)NavigableString：字符串常被包含在tag内.BeautifulSoup用NavigableString 类来包装tag中的字符串。通过unicode()方法可以直接将NavigableString对象转换成Unicode字符串；
3)BeautifulSoup：表示的是一个文档的全部内容。大部分时候，可以把它当作Tag对象。它支持 遍历文档树和搜索文档树中描述的大部分的方法。BeautifulSoup的name属性值为“[document]”，attrs属性为空字典；
4)Comment：Comment 对象是一个特殊类型的NavigableString对象。
访问Comment需要使用标签的string属性，并且会去掉<!-和->，但是可以通过类型判断是否是Comment，if type(string) == bs4.element.Comment: 为真是Comment。
BeautifulSoup知识点


示例代码
# _*_ coding: utf-8 _*_
# @time     : 2018/5/3 9:26
# @Author   : liying
# @FileName : practise_1.py
# @Software : PyCharm

from bs4 import BeautifulSoup
import re

html_doc = '''
    <html>
    <head>
        <title>The Dormouse's story</title>
    </head>
    <body>
        <p class="title"><span>The Dormouse's story</span></p>
        <p class="story">
            Once upon a time there were three little sisters; and their names were
            <a href="http://example.com/elsie" class="sister" id="link1">Elsie</a>,
            <a href="http://example.com/lacie" class="sister" id="link2">Lacie</a> and
            <a href="http://example.com/tillie" class="sister" id="link3">Tillie</a>;
            and they lived at the bottom of a well.
        </p>
        <p class="story">...</p>
    '''

soup = BeautifulSoup(html_doc, 'lxml')
# print(soup.prettify()) #输出加载的html页面

#=========================================================================
#获取第一个标签对象(head,title,body.b,a)
# print(soup.head)
# print(soup.title)
# print(soup.body.span)
# print(soup.a)
# print(soup.body.a.name) #Tag类型节点的名字
# print(soup.body.a.attrs) #Tag类型节点的属性（返回字典）
# print(soup.body.a.attrs['href']) #Tag类型节点的属性（返回字典）
#
# print(soup.find_all('a')) #返回所有a标签列表
# print(soup.body.contents) #返回body标签的所有子节点，仅包含tag的直接子节点
# for child in soup.body.children: #children返回所有子节点迭代器，仅包含tag的直接子节点
#     print(child)
# for child in soup.head.descendants: #所有的后代对象产生器
#     print(child)
# print(soup.body.string) #输出None
# print(soup.title.string) #string是title标签内的字符串
# print(soup.body.p.span.string)
# print(soup.body.a.string)
# print(soup.body.string) #输出None
# print(soup.body.strings) #strings是产生器，包括所有字符串
# for string in soup.body.strings: #body的所有字符串（任意子节点）
#     print(string)
# for string in soup.body.stripped_strings: #body的所有字符串（任意子节点），去掉首位空白
#     print(string)
#
# print(soup.title.parent) #title的父节点
# print(soup.title.parents)
# for parent in soup.title.parents:
#     print('-'*20)
#     if parent is None:
#         print(parent)
#     else:
#         print(parent.name)
#
# print(soup.body.a.previous_sibling)
# print(soup.body.a.next_sibling.next_sibling)
# print(soup.head.next_sibling)
# print(soup.head.next_sibling.next_sibling)
# print(soup.head.next_element.next_element)
#对于next_element，比如head节点为<head><title>The Dormouse's story</title></head>,那么它的下一个节点便是 title，它是不分层次关系的
#
# print(soup.find_all(['p','title'])) #搜索全部p和title标签
# print(soup.find_all('p',"title")) #搜索全部属性为title的p标签
# attrs = {
#     'class': 'sister',
#     'id': 'link2'
# }
# print(soup.find_all('p',attrs=attrs)) #搜索全部属性为title的p标签
#
# print(soup.find_all('a',href=re.compile(r'http://example.com'),limit=2)) #最多搜索2个符合href正则表达式的a标签
# print(soup.find_all(text='Elsie')) #通过text参数搜文档中的字符串内容
# print(soup.find('title')) #相当于find_all('title',limit=1),但是find_all返回值是列表，find返回值只有一个
#注：find()搜索结果为一个数据,find_all()搜索结果为一个多个数据组成的列表
```

```
#=========================================================================
#CSS选择器，返回值是列表
print(soup.select('title')) #选择title标签
print(soup.select('body a')) #选择body下的所有a标签
print(soup.select('body span')) #选择body下任意位置的span标签
print(soup.select('body > span')) #选择body下的直接子标签span，该选择返回空列表
print(soup.select('body > p > span')) #选择body下的直接子标签p下的直接子标签span
print(soup.select('.sister')) #选择所有class="sister"的标签
print(soup.select('#link2'))
#~代表兄弟节点
print(soup.select('#link1 ~ #link3')) #选择id="link1"的兄弟节点中id="link3"的节点
print(soup.select('#link1 + #link2')) #选择id="link1"的节点的相邻兄弟节点(必须是紧挨着的下一个，挨着的上一个不可以)中id="link3"的节点
print(soup.select('a[href="http://example.com/lacie"]')) #选择href属性为xxx的a标签
print(soup.select('a[href^="http://example.com/"]')) #选择href属性以xxx开头的a标签
print(soup.select('a[href$="tillie"]')) #选择href属性以xxx结尾的a标签
print(soup.select('a[href*="example.com"]')) #选择href属性中包含xxx的a标签
知识点补充
```


```
练习1：运用BeautifulSoup匹配字符串，进行“糗事百科网”数据爬取
示例代码
# _*_ coding: utf-8 _*_
# @time     : 2018/5/3 13:48
# @Author   : liying
# @FileName : practise_2.py
# @Software : PyCharm

from bs4 import BeautifulSoup
import urllib, re

headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36",
}

req = urllib.request.Request("https://www.qiushibaike.com/hot", headers=headers) #构造请求
response = urllib.request.urlopen(req) #发送请求
html = response.read() #html是字符串
soup = BeautifulSoup(html,'lxml')

attrs = {
    'class': re.compile(r'^article'),
    'id': re.compile(r'qiushi_tag')
}
divs = soup.find_all('div',attrs=attrs)
for div in divs:
    names = div.find('h2').string

    # 第一种
    # contents = div.find('div',class_="content").span.contents
    # print(type(contents)) #<class 'list'>
    # print(contents)
    # for content in contents:
    #     print(type(content)) #(1)输出为<class 'bs4.element.NavigableString'>和<class 'bs4.element.Tag'>的多次出现，
    #                          #此时不能使用.join()对这种类型的数据组成的列表进行连接，会报错,可以使用str()将列表内元素转换为<class 'str'>类型的字符换，然后用.join()进行连接;
    #                          #(2)<class 'str'>类型的字符串组成的列表，可以用.join()连接

    # 第二种
    contents = div.find('div', class_="content").span.get_text(strip=True).replace('</br>', '\n') #.get_text()为获取所有内容
    # print(type(contents)) #<class 'str'>
    # print(contents)

    print('='*30)
    print(names)
    print(contents)
运行结果
```


```
练习2：运用BeautifulSoup匹配字符串，进行“中国天气网”数据爬取
示例代码
# _*_ coding: utf-8 _*_
# @time     : 2018/5/3 15:01
# @Author   : liying
# @FileName : practice_3.py.py
# @Software : PyCharm

import urllib.request

from bs4 import BeautifulSoup
import urllib, re

headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36",
}

req = urllib.request.Request("http://www.weather.com.cn/weather1d/101070101.shtml", headers=headers) #构造请求
response = urllib.request.urlopen(req) #发送请求
html = response.read() #html是字符串
soup = BeautifulSoup(html,'lxml')

obj = soup.find('div',attrs={'class': 't'})

day = obj.find_all('h1')
wea = obj.find_all('p',attrs={'class': 'wea'})
tem = obj.find_all('p',attrs={'class': 'tem'})
win = obj.find_all('p',attrs={'class': 'win'})
sun = obj.find_all('p',attrs={'class': re.compile(r'^sun')})

for i in range(2):
    print('='*30)
    print(day[i].string)
    print(wea[i].string)
    print(tem[i].find('span').string + '℃')
    print(win[i].find('span').attrs['title'] + win[i].find('span').string)
    print(sun[i].find('span').string)
运行结果
```

```
练习3：运用BeautifulSoup中的CSS选择器匹配字符串，进行“糗事百科网”数据爬取
示例代码
# _*_ coding: utf-8 _*_
# @time     : 2018/5/3 17:37
# @Author   : liying
# @FileName : practice_4.py
# @Software : PyCharm

import urllib.request
from bs4 import BeautifulSoup

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
html = response.read() # html字符串
soup = BeautifulSoup(html, 'lxml')

divs = soup.select('div[id^="qiushi_tag"]')
for div in divs:
   names = div.select('div h2')
   print(names[0].string)
   spans = div.select('div[class="content"] span')
   for span in spans:
      print(''.join([str(x) for x in span.contents]).strip().replace('<br/>', '\n'))
   print('---------------------------------')
运行结果
```

- Scrapy框架
```
(1)资料网址
http://scrapy-chs.readthedocs.io/zh_CN/0.24/intro/tutorial.html
http://scrapy-chs.readthedocs.io/zh_CN/1.0/intro/overview.html

(2)创建框架
在开始爬取之前，您必须创建一个新的Scrapy项目。 进入您打算存储代码的目录中，运行下列命令:

scrapy startproject tutorial

该命令将会创建包含下列内容的 tutorial 目录:

tutorial/
    scrapy.cfg
    tutorial/
        __init__.py
        items.py
        pipelines.py
        settings.py
        spiders/
            __init__.py
            ...

这些文件分别是:

    scrapy.cfg: 项目的配置文件
    tutorial/: 该项目的python模块。之后您将在此加入代码。
    tutorial/items.py: 项目中的item文件.
    tutorial/pipelines.py: 项目中的pipelines文件.
    tutorial/settings.py: 项目的设置文件.
    tutorial/spiders/: 放置spider代码的目录.
在开始爬取之前，您必须创建一个新的Scrapy项目。 进入您打算存储代码的目录中，运行下列命令:

scrapy startproject tutorial（项目名）

该命令将会创建包含下列内容的 tutorial 目录:

tutorial/
    scrapy.cfg
    tutorial/
        __init__.py
        items.py
        pipelines.py
        settings.py
        spiders/
            __init__.py
            ...

这些文件分别是:

    scrapy.cfg: 项目的配置文件,一般不需要修改
    tutorial/: 该项目的python模块。之后您将在此加入代码。
    tutorial/items.py: 项目中的item文件，类似字典，是提取的结构化数据
    tutorial/pipelines.py: 项目中的pipelines文件。检查数据完整性，完成数据的持久化（保存到数据库或文件中等）
    tutorial/settings.py: 项目的设置文件。注册pipeline，设置请求头参数（User-Agent等），延迟等。
    tutorial/spiders/: 放置spider代码的目录。需要实现Spider类，用于解析下载器返回的Response（可以用正则表达式，XPath，BeautifulSoup）。

(3)编写第一个爬虫(Spider)

Spider是用户编写用于从单个网站(或者一些网站)爬取数据的类。

其包含了一个用于下载的初始URL，如何跟进网页中的链接以及如何分析页面中的内容， 提取生成 item 的方法。

为了创建一个Spider，您必须继承 scrapy.Spider 类， 且定义以下三个属性:

    name: 用于区别Spider。 该名字必须是唯一的，您不可以为不同的Spider设定相同的名字。
    start_urls: 包含了Spider在启动时进行爬取的url列表。 因此，第一个被获取到的页面将是其中之一。 后续的URL则从初始的URL获取到的数据中提取。
    parse() 是spider的一个方法。 被调用时，每个初始URL完成下载后生成的 Response 对象将会作为唯一的参数传递给该函数。 该方法负责解析返回的数据(response data)，提取数据(生成item)以及生成需要进一步处理的URL的 Request 对象。
创建Scrapy框架的步骤
(1)在Terminal输入

注：Scrapy是自己所创建的工程名字，此条语句的作用是在该工程下创建Scrapy框架

(2)在spiders文件夹下创建文件

文件内容示例：

(3)更改setting.py文件设置


(4)执行程序
在Terminal中输入：

注意点
若输入程序执行命令时出现如下错误：

可以通过输入以下命令解决：


练习1：使用Scrapy框架对“糗事百科网”进行数据爬取
示例代码
# _*_ coding: utf-8 _*_
# @time     : 2018/5/4 11:08
# @Author   : liying
# @FileName : qiushibaike_spider.py
# @Software : PyCharm

import scrapy

class QiushibaikeSpider(scrapy.Spider):
    #1.name:用于区别Spider。该名字必须是唯一的,不可以为不同的Spider设定相同的名字
    name = 'qiushibaike'

    #2.start_urls:包含了Spider在启动时进行爬取的url列表。因此,第一个被获取到的页面将是其中之一
    #后续的URL则从初始的URL获取到的数据中提取
    start_urls = [
        'http://www.qiushibaike.com/hot/'
    ]

    #3.parse()是spider的一个方法。被调用时,每个初始URL完成下载后生成的Response对象将会作为唯一的参数传递给该函数
    #该方法负责解析返回的数据(response data),提取数据(生成item)以及生成需要进一步处理的URL的Request对象
    def parse(self, response):
        print('-'*30)
        divs = response.xpath('//div[starts-with(@id,"qiushi_tag_")]')
        for div in divs:
            #extract()返回值是标签内的unicode字符串组成的列表
            name = div.xpath('div[@class="author clearfix"]//h2/text()').extract()
            content = div.xpath('a[@class="contentHerf"]/div/span[1]/text()').extract()
            print(name,content)
运行结果

代码完善
增加了数据提交功能
spiders/qiushibaike_spider.py

# _*_ coding: utf-8 _*_
# @time     : 2018/5/4 11:08
# @Author   : liying
# @FileName : qiushibaike_spider.py
# @Software : PyCharm

import scrapy

from qiushibaike.items import QiushibaikeItem


class QiushibaikeSpider(scrapy.Spider):
    #1.name:用于区别Spider。该名字必须是唯一的,不可以为不同的Spider设定相同的名字
    name = 'qiushibaike'

    #2.start_urls:包含了Spider在启动时进行爬取的url列表。因此,第一个被获取到的页面将是其中之一
    #后续的URL则从初始的URL获取到的数据中提取
    start_urls = [
        'http://www.qiushibaike.com/hot/'
    ]

    #3.parse()是spider的一个方法，是一个回调函数。被调用时,每个初始URL完成下载后生成的Response对象将会作为唯一的参数传递给该函数
    #该方法负责解析返回的数据(response data),提取数据(生成item)以及生成需要进一步处理的URL的Request对象
    def parse(self, response):
        print('-'*30)
        divs = response.xpath('//div[starts-with(@id,"qiushi_tag_")]')
        for div in divs:
            #extract()返回值是标签内的unicode字符串组成的列表
            name = div.xpath('div[@class="author clearfix"]//h2/text()').extract()
            content = div.xpath('a[@class="contentHerf"]/div/span[1]/text()').extract()
            # print(name[0],''.join(content).strip())
            #unicode型字符串和str型字符串组成的列表都可以使用.join()进行连接
            item = QiushibaikeItem() #构造item
            item['name'] = name
            item['content'] = content
            yield item #提交item,pipelines.py文件会被调用



items.py

# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# https://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class QiushibaikeItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    name = scrapy.Field()
    content = scrapy.Field()

pipelines.py

# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://doc.scrapy.org/en/latest/topics/item-pipeline.html

from scrapy.exceptions import DropItem

class QiushibaikePipeline(object):
    def process_item(self, item, spider):
        if item['name'] and item['content']:
            # print(item['name'])
            # print(item['content'])
            return item
        else:
            raise DropItem('Invalied item %s %s' %(item['name'], item['content'])) #抛出异常
setting.py

qiushibaike_main.py
# _*_ coding: utf-8 _*_
# @time     : 2018/5/4 15:56
# @Author   : liying
# @FileName : qiushibaike_main.py
# @Software : PyCharm

from scrapy import cmdline

cmdline.execute(['scrapy', 'crawl', 'qiushibaike'])

这个文件的作用是使程序可以直接通过

运行，而不必在命令行输入指令。
增加了翻页及数据存储到文件功能
spiders/qiushibaike_spider.py
# _*_ coding: utf-8 _*_
# @time     : 2018/5/4 11:08
# @Author   : liying
# @FileName : qiushibaike_spider.py
# @Software : PyCharm

import scrapy
from qiushibaike.items import QiushibaikeItem

class QiushibaikeSpider(scrapy.Spider):
    #1.name:用于区别Spider。该名字必须是唯一的,不可以为不同的Spider设定相同的名字
    name = 'qiushibaike'

    allowed_domains = ["qiushibaike.com"] #如果请求不属于该域名,无法爬取

    #2.start_urls:包含了Spider在启动时进行爬取的url列表。因此,第一个被获取到的页面将是其中之一
    #后续的URL则从初始的URL获取到的数据中提取
    start_urls = [
        'http://www.qiushibaike.com/hot/'
    ]

    #3.parse()是spider的一个方法。被调用时,每个初始URL完成下载后生成的Response对象将会作为唯一的参数传递给该函数
    #该方法负责解析返回的数据(response data),提取数据(生成item)以及生成需要进一步处理的URL的Request对象
    def parse(self, response):
        print('-'*30)
        divs = response.xpath('//div[starts-with(@id,"qiushi_tag_")]')
        for div in divs:
            #extract()返回值是标签内的unicode字符串组成的列表
            name = div.xpath('div[@class="author clearfix"]//h2/text()').extract()
            content = div.xpath('a[@class="contentHerf"]/div/span[1]/text()').extract()
            # print(name[0],''.join(content).strip())
            #unicode型字符串和str型字符串组成的列表都可以使用.join()进行连接
            item = QiushibaikeItem() #构造item
            item['name'] = name
            item['content'] = content
            yield item #提交item,pipelines.py文件会被调用
        next_page_href = response.xpath('//a[span/@class="next"]/@href').extract()
        # <a href="/hot/page/4/" rel="nofollow">
        #   <span class="page-numbers">
        #       4
        #   </span>
        # </a>
        #构造Request请求,指定回调函数是self.parse,并提交
        next_page_text = response.xpath('//a/span[@class="next"]/text()').extract()
        if u'下一页' in next_page_text[0]:
            # yield scrapy.http.Request('https://www.qiushibaike.com' + next_page_href[0],callback=self.parse)
            yield scrapy.http.Request(response.urljoin(next_page_href[0]), callback=self.parse)
        print(next_page_href)
pipelines.py
# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://doc.scrapy.org/en/latest/topics/item-pipeline.html

from scrapy.exceptions import DropItem
import json

class QiushibaikePipeline(object):
    def __init__(self):
        self.file = open('qiushibaike.json', 'a+')

    def process_item(self, item, spider):
        if item['name'] and item['content']:
            # print(item['name'])
            # print(item['content'])
            json.dump(dict(item), self.file, ensure_ascii=False) #将字典转换成字符串
                                                                 #ensure_ascii默认是True,以ascii码形式写入
            return item
        else:
            raise DropItem('Invalied item %s %s' %(item['name'], item['content'])) #抛出异常
setting.py

运行结果

增加图片下载功能
setting.py


图像管道避免下载最近已经下载的图片。使用 FILES_EXPIRES (或 IMAGES_EXPIRES) 设置可以调整失效期限，可以用天数来指定。
spiders/qiushibaike_spider.py
# _*_ coding: utf-8 _*_
# @time     : 2018/5/4 11:08
# @Author   : liying
# @FileName : qiushibaike_spider.py
# @Software : PyCharm

import scrapy
from qiushibaike.items import QiushibaikeItem

class QiushibaikeSpider(scrapy.Spider):
    #1.name:用于区别Spider。该名字必须是唯一的,不可以为不同的Spider设定相同的名字
    name = 'qiushibaike'

    allowed_domains = ["qiushibaike.com"] #如果请求不属于该域名,无法爬取

    #2.start_urls:包含了Spider在启动时进行爬取的url列表。因此,第一个被获取到的页面将是其中之一
    #后续的URL则从初始的URL获取到的数据中提取
    start_urls = [
        'http://www.qiushibaike.com/hot/'
    ]

    #3.parse()是spider的一个方法。被调用时,每个初始URL完成下载后生成的Response对象将会作为唯一的参数传递给该函数
    #该方法负责解析返回的数据(response data),提取数据(生成item)以及生成需要进一步处理的URL的Request对象
    def parse(self, response):
        print('-'*30)
        divs = response.xpath('//div[starts-with(@id,"qiushi_tag_")]')
        for div in divs:
            #extract()返回值是标签内的unicode字符串组成的列表
            name = div.xpath('div[@class="author clearfix"]//h2/text()').extract()
            content = div.xpath('a[@class="contentHerf"]/div/span[1]/text()').extract()
            # print(name[0],''.join(content).strip())
            #unicode型字符串和str型字符串组成的列表都可以使用.join()进行连接
            imageurl = div.xpath('div[@class="thumb"]/a/img/@src').extract()

            item = QiushibaikeItem() #构造item
            item['name'] = name
            item['content'] = content
            for url in imageurl:
                print('url = '+url)
                item['image_urls'] = ['https:'+url] #注意:该项是列表,而不是字符串
            yield item #提交item,pipelines.py文件会被调用

        # next_page_href = response.xpath('//a[span/@class="next"]/@href').extract()
        # <a href="/hot/page/4/" rel="nofollow">
        #   <span class="page-numbers">
        #       4
        #   </span>
        # </a>
        #构造Request请求,指定回调函数是self.parse,并提交
        # next_page_text = response.xpath('//a/span[@class="next"]/text()').extract()
        # if u'下一页' in next_page_text[0]:
        #     # yield scrapy.http.Request('https://www.qiushibaike.com' + next_page_href[0],callback=self.parse)
        #     yield scrapy.http.Request(response.urljoin(next_page_href[0]), callback=self.parse)
        # print(next_page_href)
items.py
# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# https://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class QiushibaikeItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    name = scrapy.Field()
    content = scrapy.Field()
    image_urls = scrapy.Field()
    images = scrapy.Field()

pipelines.py
# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://doc.scrapy.org/en/latest/topics/item-pipeline.html

import scrapy
from scrapy.exceptions import DropItem
import json
from scrapy.pipelines.images import ImagesPipeline

class QiushibaikePipeline(object):
    def __init__(self):
        self.file = open('qiushibaike.json', 'a+')

    def process_item(self, item, spider):
        if item['name'] and item['content']:
            # print(item['name'])
            # print(item['content'])
            json.dump(dict(item), self.file, ensure_ascii=False) #将字典转换成字符串
                                                                 #ensure_ascii默认是True,以ascii码形式写入
            return item
        else:
            raise DropItem('Invalied item %s %s' %(item['name'], item['content'])) #抛出异常

class QiushibaikeImagePipeline(ImagesPipeline):
    def get_media_requests(self, item, info):
        for image_url in item['image_urls']:
            print(image_url)
            yield scrapy.Request(image_url)

    def item_completed(self, results, item, info):
        image_paths = [x['path'] for ok, x in results if ok]
        if not image_paths:
            raise DropItem("Item contains no images")
        item['image_paths'] = image_paths
        print(image_paths)
        return item
运行结果

简单的文件导出
setting.py

输出结果:



输出结果:
```


- scrapy终端(scrapy shell)

```
简介
Scrapy终端是一个交互终端，供您在未启动spider的情况下尝试及调试您的爬取代码。 其本意是用来测试提取数据的代码，不过您可以将其作为正常的Python终端，在上面测试任何的Python代码。
该终端是用来测试XPath或CSS表达式，查看他们的工作方式及从爬取的网页中提取的数据。 在编写您的spider时，该终端提供了交互性测试您的表达式代码的功能，免去了每次修改后运行spider的麻烦。
启动终端
(1)scrappy shell <url> 启动终端并请求url
(2)或者先启动终端，后发出请求：
scarpy shell
headers = {…}
scrappy.Request(url, headers=headers)


使用终端
(1)shelp() 打印可用对象和命令列表

(2)fetch(request_or_url) 根据定义的获取新的response，并更新对象，redirect=False是不更新。

(3)view(response) 在本机的浏览器打开给定的response。 其会在response的body中添加一个 <base> tag ，使得外部链接(例如图片及css)能正确显示。 注意，该操作会在本地创建一个临时文件，且该文件不会被自动删除。


request和response的属性
(1)request包括url，method，headers，body，meta等方法
(2)response包括url，status，headers，body，request，meta，flags等属性




提取网页中的数据
response.xpath(‘//div[starts-with(@id, “qiushi_tag”)]’) # 使用XPath选择节点
response.css('div[id^=qiushi_tag]') # 使用CSS选择器选择节点
```
