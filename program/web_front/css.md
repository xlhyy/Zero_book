### css


- css优点
```
HTML用于结构化内容；CSS用于格式化结构化的内容。CSS最重要的目标是将文件的内容与显示分隔开来。 
CSS 的主要优点是容易更新，只要对一处 CSS 规则进行更新，则使用该定义样式的所有文档的格式都会自动更新为新样式。 
通过仅仅编辑一个简单的 CSS 文档，外部样式表使你有能力同时改变站点中所有页面的布局和外观。 
```


- css语法
```
CSS 规则由两个主要的部分构成：选择器，以及一条或多条声明。 
CSS代码注释以/*开头，以*/结束。如下：
p{text-align:center;
/*这是另一个注释*/
color:black;font-family:arial;}

CSS语法基础
一个CSS样式表代码由一个或多个CSS规则组成； 
CSS样式规则由选择器和格式声明语句组成； 
选择器通常是您需要改变样式的 HTML 元素； 
格式声明语句放在{ }内； 
每一条格式声明语句由“属性名:属性值”对组成，属性名和属性值间以冒号隔开，每条声明语句以英文状态下的分号“;”结束。 
CSS对大小写不敏感。

css的注释/*  */
html的注释<!--   -->
```


- css元素
```
如果你要在HTML元素中设置CSS样式，你需要在元素中设置"id" 和 "class"选择器。
id 选择器可以为标有特定 id 的 HTML 元素指定特定的样式。 
HTML元素以id属性来设置id选择器,CSS 中 id 选择器以 "#" 来定义。
例如： 
CSS样式： 
 #para1{text-align:center;color:red;}
html样式：
<p id="para1">Hello World!</p> 

class 选择器用于描述一组元素的样式， 
class 选择器有别于id选择器，class可以在多个元素中使用。 
class 选择器在HTML中以class属性表示, 
在 CSS 中，类选择器以一个点"."号显示： 
例如： 
<h1 class="center">标题居中</h1>
<p class="center">段落居中。</p> 
在以下的例子中，所有拥有 center 类的 HTML 元素均为居中。 
.center {text-align:center;}
也可以指定特定的HTML元素使用class。
在以下实例中, 所有的 p 元素使 用 class="center" 让该元素的文本居中:
p.center {text-align:center;} 

示例代码:
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style>
			/*id的值不允许重复，class的值允许重复*/
			/*id选择器，只能作用在一个标签上*/
			#box{
				width: 100px;
				height: 100px;
				background-color: red;
			}
			/*class选择器，可以作用在多个标签上*/
			.box2{
				width: 200px;
				height: 200px;
				background-color: yellow;
			}
		</style>
	</head>
	<body>
		<div id="box"></div>
		
		<div class="box2"></div>
		
		<!--<div id="box"></div>  id的值不能重复-->
		
		<div class="box2"></div>
	</body>
</html>

运行结果：
```


- css样式表使用方式
```
插入样式表的方法有三种:
外部样式表：在文档头部用 <link> 标签定义,当样式需要应用于很多页面时使用。
如：<link rel="stylesheet" type="text/css" href="mystyle.css">
内部样式表：在文档头部用 <style> 标签定义，当单个文档需要特殊的样式时使用。
如：<style>
h1{color:#C39}
p{text-align:center}
</style>
内联样式：当样式仅需要在一个元素上应用一次时使用。
如：<p style="color:#C39;margin-left:20px">This is a test.</p>

外部样式表使用示例代码
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<link rel="stylesheet" href="css/mystyle.css" />
	</head>
	<body>
		<div id="box"></div>
		
		<div class="box2"></div>
		
		<!--<div id="box"></div>  id的值不能重复-->
		
		<div class="box2"></div>
	</body>
</html>

mystyle.css
#box{
	width: 100px;
	height: 100px;
	background-color: red;
}

.box2{
	width: 200px;
	height: 200px;
	background-color: yellow;
}

运行结果：


使用外部样式表，相对于内联和内部式，有以下优点： 
样式代码可以复用。一个外部CSS文件，可以被很多网页共用。 
便于修改。如果要修改样式，只需要修改CSS文件，而不需要修改每个网页。 
提高网页显示的速度。 
如果样式写在网页里，会降低网页显示的速度，
如果网页引用一个CSS文件，这个CSS文件多半已经在缓存区(其它网页早已经引用过它)，网页显示的速度就比较快。 
注：优先级  内联样式>内部样式>外部样式 
```


