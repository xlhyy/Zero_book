# jQuery


- jQuery简介

```
jQuery是一个轻量级的"写的少，做的多"的优秀的Javascript库。 
它是轻量级的js库 ，它兼容CSS3，还兼容各种浏览器，jQuery2.0及后续版本将不再支持IE6/7/8浏览器。 
jQuery使用户能更方便地处理HTML（标准通用标记语言下的一个应用）、events、实现动画效果，并且方便地为网站提供AJAX交互。 
jQuery还有一个比较大的优势是，它的文档说明很全，而且各种应用也说得很详细，同时还有许多成熟的插件可供选择。
```


- jQuery的好处

```
jQuery 是一个高效、精简并且功能丰富的 JavaScript 工具库 
极大的简化了JS的复杂操作与代码
不需要再关心兼容问题
提供大量使用方法 
```


- jQuery环境搭建

```
可以通过多种方法在网页中添加 jQuery。 您可以使用以下方法： 
从 jquery.com 下载 jQuery 库 
从 CDN 中载入 jQuery, 如从 Google 中加载 jQuery
jQuery 库是一个 JavaScript 文件，您可以使用 HTML 的 <script> 标签引用它： 
<script src="jquery-2.2.1.js"></script>  
如果您不希望下载并存放 jQuery，那么也可以通过 CDN（内容分发网络） 引用它。百度、新浪、谷歌和微软的服务器都存有 jQuery 。
如果你的站点用户是国内的，建议使用百度、新浪等国内CDN地址，如果你站点用户是国外的可以使用谷歌和微软。
```


- 基本语法

```
$()
jQuery 语法是为 HTML 元素的选取编制的，可以对元素执行某些操作。
基础语法是：$('p').html();
美元符号定义 jQuery 
选择符$（'p'）选择P标签
jQuery 的 .html() 执行对元素的操作,获取P标签里的内容
当页面加载完成后执行jquery脚本 
语法一：文档就绪事件 
$(document).ready(function(){
})
语法二 
$(function(){
}) 

步骤：将jquery-3.0.0.js复制到项目js目录中
将js文件引入到html文件中<script type="text/javascript" src="js/jquery-3.0.0.js" ></script>

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script type="text/javascript" src="js/jquery-3.0.0.js" ></script>
		<script>
//			$(document).ready(function(){
//				$("div").html("hello");
//			});

			$(function(){
				$("div").html("hello");
			});
		</script>
	</head>
	<body>
		
		<div>
			
		</div>
	</body>
</html>

运行结果：
```

- jQuery常用选择器

```
<img src="../images/jquery_1.png" width="60%" height="40%" alt="" />
5.1 基本选择器 
$(“#test”); 选取id为test的元素 
$(“.test”); 选取所有class为test的元素 
$(“p”); 选取所有的<p>元素 
$(“*”); 选取所有的元素 
5.2 层次选择器 
$(“div,span,p.myClass”); 选取所有<div>,<span>和拥有class为myClass的<p>标签的一组元素 
$(“div span”); 选取<div>里的所有的<span>元素（后代元素） 
$(“div>span”); 选取<div>元素下元素名是<span>的子元素 （注意：子元素和后代元素的区别）
5.3 过滤选择器 
$(“div:first”); 选取所有<div>元素中的第1个<div>元素 
$(“div:last”); 选取所有<div>元素中最后一个<div>元素 
$(“div:contains(‘我’)”); 选取含有文本“我”的<div>元素 
$(“div:empty”); 选取不包含子元素（包括文本元素）的<div>空元素 
$(“div:visible”); 选取所有可见的<div>元素 
$(“div[id]”); 选取拥有属性id的元素 
$(“div[title=test]”); 选取属性title为“test”的<div>元素
5.4 表单选择器 
$(“#form1:enabled”); 选取id为“form1“的表单内的所有可用元素 
$(“#form2:disabled”); 选取id为“form2“的表单内的所有不可用元素 
$(“input:checked”); 选取所有被选中的<input>元素 
5.5 jQuery常用选择器注意事项 
选择器中含有".""#""("或"]"等特殊字符 用"\\"转义比如： 
<div id="id#b">bb</div> 获取方法：$("#id\\#b") 
<div id="id[1]">bb</div> 获取方法：$("#id\\[1\\]")
1.3以上版本不再使用@，比如$("div[@title='test']");正确的写法是$("div[title='test']");
选择器中含有空格。var $t_a=$(".test :hidden");和 var $t_b=$(".test:hidden")区别 
```


