### html


- 前端开发流程
```
所有软件开发大致流程：
	需求分析：知道用户需求，软件实现哪些功能
	技术调研：根据需求分析决定使用哪些工具、框架、技术路线
	软件设计：概要设计、详细设计、数据库设计
	编码
	测试
	试运行，上线发布

前端开发流程：
```


- 语言介绍
```
1.html  —— 超文本标记语言 - 结构
2.css   —— 层叠样式表 - 样式
3.javascript —— 脚本语言 - 行为 
```


- 前端开发工具
```
代码编译软件 
Dreamweaver、Sublime、Hbuilder、webstorm等 
图片处理软件 
Photoshop、Fireworks等 
浏览器 
Internet Explorer、Opera、Safari、Firefox、Chrome等 
```


- 第一个网页
```
<!DOCTYPE html>  文档类型html5
<html>
	<head>
		<meta charset="utf-8" />  规定文档字符集是utf-8，可以显示中文
		<title>练习1</title>		 设置标题
	</head>
	<body>							网站显示的内容
		hello world
	</body>
</html>
运行结果：
```


- html语言
```
HTML(超文本标记语言 Hyper Text Markup Language)
是一种用来制作超文本文档的简单标记语言。 
用HTML编写的超文本文档称为HTML文档。 
主要由双标签和单标签组成。 双标签<title></title>.单标签<meta />

一个HTML文件是由一系列的元素和标签组成的 
元素是HTML文件的重要组成部分，例如title（文件标题）、img（图像）及table（表格）等。元素名不区分大小写。 
HTML用标签来规定元素的属性和它在文件中的位置 

HTML的标签分单独出现的标签和成对出现的标签两种 
成对标签仅对包含在其中的文件部分发生作用，例如<title>和</title>标签用于界定标题元素的范围，也就是说，<title>和</title>标签之间的部分是此HTML文件的标题。 
单独标签的格式为<元素名称>，其作用是在相应的位置插入元素，例如<br />标签便是在该标签所在位置插入一个换行符。 

说明：在每个HTML标签，大、小写混写均可。
	例如<HTML>、<html>和<Html>,其结果都是一样的。 

概念
当用一组HTML标签将一段文字包含在中间时，这段文字与包含文字的HTML标签被称之为一个元素。 
应用
在所有HTML文件，最外层的元素是由<html>标签建立的。 
在<html>标签所建立的元素中，包含了两个主要的子元素，这两个子元素是由<head>标签与<body>标签所建立的。 
<head>标签所建立的元素的内容为文件标题。 
<body>标签所建立的元素内容为文件主体。
```


- 网页命名规则（重点）
```
*.htm或*.html
无空格
无特殊符号（例如&符号），只可以有下划线“_”，只可以为英文、数字
在windows系统下不区分大小写，在Unix和linux系统中区分大小写。 
首页文件名默认为：index.htm 或 index.html 
```


- 头部标记信息说明
```
概述
在HTML语言的头元素中，一般需要包括基底信息、元信息、标题等。 
一般情况下，CSS和JavaScript都定义在头元素中的 
而定义在HTML语言头部的内容往往不会在网页上直接显示。它用于包含当前文档的相关信息。 
标记方法
HTML的头元素是以<head>为开始标记，以</head>为结束标记的 
示例1：
<!DOCTYPE html>
<html>
	<head>
		<base href="http://www.baidu.com" />  基底信息
		<meta charset="utf-8" />  元信息
		<title>测试</title>
	</head>
	<body>
		欢迎来到web的江湖<br />
		<a href="">进入百度</a>
	</body>
</html>

运行结果：


示例2：
<!DOCTYPE html>
<html>
	<head>
		<base href="http://www.baidu.com" />
		<meta charset="utf-8" />
		<title>测试</title>
		<style>  设定css层叠样式表的内容（给a中的字体添加颜色，即“进入百度”）
			a{
				color:red;
			}
		</style>
	</head>
	<body>
		欢迎来到web的江湖<br />
		<a href="">进入百度</a>
	</body>
</html>

运行结果：


示例3：
<!DOCTYPE html>
<html>
	<head>
		<base href="http://www.baidu.com" />
		<meta charset="utf-8" />
		<title>测试</title>
		<style>  设定css层叠样式表的内容（给a中的字体添加颜色，即“进入百度”）
			a{
				color:red;
			}
		</style>
	</head>
	<body text="yellow">
		欢迎来到web的江湖<br />
		<a href="">进入百度</a>
	</body>
</html>

运行结果：

注：在<body>中加上text="yellow"后，<body></body>内部字体颜色变为”yellow”，并且a{color:red;}对”进入百度”加颜色的操作将无效，字体将恢复默认颜色

知识点补充：对text赋值时也可以采用<body text=”#c91623”>这种方式

示例4：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>测试</title>
		<link rel="stylesheet" href="css/mystyle.css" />  设定外部文件的链接
		<script type="test/javascript" src="js/myjs.js"></script>  设定页面中程序脚本的内容
	</head>
	<body>
		姓名：李营<br />告示板：欢迎进入web的江湖<br />	
	</body>
</html>
```


- 元信息标记<meta>
```
	概述
meta元素提供的信息是用户不可见的，它不显示在页面中，一般用来定义页面信息的名称、关键字、作者等。 
在HTML中，meta标记不需要设置结束标记，在一个尖括号内就是一个meta内容，而在一个HTML头页面中可以有多个meta元素。
meta元素的属性有两种：name和http-equiv，其中name属性主要用于描述网页，以便于搜索引擎机器人查找、分类。 http-equiv 属性可用于模拟一个 HTTP 响应头，设置字符集，预定义样式表，自动刷新时间间隔。 
这其中最重要的是description（站点在搜索引擎上的描述）和keywords（关键字）。 



<meta>元素位于<head></head>之间,常有以下用法:
用来标记搜索引擎在搜索你的页面时所取出的关键词
<meta name=“keywords” content=“具体的关键字"> 
用来标记文档的作者
<meta name=“author” content=“作者的姓名"> 
用来标记你的页面的解码方式
<meta http-equiv=“Content-Type” content=“text/html; charset=utf-8”> 
用来描述页面是为了便于搜索引擎的查找
<meta name=“description” content=“对页面的描述语言”>
用来限制搜索方式
<meta name=“roborts” content=“搜索方式"> 
用来设置网页的定时跳转
<meta http-equiv=“refresh” content=“跳转时间 url=链接地址”> 
用来设定有效期限，一旦过期则必须到服务器上重新调用。
<meta http-equiv=“expires” content=“到期的时间”>
用来强制打开新窗口
<meta http-equiv=“window-target” content=“_top”> 
用来设置网页的过渡效果 
<meta http-equiv=“过渡事件” content=“revealtrans(duration=过渡效果持续时间,transition=过渡方式)”>
```


