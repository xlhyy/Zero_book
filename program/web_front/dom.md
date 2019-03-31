### dom


- dom简介
```
DOM脱胎于Netscape及微软公司创始的DHTML（动态HTML），但现在它已经成为表现和操作页面标记的真正跨平台、语言中立的方式。 
DOM（Document Object Model）即文档对象模型，针对HTML和XML文档的API（应用程序接口）。
DOM描绘了一个层次化的节点树，运行开发人员添加、移除和修改页面的某一部分。
细看D、O、M
D（文档）可以理解为整个Web加载的网页文档；
O（对象）可以理解为类似window对象之类的东西，可以调用属性和方法，这里我们说的是document对象；
M（模型）可以理解为网页文档的树型结构。
节点树
在加载HTML页面时，Web浏览器生成一个树型结构，用来表示页面内部结构。DOM将这种树型结构理解为由节点组成。
```


- 节点种类以及相关方法
```
2.1节点种类
元素节点、文本节点、属性节点。

eg：   
 <div title="属性节点">测试Div</div>

2.2 相关方法
2.2.1 getElementById() getElementsByTagName() getElementsByName
查找元素
W3C提供了比较方便简单的定位节点的方法和属性，以便我们快速的对节点进行操作。

2.2.2 getAttribute()
方法将获取元素中某个属性的值。它和直接使用点（.）属性获取属性值的方法有一定区别。
document.getElementById('box').getAttribute('id');
//获取元素的id值
document.getElementById('box').id;
//获取元素的id值
查找元素 
2.2.3 setAttribute()
这个方法将设置元素中某个属性和值。它需要接受两个参数：属性名和值。如果属性本身已存在，那么就会被覆盖。
注：在IE7及更低的版本中，使用setAttribute()方法设置class和style属性是没有效果的，虽然IE8解决了这个bug，但还是不建议使用
2.2.4 removeAttribute()
这个方法可以移除HTML属性。
document.getElementById('box').removeAttribute('style');		//移除属性
注：IE6及更低版本不支持removeAttribute()方法。

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<style>
			.mydiv{
				width: 100px;
				height: 100px;
				border: 1px solid red;
			}
		</style>
		<script>
			function my(){
				var divObj = document.getElementsByTagName("div")[0];
				alert(divObj.getAttribute("class"));//null
				divObj.setAttribute("class","mydiv");//将mydiv设置为divObj标签的class属性值
				alert(divObj.getAttribute("class"));//mydiv
			}
			function myRemove(){
				var divObj = document.getElementsByTagName("div")[0];
				divObj.removeAttribute("class");
			}
		</script>
	</head>
	<body>
		<div ></div>
		<input type="button" value="addClassValue" onclick="my()" />
		<input type="button" value="removeClassValue" onclick="myRemove()" />
	</body>
</html>

运行结果：

点击”addClassValue”按钮之后：



点击”removeClassValue”按钮之后：


查找元素 
getElementById() 
获取到特定元素节点时，这个节点对象就被我们获取到了，而通过这个节点对象，我们可以访问它的一系列属性。
元素节点属性 
tagName		获取元素节点的标签名，和nodeName相同 
innerHTML	获取元素节点里的内容，非W3C  DOM规范。

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<script>
			function myTagName(){
				var obj = document.getElementById("box");
				alert("nodeName:"+obj.nodeName+";TagName:"+obj.tagName);
				alert(obj.innerHTML);//<b>Hello,everyonoe</b>
			}
		</script>
	</head>
	<body>
		<div id="box"><b>Hello,everyonoe</b></div>
		
		<input type="button" value="getTagName" onclick="myTagName()" />
	</body>
</html>

运行结果：

点击”getTagName”按钮之后：
```


