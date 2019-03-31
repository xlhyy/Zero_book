### XPath爬虫

- XPath简介
```
XPath 是一门在 XML 文档中查找信息的语言。XPath 用于在 XML 文档中通过元素
和属性进行导航。
这里我们使用lxml库。
参考资料：http://www.zvon.org/xxl/XPathTutorial/General_chi/examples.html
```


```
选取节点：
XPath 使用路径表达式在 XML 文档中选取节点。节点是通过沿着路径或者 step 来选取的。
下面列出了最有用的路径表达式:

例如：
import lxml.etree

bookstore = '''
		<bookstore>
			<book>
				<title lang="eng">Harry Potter</title>
				<price>29.99</price>
			</book>
			<book>
				<title lang="zh">XPATH 学习</title>
				<price>39.95</price>
			</book>
			<book>
				<title lang="zh">PYTHON 核心编程</title>
				<price>69.95</price>
			</book>
		</bookstore>
		'''

booktree = lxml.etree.XML(bookstore)
# print(lxml.etree.tostring(booktree)) # 转换成字符串
print(booktree.xpath('/bookstore/*')) # bookstore的所有子节点
print(booktree.xpath('/bookstore/book/title/text()')) # 返回所有title内的文本列表
print(booktree.xpath('/bookstore/book/title/@lang')) # 返回全部title的lang属性列表
print(booktree.xpath('/bookstore/book')) # 返回所有book组成的列表


谓语（Predicates ）：
谓语用来查找某个特定的节点或者包含某个指定的值的节点。谓语被嵌在方括号中。


print(booktree.xpath('/bookstore/book/title[@lang="eng"]/text()')) # 返回titles属性为lang="eng"的文本列表
print(booktree.xpath('/bookstore/book[3]/*')) # 第3个book标签下的所有节点（*表示所有子节点）
print(booktree.xpath('/bookstore/book[2]/title/text()')) # 第2个book标签下的title标签里的文本
print(booktree.xpath('/bookstore/book[price>30]/title/text()')) # 价格高于30的书名
print(booktree.xpath('/bookstore/book[title/@lang="zh"]/price/text()')) # 所有中文书的价格
print(booktree.xpath('/bookstore/book[title[@lang="zh"]]/price/text()')) # 所有中文书的价格

选取若干路径：
通过在路径表达式中使用“|”运算符，您可以选取若干个路径


XPath Axes （坐标轴）：


     XPath轴(XPath Axes)可定义某个相对于当前节点的节点集：
     1、child  选取当前节点的所有子元素
     2、parent  选取当前节点的父节点
     3、descendant 选取当前节点的所有后代元素（子、孙等）
     4、ancestor  选取当前节点的所有先辈（父、祖父等）
     5、descendant-or-self  选取当前节点的所有后代元素（子、孙等）以及当前节点本身
     6、ancestor-or-self  选取当前节点的所有先辈（父、祖父等）以及当前节点本身
     7、preceding-sibling 选取当前节点之前的所有同级节点
     8、following-sibling 选取当前节点之后的所有同级节点
     9、preceding   选取文档中当前节点的开始标签之前的所有节点
     10、following   选取文档中当前节点的结束标签之后的所有节点
     11、self  选取当前节点
     12、attribute  选取当前节点的所有属性
     13、namespace 选取当前节点的所有命名空间节点


使用XPath爬取糗事百科24小时热帖：

import urllib.request
import time
import random
import re
import lxml.etree

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
# html = response.read().decode('utf-8') # html字符串
html = response.read() # html字符串
htmltree = lxml.etree.HTML(html)
divs = htmltree.xpath('//div[starts-with(@id, "qiushi_tag_")]') # 取div标签，其id以qiushi_tag_开始（starts-with）
# print(lxml.etree.tostring(divs[0]))
for div in divs:
	name = div.xpath('div[@class="author clearfix"]//h2/text()')[0]
	content = '\n'.join(div.xpath('a[@class="contentHerf"]/div/span[1]/text()'))
	# print(divs[0].xpath('.//div[@class="content"]/span/text()'))
	print(name, content)
```