- body标签常用属性（重点）
```
bgcolor：设置body的背景颜色
background：设置body的背景图片
text：设置文字的颜色

<body  bgcolor="value" background="value" text="value">
</body>

补充：
<img>标签用来显示图片
<img src="img/product1.png" title="这是荷花图片" />
img标签属性src：设置图片的路径
img标签属性title：设置光标移入时显示的内容

<body  bgcolor="value" background="value" text="value">
</body>

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<!--<base href="http://www.baidu.com" />-->
		<meta charset="utf-8" />
		<title>测试</title>
	</head>
	<body>
		姓名：李营<br />告示板：欢迎进入web的江湖<br />	
		<img src="img/1.jpg" title="你瞅啥!" /><br />
		<!--<a href="">进入百度</a>-->
	</body>
</html>

运行结果：


注：当加上<base href="http://www.baidu.com" />和<a href="">进入百度</a>时，图片不能显示，因为www.baidu.com/img/1.jpg路径下找不到1.jpg文件

知识点补充：（这种写法时可以正常进行操作）
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>测试</title>
	</head>
	<body>
		姓名：李营<br />告示板：欢迎进入web的江湖<br />	
		<img src="img/1.jpg" title="你瞅啥!" /><br />
		<a href="http://www.baidu.com">进入百度</a>
	</body>
</html>
```


- HBuilder快捷键
```
	alt+?:代码辅助键，自动补全代码
	Ctrl+?:将选中代码，或光标当前行代码添加注释
	Ctrl+Shift+F：格式化代码
	Ctrl+R:运行

查看项目存储路径：项目名称右键点击属性，位置显示项目存储路径
```


- 相对路径和绝对路径（重点）
```
绝对路径：C:\Users\Administrator\Documents\HBuilderProjects\Day1\img\product1.png
相对路径：index.html中使用\img\product1.png，在index.xml所在文件夹中查找img路径下的product1.png
```


- h1 标题标签
```
概述 
一般采用<h1>-<h6>标签来标记标题，这样显示标题在HTML中重要性 
<H1>到<H6>字体大小依次递减 
H1 到 H6 标签用于指定不同级别的标题 
同时也考虑到告诉搜索引擎标签内内容为标题很重要。 
标题标签 
<H#> ... </H#>	#=1, 2, 3, 4, 5, 6
例子 

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>	
		<h1>这是h1标题</h1>
		<h2>这是h2标题</h2>
		<h3>这是h3标题</h3>
		<h4>这是h4标题</h4>
		<h5>这是h5标题</h5>
		<h6>这是h6标题</h6>
	</body>
</html>

运行结果：


12.1  align 对齐属性取值：left、center、right
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>	
		<h1 align="left">这是h1标题</h1>
		<h2 align="left">这是h2标题</h2>
		<h3 align="center">这是h3标题</h3>
		<h4 align="center">这是h4标题</h4>
		<h5 align="right">这是h5标题</h5>
		<h6 align="right">这是h6标题</h6>
	</body>
</html>

运行结果：
```


- 文字格式设置
```
13.1文字样式
写到标签的style属性中，多个用分号区分。例如：
<span style="font-size:50px;color: red;" >大家好，欢迎来到web世界</span>

设置文字字体—— font-family
设置字号——font-size 
设置文字颜色——color 
13.2文字格式标签

粗体、斜体、下划线——strong、b、i、u 
设置删除线——del 
示例代码1：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<span style="font-family:'times new roman'">abcd</span>
	</body>
</html>

运行结果：



示例代码2：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<span style="font-size:50px;color: red;" >大家好，欢迎来到web世界</span><br />
		大家好，欢迎来到web世界<br />
		<strong>大家好，欢迎来到web世界</strong><br />
		<b>大家好，欢迎来到web世界</b><br />
		<i>大家好，欢迎来到web世界</i><br />
		<del>大家好，欢迎来到web世界</del><br />
	</body>
</html>

运行结果：


上标与下标——sup、sub 

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		3<sup>2</sup>
		H<sub>2</sub>O
	</body>
</html>
运行结果：

13.3 文字样式设置方式
设置文字格式的方法有两种：
第一种是利用标签进行设置 
第二种是利用行间样式css代码进行设置 
```


- HTML文档中其他特殊字符
```
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		&copy; 
		&reg; 
	</body>
</html>

运行结果：
```


- 设置段落格式
```
段落标记——p 
取消文字换行标记——nobr 
换行标记——br 
保留原始排版方式标记——pre 
居中对齐标记——center 
向右缩进标记——blockquote 


示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<p>hello,</p><p>,everyone</p>
		<p>hello,
		everyone</p>
		
		<pre>hello,
		everyone</pre>
		<center>hello</center>
		<blockquote>hello</blockquote>
	</body>
</html>


运行结果：

16 水平线标记
添加水平线——hr 
设置水平线宽度与高度属性——width、size 
设置水平线的颜色——color 
设置水平线的对齐方式——align 
去掉水平线阴影——noshade 

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<hr width="500px" size="20px" align="right" noshade />
		<hr width="500px" size="20px" align="right" />
		<hr width="500px" size="2px" color="gray" align="left" />
	</body>
</html>

运行结果：
```


- 练习
```
输出一首诗，格式如下：
静夜思
						李白
                                                                                     
床前明月光，疑似地上霜。
举头望明月，低头思故乡。

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<h3 align="center">静夜思</h3>
		<p align="right" style="color: red;">李白</p>
		<hr width="500px" size="3px" color="red" align="center"/>
		<center>床前明月光，疑似地上霜。</center>
		<center>举头望明月，低头思故乡。</center>
	</body>
</html>
```