- css组合
```
组合(Grouping) 
你也可以将相同的属性和属性值赋予多个Selector（选择器）。
Selector之间用逗号分隔。 
   例如： 
     h1,h2,h3,h4,h5,h6 
    { 
     color: red; 
    } 
  上面的例子是将所有正文标题(<h1>到<h6>)的字体颜色都变成红色。
6 a链接标签的伪类：
链接样式，可以用任何CSS属性（如颜色，字体，背景等）。 
特别的链接，可以有不同的样式，这取决于他们是什么状态。
这四个链接状态是：
a:link - 正常，未访问过的链接
a:visited - 用户已访问过的链接
a:hover - 当用户鼠标放在链接上时
a:active - 链接被点击的那一刻
 注意：四个链接状态必须按照顺序写，否则不起作用。顺序规则爱恨法则（love-hate）link，visited，hover，active，必须按照这样顺序书写。

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style>
			a:link{
				color: yellow;
			}
			a:visited{
				color: blue;
			}
			a:hover{
				color: red;
			}
			a:active{
				color: black;
			}
		</style>
	</head>
	<body>
		<a href="#">百度</a>
		<a href="#">百度</a>
		<a href="#">百度</a>
		<a href="#">百度</a>
		
	</body>
</html>

运行结果：
```


```
注：由于浏览器有记忆功能，故只有第一次运行时会正常显示。以后运行时只会显示visited
```


- 盒子模型
```
CSS 盒子模型(Box Model)
所有HTML元素可以看作盒子 。
在CSS中，"box model"这一术语是用来设计和布局时使用。
CSS盒模型本质上是一个盒子，封装周围的HTML元素。
它包括：边距，边框，填充，和实际内容。
盒模型允许我们在其它元素和周围元素边框之间的空间放置元素。
下面的图片说明了盒子模型(Box Model): 

不同部分的说明：
Margin(外边距) - 清除边框外的区域，外边距是透明的。
Border(边框) - 围绕在内边距和内容外的边框。
Padding(内边距) - 清除内容周围的区域，内边距是透明的。
Content(内容) - 盒子的内容，显示文本和图像。
```


- css优化
```
一个良好的首页布局及规划对于整站的运作起着关键的作用，故首页的优化就显得极为重要。
对于代码的布局方便CSS不可过多，当一个网站内页的页面文字过少，代码过多往往会影响网站优化；我们要做到的尽量是文字多，代码少才能更利于网站优化， 
所以，这时候我们要利用如外部样式表来进行引用精简代码，常使用DIV+CSS的方式进行布局优化。
尽量以列表形式罗列更新内容，列表形式的使用能在空间跟效果上实现首页的优化，也能够尽量多的展现网站的最新动态，对用户的巩固很有帮助。 
```