- jquery事件

```
6.1 常规事件
<img src="../images/jquery_2.png" width="60%" height="40%" alt="" />


绑定方法：
<img src="../images/jquery_3.png" width="60%" height="40%" alt="" />
<img src="../images/jquery_4.png" width="60%" height="40%" alt="" />
<img src="../images/jquery_5.png" width="60%" height="40%" alt="" />




注：
$().bind("click",function(){}) 此时click是事件。
$().click(function(){}) 此时click是方法。

有时候事件执行完了，想取消事件的效果可以通过一定的办法来处理。比如bind()方法，可以通过unbind()方法来移除事件的效果。 
$('#btn').unbind("click");这句代码的作用就是取消元素btn下的click事件。 
它不仅仅对于bind()方法有效，它对于click()方法同样有效。 
从某种角度上讲，bind("click",function(){})与click(function(){})是等价的。
还有一种跟bind()方法类似的方法one()，区别大概就是one()方法只执行一次

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script type="text/javascript" src="js/jquery-3.0.0.js" ></script>
		<script>

			$(function(){
//				$("#demo").click(function(){
//					alert("hello");
//				});

				$("#demo").bind("click",function(){
					alert("hello");
				});
				
				$("#undemo").click(function(){
					$("#demo").unbind("click");
				});
			});
		</script>
	</head>
	<body>
		<input type="button" id="demo" value="click me" />
		<input type="button" id="undemo" value="unbind click me" />
	</body>
</html>

运行结果：
<img src="../images/jquery_6.png" width="60%" height="40%" alt="" />

点击”click me”:
<img src="../images/jquery_7.png" width="60%" height="40%" alt="" />

点击”unbind click me”之后，再点击”click me”:
没反应
6.2 合成事件
6.2.1 hover
在进行事件捕获的时候，常常需要捕获组合的用户操作，并且以多个函数作为响应，这些事件我们称为复合事件。 
 jQuery提供的.ready()方法就是最常用的符合事件方法之一，除此之外，还有进行交互处理的时候用到的两个函数： 
 hover(over,out)一个模仿悬停事件（鼠标移动到一个对象上面及移出这个对象）的方法。 
 参数 :
 over (Function) : 鼠标移到元素上要触发的函数。
 out (Function): 鼠标移出元素要触发的函数。 

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script type="text/javascript" src="js/jquery-3.0.0.js" ></script>
		<script>		
			$(function(){
				$("div").hover(function(){
					$(this).html("移入");
				},function(){
					$(this).html("移出");
				});
			})
		</script>
	</head>
	<body>
		<div style=" width: 100px;height: 100px;border: 1px solid red;">		
			hello
		</div>
	</body>
</html>

运行结果：

光标移入div：

光标移出div：

6.2.2 toggle
toggle(fn,fn)
每次点击时切换要调用的函数。 
如果点击了一个匹配的元素，则触发指定的第一个函数，当再次点击同一元素时，则触发指定的第二个函数。 
随后的每次点击都重复对这两个函数的轮番调用。

注：jquery3.0版本不支持toggle函数。此时可以在线引用jquery脚本。 

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script type="text/javascript" src="http://libs.baidu.com/jquery/1.6.4/jquery.min.js" ></script>
		<!--<script type="text/javascript" src="js/jquery-3.0.0.js" ></script>-->
		<script>		
			$(function(){
				$("#mybtn").toggle(function(){
					$("div").css("background","red");
				},function(){
					$("div").css("background","yellow");
				});
			})
		</script>
	</head>
	<body>
		<div style=" width: 100px;height: 100px;border: 1px solid red;"></div>
		<input type="button" value="改变颜色" id="mybtn"/> 
	</body>
</html>

运行结果：

点击”改变颜色”：

点击”改变颜色”：

点击”改变颜色”：

以此类推…

6.2.3 知识点补充
event.type：获取事件的类型
event.target：获取触发事件的元素
event.pageX 和 event.pageY：获取鼠标当前相对于页面的坐标
event.preventDefault() 方法：阻止默认行为
event.stopPropagation() 方法：让Jquery停止事件冒泡
event.which：获取在鼠标单击时，单击的是鼠标的哪个键 
6.2.4 练习题1：获取多选框中选中选项的值
知识点：$("input:checked[name=…]").each(function(){…});
例：$("input:checked[name=hobby]").each(function(){
temp+=$(this).val()
});

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<script type="text/javascript" src="js/jquery-3.0.0.js" ></script>
		<script>
			$(function(){
				$("#regiBtn").click(function(){
					var hobby = "";
					$("input:checked[name=hobby]").each(function(){
						hobby+=$(this).val();
					});
					alert(hobby);
				});
			})
		</script>
	</head>
	<body>
		<input type="checkbox" name="hobby" value="reading"/>reading
		<input type="checkbox" name="hobby" value="swimming"/>swimming
		<input type="checkbox" name="hobby" value="running"/>running
		<hr />
		<input type="checkbox" name="carree" value="reading1"/>reading1
		<input type="checkbox" name="carree" value="swimming2"/>swimming2
		<input type="checkbox" name="carree" value="running3"/>running3
		<input type="button" value="register" id="regiBtn" />
	</body>
</html>

运行结果：

勾选后点击”register”：


6.2.5 练习题2：多选框中的选项全选和全不选
知识点：$().prop(属性名,值)；//用于设置属性的值
例：$("input[name=…]").prop("checked",true);

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<script type="text/javascript" src="js/jquery-3.0.0.js" ></script>
	<script>
		$(function(){
			$("#Y").click(function(){
				$("input[name=dynasties]").prop("checked",true);
			});
			$("#N").click(function(){
				$("input[name=dynasties]").prop("checked",false);
			});
		})
	</script>
	<body>
		<input type="checkbox" name="dynasties" value="tang"/>唐朝
		<input type="checkbox" name="dynasties" value="song"/>宋朝
		<input type="checkbox" name="dynasties" value="yuan"/>元朝
		<input type="checkbox" name="dynasties" value="ming"/>明朝
		<input type="checkbox" name="dynasties" value="qing"/>清朝
		<br />
		<input type="button" id="Y" value="全选"/>
		<input type="button" id="N" value="全不选"/>
	</body>
</html>

运行结果：


点击全选：


点击全不选：
```