- 块元素和内嵌元素（重点）
```
什么是块元素 
块元素 一般用来搭建网站架构、布局。比如<div>、<p>、<h1>~<h6>、<ul>、<ol>、<dl>等。 
块元素的特点：
1.默认独占一行
2.没有宽度时，默认撑满一排
3.支持所有css命令 

什么是内嵌元素
内嵌元素 一般用在网站内容之中的某些细节或部位。比如<span>、<a>、<img>、<sub>、<sbp>、<strong>、<b>、<i>、<em>等
内嵌元素的特点：
1.同排可以继续跟同类的标签
2.内容撑开宽度
3.不支持宽高
4.不支持margin_top/margin_bottom和padding_top/padding_bottom
5.代码换行被解析

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<p style="border: 1px solid red;margin-bottom: 30px;">hello</p>
		<p style="border: 1px solid red;width: 300px;height: 300px;margin-top: 100px;" >hello</p>
		
		<span style="border: 1px solid red;margin-right: 100px;margin-top: 100px;">hello,span</span>
		<span style="border: 1px solid red;">hello,<br />span</span>
	</body>
</html>

运行结果：
```


```
border: 1px solid red：边框1像素，实线，红色
width：标签的宽度
height：标签的高度
margin：外边框的距离，边框和其他组件的距离。
	margin-top、margin-bottom、margin-left、margin-right
padding：内边距，边框和显示内容的距离
	padding-top、padding-bottom、padding-left、padding-right

margin和padding：
	值是一个x，代表上下左右都是这个距离
	值是两个x  y,代表上下是x距离，左右是y距离
	值是三个x y z，代表x是上距离，y是左右距离，z是下距离
	值是四个x  y  z  m,代表上右下左的距离分别是xyzm


div盒子模型
元素转换
display
块元素转换内联元素：
display:inline;
内嵌元素转换块元素： 
display:block;
行内块元素：支持宽高，内外边距等属性 
display:inline-block; 
```


```
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		将块元素h3转成行内（内嵌）元素不支持宽和高
		<h3 style="display: inline;border: 1px solid red;width: 300px;">元素转换内嵌元素</h3>  
		<h3 style="display: inline;">display:inline;</h3>
		将块元素h3转成行内块元素支持宽和高，支持上下的margiin和padding
		<h3 style="display: inline-block;border: 1px solid red;width: 300px;">元素转换内嵌元素</h3>  
		<h3 style="display: inline-block;;">display:inline;</h3>
		
		<span style="display: block;border: 1px solid red;">元素转换内嵌元素</span>
		<span style="display: block;">display:inline;</span>
	</body>
</html>

运行结果：
```


- 列表
```
18.1分类
列表分为两种类型，一是有序列表，一是无序列表。无序列表用项目符号来标记无序的项目，有序列表则使用编号来记录项目的顺序。 
所谓有序，指的是按照数字或字母等顺序排列列表项目 
所谓无序，是指以●、○、■等开头的，没有顺序的列表项目 
18.2 ul无序列表（重点）
list-style样式控制每一个项目的项目符号类型。默认是实现圆。取值可以circle（空心圆），square（实心正方形），none（没有项目符号）

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		无序列表
		<ul>
			<li>菜单一</li>
			<li>菜单二</li>
			<li>菜单三</li>
		</ul>
		
		<ul style="list-style: square;">
			<li>菜单一</li>
			<li>菜单二</li>
			<li>菜单三</li>
		</ul>
		
		<ul style="list-style:none;">
			<li>菜单一</li>
			<li>菜单二</li>
			<li>菜单三</li>
		</ul>
	</body>
</html>

运行结果：

18.3 ol有序列表（重点）
属性type：设置每一项前面序列号的类型，值1，a,A，i,I
属性start：可以设置第一个项目的起始数字，值只能是数字。

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		ol是有序列表，默认从数字1开始.
		<ol >
			<li>菜单一</li>
			<li>菜单二</li>
			<li>菜单三</li>
		</ol>
		start属性设置列表每一项起始的数字，值只能是数字
		<ol start="3">
			<li>菜单一</li>
			<li>菜单二</li>
			<li>菜单三</li>
		</ol>
		type属性设置序号的类型
		<ol type="a" start='2'>
			<li>菜单一</li>
			<li>菜单二</li>
			<li>菜单三</li>
		</ol>
		<ol type="i" start="3">
			<li>菜单一</li>
			<li>菜单二</li>
			<li>菜单三</li>
		</ol>
	</body>
</html>

运行结果：

练习
沈阳中心	
	班级703
	班级709
	班级710
北京中心
	班级1703
	班级1709
	班级1710
成都中心
	班级503
	班级510
深圳中心
	班级203

方法1：各个中心属于同一个列表的不同项
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<!--代码一：各个中心属于同一个列表的不同项-->
		<ul style="list-style: none;">
			<li>沈阳中心</li>
			<li>
				<ul style="list-style: none;">
					<li>班级703</li>
					<li>班级709</li>
					<li>班级710</li>
				</ul>
			</li>
			<li>北京中心</li>
			<li>
				<ul style="list-style: none;">
					<li>班级1703</li>
					<li>班级1709</li>
					<li>班级1710</li>
				</ul>
			</li>
			<li>成都中心</li>
			<li>
				<ul style="list-style: none;">
					<li>班级503</li>
					<li>班级510</li>
				</ul>
			</li>
			<li>深圳中心</li>
			<li>
				<ul style="list-style: none;">
					<li>班级203</li>
				</ul>
			</li>
		</ul>
	</body>
</html>
		每个中心独自是一个列表
		<ul>
			<li>沈阳中心</li>
			<ul>
				<li>班级999</li>
			</ul>
		</ul>
		
		<ul>
			<li>上海中心</li>
			<ul>
				<li>班级999</li>
			</ul>
		</ul>
	</body>
</html>

方法2：每个中心独自是一个列表
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<!--每个中心独自是一个列表-->
		<ul style="list-style: none;">
			<li>沈阳中心</li>
			<ul style="list-style: none;">
					<li>班级703</li>
					<li>班级709</li>
					<li>班级710</li>
			</ul>
		</ul>
		<ul style="list-style: none;">
			<li>北京中心</li>
			<ul style="list-style: none;">
					<li>班级1703</li>
					<li>班级1709</li>
					<li>班级1710</li>
			</ul>
		</ul>
		<ul style="list-style: none;">
			<li>成都中心</li>
			<ul style="list-style: none;">
				<li>班级503</li>
				<li>班级510</li>
			</ul>
		</ul>
		<ul style="list-style: none;">
			<li>深圳中心</li>
			<ul style="list-style: none;">
				<li>班级203</li>
			</ul>
		</ul>
	</body>
</html>
18.4 dl自定义标签
dl标签，每一项可以用dt和dd，dd多一个缩进。
概述 
自定义列表标记--dl 
不同于前两种列表，它主要用于解释名词。 
包含两个层次的列表 
第一层次是需要解释的名词， 
第二层次是具体的解释 
语法 
<dl>
<dt>名词</dt>
<dd>解释</dd>
</dl>
语法解释 
dl的子级必须是dt标签与dd标签。
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<dl>
			<dt>Python</dt>
			<dd>是一种面向对象的解释型计算机程序设计语言，由荷兰人Guido van Rossum于1989年发明，第一个公开发行版发行于1991年。</dd>
			<dt>Python</dt>
			<dd>是一种面向对象的解释型计算机程序设计语言，由荷兰人Guido van Rossum于1989年发明，第一个公开发行版发行于1991年。</dd>
		</dl>
	</body>
</html>

运行结果：


18.5 菜单列表
概述 
菜单列表标记——menu 
菜单列表主要用于设计单列的菜单列表。 
菜单列表在浏览器中的显示效果和无序列表是相同的，因此它的功能也可以通过无序列表来实现 
语法 
<menu></menu>
语法解释 
菜单列表的子级为li，与无序列表写法相同。 

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<menu>
			<li>电视剧</li>
			<li>综艺</li>
			<li>电影</li>
		</menu>
	</body>
</html>

运行结果：

18.6 目录列表
概述 
目录列表标记——dir 
目录列表用于显示文件内容的目录大纲，通常用于设计一个压缩窄列的列表，用于显示一系列的列表内容。 
例如字典中的索引或单词表中的单词等 
语法 
<dir></dir>
语法解释 
目录列表的写法与无序列表写法相同，子级必须为li。 

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<dir>
			<li>电视剧</li>
			<li>综艺</li>
			<li>电影</li>
		</dir>
	</body>
</html>

运行结果：

总结：
自定义列表的嵌套
在定义列表中，一个<dt>标记下可以有多个<dd>标记作为名词的解释和说明，以实现定义列表的嵌套。
无序列表和有序列表的嵌套
最常见的列表嵌套模式就是有序列表和无序列表的嵌套，可以重复第使用<ol>和<ul>标记组合实现。
```