- css选择器
```
9.1 元素选择器（又叫标签选择器）
概述 
元素选择器是CSS选择器中最常见的选择器 
因为文档的元素就是最基本的选择器 
如果设置元素样式那选择器就是元素本身 
语法 
<div></div> 	div{width:100px;height:100px;}
语法解释 
我们如果选择一个div元素那我们可以直接以div为选择器
9.2 class选择器
概述 
class选择器是CSS选择器中经常使用到的选择器 
class选择器可以定义一种样式，然后由多个元素使用 
class选择器可以帮我们极大的简化代码 
语法 
<div class=“box”></div>	.box{width:100px;height:100px;}
语法解释 
我们可以给一个class名添加一种样式。然后将这个class名添加给好几个元素，这样这几个元素就同时拥有这一种样式，class名前的”.”一定要加上。 
9.3 id选择器
概述 
id选择器在文件中用到“重要”元素上 
重要元素即为，我们可以通过这个元素去寻找到其子级元素 
id选择器名在一个文档中只能出现一次 
语法 
<div id=“box”></div> 	#box{width:100px;height:100px;}
语法解释 
Id选择器的使用方法与class选择器的方法一样只是其代表的意义不一样，一个为给多个元素添加，一个只能给单个元素添加，id名前的”#”一定要加上。 
9.4 通配符
概述 
通配符为选择页面中的所有元素，包括html和body。
通配符的权重最小，随便给个样式就会覆盖通配符的样式 
语法 
*{border：1px solid red};
语法解释 
通配符的写法为一个*号代表选择了页面中的所有元素。
9.5群组选择器
概述 
群组选择符是由各种选择符组合而成。 
群组选择符的权重为组成选择符相加之和 
语法 
#box,.box,div{border：1px solid red};
语法解释 
语法为给id为box和class名为box和div元素添加一个1px的红色边框。 

9.6后代选择器
概述 
后代选择器是选择一个元素下的某个元素。 
后代选择器是用于更精准的选择到某个元素 
语法 
#box p{border：1px solid red};
语法解释 
语法为选择到id名为box元素下的所有p元素，并添加一个1px的红色边框。 

示例代码1：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style>
			#box p{
				border: 1px solid red;
			}
		</style>
	</head>
	<body>
		<p>hello</p>
		<div id="box">
			<p>hello</p>
			<p>helloouo</p>
			<div>
				<p>fowuerowur</p>
			</div>
		</div>
	</body>
</html>
运行结果：

#box p id为box的标签中所有p元素（包括后代元素（孙子元素））都使用该样式

示例代码2：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style>
			#box>p{
				border: 1px solid red;
			}
		</style>
	</head>
	<body>
		<p>hello</p>
		<div id="box">
			<p>hello</p>
			<p>helloouo</p>
			<div>
				<p>fowuerowur</p>
			</div>
		</div>
	</body>
</html>
运行结果

#box>p 代表id为box的元素的子元素（不包括后代元素）使用该样式
```


- css继承
```
CSS继承为特定的CSS属性向下传递到子孙元素。 
直白一点说就是我们给父级定义了特定的样式，而子级也会实现效果。 
在我们编写的页面中继承效果是经常使用到的。 
继承没有特定的代码，而是一种效果。 
我们可以想象一下如果没有继承，我们每个元素都需要去写一些特定的样式。 

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style>
			div{
				color: red;
			}
		</style>
	</head>
	<body>
		<div>
			<span>hello</span>
			<div>
				<span>world</span>
			</div>
		</div>
	</body>
</html>

运行结果：


10.1 css能够继承的属性
文本相关的属性： 
font-family：字体
font-size：字体大小 例如：12px 
font-style：字体样式。font-style:oblique(偏斜体)/italic(斜体)/normal(正常);
font-variant：
	属性设置小型大写字母的字体显示文本，这意味着所有的小写字母均会被转换为大写，但是所有使用小型大写字体的字母与其余文本相比，其字体尺寸更小。 取值如下：
small-caps：浏览器会显示小型大写字母的字体 ；
normal ：默认值。浏览器会显示一个标准的字体；
inherit：规定应该从父元素继承 font-variant 属性的值。
font-weight
	文本的粗细。取值如下：normal，bold，bolder，lighter，100-900粗细。400等同于normal，700等同于bold。
		
letter-spacing
	增加或减少字符间的空白（字符间距）。 
line-height
	属性设置行间的距离（行高）。 一般设置文字垂直居中
text-align
	文本对齐方式： text-align:/left(左对齐)/right(右对齐)/center(居中)。
text-indent
	缩进。必须是块元素。
text-transform
	将单词转换大小写。取值如下:
		none：无转换 
		capitalize： 将每个单词的第一个字母转换成大写 
		uppercase： 转换成大写 
		lowercase： 转换成小写 
word-spacing
	设置对象中的单词之间间隔。 

列表相关的属性： 
list-style-image:设置每条li的图片
list-style-position 
list-style-type
list-style：（最常用的是none）

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style>
			#box1{
				border: 1px solid blue;
				color: red;
				font-style: oblique;
				text-align: center;
			}
			#box2{
				font-variant: small-caps;
				font-weight: 600;
			}
			#box3{
				line-height: 100px;
			}
			#box4{
				letter-spacing: 10px;
			}
			#box5{
				text-indent: 50px;
				text-transform: capitalize;
			}
			#box6{
				word-spacing: 20px;
				
			}
		</style>
	</head>
	<body>
		<div id="box1">
			jfwuerauoWSKWHEWROWIEURW你好文俄日
		</div>		
		<div id="box2">
			jfwuerauoWSKWHEWROWIEURW你好文俄日
		</div>
		<div id="box3">
			jfwuerauoWSKWHEWROWIEURW你好文俄日
		</div>
		<div id="box4">
			hello everyone nice to meet you 你好
		</div>
		<div id="box5">
			hello everyone nice to meet you 你好
		</div>
		<div id="box6">
			hello everyone nice to meet you 你好
		</div>
	</body>
</html>

运行结果：
```


