# BeautifulSoup解析HTML


- BeautifulSoup安装

```
pip install beautifulsoup4
```

- BeautifulSoup对象类型

```
BeautifulSoup将复杂HTML文档转换成一个复杂的树形结构,每个节点都是Python对象,所有对象可以归纳为4种: 
1)Tag： Tag 对象与XML或HTML原生文档中的标签对应。Tag都有名字和属性，可以通过tag.name和tag.attrs访问，其中tag.attrs是全部属性组成的字典；
2)NavigableString：字符串常被包含在tag内.BeautifulSoup用NavigableString 类来包装tag中的字符串。通过unicode()方法可以直接将NavigableString对象转换成Unicode字符串；
3)BeautifulSoup：表示的是一个文档的全部内容。大部分时候，可以把它当作Tag对象。它支持 遍历文档树和搜索文档树中描述的大部分的方法。BeautifulSoup的name属性值为“[document]”，attrs属性为空字典；
4)Comment：Comment 对象是一个特殊类型的NavigableString对象。
访问Comment需要使用标签的string属性，并且会去掉<!-和->，但是可以通过类型判断是否是Comment，if type(string) == bs4.element.Comment: 为真是Comment。
序号	解析库	使用方法	优势	劣势
1	Python标准库	BeautifulSoup(html,’html.parser’)	Python内置标准库；执行速度快	容错能力较差
2	lxml HTML解析库	BeautifulSoup(html,’lxml’)	速度快；容错能力强	需要安装，需要C语言库
3	lxml XML解析库	BeautifulSoup(html,[‘lxml’,’xml’])	速度快；容错能力强；支持XML格式	需要C语言库
4	htm5lib解析库	BeautifulSoup(html,’htm5llib’)	以浏览器方式解析，最好的容错性	速度慢
```


- BeautifulSoup解析库

- 遍历文档树

```
1）获取标签对象：
# 获取第一个标签对象(head, title, body.b, a)
soup.head # 第一个head标签对象
soup.title # 第一个title标签对象
soup.body.b # 第一个body对象下的第一个b对象
soup.a # 第一个a标签对象
soup.prettify() # 将BeautifulSoup的文档树格式化后以Unicode编码输出，每个XML/HTML标签都独占一行
soup.body.a.name # Tag类型标签对象的名字
soup.body.a.attrs # Tag类型标签对象的属性（返回字典）
soup.body.a.attrs['href'] # 获取a标签的href属性
soup.body.string # 输出None
soup.title.string # string是title标签内的字符串
soup.body.strings # strings是产生器（需要迭代），包括所有body标签下的字符串（包括空白字符）
soup.body.stripped_strings # 和strings类似，只是去掉了首尾的空白
2）子节点：
soup.body.contents # 返回body标签的所有子节点，仅包含tag的直接子节点
soup.body.children # children返回所有子节点迭代器, 仅包含tag的直接子节点
soup.head.descendants: # 所有的后代对象产生器
3）父节点：
soup.title.parent # title的父节点
soup.title.parents # title的父节点，该对象是一个产生器，可以通过for…in遍历全部父标签
4）兄弟节点
soup.head.previous_sibling # 前兄弟节点
soup.head.next_sibling # 后兄弟节点
注意：实际文档中的Tag的 .next_sibling 和 .previous_sibling 属性通常是字符串或空白，因为空白或者换行也可以被视作一个节点，所以得到的结果可能是空白或者换行
.next_siblings 和 .previous_siblings 属性可以对当前节点的兄弟节点迭代输出。
soup.head.next_element # 之后的所有节点，不分层次
soup.head.previous_element # 之前的所有节点，部分层次
.next_elements 和 .previous_elements 可以向后或向前迭代文档的解析内容
```


- 搜索文档树

```
find_all( name , attrs , recursive , text , **kwargs )
	参数：
		name：参数可以查找所有名字为name的Tag,字符串对象会被自动忽略掉；
		attrs：定义一个字典参数来搜索包含特殊属性的Tag；
recursive：默认会检索当前Tag的所有子孙节点,如果只想搜索Tag的直接子节点,可以使用参数 recursive=False；
text：通过 text 参数可以搜搜文档中的字符串内容。与name参数的可选值一样,  该参数接受，字符串, 正则表达式，列表，True；
kwargs：如果一个指定名字的参数不是搜索内置的参数名，搜索时会把该参数当作指定名字Tag的属性来搜索。如包含一个名字为 id 的参数，会搜索每个Tag的”id”属性；

soup.find_all('a') # 返回所有a标签列表
soup.find_all(["p", "title"]) # 搜索全部p和title标签
soup.find_all("p", "title") # 搜索全部属性为title的p标签
attrs = {
		'class': 'sister', # 也可以使用正则表达式
		'id': 'link2'
}
soup.find_all(attrs=attrs)) # 搜索全部属性符合attrs字典的标签
soup.find_all('a', href=re.compile(r'^http://example.com'), limit=2) # 最多搜索2个符合href正则表达式的a标签
soup.find_all(text="Elsie") # 通过text参数搜文档中的字符串内容

find( name , attrs , recursive , text , **kwargs )
相当于find_all('title', limit=1)，但是find_all返回值是列表，find返回值只有一个。如果只搜索一个用find更方便。
```


- 通过CSS选择器查找节点

```
	print(soup.select('title')) # 选择title标签
	print(soup.select('body a')) # 选择body下的所有a标签
	print(soup.select('body span')) # 选择body下任意位置的span标签
	print(soup.select('body > span')) # 选择body下的直接子标签，该选择返回空列表
	print(soup.select('body > p > span')) # 选择body下的直接子标签p, p的直接自标签span
	print(soup.select('.sister')) # 选择所有class="sister"的标签
	print(soup.select('#link2'))
	print(soup.select('#link1 ~ .sister')) # 选择id="link1"节点的全部兄弟节点，并且兄弟节点的class="sister"
	print(soup.select('#link1 ~ #link3')) # 选择id="link1"节点兄弟节点，并且兄弟节点的id="link3"
	print(soup.select('#link1 + .sister')) # 选择id="link1"节点的相邻兄弟节点(必须连续)，并且兄弟节点的class="sister"
	print(soup.select('a[href="http://example.com/lacie"]')) # 选择所有a标签，并且href="http://example.com/lacie"
	print(soup.select('a[href^="http://example.com/"]')) # 选择所有a标签，并且href以"http://example.com/"起始
	print(soup.select('a[href$="tillie"]')) # 选择所有a标签，并且href以"tillie"结束
	print(soup.select('a[href*="example.com"]')) # 选择所有a标签，并且href包含"example.com"
	print(soup.select('body > p[class="title"]')) # 选择body下的直接子标签p, p的直接自标签span
	print('----------------')
	multilingual_markup = """
	 <p lang="en">Hello</p>
	 <p lang="en-us">Howdy, y'all</p>
	 <p lang="en-gb">Pip-pip, old fruit</p>
	 <p lang="fr">Bonjour mes amis</p>
	"""
	multilingual_soup = BeautifulSoup(multilingual_markup, 'lxml')
	print(multilingual_soup.select('p[lang|=en]')) # 通过语言查找（p[lang^="en"]也可以）
```