- img 图像标签
```
1.1 图片格式

1.2 img标签的属性
img是特殊的内嵌（行内）元素，可以理解行内块元素，支持宽和高。
src：设置图片的路径
alt：当图片取不到值时，显示该属性的内容
title：当光标移入图片时，显示该属性的内容

图像高度——height 
图像宽度——width 
图像边框——border 
图像水平间距——hspace （horizontal）
图像垂直间距——vspace （vertical）
图像相对于文字基准线的对齐方式——align 
图像的提示文字——alt 

示例代码1：
<!DOCTYPE html>
<html>
	<head>
		<base href="http://www.baidu.com" />
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<p>这是img标签</p>
		<img src="img/cartoon.png" alt="图片显示错误" height="200px" width="200px">
	</body>
</html>

运行结果：


示例代码2：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<p>这是img标签</p>
		<img src="img/cartoon.png" alt="图片显示错误" height="200px" width="300px">
		<img src="img/cartoon.png" alt="图片显示错误" height="200px" width="200px" hspace="100px"/>
		<img src="img/vx图标.png" alt="图片显示错误" border="2px"/>
		<img src="img/vx图标.png" alt="图片显示错误" vspace="20px""/>
		<br />
		<img src="img/cartoon.png" alt="图片显示错误" height="200px" width="200px" hspace="100px" align="top"/>
		<span>你好，请向我看齐</span><br />
		<br />
	</body>
</html>

运行结果：

1.3 属性详细说明
我们可以指定一幅图片在浏览器窗口里的显示大小。 
定义图片的显示大小的方法是：
<img src=“sample.jpg” width=“100” height=“100” >
width指定图片的宽度，height指定高度。它们的属性值可以是像素，也可以是%
我们可以为一幅图片加一个边框以突出显示：
<img src="sample.jpg" border= " 2 " >
border的属性值为像素数 
定义图片与左、右和上、下的文本之间的间距 
图片在显示时，与左右的文本之间可以有一定的间距
语法
<img src="sample.jpg" hspace=5 vspace=5 >
语法解释
Hspace(horizontal)定义水平间距； 
Vspace(vertical)定义垂直间距。单位都是像素数.
图片的对齐方式
图片可以相对于页面或单元格有一个对齐方式。
定义水平对齐方式的方式：
<img src=“sample.jpg” align=“left” >
<img src=“sample.jpg” align=“right”>
定义图片的垂直对齐方式：
<img src="sample.jpg" align="top" >
<img src="sample.jpg" align="middle">
<img src="sample.jpg" align="bottom" >

提示文字作用:如果图像没有被下载，在图像的位置上就会显示提示文字 
语法
<img src=”图像文件的地址” alt=”提示文字的内容”title=“光标移入显示文字”> 
语法解释
在该语法中，提示文字的内容可以是中文，也可以是英文
1.4 常见应用--图片链接
点击图片进入到另一个页面
index.html
示例代码：
index.html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
	</head>
	<body>
		<a href="picInfo.html"><img src="img/cartoon.png" alt="图片显示错误" title="造作啊！"/> </a>
	</body>
</html>

picInfo.html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		这是图片详细信息页面
		<br />
		<img src="../img/cartoon.png" />
	</body>
</html>

运行结果：
```


