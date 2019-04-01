# Scrapy 爬虫框架


- 简介

```
Scrapy是Python开发的一个快速，高层次的屏幕抓取和web抓取框架，用于抓取web站点并从页面中提取结构化的数据。Scrapy用途广泛，可以用于数据挖掘、监测和自动化测试。 Scrapy吸引人的地方在于它是一个框架，任何人都可以根据需求方便的修改。它也提供了多种类型爬虫的基类，我们可以用如下方式查看。
(base) D:\python_project>scrapy genspider -l
Available templates:
  basic
  crawl
  csvfeed
xmlfeed
Scrapy并不是一个函数功能库，而是一个爬虫框架。爬虫框架是实现爬虫功能的一个软件结构和功能组件集合。爬虫框架是一个半成品，能够帮助用户实现专业网络爬虫。

Scrapy框架分析：



Scrapy框架包括图中5个部分

Scrapy Engine:
Scrapy引擎是用来控制整个系统所有模块的数据处理流程，并根据条件触发事件。不需要用户修改。

Scheduler:
调度程序从Scrapy引擎接受请求并排序列入队列，并在Scrapy引擎发出请求后返还给他们。不需要用户修改。
Downloader:
下载器的主要职责是根据请求抓取网页并将网页内容返还给Spiders。
Spider:
Spider是有Scrapy用户自己定义用来解析网页并抓取制定URL返回的内容的类。就是用来解析Downloader返回的响应（Response），然后产生爬取项（scraped item），还可能产生额外的爬取请求（Request）。

Item Pipeline:
项目管道的主要责任是负责处理有Spider从网页中抽取的Item，他的主要任务是清晰、验证和存储数据。当页面被蜘蛛解析后，将被发送到项目管道，并经过几个特定的次序处理数据。每个项目管道的组件都是有一个简单的方法组成的Python类。他们获取了项目并执行他们的方法，同时他们还需要确定的是是否需要在项目管道中继续执行下一步或是直接丢弃掉不处理。

Scrapy安装：
	在PyCharm终端中输入pip install scrapy安装或使用PyCharm图形界面安装（Setting->Project Interpreter）
```

- Scrapy开发步骤

```
1.创建项目（糗事百科为例）
scrapy startproject qiushibaike


    scrapy.cfg: 项目的配置文件
    qiushibaike/: 该项目的python模块。之后您将在此加入代码。
    qiushibaike /items.py: 项目中的item文件，类似字典，是提取的结构化数据
    qiushibaike /pipelines.py: 项目中的pipelines文件。检查数据完整性，完成数据的持久化（保存到数据库或文件中等）
    qiushibaike /settings.py: 项目的设置文件。注册pipeline，设置请求头参数（User-Agent等），延迟等。
    qiushibaike /spiders/: 放置spider代码的目录。需要实现Spider类，用于解析下载器返回的Response（可以用正则表达式，XPath，BeautifulSoup）。

2.在qiushibaike/spiders目录下创建存放qishibaike_spider.py文件
Spider是用户编写用于从单个网站(或者一些网站)爬取数据的类。其包含了一个用于下载的初始URL，如何跟进网页中的链接以及如何分析页面中的内容， 提取生成 item 的方法。为了创建一个Spider，您必须继承 scrapy.Spider 类， 且定义以下三个属性和方法:
1)name: 用于区别Spider。 该名字必须是唯一的，您不可以为不同的Spider设定相同的名字。
2)start_urls: 包含了Spider在启动时进行爬取的url列表。 因此，第一个被获取到的页面将是其中之一。 后续的URL则从初始的URL获取到的数据中提取。
3)parse() 是spider的一个方法。 被调用时，每个初始URL完成下载后生成的 Response 对象将会作为唯一的参数传递给该函数。 该方法负责解析返回的数据(response data)，提取数据(生成item)以及生成需要进一步处理的URL的 Request 对象。

3.实现QiushibaikeItem类，定义需要的属性，也就是提取的数据：
name = scrapy.Field()
content = scrapy.Field()

4.实现QiushibaikePipeline类，并实现process_item()方法。
检查Spider提交的Item是否有效，并完成数据持久化（存储到文件或数据库），该函数成功处理要return Item，失败要抛出DromItem异常。

5.最后别忘了在settings.py中激活该Pipeline：
ITEM_PIPELINES = {
    'qiushibaike.pipelines.QiushibaikePipeline': 300,
}
两外还有：
USER_AGENT = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36'
如果连续发出请求，可以设置一下延迟：
DOWNLOAD_DELAY = 3
另外settings.py中还有其他配置项：
ROBOTSTXT_OBEY = True # 是否准守ROBOT协议
DEFAULT_REQUEST_HEADERS = { #定义请求头 
  'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
  'Accept-Language': 'en',
}

参考资料：
	http://scrapy-chs.readthedocs.io/zh_CN/0.24/intro/tutorial.html
	http://scrapy-chs.readthedocs.io/zh_CN/1.0/intro/overview.html
```