- 样式优先级
```
多重样式： 
如果外联样式、内联样式和行间样式同时应用于同一个元素，就是使多重样式的情况。
一般情况下，优先级如下（先定义style内部样式表，在用link引入外部样式表，此时外部样式表起作用） （但是我们写的时候，一般都把link写在style之前）
行间样式>内联样式>外联样式（与内联样式>内部样式>外部样式 是同一个意思，由于翻译问题所导致）

12选择器优先级
在讲解选择器的优先权问题时候，会涉及到行间样式表的情况，因为行间样式的添加相对于各种选择器的权重都要高。 
权重： 
行间样式权重 = 1000
id选择器权重 = 100
class选择器权重  = 10
元素选择器权重 = 1
群组选择器权重 = 群组中包含选择器权重相加之和 
后代选择器权重 = 后代选择器包含选择器相加之和 
注意：如果权重值相同则按照页面加载顺序，后写的样式起作用。

示例代码1：id选择器与class选择器的例子
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style>
			#box{
				width: 200px;
				height: 200px;
				background: red;
			}
			.box{
				width: 100px;
				height: 100px;
				background: blue;
			}
		</style>
	</head>
	<body>
		<div id="box" class="box"></div>
	</body>
</html>

运行结果：


示例代码2：行间样式表优先级的例子
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style>
			#box{
				width: 200px;
				height: 200px;
				background: red;
			}
			.box{
				width: 100px;
				height: 100px;
				background: blue;
			}
		</style>
	</head>
	<body>
		<div id="box" class="box" style="background: yellow;"></div>
	</body>
</html>

运行结果：

注：如上书写代码时，运行结果中的方框大小由id选择器中的值决定。
```


- css编写规则
```
11.1 命名
一个乱七八糟的命名方式，无论是谁看到恐怕都会抓狂。 
正常来说每个公司都有一套自己的命名方式 
比如按照结构命名 
按照样式命名 
或者以自己名字首字母开头等 
一个良好的命名方式不但能够给人以耳目一新的感觉，而且还能够帮助我们更方便的维护代码，使我们更快的找到出问题的代码块。 
11.2缩进
缩进指的是当我们在编辑代码时候会使用Tab键或者空格帮助我们使代码对齐，例如： 
我们在图片上可以一眼就看到我们的选择器，这样我们可以更方便的去维护我们的代码。 

11.3 注释
代码注释可以让别人更容易读懂你的代码 
合理的组织代码注释，可使得结构更加清晰。 
对于代码的整体结构我们可以使用注释对其进行划分 
在有必要的地方对代码进行注释说明，更有利于团队开发。 
11.4 优化
良好的代码优化能够使我们的网页加载速度更高效，更快速。 
引入外联样式表 
利用CSS继承 
利用群组选择器 
```