- a 超链接标签
```
2.1 a链接基本语法
超链接是用元素<a>定义的 
在<a>元素下，有元素属性href, href的属性值为一个URL地址
如：<a href=“http://www.baidu.com”>指向百度超级链</a> 
如：<a href=“index.html">普通超级链接</a> 
超链接标签<a>有一个Target属性，它可以取值为:
_blank(新开窗口)
_self(在同一窗口打开，与默认设置相同)
_parent(父框架，在上一级窗口打开)
-top(在浏览器的整个窗口打开)
例如： 
<a href=“index.htm” target=“_blank”> 新窗口打开页面 </a> 
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<a href="http://www.baidu.com" target="_blank">百度</a>
	</body>
</html>

运行结果：

2.2 书签应用
在浏览页面的时候，如果页面的内容较多，页面过长，浏览的时候需要不断拖动滚动条，很不方便，如果要寻找特定的内容，就更加不方便。这时如果能在该网页或另外一个页面上建立目录，浏览者只要单击目录上的项目就能自动跳到网页相应的位置进行阅读，这样无疑是最方便的事，并且还可以在页面中设定诸如“返回页首”之类的链接。这就称为书签链接。
建立书签链接分为两步：
一是建立书签
二是为书签制作链接 

建立书签
概述
书签可以与链接文字在同一页面，也可以在不同的页面。 
但是实现网页内部的 书签链接，都需要先建立书签。 
通过建立书签才能对页面的内容进行引导跳转
语法
<a name=“书签的名称”>文字</A>
语法解释
在该语法中，书签名称就是对于后面要跳转所创建的书签，而文字则是设置链 接后跳转的位置。 
为书签制作链接
语法
<A href=”#书签的名称”>链接的文字</A>
语法解释
在该语法中，书签的名称就是刚才所定义的书签名，也就name的赋值。
而#则代表这是书签的链接地址。 
示例代码
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<a href="#contentA">书签A</a>
		<a href="#contentB">书签B</a>
		<p> this is my content</p>
		<p> this is my content</p>
		<p> this is my content</p>
		<p> this is my content</p>
		
		
		<p> this is my content</p>
		
		<p> this is my content</p>
		<p> this is my content</p>
		
		<p> this is my content</p>
		<p> this is my content</p>
		
		<p> this is my content</p>
		<p> this is my content</p>
		
		<p> this is my content</p>
		<a name="contentA">这是书签A</a>
		<p> this is my content</p>
		<p> this is my content</p>
		<p> this is my content</p>
		<p> this is my content</p>
		
		<p> this is my content</p>
		<p> this is my content</p>
		
		
		<p> this is my content</p>
		<a name="contentB">这是书签B</a>
		<p> this is my content</p>
		<p> this is my content</p>
		
		<p> this is my content</p>
		
		<p> this is my content</p>
		<p> this is my content</p>
		
		<p> this is my content</p>
		<p> this is my content</p>
		
		<p> this is my content</p>
		<p> this is my content</p>
		
		<p> this is my content</p>
		
	</body>
</html>

为不同页面建立书签
语法
<A href=”链接的文件地址#书签的名称” >链接的文字</A> 
语法解释
在该语法中，与同一页面的书签链接不同的是，需要在链接的地址前增加文件所在的位置 
示例代码：
第一个html文件
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<a href="#contentA">书签A</a>
		<a href="#contentB">书签B</a>
		<a href="student/demo_a_pagetag.html#contentA">第二个页面的书签A</a>
		
		
	</body>
</html>

在student文件夹下的demo_a_pagetag.html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<p> this is my content9</p>
		<p> this is my content9</p>
		<p> this is my content9</p>
		<p> this is my content9</p>
		
		
		<p> this is my content</p>
		
		<p> this is my content</p>
		<p> this is my content</p>
		
		<p> this is my content</p>
		<p> this is my content</p>
		
		<p> this is my content</p>
		<p> this is my content</p>
		
		<p> this is my content</p>
		<a name="contentA">这是书签A</a>
		<p> this is my content9</p>
		<p> this is my content9</p>
		<p> this is my content</p>
		<p> this is my content</p>
		
		<p> this is my content</p>
		<p> this is my content</p>
	</body>
</html>
2.3 外部链接
通过HTTP协议 
网页中最常使用HTTP协议进行外部链接的是在设置友情连接时 
语法 
<A href=”https://....”>链接文字</A> 
语法解释 
在该语法中，https://表明这是关于HTTP协议的外部链接，而在其后则输入网站的网址即可。
发送Email 
在网络中，很多拥有个人网页的朋友都喜欢在网站的醒目位置处写上自己的电子邮件地址，这样网页浏览者一旦用鼠标单击一下由mailto组成的超链接后，就能自动打开当前计算机系统中默认的电子邮件客户端软件， 
例如Outlook Express、Foxmail等。其实这是通过mailto标签来实现的。 
语法
<A href=“mailto:电子邮件地址”>链接文字</A>
语法解释
在该语法的电子邮件地址后还可以增加一些参数，如下表所示 
示例代码:
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<a href="mailto:liuj@hqyj.com?Subject=关于703传课">发送邮件</a>
	</body>
</html>

当有多个时用地址符&区分：
<a href="mailto:liuj@hqyj.com?Subject=关于703传课&CC=zheng@hqyj.com">发送邮件</a>
下载文件

如果希望制作下载文件的链接，只需在链接地址处输入文件所在的位置即可。 
当浏览器用户单击链接后，浏览器会自动判断文件的类型，以做出不同情况的处理 
语法
<A href=”文件所在地址”>链接文字</A>
语法解释
在文件所在地址中设置文件的路径，可以是相对地址，也可以是绝对地址 

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<a href="img/header_firstPage.png">下载图片</a>
	</body>
</html>
```