```
代码如下：

爬虫解析文件qishibaike_spider.py
import scrapy
from qiushibaike.items import QiushibaikeItem

class QiushibaikeSpider(scrapy.Spider):
	# 1. name: 用于区别Spider。 该名字必须是唯一的，您不可以为不同的Spider设定相同的名字。
	name = 'qiushibaike'

	allowed_domains = ["qiushibaike.com"] # 如果请求不属于该域名无法爬取

	# 2. start_urls: 包含了Spider在启动时进行爬取的url列表。 因此，第一个被获取到的页面将是其中之一。后续的URL则从初始的URL获取到的数据中提取。
	start_urls = [
		'https://www.qiushibaike.com/hot/' # 生成请求
	]

	# 3. parse() 是spider的一个方法。 被调用时，每个初始URL完成下载后生成的 Response 对象将会作为唯一的参数传递给该函数。该方法负责解析返回的数据(response data)，提取数据(生成item)以及生成需要进一步处理的URL的 Request 对象

	def parse(self, response):
		print('-----------------------------------------')
		divs = response.xpath('//div[starts-with(@id, "qiushi_tag_")]')  # 取div标签，其id以qiushi_tag_开始（starts-with）
		for div in divs:
			# extract()返回值是标签内的unicode字符串列表
			name = div.xpath('div[@class="author clearfix"]//h2/text()').extract()
			# content = '\n'.join(div.xpath('a[@class="contentHerf"]/div/span[1]/text()'))
			content = div.xpath('a[@class="contentHerf"]/div/span[1]/text()').extract()
			# print(name[0], ''.join(content).strip())
			item = QiushibaikeItem()
			item['name'] = name[0]
			item['content'] = ''.join(content).strip()
			yield item # 提交item给Pipeline处理
		next_page_href = response.xpath('//a[span/@class="next"]/@href').extract()
		next_page_text = response.xpath('//a/span[@class="next"]/text()').extract()
		# 构造Request请求，指定回掉函数是selt.parse，并提交请求
		if u'下一页' in next_page_text[0]:
			yield scrapy.http.Request(response.urljoin(next_page_href[0]), callback=self.parse) 
		print(next_page_href)

管道文件pipilines.py
from scrapy.exceptions import DropItem
import json

class QiushibaikePipeline(object):
	# def __init__(self):
	# 	self.file = open('qiushibaike.json', 'w+')

	def process_item(self, item, spider):
		if item['name'] and item['content']:
			# print(item['name'], item['content'])
			# json.dump(dict(item), self.file, ensure_ascii=False) # ensure_ascii默认是True，以ascii方式写入文件
			return item
		else:
			raise DropItem('Invalied item %s %s' %(item['name'], item['content']))

结构化数据文件items.py
import scrapy

class QiushibaikeItem(scrapy.Item):
	# define the fields for your item here like:
	# name = scrapy.Field()
	name = scrapy.Field()
	content = scrapy.Field()
```


- scrapy 终端

```
Scrapy终端是一个交互终端，供您在未启动spider的情况下尝试及调试您的爬取代码。 其本意是用来测试提取数据的代码，不过您可以将其作为正常的Python终端，在上面测试任何的Python代码。
该终端是用来测试XPath或CSS表达式，查看他们的工作方式及从爬取的网页中提取的数据。 在编写您的spider时，该终端提供了交互性测试您的表达式代码的功能，免去了每次修改后运行spider的麻烦。

步骤：
1.启动终端
scrapy shell <url> 启动终端并请求url
或者先启动终端，后发出请求：
scrapy shell
header = {}
scrapy.Request(url, headers=header)
2.使用终端
1)shelp() 打印可用对象和命令列表

2)fetch(request_or_url) 根据定义的获取新的response，并更新对象，redirect=False是不更新。
3)view(response) 在本机的浏览器打开给定的response。 其会在response的body中添加一个 <base> tag ，使得外部链接(例如图片及css)能正确显示。 注意，该操作会在本地创建一个临时文件，且该文件不会被自动删除。

3.request和response的属性
request包括url，method，headers，body，meta等方法
response包括url，status，headers，body，request，meta，flags等属性

4.提取网页中的数据
response.xpath(‘//div[starts-with(@id, “qiushi_tag”)]’) # 使用XPath选择节点
response.css('div[id^=qiushi_tag]') # 使用CSS选择器选择节点


实现下载图片：

修改部分代码
1.items.py 中添加两个字段
image_urls = scrapy.Field()
images = scrapy.Field()
2.修改settings.py，添加：
# Obey robots.txt rules
ROBOTSTXT_OBEY = False # scrapy框架默认准守ROBOTS协议，该成False不准守
ITEM_PIPELINES = {
	'qiushibaike.pipelines.QiushibaikePipeline': 300,
	'scrapy.pipelines.images.ImagesPipeline': 1,
}

IMAGES_STORE = 'D:\python_project\qiushibaike' # 存储路径
# IMAGES_URLS_FIELD = 'image_urls'
# IMAGES_RESULT_FIELD = 'images'
# 1天的图片失效期限
IMAGES_EXPIRES = 1
# 缩略图
# IMAGES_THUMBS = {
#     'small': (50, 50),
#     'big': (270, 270),
# }
# 过滤小图片
# IMAGES_MIN_HEIGHT = 110
# IMAGES_MIN_WIDTH = 11
3.在qishibaikke_spider.py中，增加image_urls的赋值，要注意该项是列表
imgurls = div.xpath('div[@class="thumb"]/a/img/@src').extract()
for url in imgurls:
		item['image_urls'] = ['https:' + url] # 该项是列表


简单的导出文件（Feed Export）：
可以导出json，csv，xml等，如：
FEED_URI = '%(name)s (%(time)s).json' #name项目名，time当前时间
FEED_FORMAT = 'json'
FEED_EXPORT_FIELDS = ['name', 'content'] # 只导出name和content
FEED_STORE_EMPTY = False # 忽略空项
```