- Dom节点
```
3.1 节点属性


3.1.1 nodeName、nodeType、nodeValue


3.1.2 childNodes
获取某一个元素节点的所有子节点，这些子节点包含元素子节点和文本子节点。
在获取到文本节点的时候，是无法使用innerHTML这个属性输出文本内容的。这个非标准的属性必须在获取元素节点的时候，才能输出里面包含的文本。
alert(box.innerHTML);
//innerHTML和nodeValue第一个区别 
注：使用childNodes[n]返回子节点对象的时候， 
有可能返回的是元素子节点，比如 HTMLElement； 
也有可能返回的是文本子节点，比如Text。 
元素子节点可以使用nodeName或者tagName获取标签名称，而文本子节点可以使用nodeValue获取。 
childNodes属性
innerHTML和nodeValue第一个区别，就是取值的。 
第二个区别就是赋值的时候，nodeValue会把包含在文本里的HTML转义成特殊字符，从而达到形成单纯文本的效果。
box.childNodes[0].nodeValue = '<strong>abc</strong>';
//结果为：<strong>abc</strong>
box.innerHTML = '<strong>abc</strong>';	
			//结果为：abc

3.1.3 firstChild、lastChild
firstChild用于获取当前元素节点的第一个子节点，相当于childNodes[0]；
lastChild用于获取当前元素节点的最后一个子节点，相当于childNodes[box.childNodes.length - 1]。
3.1.4 ownerDocument
ownerDocument属性返回该节点的文档对象根节点，返回的对象相当于document。
alert(box.ownerDocument === document);
//true，根节点

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style>
			.mydiv{
				width: 100px;
				height: 100px;
				border: 1px solid red;
			}
		</style>
		<script>
			function mytag(){
				//元素节点
				var divObj = document.getElementById("box");
				alert("nodeType:"+divObj.nodeType+"; nodeName:"+divObj.nodeName+";  nodeValue:"+divObj.nodeValue);//1  DIV  null
				
				//属性节点
				alert("属性个数："+divObj.attributes.length);//2
				for (var i=0;i<divObj.attributes.length;i++) {
					alert("nodeType:"+divObj.attributes[i].nodeType+"; nodeName:"+divObj.attributes[i].nodeName+";  nodeValue:"+divObj.attributes[i].nodeValue);
				}
				//2		 id		box
				//2		 class  mydiv	
			}
			function mytext(){
				var divObj = document.getElementById("box1");
				var textObj = divObj.childNodes[0];
				alert("nodeType:"+textObj.nodeType+"; nodeName:"+textObj.nodeName+";  nodeValue:"+textObj.nodeValue);
				//3  #text welcome
			}
			function myget(){
				var divObj = document.getElementById("box");
				alert(divObj.childNodes.length);//3,说明前后有空白的节点
//				for (var i=0;i<divObj.childNodes.length;i++) {
//					alert("nodeType:"+divObj.childNodes[i].nodeType+"; nodeName:"+divObj.childNodes[i].nodeName+";  nodeValue:"+divObj.childNodes[i].nodeValue);
//				}
				
				var helloText = divObj.childNodes[1].childNodes[0];//childNodes每个元素标签前后加空白节点，文本几点不加。
				alert(helloText.nodeValue);
			}
		</script>
	</head>
	<body>
		<div id="box" class="mydiv">
			<h1>hello</h1>
		</div>
		<div id="box1" class="mydiv">
			welcome
		</div>
		<input type="button" value="tagInfo" onclick="mytag()" />
		<input type="button" value="textInfo" onclick="mytext()" />
		<input type="button" value="get div's hello"  onclick="myget()"/>
	</body>
</html>

运行结果：


点击”tagInfo”按钮：





点击”textInfo”按钮：


点击”get div’s hello”按钮：



3.1.5 parentNode、previousSibling、nextSibling 
parentNode属性返回该节点的父节点，previousSibling属性返回该节点的前一个同级节点，nextSibling属性返回该节点的后一个同级节点。
eg： 
alert(box.parentNode.nodeName);		//获取父节点的标签名 
alert(box.lastChild.previousSibling);	//获取前一个同级节点 
alert(box.firstChild.nextSibling);		//获取后一个同级节点 

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script>
			function my(){
				var hobj = document.getElementsByTagName("h1")[0];
				alert("nodeType:"+hobj.parentNode.nodeType+"; nodeName:"+hobj.parentNode.nodeName+";  nodeValue:"+hobj.parentNode.nodeValue);//1  DIV	null
				//每一个元素标签之间有空白文本节点
				//且两个元素标签之间也只有一个空白文本节点
				alert("nodeType:"+hobj.previousSibling.nodeType+"; nodeName:"+hobj.previousSibling.nodeName+";  nodeValue:"+hobj.previousSibling.nodeValue);//3  #text 
				alert("nodeType:"+hobj.previousSibling.previousSibling.nodeType+"; nodeName:"+hobj.previousSibling.previousSibling.nodeName+";  nodeValue:"+hobj.previousSibling.previousSibling.nodeValue);//1 P null
				var previouobj = hobj.previousSibling.previousSibling;
				alert(previouobj.innerHTML);
			}
		</script>
	</head>
	<body>
		<div id="box">
			<p>this is p</p>
			<h1>this is h1</h1>
			<span>this is span</span>
		</div>
		<input type="button" value="click me" onclick="my()" />
	</body>
</html>

运行结果：


点击”click me”按钮：


3.1.6 忽略空白文本节点
var body = document.getElementsByTagName('body')[0];
//获取body元素节点
alert(body.childNodes.length); //得到子节点个数，IE3个，非IE7个 
在非IE中，标准的DOM具有识别空白文本节点的功能，所以在火狐浏览器是7个，而IE自动忽略了，如果要保持一致的子元素节点，需要手工忽略掉它。
```