- table表格标签
```
3.1 表格基本语法
<table> 元素：定义一个表格。每一个表格只有一对<table>和</table>，一张页面中可以有多个表格。
<tr>元素：定义表格的行，一个表格可以有多行，所以<tr>对于一个表格来说不是唯一的。
<td>元素：定义表格的一个单元格。每行可以有不同数量的单元格，在<td>和</td>之间是单元格的具体内容。
需要注意的是：上述的三个元素必须、而且只能够配对使用。缺少任何一个元素，都无法定义出一个表格。
表格中除了<td>和</td>可用来设置表格的单元格外，还可以通过caption来设置特殊的一种单元格——标题单元格。 
表格的标题一般位于整个表格的第一行，为表格标识一个标题行，如同在表格上方加一个没有边框的行，通常用来存放表格标题。
语法
    <caption>表格的标题</caption>
在表格中还有一种特殊的单元格，称为表头。 
表格的表头一般位于第一行和第一列，用来表明这一行的内容类别，用<th>和</th>标记来表示。 
表格的表头与<td>标记使用方法相同，但是表头的内容是加粗显示的。
语法
<table>
<tr>
<th>表格的表头</th>
<th>表格的表头</th>
</tr>
<tr>
<td>单元格内的文字</td>
<td>单元格内的文字</td>
</tr>
</table> 

示例代码
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<table border="1px">
			<caption>季度销售表</caption>
			<tr>
				<th>一月</th>
				<th>二月</th>
				<th>三月</th>
				<th>四月</th>
			</tr>
			<tr>
				<td>334</td>
				<td>232</td>
				<td>5656</td>
				<td>566</td>
			</tr>
			<tr>
				<td>334</td>
				<td>232</td>
				<td>5656</td>
				<td>566</td>
			</tr>
			<tr>
				<td>334</td>
				<td>232</td>
				<td>5656</td>
				<td>566</td>
			</tr>
		</table>
	</body>
</html>
3.2 表格的属性
设置表格宽度——width
设置表格高度——height 
设置表格对齐方式——align ：

表格的基本属性包括表格的大小和对齐方式。
width属性：指定表格或某一个表格单元格的宽度。单位可以是%或者像素。
height属性：指定表格或某一个表格单元格的高度。单位可以是%或者像素。
align属性：指定表格或某一个单元格里的内容（文本、图片等）的对齐方式。 
align参数可以取值为left（左对齐）、center（居中）或 right（右对齐），表格在页面的对齐方式。

表格除了设置基本属性外，还可以设置边框效果，包括颜色、宽度等。
border属性：表格边线粗细。
bordercolor属性：指定边框的颜色，设置边框颜色的前提是边框的宽度不能为0。
Cellspacing属性：指定表格内部各个单元格之间的宽度。 
Cellpadding属性：指定表格内文字与边框间距。
设置表格背景颜色——bgcolor 
设置表格的背景图像——background
为了凸显表格，还可以为表格设置与页面不同的背景。
bgcolor属性：指定表格或某一个单元格的背景颜色。
background属性：指定表格或某一个单元格的背景图片。其属性值为一个URL地址。 

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<table border="1px" width="300px" height="200px" align="right" bordercolor="red" cellspacing="50px" cellpadding="30px">
			<caption>季度销售表</caption>
			<tr>
				<th>一月</th>
				<th>二月</th>
				<th>三月</th>
				<th>四月</th>
			</tr>
			<tr>
				<td>334</td>
				<td>232</td>
				<td>5656</td>
				<td>566</td>
			</tr>
			<tr>
				<td>334</td>
				<td>232</td>
				<td>5656</td>
				<td>566</td>
			</tr>
			<tr>
				<td>334</td>
				<td>232</td>
				<td>5656</td>
				<td>566</td>
			</tr>
		</table>
	</body>
</html>

运行结果
```


- 行属性
```
高度的控制——height 
边框颜色——bordercolor （IE支持，google不支持） 
行背景——bgcolor、background 
行文字的水平对齐方式——align （取值left、center、 right）
行文字的垂直对齐方式——valign（取值top、middle、bottom） 
```


- 单元格属性
```
表格中另外一种元素就是单元格，单元格的属性标记和行标记非常相似。 
width、height属性：指定单元格的高度和宽度，单元格高度和宽度的单位是像素 。
colspan属性：指定单元格水平跨度 ，单元格跨越几列。
rowspan属性：指定单元格垂直方向上跨行 
valign属性：指定某一个单元格里的内容（文本、图片等）的垂直对齐方式。垂直对齐方式的属性值包 
top：顶端对齐； 
middle：居中对齐； 
bottom：底端对齐； 
Baseline：相对于基线对齐；
单元格属性 
align属性：指定某一个单元格里的内容（文本、图片等）水平对齐方式的取值可以是left、center或right 。
bgcolor属性：指定单元格背景颜色。
background属性：指定单元格的背景图像 
合并单元格 
colspan属性：指所要合并单元格的列数，横向合并。 
rowspan属性：指所要合并单元格的行数，纵向合并。
```

- 练习
```
练习1：
学生信息表
学号	姓名	年龄
		
		
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<table border="1px" width="300px">
			<caption>学生信息表</caption>
			<tr align="left">
				<th>年龄</th>
				<th>姓名</th>
				<th>学号</th>
			</tr>
			<tr>
				<td>00&nbsp;1</td>
				<td>jane</td>
				<td>22</td>
			</tr>
			<tr>
				<td>002</td>
				<td>violet</td>
				<td>34</td>
			</tr>
		</table>
	</body>
</html>

练习2：小键盘布局
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<table border="1px" cellspacing="10px">
			<tr align="center">
				<td width="50px" height="50px">Num<br />Lock</td>
				<td width="50px" height="50px">/</td>
				<td width="50px" height="50px">*</td>
				<td width="50px" height="50px">-</td>
			</tr>
			<tr align="center">
				<td width="50px" height="50px">7</td>
				<td width="50px" height="50px">8</td>
				<td width="50px" height="50px">9</td>
				<td width="50px" height="50px" rowspan="2">+</td>
			</tr>
			<tr align="center">
				<td width="50px" height="50px">4</td>
				<td width="50px" height="50px">5</td>
				<td width="50px" height="50px">6</td>
			</tr>
			<tr align="center">
				<td width="50px" height="50px">1</td>
				<td width="50px" height="50px">2</td>
				<td width="50px" height="50px">3</td>
				<td width="50px" height="50px" rowspan="2">Enter</td>
			</tr>
			<tr align="center">
				<td width="50px" height="50px" colspan="2">0</td>
				<td width="50px" height="50px">del</td>
			</tr>
		</table>
	</body>
</html>

运行结果：
```