- 浮动
```
CSS的float（浮动）会使元素向左或向右移动，其周围的元素也会重新排列。 
元素的水平方向浮动，意味着元素只能左右移动而不能上下移动。 
一个浮动元素会尽量向左或向右移动，直到它的外边缘碰到包含框或另一个浮动框的边框为止。 
浮动元素之后的元素将围绕它。 
浮动元素之前的元素将不会受到影响。
```


- css属性
```
13.1字体属性
字体属性 
字体大小：font-size:10px;
字体样式：font-style:oblique(偏斜体)/italic(斜体)/normal(正常);
字体行高：line-height:10px;
字体粗细：font-weight:bold(粗)/lighter(细)/normal(正常);
文字间距：letter-spacing:normal;数值 px/pt/em.
文字对齐：text-align:justify(两端对齐)/left(左对齐)/right(右对齐)/center(居中)。 
文字缩进：text-indent：10px;
词间距：word-spacing:normal;数值 px;
字体修饰：text-decoration:underline(下划线)/overline(上划线)/line-through(删除线)/blink(删除线).
字体：font-family：“微软雅黑”;

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<style>
			#b1{
				text-decoration: overline;
			}
			#b2{
				border: 1px solid red;
				line-height: 50px;
				text-indent: 10px;
				text-decoration: line-through;
			}
		</style>
	</head>
	<body>
		<div id="b1">hello</div>
		<div id="b2">hello</div>
	</body>
</html>

运行结果：

13.2背景属性
背景属性 
背景颜色：background-color:#fff;
三位rgb：#rgb；六位rgb：#rrggbb；八位：#rrggbbaa（a透明度）
背景图片：background-image:url();
background-image: url(img/cartoon.png);
背景图片滚动：background-attachment:fixed(固定)/scroll(滚动);
fixed：图片不随滚动条滚动，始终在页面的原有位置
scroll:图片随滚动条滚动
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<style>
			body{
				background-image: url(img/cartoon.png);
				background-repeat: no-repeat;
				background-attachment: fixed;
			}
			#b1{
				height: 100px;
				text-decoration: overline;
			}
		</style>
	</head>
	<body>
		<div id="b1">
		<p>luifweriwperi</p>
		<p>luifweriwperi</p>
		<p>luifweriwperi</p>
		<p>luifweriwperi</p>		
		<p>luifweriwperi</p>
		<p>luifweriwperi</p>		
		<p>luifweriwperi</p>
		<p>luifweriwperi</p>		
		<p>luifweriwperi</p>
		<p>luifweriwperi</p>		
		<p>luifweriwperi</p>
		<p>luifweriwperi</p>
		<p>luifweriwperi</p>
		<p>luifweriwperi</p>
		<p>luifweriwperi</p>
		<p>luifweriwperi</p>
		<p>luifweriwperi</p>
		</div>
	</body>
</html>

运行结果：


背景图片位置：background-position:left(水平) top(垂直);
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<style>
			div{
				height: 100px;
				background-image: url(img/cartoon.png);
				background-repeat: no-repeat;
				border: 1px solid red;
			}
			#b1{
				background-position: 100px 30px;/*图片举例左边的距离100px，距离上面距离30px*/
			}
		</style>
	</head>
	<body>
		<div id="b1"></div>
		
		<div></div>
	</body>
</html>

运行结果：


简写方法:background:#fff url() left top repeat;
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<style>
			
			div{
				height: 100px;
				background: url(img/cartoon.png) 100px 30px no-repeat;
				border: 1px solid red;
			}
			
		</style>
	</head>
	<body>
		<div id="b1"></div>
	</body>
</html>

运行结果：


13.3 边框属性
边框属性 
边框样式：border-style:dotted(点线);
dashed(虚线);
solid(实线);
double(双线);
边框宽度：border-width:1px;
边框颜色：border-color:#fff;
简写方法：border: 1px solid #fff; 
13.4 定位属性
定位属性 
定位位置：position:absolute(绝对定位)/relative(相对定位)/fixed(固定定位);

元素是否可见：visibility:inherit(继承)/visible(可见)/hidden(不可见);
内容溢出：overflow:visible(溢出)/hidden(溢出隐藏)/scroll(显示滚动条)/auto;
裁剪：clip:rect(12px auto 12px auto);剪裁绝对定位元素。 
auto： 对象无剪切 
rect(<number>|auto <number>|auto <number>|auto <number>|auto)： 
依据上-右-下-左的顺序提供自对象左上角为(0,0)坐标计算的四个偏移数值，其中任一数值都可用auto替换，即此边不剪切。 示例：clip:rect(auto 50px 20px auto);
说明：上边不剪切，右边从第50个像素开始剪切直至最右边，下边从第20个像素开始剪切直至最底部，左边不剪切
13.4.1 position
（1）position：relative
相对定位
设置为相对定位的元素框会偏移某个距离。元素仍然保持其未定位前的形状，它原本所占的空间仍保留。 
如果将 top 设置为 20px，那么框将在原位置顶部下面 20 像素的地方。如果 left 设置为 30 像素，那么会在元素左边创建 30 像素的空间，也就是将元素向右移动。 
注意，在使用相对定位时，无论是否进行移动，元素仍然占据原来的空间。因此，移动元素会导致它覆盖其它框。 

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style type="text/css">
		
			.box{
				width: 100px;
				height: 100px;
				border: 1px double red;
			}
			
			#box2{
				position: relative;/*相对定位。相对于原来的位置进行移动。原来位置保留。下面的div不会向上移动*/
				left: 30px;
				top: 30px;
			}
		</style>
	</head>
	<body>
		<div class="pbox">
			<div class="box"></div>
			<div id="box2" class="box"></div>
			<div class="box">				
			</div>
		</div>		
	</body>
</html>

运行结果：


（2）position：absolute
设置为绝对定位的元素框从文档流完全删除，并相对于其包含块定位，包含块可能是文档中的另一个元素或者是初始包含块。 
元素原先在正常文档流中所占的空间会关闭，就好像该元素原来不存在一样。元素定位后生成一个块级框，而不论原来它在正常流中生成何种类型的框。 
绝对定位使元素的位置与文档流无关，因此不占据空间。这一点与相对定位不同，相对定位实际上被看作普通流定位模型的一部分，因为元素的位置相对于它在普通流中的位置。 
绝对定位的元素的位置相对于最近的已定位祖先元素(相对或绝对定位元素)，如果元素没有已定位的祖先元素，那么它的位置相对于最初的包含块。 

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style type="text/css">		
			.box1{
				width: 100px;
				height: 100px;
				border: 1px double red;
			}
			.box2{
				width: 30px;
				height: 30px;
				border: 1px double gray;	
			}
			#box3{
				position: relative;
			}
			#box4{
				position: absolute;
				/*绝对定位。原来的位置不保留，下面的会向上移动.相对于第一个有定位的祖先组件进行left和top移动。如果父组件position不是static，按照父组件的位置进行left和top移动。如果父组件position是static，找第一个由position定位的组件进行left和top移动。*/
			}
		</style>
	</head>
	<body>
		<div class="pbox">
			<div id="box3" class="box1"></div>
			<div id="box3" class="box1"></div>
			<div id="box4" class="box1" style="left: 30px;top: 30px;"></div>
			<div id="box3" class="box1"></div>
		</div>
		
	</body>
</html>

运行结果：


（3）position：fixed
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style type="text/css">
			*{
				margin: 0px;
				padding: 0px;
			}
			.pbox{
				width: 1000px;
				height: 100px;
				background: gray;
				position: fixed;	/*固定定位，不随滚动条的滚动而滚动*/
			}
		</style>
	</head>
	<body>
		<div  class="pbox">
		</div>
		<p>slrooier</p>
		<p>slrooier</p>
		<p>slrooier</p>
		<p>slrooier</p>
		<p>slrooier</p>
		<p>slrooier</p>
		<p>slrooier</p>
		<p>slrooier</p>
		<p>slrooier</p>
		<p>slrooier</p>
		<p>slrooier</p>
		<p>slrooier</p>
		<p>slrooier</p>
		<p>slrooier</p>
		<p>slrooier</p>
		<p>slrooier</p>
	</body>
</html>

运行结果：

练习:
示例代码：（采用absolute）：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style type="text/css">
			.box{
				position: absolute;
				width: 100px;
				height: 100px;
				left: 30px;
				top: 30px;
			}
		</style>
	</head>
	<body>
		<div class="box" style="background: red;">
			<div class="box" style="background: green;">
				<div class="box" style="background: blue">
				</div>
			</div>
		</div>
		
	</body>
</html>

position属性定义建立元素布局所用的定位机制。 
任何元素都可以定位，不过绝对或固定元素会生成一个块级框，而不论该元素本身是什么类型。相对定位元素会相对于它在正常流中的默认位置偏移。 

13.5 元素是否可见
元素是否可见：visibility:inherit(继承)/visible(可见)/hidden(不可见);

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style type="text/css">
			.pbox{
				width: 1000px;
				height: 100px;
				visibility: hidden;
			}
		</style>
	</head>
	<body>
		<div  class="pbox">
			Hello World
		</div>
		
	</body>
</html>

13.6 内容溢出
内容溢出：overflow:visible(溢出.默认值)/hidden(溢出隐藏)/scroll(显示滚动条)/auto;
scroll：水平和垂直都有滚动条。垂直滚动条能滚动
auto：只有垂直有滚动条。

示例代码1：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style type="text/css">
			.pbox{
				width: 100px;
				height: 60px;
				border: 1px solid red;
				overflow: visible;
			}
		</style>
	</head>
	<body>
		<div  class="pbox">
			HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld
		</div>
	</body>
</html>

运行结果：


示例代码2：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style type="text/css">
			.pbox{
				width: 100px;
				height: 60px;
				border: 1px solid red;
				overflow: auto;
			}
		</style>
	</head>
	<body>
		<div  class="pbox">
			HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld HelloWorld
		</div>
	</body>
</html>

运行结果：

13.7 裁剪
裁剪：clip:rect(12px auto 12px auto);剪裁绝对定位元素。 
auto： 对象无剪切 
rect(<number>|auto <number>|auto <number>|auto <number>|auto)： 
依据上-右-下-左的顺序提供自对象左上角为(0,0)坐标计算的四个偏移数值，其中任一数值都可用auto替换，即此边不剪切。 示例：clip:rect(auto 50px 20px auto);
说明：上边不剪切，右边从第50个像素开始剪切直至最右边，下边从第20个像素开始剪切直至最底部，左边不剪切

练习


示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style>
			#i{
				position: absolute;
					
				clip: rect(36px 135px 74px auto);
				/*对于这个练习来说，使用clip: rect(36px auto 74px auto);也可以*/
			}
		</style>
	</head>
	<body>
		<img id="i" src="img/logo.png" >
	</body>
</html>

运行结果：
```


- 块元素居中方式
```
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<style>
			#b1{
				border: 1px solid red;
				width: 1000px;
				height: 300px;
              /*居中方式一*/
				/*margin: 0px auto;*/
                           
              /*居中方式二*/
				position: relative;
				left: 50%;
				margin-left: -500px;
			}		
		</style>
	</head>
	<body>
		<div id="b1"></div>
		<div></div>
	</body>
</html>

运行结果：
```


- 同一个页面，a标签不同的样式显示
```
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<style>
			/*方式一：后代选择器*/
			.loginMenu a{
				color: black;
			}
			.loginMenu a:hover{
				color: red;
			}
			
			/*方式二：通过元素本身的选择器*/
			#zhA{
				color: blue;
			}
			#zhA:hover{
				color: green;
			}
		</style>
		
	</head>
	<body>
		<div class="loginBox">
			<div class="loginMenu" ><a>扫码登录</a></div>
			<div><a id="zhA">账号登录</a></div>
		</div>
	</body>
</html>

运行结果：

光标移到扫码登陆：

光标移到账号登陆：
```