- Dom节点操作方法
```
4.1 节点操作
DOM不单单可以查找节点，也可以创建节点、复制节点、插入节点、删除节点和替换节点。 

4.1.1 write()
把任意字符串插入到文档中去。
document.write('<p>这是一个段落！</p>')；//输出任意字符串
4.1.2 createElement()
创建一个元素节点。
document.createElement('p'); //创建一个元素节点 
4.1.3 appendChild()
把一个新节点添加到某个节点的子节点列表的末尾上。
var box = document.getElementById('box');	//获取某一个元素节点
var p = document.createElement('p');//创建一个新元素节点<p>
box.appendChild(p);	//把新元素节点<p>添加box节点末尾
4.1.4 createTextNode()
创建一个文本节点。
var text = document.createTextNode('段落');	//创建一个文本节点
p.appendChild(text);				//将文本节点添加到子节点末尾
4.1.5 insertBefore()
insertBefore()方法可以把节点创建到指定节点的前面。
node.insertBefore(newnode,existingnode) //将新节点插在已存在节点前 
		existingnode.parentNode.insertBefore(newNode, existingnode);
insertBefore()方法可以给当前元素的前面创建一个节点，但却没有提供给当前元素的后面创建一个节点。那么，我们可以用已有的知识创建一个insertAfter()函数。
createElement在创建一般元素节点的时候，浏览器的兼容性都还比较好。但在几个特殊标签上，比如iframe、input中的radio和checkbox、button元素中，可能会在IE6,7以下的浏览器存在一些不兼容
4.1.6 replaceChild()
把节点替换成指定的节点。
existingnode.parentNode.replaceChild(newNode, existingnode);
4.1.7 cloneNode()
cloneNode()方法可以把子节点复制出来。
var box = document.getElementById('box');	
var clone = box.firstChild.cloneNode(true);	
   //获取第一个子节点，true表示复制内容
box.appendChild(clone);				
   //添加到子节点列表末尾
4.1.8 removeChild()
删除指定节点 
box.parentNode.removeChild(box);
//删除指定节点
box.removeChild(b);

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script>
			function my(){
				var pNode = document.createElement("p");
				var textNode = document.createTextNode("这是用js创建的文本节点");
				var boxNode=document.getElementById("box");
				pNode.appendChild(textNode);
				boxNode.appendChild(pNode);
			}
			
			//克隆h2节点放到h1前面
			function my1(){
				var h1Node = document.getElementsByTagName("h1")[0];
				var h2Node = document.getElementsByTagName("h2")[0];
				var h2CloneNode = h2Node.cloneNode(true);//复制节点中内容
				h1Node.parentNode.insertBefore(h2CloneNode,h1Node);
				
			}
			
			//克隆h2节点放到h1前面
			function my1(){
				var h1Node = document.getElementsByTagName("h1")[0];
				var h2Node = document.getElementsByTagName("h2")[0];
				var h2CloneNode = h2Node.cloneNode(true);//复制节点中内容
				h1Node.parentNode.insertBefore(h2CloneNode,h1Node);
				
			}
			
			//将box2中h1替换成box2h2
			function my2(){
				var h2box2Node=document.getElementById("box2h2");
				var h1box2Node=document.getElementById("box2h1");
				h1box2Node.parentNode.replaceChild(h2box2Node,h1box2Node);
			}
			
			function my3(){
				var h1box2Node=document.getElementById("box2h1");
				h1box2Node.parentNode.removeChild(h1box2Node);
			}
		</script>
	</head>
	<body>
		<div id="box">
			<h1>this is h`1</h1>
		</div>
		<h2> this is h2</h2>
		<input type="button" value="new"  onclick="my()"/>
		<input type="button" value="insertBefor and clone"  onclick="my1()"/>
		<br />
		<hr />
		<div id="box2">
			<h1 id="box2h1">this is h`1</h1>
		</div>
		<h2 id="box2h2"> this is h2</h2>
		<input type="button" value="replaceChild"  onclick="my2()"/>
		<input type="button" value="removeChild"  onclick="my3()"/>
	</body>
</html>

运行结果：


点击”new”按钮之后：


然后点击”insertBefor and clone”按钮：


然后点击”replaceChild”按钮：


不点击”replaceChild”按钮,而是点击”removeChild”按钮：

练习：利用jQuery实现可以编辑的表格
要求：在前台的表格中单击单元格便可修改其中的内容，回车键保存修改的内容，esc撤销保存的内容。 
原理：单击客户端表格单元格时，在单元格中添加一个文本框，并将单元格中原来的内容赋值给文本框，再进一步去修改文本框内容，修改后将文本框内容重新赋值给单元格。 

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<script type="text/javascript" src="js/jquery-3.0.0.js" ></script>
		<script>
			$(function(){
				$("tr:even").addClass("evenTd");
				
				$("td").click(function(){
					
					var tdObj = $(this);
					if(tdObj.children("input").length==0){
						var preText = tdObj.html();
						tdObj.html("");
						var inputObj = $("<input type='text' />");
						inputObj
							.width(tdObj.width())
							.height(tdObj.height())
							.val(preText)
							.trigger('focus')
							.css({"border":"1px","fontsize":"12px"})
							.appendTo(tdObj);
						
						inputObj.keydown(function(event){
							if(event.which==13){
								tdObj.html(inputObj.val());
							}else if(event.which==27){
								tdObj.html(preText);	
							}
						});
					}
				});		
			})
		</script>
		<style>
			table,tr,td,th{
				border: 1px solid black;
			}
			.evenTd{
				background: gray;
			}
		</style>
	</head>
	<body>
		<table>
			<caption>学生信息表</caption>
			<tr>
				<th>学号</th>
				<th>姓名</th>
				<th>年龄</th>
				<th>班级</th>
			</tr>
			<tr>
				<td>SC1801</td>
				<td>tOM</td>
				<td>21</td>
				<td>703</td>
			</tr>
			<tr>
				<td>SC1801</td>
				<td>tOM</td>
				<td>21</td>
				<td>703</td>
			</tr>
			<tr>
				<td>SC1801</td>
				<td>tOM</td>
				<td>21</td>
				<td>703</td>
			</tr>
			<tr>
				<td>SC1801</td>
				<td>tOM</td>
				<td>21</td>
				<td>703</td>
			</tr>
			<tr>
				<td>SC1801</td>
				<td>tOM</td>
				<td>21</td>
				<td>703</td>
			</tr>
		</table>
	</body>
</html>

运行结果：
```