- 知识点补充：
```
&nbsp; 转义字符，代表空格（如果直接敲空格，不管一次性敲多少个都算1个）
4 form表单
概述
 在HTML中，<form></form>标记对用来创建一个表单，即定义表单的开始和结束位置。在标记对之间的一切都属于表单的内容。 
每个表单元素开始于form元素，可以包含所有的表单控件，还有任何必需的伴随数据，如控件的标签、处理数据的脚本或程序的位置等。 
在表单的<form>标记中，还可以设置表单的基本属性，包含表单的名称、处理程序、传送方法等。 
一般情况下，表单的处理程序action和传送方法method是必不可少的参数。

封装提交给后台数据的控件。
处理动作——action 
表单名称——name 
传送方法——method 
编码方式——enctype 
目标显示方式——target  
action属性：用来定义表单处理程序的位置(相对地址或绝对地址)。
Name属性：用来给表单命名。
Method属性：定义表单结果从浏览器传送到服务器的方法,一般有两种方法： 
Get 
Post
enctype 属性：用于设置表单信息提交的编码方式。
enctype属性为表单定义了MIME编码方式，编码方式的取值如下表所示

target属性：用来指定目标窗口的打开方式。 
_blank是指将返回的信息显示在新打开的窗口中；
_parent是指将返回信息显示在父级的浏览器窗口中；
_self则表示将返回信息显示在当前浏览器窗口；
_top表示将返回信息显示在顶级浏览器窗口中 
method=get：不安全
使用这个设置时，表单数据会被视为CGI或ASP的参数发送 
也就是来访者输入的数据会附加在URL之后 
url？变量名=值&变量名=值 
由用户端直接发送至服务器，所以速度上会比post快 
但缺点是数据长度不能够太长 
在没有指定method的情形下，一般都会视get为默认值。
method=post：安全
使用这种设置时，表单数据是与URL分开发送的 
用户端的计算机会通知服务器来读取数据 
所以通常没有数据长度上的限制，缺点是速度上会比get慢。 
提交敏感信息比如用户名和密码的时用post。提交给服务器不敏感信息比如查询条件用get提交
```

- 输入空间
```
输入类控件概述
按照控件的填写方式可以分为输入类和菜单列表类。 
输入类的控件一般以input标记开始，说明这一控件需要用户的输入； 
而菜单列表类则以select开始，表示用户需要选择。 
按照控件的表现形式则可以将控件分为文本类、选项按钮、菜单等几种。
在HTML表单中，input参数是最常用的控件标记，包括最常见的文本域、按钮都是采用这个标记 
语法 
<form>
    <input name="控件名称" type="控件类型" />   
</form>
	type取值如下：
文字字段——text 
密码域——password 
单选按钮——radio 
复选框——checkbox 
普通按钮——button 
提交按钮——submit 
重置按钮——reset 
图像域——image 
隐藏域——hidden 
文件域——file 

5.1 输入文本框
<input name=“”type=“”value=“”maxlength=“”size=“”>
name  文本框的名字
type  text,password 
value  默认值
maxlength  最大输入字符数 
size  长度
5.2单选按钮
单选框能够进行项目的单项选择，以一个圆框表示。
语法
<input type="radio" value="单选按钮的取值" name="单选按钮名称" checked="checked"/>
语法解释
在该语法中，checked属性表示这一单选按钮默认被选中， 
而在一个单选按钮组中只能有一项单选按钮控件设置为checked。
Value则用来设置用户选中该项目后，传送到处理程序中的值。
5.3 复选框
复选框在页面中以一个方框来表示。
语法
<input type="checkbox" value="复选框的值" name="名称" checked="checked" />
语法解释
在该语法中，checked参数表示该选项在默认情况下已经被选中 
一个选择中可以有多个复选框被选中 
5.4按钮
包括普通按钮、提交按钮和重置按钮
语法
<input type=“button ” value=“普通按钮" name=“B1">
<input type="submit" value="提交" name=“B2">
<input type="reset" value="全部重写" name=“B3">
5.5 图像按钮
概述
图像域是指可以用在提交按钮位置上的图片，这幅图片具有按钮的功能。 
使用默认的按钮形式往往会让人觉得单调。 
如果网页使用了较为丰富的色彩，或稍微复杂的设计再使用表单默认的按钮形式甚至会破坏整体的美感。 
这时，可以使用图像域，创建和网页整体效果相统一的图像提交按钮。 
语法
<input type="image" src="图像地址" name="图像域名称" />
语法解释
在该语法中，图像地址可以是绝对地址或相对地址。 
5.6 隐藏域
概述
表单中的隐藏域主要用来传递一些参数， 
而这些参数不需要在页面中显示。 
当浏览者提交表单时，隐藏域的内容会一起提交给处理程序。
语法
<input type="hidden" name="隐藏域名称" value="提交的值" /> 
5.7 文件域
概述
文件域在上传文件时常常用到，它用于查找硬盘中的文件路径，然后通过表单将选中的文件上传。 
在设置电子邮件的邮件、上传头像、发送文件时常常会看到这一控件。
语法
<input type="file" name="文件域的名称” > 
5.8 菜单标记 （下拉框）
概述
菜单列表类的控件主要用来进行选择给定答案中的一种 
这类选择往往答案比较多，使用单选按钮比较浪费空间。 
菜单列表类的控件主要是为了节省页面空间而设计的。 
菜单和列表都是通过<select>和<option>标记来实现的。
语法
<select name="下拉菜单的名称">
  	<option value="" selected="selected”>A</option>
  	<option value="选项值”>B</option>
  	<option value="选项值”>C</option>
	<option value="选项值”>D</option>
	<option value="选项值”>E</option>
</select>
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<form action="" name="myform" method="get" enctype="multipart/form-data">
			<input type="hidden" name="id"  value="5"/>该输入域不显示到页面上	<br />
			<input type="text" name="username" placeholder="please input your name" maxlength="5" size="100"/>
			<br />
			<input type="password" name="password" />
			<br />
			<input type="radio" name="sex" value="male" checked="checked"/>男
			<input type="radio" name="sex" value="female"/>女
			<br />
			<input type="checkbox" name="hobby" value="reading"/>读书
			<input type="checkbox" name="hobby" value="swimming" checked="checked"/>游泳
			<input type="checkbox" name="hobby" value="sport" checked="checked"/>运动
			<br />
			<input type="reset" value="重置" />将form表单所有的输入信息清空	
			<br />
			<input type="button" value="普通按钮" onclick=""/>
			<br />
			<input type="submit" value="提交" /> submit按钮会将form表单的值提交给action对应的后台文件	
			<br />
			<input type="file" />提交文件给服务器，此时enctype值必须是multipart/form-data
			<br />
			<input type="image" src="img/product1.png" onclick="javascript:alert('hello')"; />与按钮的区别是显示不是文本而是图片
			<br />
			<select>
				<option>辽宁省</option>
				<option selected="selected">黑龙江</option>
				<option>吉林</option>
				<option>河北</option>
			</select>
			<br />
			<textarea name="" rows="5" cols="50"></textarea>
		</form>
	</body>
</html>
	

运行结果：
```