- jQuery的Dom操作
```
7.1 append() append() prepend() prependTo() after() insertAfter()
通过 jQuery，可以很容易地添加、删除元素/内容。 
append(): 向每个匹配的元素内部追加内容。
append(): 将所有匹配的元素追加到指定的元素中,即$(A).appendTo(B),是将A追加到B中。
prepend(): 向每个匹配的元素内部前置内容。
prependTo(): 将所有匹配的元素前置到指定的元素中,即$(A).prependTo(B),是将A前置到B中。
after(): 在每个匹配的元素之后插入内容。
insertAfter(): 将所有匹配的元素插入到指定元素的后面。即$(A).prependTo(B),将A放到B后 

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script type="text/javascript" src="js/jquery-3.0.0.js" ></script>
		<script>

			$(function(){
				//append(): 向每个匹配的元素内部追加内容。
				$("#append").click(function(){
					$("#box").append("i am (append)&nbsp;");
				});	
				
				//appendTo(): 将所有匹配的元素追加到指定的元素中,即$(A).appendTo(B),是将A追加到B中。
				$("#appendTo").click(function(){
					$("p").appendTo("#box");
				});
				
				//prepend(): 向每个匹配的元素内部前置内容。
				$("#prePend").click(function(){
					$("#box").prepend("i am (prePend)&nbsp;");
				});
				
				//prependTo(): 将所有匹配的元素前置到指定的元素中,即$(A).prependTo(B),是将A前置到B中。
				$("#prependTo").click(function(){
					$("h1").prependTo("#box");
				});
				
				//after(): 在每个匹配的元素之后插入内容。
				$("#after").click(function(){
					$("#box").after("i am (after)&nbsp;");
				});
				
				//insertAfter(): 将所有匹配的元素插入到指定元素的后面。即$(A).prependTo(B),将A放到B后
				$("#insertAfter").click(function(){
					$("span").insertAfter("#box");
				});
			});				
		</script>
	</head>
	<body>
		<span>this is my span(insertAfter)&nbsp;</span>
		<div id="box" style="width: 500px;height: 300px;border: 1px solid red;">
			&nbsp;this is my div&nbsp;
		</div>
		<p style="width: 200px;background: gray;">this is my p(appendTo)&nbsp;</p>
		<h1>this is my h1(prependTo)&nbsp;</h1>
		<input type="button" value="append" id="append" />
		<input type="button" value="appendTo" id="appendTo" />
		<input type="button" value="prePend" id="prePend" />
		<input type="button" value="prependTo" id="prependTo" />		
		<br />
		<input type="button" value="after" id="after" />
		<input type="button" value="insertAfter" id="insertAfter" />
	</body>
</html>

运行结果：


全部点击一遍之后：

7.2 before() insertBefore() remove() empty() clone() replaceAll()
通过 jQuery，可以很容易地添加、删除元素/内容。 
before()：在每个匹配的元素之前插入内容。 
insertBefore()：将所有匹配的元素插入到指定元素的前面。 
remove()：删除被选元素（及其子元素）。 
empty()：从被选元素中删除子元素。 
clone()：复制节点元素。 
replaceAll()：使用前面的元素替换后面的元素。 
replaceWith() ：使用后面的元素替换前面的元素。

示例代码1：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script type="text/javascript" src="js/jquery-3.0.0.js" ></script>
		<script>
			$(document).ready(function(){
//				before(): 在每个匹配的元素之前插入内容。
				$("#before").click(function(){
					$("#box").before("i am (before)&nbsp;");
				});
				
//				insertBefore(): 将所有匹配的元素插入到指定元素的前面。
				$("#insertBefore").click(function(){
					$("h1").insertBefore("#box");
				});

//				remove() ：删除被选元素（及其子元素）。
				$("#remove").click(function(){
					$("#box2").remove();
				});
				
//				empty() ： 从被选元素中删除子元素。
				$("#empty").click(function(){
					$("#box2").empty();
				});
			});
		</script>
	</head>
	<body>
		<div id="box" style="width: 500px;height: 300px;border: 1px solid red;">
			&nbsp;this is my div&nbsp;
		</div>
		<h1>this id my h1(insertBefore)</h1>
		<div id="box2"  style="width: 500px;height: 300px;border: 1px solid red;">
			<img src="img/cartoon.png" />this is my picture
		</div>
		<input type="button" value="before" id="before" />
		<input type="button" value="insertBefore" id="insertBefore" />
		<input type="button" value="remove" id="remove" />
		<input type="button" value="empty" id="empty" />
	</body>
</html>

运行结果：


（1）只点击”remove”：


（2）只点击”empty”:


（3）只点击”before”及”insertBefore”：


示例代码2：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script type="text/javascript" src="js/jquery-3.0.0.js" ></script>
		<script>
			$(document).ready(function(){
				//用于与clone()作对比
				$("#insertbefore").click(function(){
					$("h1").insertAfter($("#box"));//移动h1到div后面
				});
				//clone(): 复制节点元素。
				$("#clone").click(function(){
					$("h1").clone().insertAfter($("#box"));//复制h1到div后面，原有不动
				});
				
//				replaceAll() ：使用前面的元素替换后面的元素。前面的元素移动到后面元素位置，后面元素没有
				$("#replaceAll").click(function(){
					$("h1").replaceAll($("span"));//
				});
				
//				replaceWith() ：使用后面的元素替换前面的元素。
				$("#replaceWith").click(function(){
					$("h1").replaceWith($("span"));//
				});
			});
		</script>
	</head>
	<body>
		<h1>this id my h1</h1>
		<div id="box" style="width: 1000px;height: 500px;border: 1px solid red;">
			this is my div
		</div>		
		<span>this is my span</span><br />
		<input type="button" value="h1 insertbefore first div" id="insertbefore" />
		<input type="button" value="clone h1 insertbefore first div" id="clone" />		
		<input type="button" value="replaceAll" id="replaceAll" />
		<input type="button" value="replaceWith" id="replaceWith" />
	</body>
</html>

运行结果：


（1）只点击”h1 insertbefore first div”：


（2）只点击”clone h1 insertbefore first div”：


（3）只点击”replaceAll”：


（4）只点击”replaceWith”：

7.3 parent() find() is() triggerHandler()
parent()是找到匹配元素的父节点。 
find()是来搜索与表达式匹配的元素。即$(A). find(B),在A的后代元素中找B元素 
$("ul").find("span").css({"color":"red","border":"2px solid red"}); 
is()是用一个表达式来检查当前选择器的元素集合，如果存在至少一个匹配元素，则返回 true。 
$("p").parent().is("div")
triggerHandler()里面放事件，当执行triggerHandler()时，会触发内部事件所对应的方法。
$("input").triggerHandler("select");
此时，当执行此条语句时，程序内的select()方法会被触发。
示例代码1：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script type="text/javascript" src="js/jquery-3.0.0.js" ></script>
		<script>
			$(function(){
				//parent()是找到匹配元素的父节点。
				$("#parent").bind("click",function(){
					$(this).parent().css("background","red");
				});
				
				//find()是来搜索与表达式匹配的元素。即$(A). find(B),在A的后代元素中找B元素
				$("#find").bind("click",function(){
					$("div").find("span").css({"background":"gray","border":"2px solid red"});
//					$(this).parent().find("span").css({"background":"gray","border":"2px solid red"});
				});
				
				//is()是用一个表达式来检查当前选择器的元素集合，如果存在至少一个匹配元素，则返回 true。
				$("#is").bind("click",function(){
					alert($("#mys").is("span"));
					alert($("#mys").is("h1"));
				});			
			})
		</script>
	</head>
	<body>
		<div style="width: 300px;height: 300px;border: 1px solid red;">
			<input type="button" value="parent" id="parent" />
			<input type="button" value="find" id="find" />
			<input type="button" value="is" id="is" />
			<span id="mys">this is my span</span>
		</div>
	</body>
</html>

运行结果：


（1）点击”parent”：


（2）再点击”find”：


（3）再点击”is”：



示例代码2：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script type="text/javascript" src="js/jquery-3.0.0.js" ></script>
		<script>
			$(document).ready(function(){
				$("input").dblclick(function(){
					$("input").after("dblclick 事件触发");
				});
				$("input").select(function(){
					$("input").after("select 事件触发");
				});
				$("button").click(function(){
					$("input").triggerHandler("select");
				});
			})
		</script>
	</head>
	<body>
		<div>
			<input type="text" value="Hello World"/>
			<br><br>
			<button>触发输入框的 select 事件</button>
		</div>
	</body>
</html>

运行结果：


（1）当选中输入框中的内容或者点击”触发输入框的select事件”按钮时：


（2）当双击输入框时：
```