- 练习
```
新用户注册
                                                                                  
					姓名：
					密码：
					性别：
					爱好：多选框列出
					所在地区：下拉框显示几个城市
					
					
						重置按钮	注册按钮
示例代码：
practice_3.html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style>
			a{
				color: blue;
			}
		</style>
	</head>
	<body bgcolor="#f5f5f5" >
		<form>
			<table width="500"  align="center">	
				<caption>新用户注册</caption>
				<caption><hr width="800" size="1" color="black" align="center" /></caption>
				<tr>
					<td align="right" width="250">姓名：</th>
					<td align="left"  width="250"><input type="text" name="username"/></th>
				</tr>
				<tr>
					<td align="right">密码：</td>
					<td align="left"><input type="password" name="password"/></td>
				</tr>
				<tr>
					<td align="right">性别：</td>
					<td align="left">
						<input type="radio" name="sex" value="male"/>男
						<input type="radio" name="sex" value="female"/>女
					</td>
				</tr>
				<tr>
					<td align="right">爱好：</td>
					<td align="left">
						<input type="checkbox" name="hobby" value="reading"/>读书
						<input type="checkbox" name="hobby" value="runing"/>跑步
						<input type="checkbox" name="hobby" value="singing"/>唱歌
					</td>
				</tr>
				<tr>
					<td align="right">所在地区：</td>
					<td align="left">
						<select>
							<option>辽宁省</option>
							<option>吉林省</option>
							<option>黑龙江省</option>
						</select>
					</td>
				</tr>
				<tr align="center">
					<td  colspan="2" align="center">
						<input type="checkbox" name="agree" value="agree"/><span style="font-size: 10px;">我已阅读并同意智联招聘<a href="yhfwxy.html">《用户服务协议》</a>和<a href="yszc.html">《隐私政策》</a></span>
					</td>
				</tr>
				<tr>
					<td align="right">
						<input type="reset" value="重置按钮"/>
					</td>
					<td align="left">
						<input type="submit" value="注册按钮"/>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

yhfwxy.html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		这是用户服务协议
	</body>
</html>

yszc.html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		这是隐私政策
	</body>
</html>

运行结果：
```


- html布局
```
Div布局
表格布局
```
- Div布局
```
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<div>块元素div在同一行显示，方式一使用display转换成行内（块）元素</div>
		<div style="border: 1px solid red;display: inline;">hello</div>
		<div style="border: 1px solid red;display: inline;">hello,everyone</div>
		
		<div>块元素div在同一行显示，方式二使用float样式</div>
		<div style="border: 1px solid red;float: left;">hello</div>
		<div style="border: 1px solid red;float: left;">hello,everyone</div>
		<br />
		<div>块元素div在同一行显示，方式二使用float样式</div>
		<div style="border: 1px solid red;float: right;">hello</div>
		<div style="border: 1px solid red;float: right;">hello,everyone</div>
	</body>
</html>

运行结果：

代码改良：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<div>块元素div在同一行显示，方式一使用display转换成行内（块）元素</div>
		<div style="border: 1px solid red;display: inline;">hello</div>
		<div style="border: 1px solid red;display: inline;">hello,everyone</div>
		
		<div>块元素div在同一行显示，方式二使用float样式</div>
		<div style="border: 1px solid red;float: left;">hello</div>
		<div style="border: 1px solid red;float: left;">hello,everyone</div>
		<br />
		<div style="clear: both;">块元素div在同一行显示，方式二使用float样式</div>
		<div style="border: 1px solid red;float: right;">hello</div>
		<div style="border: 1px solid red;float: right;">hello,everyone</div>
	</body>
</html>

运行结果：
```

```
练习

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<div style="width: 770px;">
			<div style="width: 770px;height: 70px;background-color: #ffa500;">
				<span style="font-size: 50px;"><b>Main Title of Web Page</b></span>
			</div>
			<div style="width:150px ;height: 305px;background-color: #ffd700;float: left;">
				<strong>Menu</strong><br />
				<span>Html</span><br />
				<span>Css</span><br />
				<span>JavaScript</span><br />
			</div>
			<div style="width:620px ;height:305px ;background-color: #eeeeee;float: left;">
				<span>Content goes here</span>
			</div>
			<div style="width: 770px;height: 28px;background-color: #ffa500;clear: both;" align="center">
				<span>Copyright?W3CSchool.cc</span>
			</div>		
		</div>
	</body>
</html>
```

```
知识点补充：
(1)margin: 0px auto让div居中。
(2)如果让标签宽高支持百分比，父组件需要有宽和高。如果父组件是body，需要将html和body的宽和高设置100%
(3)float能将标签浮动，将块元素同一行显示。clear：both清除浮动。
(4) clear：both：左右两边不允许有浮动，清除浮动。如果div想在一行显示，让div设置float浮动。如果后续的div不想在同一行显示，需要设置clear:both
```

```
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		
		<style>
			html,body{
				height: 100%;
				width: 100%;
			}
		</style>
	</head>
	<body>
		<div style="width: 1024px;margin: 0px auto;height: 100%;border: 1px solid red;">
			<div style="width: 100%;height: 20%;background-color: #ffa500;">
				<span style="font-size: 50px;"><b>Main Title of Web Page</b></span>
			</div>
			<div style="width:20%;height: 75%;background-color: #ffd700;float: left;">
				<strong>Menu</strong><br />
				<span>Html</span><br />
				<span>Css</span><br />
				<span>JavaScript</span><br />
			</div>
			<div style="width:80% ;height:75%;background-color: #eeeeee;float: left;">
				<span>Content goes here</span>
			</div>
			<div style="width:  100%;height: 5%;background-color: #ffa500;clear: both;" align="center">
				<span> Copyright?W3CSchool.cc </span>
			</div>			
		</div>
	</body>
</html>

运行结果：
```