- 练习：淘宝二级菜单功能点代码

```
菜单示意图：

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script type="text/javascript" src="js/jquery-3.0.0.js" ></script>
		<style>
			*{
				padding: 0px;
				margin: 0px;
			}
			#box{
				width: 400px;
				height: 300px;
				position: relative;
				left: 200px;
				top: 100px;
			}
			#firstMenu{
				width: 100px;
				height: 300px;
				background: gray;
				float: left;
				position: relative;
			}
			.subMenu{
				width: 300px;
				height: 300px;
				background: pink;
				float: left;
				position: absolute;
				left: 100px;
				top: 0px;
			}
			ul li{
				list-style: none;
				width: 100px;
				height: 30px;
			}
			ul li:hover{
				color: red;
			}
			.on{
				color: red;
			}
		</style>
		<script>
			$(function(){
				$(".subMenu").hide();
				
				$("ul li").hover(function(){
					var index = $(this).index();
					$(".subMenu").eq(index).show();					
				},function(){
					var index = $(this).index();
					$(".subMenu").eq(index).hide();
				});				
//				
				$("#subBox .subMenu").hover(function(){
					var obj = $(this);
					obj.show();
					var subIndex = obj.index();
					$("ul li").eq(subIndex).addClass("on");				
				},function(){
					var obj = $(this);
					obj.hide();
					var subIndex = obj.index();
					$("ul li").eq(subIndex).removeClass("on");		
				});
			})
		</script>
	</head>
	<body>
		<div id="box">
			<div id="firstMenu">
				<ul>
					<li>菜单一</li>
					<li>菜单二</li>
					<li>菜单三</li>
					<li>菜单四</li>
				</ul>
			</div>常用选择器
			<div id="subBox">
				<div class="subMenu">菜单一的子菜单</div>
				<div class="subMenu">菜单二的子菜单</div>
				<div class="subMenu">菜单三的子菜单</div>
				<div class="subMenu">菜单四的子菜单</div>
			</div>
		</div>
	</body>
</html>

运行结果：

光标移到”菜单一”：
```
