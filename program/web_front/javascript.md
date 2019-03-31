### javascript


- javascript定义
```
	•	JavaScript 是 Web 的编程语言。 
	•	JavaScript 是一种轻量级的编程语言。 
	•	JavaScript 是可插入 HTML 页面的编程代码。 
	•	JavaScript 插入 HTML 页面后，可由所有的现代浏览器执行。 
	•	JavaScript是一种基于对象（Object）和事件驱动（Event Driven）并具有相对安全性的客户端脚本语言。 
	•	是一种广泛用于客户端Web开发的脚本语言，常用来给HTML网页添加动态功能。 
	•	是一种动态、弱类型、基于原型的语言，内置支持类。 
 特定：
	•	一种解释性执行的脚本语言。 
	•	一种基于对象的脚本语言。 
	•	一种简单弱类型脚本语言。 
	•	一种相对安全脚本语言。 
	•	一种事件驱动脚本语言。 
	•	一种跨平台性脚本语言。 

核心：
	•	javaScript简称JS，JS基础部分三大核心为： 
	•	ECMAScript： 
	•	JavaScript的核心，描述了语言的基本语法(var、for、if、array等)和数据类型(数字、字符串、布尔、函数、对象(obj、[]、{}、null)、未定义)
	•	ECMAScript是一套标准，定义了一种语言（比如JS）是什么样子。 
	•	文档对象模型（DOM）： 
	•	DOM（文档对象模型）是 HTML 和 XML 的应用程序接口（API）。 
	•	DOM 将把整个页面规划成由节点层级构成的文档。 
	•	HTML 或 XML 页面的每个部分都是一个节点的衍生物。 
	•	浏览器对象模型（BOM）： 
	•	对浏览器窗口进行访问和操作。例如弹出新的浏览器窗口，移动、改变和关闭浏览器窗口，提供详细的网络浏览器信息（navigator object），详细的页面信息（location object），详细的用户屏幕分辨率的信息（screen object），对cookies的支持等等。 
	•	BOM作为JavaScript的一部分并没有相关标准的支持，每一个浏览器都有自己的实现，虽然有一些非事实的标准，但还是给开发者带来一定的麻烦。 
```


- JavaScript引用方式
```
	•	JavaScript文件的引用方式与CSS一样 在head标签中
	•	在 HTML 页面中插入 JavaScript，请使用 <script> 标签。 
	•	例子 
	•	<script src=“js/script.js”></script>	外部引用js文件 
	•	<script>js代码</script>		内部使用js语言 

	•	除了内部引用与外部引用之外，还有一种为行内引用.
	•	如果是简单的代码，可以直接将代码加到HTML的标记中。这种方法一般是将JavaScript代码直接指定给事件响应句柄，由事件触发脚本的执行。
在HTML标记中直接加代码，需要使用“javascript:”协议。
```


```
示例代码：
index.html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		
		<script type="text/javascript" src="js/test.js" ></script>
		
		<style>
			div{
				width: 100px;
				height: 20px;
				background: gray;
				margin: 2px;
			}
		</style>
		
		<script>
			function testInner(){
				alert('hello,inner');
			}
		</script>
		
	</head>
	<body>
		<div onclick="testOuter()">外部js</div>
		<div onclick="testInner()">内部js</div>
		<div onclick="javascript:alert('hello,行内')">行内js</div>
	</body>
</html>

js/test.js
function testOuter(){
	alert("hello,outer");
}

运行结果：

点击 外部js：

点击 内部js：

点击 行内js：
```


- Js输出
```
	•	JavaScript 可以通过不同的方式来输出数据： 
	•	使用window.alert();
	•	语法 
	•	alert(“内容”);
	•	语法解释 
	•	内容是在页面中弹出的内容如果是数字则不需要用“”包裹。 
```


```
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<script>
			window.alert("hello,everyone");
		</script>
	</head>
	<body>	
	</body>
</html>

运行结果：


	•	使用document.write()
	•	语法 
	•	document.write(“内容");
	•	语法解释 
	•	内容是在页面中弹出的内容如果是数字则不需要用“”包裹。
```


```
示例代码
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<script>
			document.write("hello,everyone");
		</script>
	</head>
	<body>	
	</body>
</html>
运行结果：


	•	使用innerHTML 
	•	语法 
	•	document.getElementById(“demo”).innerHTML=“内容";
	•	语法解释 
	•	内容是页面中元素需要替换的内内容。 
```


```
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<script>
			//点击第一个div时，将第一个div的内容放入到第二个div中
			function test(){
				
				var boxObj1 = document.getElementById("box1");//获取id为box1的元素标签
				var boxObj2 = document.getElementById("box2");//获取id为box2的元素标签
				
				var box1Value = boxObj1.innerHTML;//获取第一个div元素中的值
				boxObj2.innerHTML = box1Value;//将值box1Value赋值给第二div元素中
			
			}
		</script>	
	</head>
	<body>
		<!--点内容，运行函数-->
		<div id="box1" onclick="test()">sao ma</div>
		
		<div id="box2">mima</div>
	</body>
</html>

运行结果：
点击sao ma之前：

点击sao ma之后：
```


- 知识点补充：
```
/*css注释*/
//javascript注释
<!--html注释-->
```

- innerText和innerHTML区别：
```
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<script>
			function test(){
				var obj = document.getElementById("box1");
				
				//弹出
				alert(obj.innerHTML);//弹出sao ma <strong>Denglu</strong>
				alert(obj.innerText);//弹出sao ma Denglu
				
				var obj2 = document.getElementById("box2");
				var obj3 = document.getElementById("box3");
				
				//更改显示
				obj2.innerHTML = "sao ma <strong>Denglu</strong>";//显示加粗，不显示strong
				obj3.innerText = "sao ma <strong>Denglu</strong>";//显示内容，显示strong
			}
		</script>	
	</head>
	<body>
		<div id="box1" onclick="test()">sao ma <strong>Denglu</strong> </div>
		<div id="box2">mima</div>
		<div id="box3">mima</div>
	</body>
</html>

运行结果：
```


```
注：
（1）
alert(obj.innerHTML);//弹出sao ma <strong>Denglu</strong>
alert(obj.innerText);//弹出sao ma Denglu
（2）
obj2.innerHTML = "sao ma <strong>Denglu</strong>";//显示加粗，不显示strong
obj3.innerText = "sao ma <strong>Denglu</strong>";//显示内容，显示strong

	•	使用console.log()
	•	语法 
	•	console.log(“内容");
	•	语法解释 
	•	内容是我们需要输出到控制台的内容。 
将右上角模式改为边改边看模式，可以看到控制台的输出
```

```
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script>
			console.log("你好")
		</script>
	</head>
	<body>
	</body>
</html>

运行结果：
```


- 获取元素
```
	•	常见的获取元素的方法有3种。 
	•	通过元素ID
	•	通过标签名字 
	•	通过类名字来获取。 

（1）getElementById 
	•	JS中对大小写特别敏感，所以请务必注意大小写。 
	•	DOM提供了一个名为getElementById的方法，这个方法将返回一个与之对应id属性的节点对象 
	•	语法： 
	•	document.getElementById('demo') //demo是元素对应的ID
	•	语法解释： 
	•	此方法通过ID来获取元素。


（2）getElementsByTagName 
	•	该方法返回一个对象数组（准确的说是HTMLCollection集合，它不是真正意义上的数组），每个对象分别对应着文档里有着给定标签的一个元素。 
	•	类似于getElementById,同样，该方法只提供一个参数，它的参数是指定标签的名字 
	•	语法： 
	•	document.getElementsByTagname(‘div')  //div是标签的名字 
	•	语法解释： 
	•	此方法会获取到一组元素，我们需要通过下标来确定获取那个元素。 


（3）getElementsByClassName 
	•	除了通过指定标签获取元素外，DOM还提供了getElementsByClassName方法来获取指定class名的元素。 
	•	不过由于该方法比较新，较老的浏览器还不支持，比如IE6。 
	•	语法： 
	•	document.getElementsByClassName('demo')  //demo为元素指定的class名 
	•	语法解释： 
	•	此方法是通过元素的class名获取一组元素，需要下标来指定获取那个元素。 
```


```
练习：登陆窗口
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<style>
			.loginBox{
				position: absolute;
				left: 200px;
				top: 100px;
				width: 350px;
				height: 450px;
				border: 1px solid gray;
			}
			.loginMenu{
				float: left;
				width: 175px;
				height: 40px;
				text-align: center;
				cursor: pointer;
			}
			
			
			.loginContent{
				position: absolute;
				top: 50px;
				width: 350px;
				height: 400px;
				border: 1px solid red;
			}
			#smLogin{
				display: none;
			}
			#zhLoginMenu{
				color: red;
			}
		</style>
		<script>
			function showInfo(flag){
				var smLoginObj = document.getElementById("smLogin");
				var zhLoginObj = document.getElementById("zhLogin");
				
				var smMenuObjArr = document.getElementsByClassName("loginMenu");
				
				if(flag==0){
					smLoginObj.style.display = "block";
					zhLoginObj.style.display = "none";
					
					smMenuObjArr[0].style.color = "red";
					smMenuObjArr[1].style.color = "black";	
				}else if(flag==1){
					smLoginObj.style.display = "none";
					zhLoginObj.style.display = "block";
					smMenuObjArr[0].style.color = "black";
					smMenuObjArr[1].style.color = "red";	
				}
				
			}
		</script>
	</head>
	<body>
		<div class="loginBox">
			<div class="loginMenu" onclick="showInfo(0)">扫码登录</div>
			<div id="zhLoginMenu" class="loginMenu" onclick="showInfo(1)" >账号登录</div>
			<div id="smLogin" class="loginContent">扫码</div>
			<div id="zhLogin" class="loginContent">账号输入框</div>
		</div>
	</body>
</html>

运行结果：
```


- 基本语句
```

条件分支语法：
if(){

}else{//可写可不写

}

语法二：
if(){

}else  if(){//可以有0到n次

}else{//可写可不写

}

with 语句用于设置代码在特定对象中的作用域。 
var sMessage = "hello";
with(sMessage) {
  alert(toUpperCase());//输出 "HELLO"
} 
```


- 语法
```
2.1字面量
	•	在编程语言中，一个字面量是一个常量 
	•	字符串（string）字面量 
	•	表达式字面量 
	•	数组字面量 
	•	对象（object）字面量 
	•	函数（function）字面量 
	•	字符串（string）字面量 
	•	通过下图可知字符串字面量可以使用单引号也可以使用双引号。
```

```
练习题：
点击按钮时，将一句话显示到div中。

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script>
			function myClick(){
				var boxObj = document.getElementById("box");
				boxObj.innerHTML = 'HELLO';//"HELLO"叫做字面量，字符串字面量可以用单引号双引号
			}
		</script>
	</head>
	<body>
		
		<input type="button" value="显示" onclick="myClick()" />
		<div id="box">
			
		</div>
	</body>
</html>

运行结果：



	•	表达式字面量 
	•	表达式字面量用于计算。 
```


```
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<!--放在上面不好用是因为解析时是由上至下的，当解析到script时，因为没有id为demo的标签，故运行结果错误-->
		<!--<script>
			var demoObj = document.getElementById("demo");
			demoObj.innerHTML = 3*4;
		</script>-->
	</head>
	<body>
		<p id="demo"></p>
	</body>
	<script>
		var demoObj = document.getElementById("demo");
		demoObj.innerHTML = 3*4;
	</script>
</html>

运行结果：


	•	数组字面量 
	•	数组字面量用于定义一个数组 
	•	[6,3,40,34,15,25,35]
	•	对象字面量 
	•	对象字面量定义一个对象 
	•	{firstName:"John", lastName:"Doe", age:50, eyeColor:"blue"}
	•	函数字面量 
	•	函数字面量定义一个函数 
	•	function myFunction(a,b){
	•	return  a+b;
	•	}
```

```
2.2 变量
	•	在编程语言中，变量用于存储数据值。 
	•	在编程语言中，JavaScript 使用关键字 var 来定义变量， 使用等号来为变量赋值。 
	•	变量可以通过变量名访问。在指令式语言中，变量通常是可变的。字面量是一个恒定的值。 
	•	变量是一个名称。字面量是一个值。 
	•	我们可以给不同数据定义不同的名字，通过不同的名字来表示不同的数据。这名字称为“变量”。变量就是一个代号，比如房间号。

var a;//声明变量a
a = 10;//给变量a赋值
var b = 10;//声明并赋值。

2.3 操作运算符
	•	JavaScript使用算术运算符 来计算值。 
	•	JavaScript使用赋值运算符给变量赋值。 

2.4 关键字和命名规则
	•	JavaScript 关键字用于标识要执行的操作。 
	•	JavaScript 保留了一些关键字为自己所用。 
	•	var 关键字告诉浏览器创建一个新的变量。 
	•	这些关键字在当前的语言版本中并没有使用，但在以后 JavaScript 扩展中会用到。 
	•	JavaScript 关键字必须以字母、下划线（_）或美元符（$）开始。 
	•	后续的字符可以是字母、数字、下划线或美元符（数字是不允许作为首字符出现的，以便 JavaScript 可以轻易区分开关键字和数字）。


2.5 注释
	•	不是所有的 JavaScript 语句都是"命令"。双斜杠 // 后的内容将会被浏览器忽略 
	•	同html与css一样，我们的JS中也有注释 

css注释：/*   */
html注释：<!--    -->

快捷键：Ctrl+/
```

- 数据类型
```
	•	JavaScript数据类型是非常简洁的，它只定义了5种基本数据类型
	•	string：字符串。最抽象的数据类型，信息传播的载体
	•	number：数值。最原始的数据类型，表达式计算的载体
	•	boolean：布尔值。最机械的数据类型，逻辑运算的载体
	•	undefined：未定义。当声明变量却没有赋值时会显示该值。可以为变量赋值为undefined 
	•	null：空、无。表示不存在，当为对象的属性赋值为null，表示删除该属性 
	•	注意：我们可以使用typeof来测试数据类型！

	•	字符串是存储字符的变量。 
	•	字符串可以是引号中的任意文本。可以使用单引号或双引号。 
	•	可以在字符串中使用引号，只要不匹配包围字符串的引号即可。 
```

```
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script>
			var demo = "这就是'江湖'";
			alert(typeof demo);
		</script>
	</head>
	<body>
	</body>
</html>
输出结果：


	•	JavaScript 只有一种数字类型。数字可以带小数点，也可以不带。 


	•	布尔（逻辑）只能有两个值：true 或 false。 
	•	布尔常用在条件测试中。 


	•	null类型也是空的对象引用。只有一个值，即null值，所以，在你 用typeof 操作符去检测null类型的值时，结果是object类型。 
	•	如果你定义了一个变量，但是想在以后把这个变量当做一个对象来用，那么最好将该对象初始化为null值。 



	•	（1）未使用var声明，也未赋初始化值进行初始化的变量，类型是undefined。 
	•	（2）使用var声明，但未赋初始化值进行初始化的变量，类型是undefined。 


	•	当给变量赋值null，typeof表示为object
		var a = null;
		alert( typeof a);//object
空、无 表示不存在。当给对象的属性赋值null，表示删除该属性
```

- 元素标签和表单输入框获取值
```
元素标签获取显示内容:obj.innerHTTML或者obj.innerText
输入框获取显示内容：obj.value
```

- 类型转换
```
	•	将数字转换为字符串 
	•	全局方法 String() 可以将数字转换为字符串。String(123)
	•	Number 方法 toString() 也是有同样的效果。x.toString() 
	•	将字符串转换为数字
	•	全局方法 Number() 可以将字符串转换为数字。Number("3.14")  
	•	空字符串转换为 0。 

var m = 1000;
var p = 500;
alert(m+p);//1500；

//假设输入框中是500
var obj = document.getElementById("money");
var plus = 1000;			
//var money = 500;
var money = obj.value;
alert(plus+money);//1000500

需要数据类型转换，才能进行运算
（1）通过Number()将字符串转换成数值类型
var obj = document.getElementById("money");
var plus = 1000;			
//var money = 500;
var money = Number(obj.value);
alert(plus+money);//1500

（2）通过eval()
var obj = document.getElementById("money");
var plus = 1000;			
//var money = 500;
var money = obj.value;
alert(plus+eval(money));//1500
```

- 练习1：四则运算
```
要求：输入框  下拉框（可以选择+-*/）输入框 按钮（=） 显示结果

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script>
			function run(){
				var box1Obj = document.getElementById("box1");
				var box2Obj = document.getElementById("box2");
				var box3Obj = document.getElementById("box3");
				var select1Obj = document.getElementById("select1");
				//第一种做法
//				if(select1Obj.value == "+"){
//					box3Obj.value = eval(box1Obj.value + "+" + box2Obj.value);
//				}else if(select1Obj.value == "-"){
//					box3Obj.value = eval(box1Obj.value + "-" + box2Obj.value);
//				}else if(select1Obj.value == "*"){
//					box3Obj.value = eval(box1Obj.value + "*" + box2Obj.value);
//				}else if(select1Obj.value == "/"){
//					box3Obj.value = eval(box1Obj.value + "/" + box2Obj.value);
//				}
				
				//第二种方法
//				switch(select1Obj.value){
//					case "+":
//						box3Obj.value = eval(box1Obj.value + "+" + box2Obj.value);
//						break;
//					case "-":
//						box3Obj.value = eval(box1Obj.value + "-" + box2Obj.value);
//						break;
//					case "*":
//						box3Obj.value = eval(box1Obj.value + "*" + box2Obj.value);
//						break;
//					case "/":
//						box3Obj.value = eval(box1Obj.value + "/" + box2Obj.value);
//						break;
//				}
				
				//第三种方法
//				box3Obj.value = eval(box1Obj.value+select1Obj.value+box2Obj.value);
			}
		</script>
	</head>
	<body>
		<input type="text" id="box1" placeholder="请输入第一个数"/>
		<select id="select1">
			<option>+</option>
			<option>-</option>
			<option>*</option>
			<option>/</option>
		</select>
		<input type="text" id="box2" placeholder="请输入第二个数"/>
		<input type="button" value="=" onclick="run()"/>
		<input type="text" id="box3" placeholder="输出结果"/>
	</body>
</html>

运行结果：
```

- 练习2：输入数字1-7，输出星期几
```
要求：输入框输入数字，点击转换按钮，将输入的数字1-7转换成对应的星期一-星期日显示到div框中。输入其他数字时，div显示非法数据。使用switch语句实现。

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script>
			function toDay(){
				var tempObj = document.getElementById("temp");
				var boxObj = document.getElementById("box");
				switch(tempObj.value){
					case "1":
						boxObj.innerHTML = "星期一";
						break;
					case "2":
						boxObj.innerHTML = "星期二";
						break;
					case "3":
						boxObj.innerHTML = "星期三";
						break;
					case "4":
						boxObj.innerHTML = "星期四";
						break;
					case "5":
						boxObj.innerHTML = "星期五";
						break;
					case "6":
						boxObj.innerHTML = "星期六";
						break;
					case "7":
						boxObj.innerHTML = "星期日";
						break;
					default:
						boxObj.innerHTML = "非法数据";
						break;
				}
			}
		</script>
	</head>
	<body>
		<input type="text" id="temp" placeholder="请输入一个1-7之间的数"/>
		<input type="button" value="转换" onclick="toDay()"/>
		<div id="box"></div>
	</body>
</html>

运行结果：
```


- 知识点补充：
```
eval(“345”); 可以
eval(“+”); 不可以
eval(“3+2”); 可以
6 Number类

更改：toPrecision()后面不是“保留小数点后面指定位数”，而是“保留指定位数”。若保留位数小于整数部分位数，则用科学计数法表示。
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<script>
			var num = 123.3456;
			alert(num+1);//124.3456
			alert(num.toString()+1);//123.34561
			
			alert(num.toFixed(2));//123.35			
			
			alert(num.toExponential());//1.233456e+2以科学计数法显示
			alert(num.toExponential(2));//1.23e+2以科学计数法显示
			
			alert(num.toPrecision());//123.3456
			alert(num.toPrecision(1));//1e+2
			alert(num.toPrecision(2));//1.2e+2
			alert(num.toPrecision(3));//123
		</script>
	</head>
	<body>
		
	</body>
</html>
```


- String类
```
			var str ="abcd";
			alert(str.length);//4
			alert(str.constructor);//function String(){[native code]}
			alter(str.prototype);

			var str ="abcd";
			alert(str.charAt(1));//下标为1的字符b
			alert(str.charCodeAt(1));//下标为1的字符b的Unicode编码98

			var str ="abcd";
			var v1 = "qwe";
			alert(str.concat(v1));//abcdqwe返回字符串拼接，str和v1不改变
			alert(v1);//qwe
			alert(str);//abcd

			var str ="abcd";
			alert(str.slice(1,3));//bc  [startIndex,endIndex),包含startIndex位置的字符，不包含endIndex位置的字符。
			alert(str);//abcd str不改变
			alert(str.substr(0,3))//abc


			var str1 = "abcabc";
			alert(str1.indexOf("bc"));//1  返回bc在str第一次出现的下标位置
			alert(str1.indexOf("bc",2));//4  从下标2开始往后查找，bc在str1第一次出现的下标位置
			
			alert(str1.lastIndexOf("bc"));//4  返回bc在str1最后一次出现的下标位置
			alert(str1.lastIndexOf("bc",4));//4
			alert(str1.lastIndexOf("bc",3));//1


			var str = "ABCabc";
			alert(str.toLowerCase());//abcabc 将str全部转换成小写，str本身不变
			alert(str.toUpperCase());//ABCABC 将str全部转换成大写，str本身不变
			alert(str);//ABCabc
			var str = "abcdef";
			alert(str.match("bc"));//bc 到str中查找bc，如果找到返回bc，没找到返回null
			alert(str.match("fe"));//null
			
			var str = "abcdef";
			alert(str.replace("bc","23"));//a23def 将str中bc替换成23,str不改变
			alert(str);//abcdef

			alert(str.search("cd"));//2 返回str中出现cd的下标

			var str1 = "读书，运动，游泳";
			var a = str1.split("，");
			alert(a[2]);	//游泳	


	•	localeCompare(str1,str2)方法详解
	•	比较两个字符串并返回以下值中的一个
	•	1.如果字符串在字母表中应该排在字符串参数之前，则返回一个负数。(多数-1)
	•	2.如果字符串等于字符串参数，则返回0。
	•	3.如果字符串在自附表中应该排在字符串参数之后，则返回一个正数。(多数1)

			alert(String.fromCharCode(98));//b unicode编码是98的字符
			alert("abcd".localeCompare("abea"));//-1
			alert("add".localeCompare("aaa"));//1
```

```
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<script>
//			var str ="abcd";
//			alert(str.length);//4
//			alert(str.constructor);//function String(){[native code]}
//			alter(str.prototype);//不常用，了解即可
			
//			var str ="abcd";
//			alert(str.charAt(1));//下标为1的字符b
//			alert(str.charCodeAt(1));//下标为1的字符b的Unicode编码98
			
//			var str ="abcd";
//			var v1 = "qwe";
//			alert(str.concat(v1));//abcdqwe返回字符串拼接，str和v1不改变
//			alert(v1);//qwe
//			alert(str);//abcd

//			var str ="abcd";
//			alert(str.slice(1,3));//bc  [startIndex,endIndex),包含startIndex位置的字符，不包含endIndex位置的字符。
//			alert(str);//abcd str不改变
//			alert(str.substr(0,3))//abc

//			var str1 = "abcabc";
//			alert(str1.indexOf("bc"));//1  返回bc在str第一次出现的下标位置
//			alert(str1.indexOf("bc",2));//4  从下标2开始往后查找，bc在str1第一次出现的下标位置
//			
//			alert(str1.lastIndexOf("bc"));//4  返回bc在str1最后一次出现的下标位置
//			alert(str1.lastIndexOf("bc",4));//4
//			alert(str1.lastIndexOf("bc",3));//1

//			var str = "ABCabc";
//			alert(str.toLowerCase());//abcabc 将str全部转换成小写，str本身不变
//			alert(str.toUpperCase());//ABCABC 将str全部转换成大写，str本身不变
//			alert(str);//ABCabc

//			var str = "abcdef";
//			alert(str.match("bc"));//bc 到str中查找bc，如果找到返回bc，没找到返回null
//			alert(str.match("fe"));//null

//			var str = "abcdef";
//			alert(str.replace("bc","23"));//a23def 将str中bc替换成23,str不改变
//			alert(str);//abcdef
//
//			alert(str.search("cd"));//2 返回str中出现cd的下标
//
//			var str1 = "读书，运动，游泳";
//			var a = str1.split("，");
//			alert(a[2]);	//游泳	

//			alert(String.fromCharCode(98));//b unicode编码是98的字符
//			alert("abcd".localeCompare("abea"));//-1
//			alert("add".localeCompare("aaa"));//1

		</script>
	</head>
	<body>
		
	</body>
</html>
```


- HTML方法
```
		<script>
			var txt = "这是华清远见703学生";
			txt.anchor("703b");
			alert(txt.anchor("703b"));
		</script>
```

```
练习1：改变字体样式
要求：
输入框，
点击红色样式按钮，将输入的内容变成红色追加到div中。
点击加粗样式按钮，将输入的内容变成加粗追加到div中。
点击斜体样式按钮，将输入的内容变成斜体追加到div中。

示例代码1：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script>	
			function changeRed(){
				var inputObj = document.getElementById("inputBox");
				var outputObj = document.getElementById("outputBox");
				outputObj.innerHTML = outputObj.innerHTML+inputObj.value.fontcolor("red");
			}
			function changeStrong(){
				var inputObj = document.getElementById("inputBox");
				var outputObj = document.getElementById("outputBox");
				outputObj.innerHTML = outputObj.innerHTML+inputObj.value.bold("red");
			}
			function changeItalic(){
				var inputObj = document.getElementById("inputBox");
				var outputObj = document.getElementById("outputBox");
				outputObj.innerHTML = outputObj.innerHTML+inputObj.value.italics("red");
			}
		</script>
	</head>
	<body>
		<input type="text" id="inputBox" placeholder="输入框"/>
		<input type="button" value="红色" onclick="changeRed()"/>
		<input type="button" value="加粗" onclick="changeStrong()"/>
		<input type="button" value="斜体" onclick="changeItalic()"/>
		<div id="outputBox"></div>
	</body>

</html>

运行结果：



示例代码2：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<style type="text/css">
			#box{
				width: 500px;
				height: 500px;
				border: 1px solid red;
			}
		</style>
		<script type="text/javascript">
			function myTransfer(operation){
				var inputObj = document.getElementById("inputValue");
				var boxObj = document.getElementById("box");
				if(operation=="color"){
					boxObj.innerHTML = boxObj.innerHTML + inputObj.value.fontcolor("red");
				}else if(operation=="bold"){
					boxObj.innerHTML = boxObj.innerHTML + inputObj.value.bold();
				}else if(operation=="italic"){
					boxObj.innerHTML = boxObj.innerHTML + inputObj.value.italics();
				}
			}
		</script>
	</head>
	<body>
		<input type="text"  id="inputValue" placeholder="please input your info" />
		<input type="button" value="mycolor" onclick="myTransfer('color')" />
		<input type="button" value="mybold" onclick="myTransfer('bold')" />
		<input type="button" value="myitalic" onclick="myTransfer('italic')" />
		<div id="box"></div>
	</body>
</html>
```

```
练习2：用户注册界面
要求：	
输入框用户名，密码，年龄，邮箱，性别，爱好。点击注册按钮，如果注册成功，在div中显示输入的信息。
如果注册失败，在下面显示注册失败。
注册成功规则：
	用户名不能为空，不能超过10位
	密码必须是6位；
	年龄在1-100之间
	邮箱格式：xxx@xx.com（说明@前至少有一个字符，@和.之间必须有一个字符，必须以com结尾）

示例代码1：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style>
			html,body{
				width: 100%;
				height: 100%;
			}
			.box1{
				width: 100%;
				position: relative;
				text-align: center;
			}
			.box2{
				text-align: left;
				position: absolute;
				left: 43%;
				
			}
			#registerButton{
				margin-top: 10px;
			}
		</style>
		<script>
			function checkInfo(){
				var usernameObj = document.getElementById("username");
				var passwordObj = document.getElementById("password");
				var ageObj = document.getElementById("age");
				var emailObj = document.getElementById("email");
				var sexObj = document.getElementsByName("sex");
				var interestObj = document.getElementsByName("interest");
				var box2Obj = document.getElementsByClassName("box2")[0];
				
				var usernameObjLen = Number(usernameObj.value.trim().length);
				var passwordObjLen = Number(passwordObj.value.length);
				var usernameObjVal = usernameObj.value;
				var passwordObjVal = passwordObj.value;
				var ageObjVal = Number(ageObj.value);
				var emailObjVal = emailObj.value;
				var emailObjIndA = Number(emailObjVal.indexOf("@"));
				var emailObjIndP = Number(emailObjVal.indexOf("."));
				var emailObjIndC = Number(emailObjVal.lastIndexOf("com"));
				var emailObjLen = Number(emailObjVal.length);
//				var box2ObjInn = box2Obj.innerHTML;
//				注：不可以这么写，因为执行之后，box2ObjInn只是一个值，并不能代表box2Obj.innerHTML这个变量，但是可以作为判断中的条件。

				if(usernameObjLen!=0 & usernameObjLen<=10){
					if(passwordObjLen==6){
						if(100>ageObjVal & ageObjVal>1){
							if(emailObjIndA>0 & emailObjIndP-emailObjIndA>0 & emailObjIndC==emailObjLen-3){
								var sexRes = "";
								var interestRes = "";
								for(var i=0;i<sexObj.length;i++){
									if(sexObj[i].checked == true){
										sexRes += sexObj[i].value;
									}
								}
								for(var i=0;i<interestObj.length;i++){
									if(interestObj[i].checked == true){
										interestRes += (interestObj[i].value+"&nbsp");
									}
								}
								box2Obj.innerHTML = "注册成功"+"<br>";
								box2Obj.innerHTML = box2Obj.innerHTML+"用户名:"+usernameObjVal+"<br />"; 
								box2Obj.innerHTML = box2Obj.innerHTML+"密码: "+passwordObjVal+"<br />";
								box2Obj.innerHTML = box2Obj.innerHTML+"年龄: "+ageObjVal+"<br />";
								box2Obj.innerHTML = box2Obj.innerHTML+"邮箱: "+emailObjVal+"<br />";
								box2Obj.innerHTML = box2Obj.innerHTML+"性别: "+sexRes+"<br />";
								box2Obj.innerHTML = box2Obj.innerHTML+"爱好: "+interestRes+"<br />";
							}
							else{box2Obj.innerHTML = "注册失败"+"<br />"+"邮箱输入有误";}
						}
						else{box2Obj.innerHTML = "注册失败"+"<br />"+"年龄输入有误";}
					}
					else{box2Obj.innerHTML = "注册失败"+"<br />"+"密码输入有误";}
				}
				else{box2Obj.innerHTML = "注册失败"+"<br />"+"用户名输入有误";}
			}
		</script>
	</head>
	<body>
		<div class="box1">
			用户名:<input type="text" id="username" placeholder="(长度<=10)(必填)"/>
			<br />
			密码： <input type="text" id="password" placeholder="(长度=6)(必填)"/>
			<br />
			年龄： <input type="text" id="age" placeholder="(1<数字<100)(必填)"/>
			<br />		
			邮箱： <input type="text" id="email" placeholder="(必填)"/>
			<br />		
			性别： <input type="radio" name="sex" value="male"/>男
			<input type="radio" name="sex" value="female"/>女
			<input type="radio" name="sex" value="secret"/>保密
			<br />		
			爱好： <input type="checkbox" name="interest" value="reading"/>reading
			<input type="checkbox" name="interest" value="singing"/>singing
			<input type="checkbox" name="interest" value="dancing"/>dancing
			<br />		
			<input type="button" id="registerButton" value="注册" onclick="checkInfo()"/>	
			<div class="box2"></div>
		</div>
	</body>
</html>

运行结果：



示例代码2：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<style>
			#box{
				width: 500px;
				height: 500px;
				border: 1px solid red;
			}
			#content{
				border: 1px solid green;
				width: 500px;
				margin: 0px auto;
			}
		</style>
		<script type="text/javascript">
			
			function myregister(){
				var nameObj = document.getElementById("name");
				var pwdObj = document.getElementById("password");
				var ageObj = document.getElementById("age");
				var emailObj =document.getElementById("email");
				var sexObj = document.getElementsByName("sex");
				var hobbyObj = document.getElementsByName("hobby");
				var  boxObj =document.getElementById("box");
				var result ;
				if(nameObj.value.trim().length>0 && nameObj.value.trim().length<=10){
					if(pwdObj.value.trim().length==6){
						if(ageObj.value<100 && ageObj.value>1){
							var emailValue = emailObj.value;
							var atIndex = emailValue.indexOf("@");
							var dotIndex = emailValue.indexOf(".");
							
							if(atIndex>0 && (dotIndex>atIndex+1) && emailValue.endsWith("com")){
								//合法，需要将值放入到box中
								result = "性别："
								for(var i=0;i<sexObj.length;i++){
									if(sexObj[i].checked==true){
										result += sexObj[i].value;
									}
								}
								alert(result);
								//checkbox取值
								
							}else{
								boxObj.innerHTML = "邮箱输入错误";
							}
						}else{
							boxObj.innerHTML = "年龄输入错误";
						}
					}else{
						boxObj.innerHTML = "密码输入错误";
					}
				}else{
					boxObj.innerHTML = "用户名输入错误";
				}
			}
		</script>
	</head>
	<body>
		<div id="content">
			姓名：<input type="text" id="name" placeholder="please input your name" /><br />
			密码：<input type="password" id="password" placeholder="please input your password" /><br />
			年龄：<input type="text" id="age" placeholder="please input your age" /><br />
			邮箱：<input type="text" id="email" placeholder="please input your email" /><br />
			性别:<input type="radio" name="sex" value="male"/>男<input type="radio" name="sex" value="female"/>女<br />
			爱好：<input type="checkbox" name="hobby" value="reading"/>reading<input type="checkbox" name="hobby" value="sport"/>sport<input type="checkbox" name="hobby" value="swimming"/>swimming<br />
			<input type="button"  value="register" onclick="myregister()" />
			<div id="box">ss</div>
		</div>
	</body>
</html>
```


- Array类型
```
	•	前言： 
	•	1、Array类型是ECMAScript最常用的类型。 
	•	2、ECMAScript中的Array类型和其他语言中的数组有着很大的区别。
	•	区别：
	•	1、ECMAScript中的数组每个元素可以保存任何类型。
	•	2、ECMAScript中数组的大小也是可以调整的。
1.1 创建数组
1.1.1 使用new关键字创建数组
	•	eg： 
	•	var box = new Array();					 
	•	//创建了一个数组 
	•	var box = new Array(86);					 
	•	//创建一个包含86个元素的数组 
	•	var box = new Array('jack',25,'工程师','武汉'); 
	•	//创建一个数组并分配好了元素 

			var myarr1 = new Array();
			myarr1[0] = "jane";
			
			var myarr2 = new Array(2);//js中的数组可以扩充。规定了长度是2，下标可以也可以大于数组长度。
			myarr2[0] = "frank";
			myarr2[1] = 5;
			myarr2[4] = "male";
			
			var result = "";
			for (var i =0; i<myarr2.length;i++) {
				result += myarr2[i]+";";
			}
			document.write(result);//frank;5;undefined;undefined;male;

1.1.2 使用字面量方式创建数组
	•	eg：
	•	var box = [];							
	•	//创建一个空的数组
	•	var box = ['Jack',25,'工程师','武汉'];			
	•	//创建包含元素的数组

			var myarr2 = ["frank",5,"male"];
	
			var result = "";
			for (var i =0; i<myarr2.length;i++) {
				result += myarr2[i]+";";
			}
			document.write(result);//frank;5;male;

1.2 读取数组的值
	•	1.使用索引下标来读取数组的值
	•	eg：
	•	var box = ['Jack',25,'工程师','武汉'];		 
	•	alert(box[2]);						
	•	//获取第三个元素
	•	box[2] = '学生';					
	•	//修改第三个元素
	•	box[4] = 'JavaScript编程技术';				
	•	//增加第五个元素
1.3 length属性
	•	获取数组元素量
	•	eg：
	•	var box = ['Jack',25,'工程师','武汉'];	
	•	alert(box.length)						
	•	//获取元素个数
	•	box.length = 10;						
	•	//强制修改元素个数
	•	box[box.length] = 'HTML5编程技术';				
	•	//通过length给数组增加一个元素
1.4 二维数组
			var myarr = new Array(2);
			
				var p1 = ["zhangsan","male",25];
				var p2 = ["lisi","female",26];
				
				myarr[0] = p1;
				myarr[1] = p2;
				
				var value2 = "";
				for(var i=0;i<myarr.length;i++){
					var temp = myarr[i];
					for(var j=0;j<temp.length;j++){
						value2 += temp[j] + ",";
					}
					value2 += ";";
				}
				alert(value2);//zhangsan,male,25,;lisi,female,26,;
```

```
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script>
//			var myarr1 = new Array();
//			myarr1[0] = "jane";
//			
//			var myarr2 = new Array(2);//js中的数组可以扩充。规定了长度是2，下标可以大于数组 长度。
//			myarr2[0] = "frank";
//			myarr2[1] = 5;
//			myarr2[4] = "male";
//			
//			var result = "";
//			for (var i =0; i<myarr2.length;i++) {
//				result += myarr2[i]+";";
//			}
//			document.write(result);//frank;5;undefined;undefined;male;

//			var myarr2 = ["frank",5,"male"];
//	
//			var result = "";
//			for (var i =0; i<myarr2.length;i++) {
//				result += myarr2[i]+";";
//			}
//			document.write(result);//frank;5;male;

//			二维数组
//			var myarr = new Array(2);
//			
//				var p1 = ["zhangsan","male",25];
//				var p2 = ["lisi","female",26];
//				
//				myarr[0] = p1;
//				myarr[1] = p2;
//				
//				var value2 = "";
//				for(var i=0;i<myarr.length;i++){
//					var temp = myarr[i];
//					for(var j=0;j<temp.length;j++){
//						value2 += temp[j] + ",";
//					}
//					value2 += ";";
//				}
//				alert(value2);//zhangsan,male,25,;lisi,female,26,;
		</script>
	</head>
	<body>
	</body>
</html>
```

- Object类型
```
	•	描述：
	•	Object类型是使用的引用类型最多的。
	•	虽然Object的实例不具备多少功能，但对于在应用程序中的存储和传输数据而言，它确实是非常理想的选择。

2.1 创建Object
2.1.1 使用new运算符创建Object
	•	eg： 
	•	var box = new Object(); 
	•	//new方式 
	•	box.name = 'jack'; 
	•	//创建属性字段 
	•	box.age = 26; 
	•	//创建属性字段 
	•	new关键字可以省略 

			var myo = new Object();
			myo.name = "frank";
			myo.age = 5;
			myo.sex = "male";		
			alert(myo.sex);//male
2.1.2 使用字面量方式创建Object
	•	eg：
	•	var box = {	//字面量方式
	•	name : 'jack',  //创建属性字段
	•	age : 26
};

			var my2 = {name:"frank",age:5,sex:"male"};
			alert(my2.age);//5
2.2 属性字段也可以使用字符串形式
	•	eg：
	•	var box = {
	•	'name' : 'jack',
	•	//也可以用字符串形式
	•	'age' : 26
	•	};

			var my4 = {"name":"lili","age":18};
2.3 Objevt赋值
	•	eg：
	•	var box = {};
	•	//字面量方式声明空的对象
	•	box.name = 'jack';
	•	//点符号给属性赋值
	•	box.age = 25;
2.3.1 第一种赋值方式
			var my3 = {name:"lili",age:18};
			alert(my3.name);//lili
2.3.1 第二种赋值方式
			var my4 = {"name":"lili","age":18};
			alert(my4.age);//18
2.3.1 第三种赋值方式
			var my5 = {};
			my5.name = "xixi";
			my5.age = 20;
			alert(my5.age);//20	
```

```
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script>
//			var myo = new Object();
//			myo.name = "frank";
//			myo.age = 5;
//			myo.sex = "male";		
//			alert(myo.sex);//male
//			
//			var my2 = {name:"frank",age:5,sex:"male"};
//			alert(my2.age);//5

//			var my3 = {name:"lili",age:18};
//			alert(my3.name);//lili
//			
//			var my4 = {"name":"lili","age":18};
//			alert(my4.age);//18
//						
//			var my5 = {};
//			my5.name = "xixi";
//			my5.age = 20;
//			alert(my5.age);//20			
		</script>
	</head>
	<body>
	</body>
</html>
2.4输出Object内容
2.4.1 点表示法输出
			var my2 = {name:"xixi",age:20};
			alert(my2.age);//20
2.4.2 中括号表示法输出
			var my1 = {name:"lili",age:18};
			alert(my1["age"]);//18

注：中括号表示法输出，注意引号不能省略  ，必须使用单引号或双引号。
2.5 给对象创建方法
	•	给对象创建方法
	•	eg：
	•	var box = {	
	•		run : function () {	//对象中的方法
	•			return '执行';
	•		}
	•	}
	•	alert(box.run());

			//调用对象中的方法
			var myo = {
				run:function(){
					alert(123);
				}
			};
			myo.run();//123
			
			var m2 = new Object();
			m2.run = function(){
				alert(456);
			}
			m2.run();//456
2.6 delete删除对象属性
	•	使用delete删除对象属性
	•	eg：
	•	var box = {
	•			name: 'jack',
	•			age: '26'
	•		          };
	•	delete box.name;
	•	alert(box);//object Object
	•	alert(box.name);//undefined 
	•	//删除属性

			var myo = {
				'name':'frank',
				'age':5,
				'sex':'male'
			};
			alert(myo.name);//frank
			delete myo.name;
			alert(myo.name);//defined
			
			myo.age = null;
			alert(myo.age);//null
			
			myo.sex = null;
			alert(myo.sex);//null

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script>
//			var my1 = {name:"lili",age:18};
//			alert(my1["age"]);//18
//			
//			var my2 = {name:"xixi",age:20};
//			alert(my2.age);//20

//			//调用对象中的方法
//			var myo = {
//				run:function(){
//					alert(123);
//				}
//			};
//			myo.run();//123
//			
//			var m2 = new Object();
//			m2.run = function(){
//				alert(456);
//			}
//			m2.run();//456

//			var myo = {
//				'name':'frank',
//				'age':5,
//				'sex':'male'
//			};
//			alert(myo);
//			alert(myo.name);//frank
//			delete myo.name;
//			alert(myo.name);//defined
//			
//			myo.age = null;
//			alert(myo.age);//null
//			
//			myo.sex = null;
//			alert(myo.sex);//null
		</script>
	</head>
	<body>
	</body>
</html>
```

- 对象方法（Array对象和Object对象）
```
3.1 toLocaleString()、toString()、valueOf()
	•	对象或数组都具有toLocaleString()、toString()和valueOf()方法。其中toString()和valueOf()无论重写了谁，都会返回相同的值。数组会将每个值进行字符串形式的拼接，以逗号隔开。
	•	eg：
	•	var box = ['jack',26,'JavaScript'];//字面量数组
	•	alert(box);			//隐式调用了toString()
	•	alert(box.toString());		//和valueOf()返回一致 
	•	alert(box.valueOf()); 
	•	alert(box.toLocaleString());	//返回值和上面两种一致

			var arr = ['frank',5,'male'];
			alert(arr);
			alert(arr.toString());//frank,5,male
			alert(arr.valueOf());//frank,5,male
			alert(arr.toLocaleString());//frank,5,male
3.2 join()
	•	默认情况下，数组字符串都会以逗号隔开。如果使用join()方法，则可以使用不同的分隔符来构建这个字符串。不改变数组的原有的分隔符和值。 
	•	eg：
	•	var box = ['jack', 26, 'JavaScript'];
	•	alert(box.join('|'));	     //jack|26|JavaScript

			var arr = ['frank',5,'male'];
			alert(arr.join('||'));//frank||5||male
			alert(arr);//frank,5,male

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script>
//			var arr = ['frank',5,'male'];
//			alert(arr);
//			alert(arr.toString());//frank,5,male
//			alert(arr.valueOf());//frank,5,male
//			alert(arr.toLocaleString());//frank,5,male

//			var arr = ['frank',5,'male'];
//			alert(arr.join('||'));//frank||5||male
//			alert(arr);//frank,5,male
		</script>
	</head>
	<body>
	</body>
</html>
```


- 栈方法 push() pop()
```
	•	栈方法
	•	ECMAScript数组提供了一种让数组的行为类似于其他数据结构的方法。 
	•	也就是说，可以让数组像栈一样，可以限制插入和删除项的数据结构。 
	•	栈是一种数据结构(后进先出)，也就是说最新添加的元素最早被移除。 
	•	而栈中元素的插入(或叫推入)和移除(或叫弹出)，只发生在一个位置——栈的顶部。 
	•	ECMAScript为数组专门提供了push()和pop()方法。
	•	注意：
	•	push()方法可以接收任意数量的参数，把它们逐个添加到数组的末尾，并返回修改后数组的长度。
	•	而pop()方法则从数组末尾移除最后一个元素，减少数组的length值，然后返回移除的元素。

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script>
			var nameArray = ['tom','jim','tim'];
			alert(nameArray.push('john'));//4 push返回数组新的长度
			alert(nameArray);//tom,jim,tim,john
			
			alert(nameArray.pop());//john
			alert(nameArray);//tom,jim,tim
		</script>
	</head>
	<body>
	</body>
</html>
```

- 队列方法 push() pop() shift() unshift()
```
	•	队列方法
	•	栈方法是后进先出，而列队方法就是先进先出。列队在数组的末端添加元素，从数组的前端移除元素。通过push()向数组末端添加一个元素，然后通过shift()方法从数组前端移除一个元素。 
	•	ECMAScript还为数组提供了一个unshift()方法，它和shift()方法的功能完全相反。unshift()方法为数组的前端添加一个元素。
	•	注意：
	•	IE浏览器对unshift()方法总是返回undefined而不是数组的新长度。

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script>
			var nameArray = ['tom','jim','tim'];
			alert(nameArray.push('john'));//4 push返回数组新的长度
			alert(nameArray);//tom,jim,tim,john
			
			alert(nameArray.shift());//tom 将数组前面数据移出，返回最前端的数据
			alert(nameArray);//jim,tim,john

			alert(nameArray.unshift("frank"));//4 将frank插入到数组前端，返回数组新长度，IE返回undefined
			alert(nameArray);//frank,jim,tim,john
		</script>
	</head>
	<body>
	</body>
</html>
```

- 排序方法 reverse() sort()
```
	•	重排序方法
	•	数组中已经存在两个可以直接用来排序的方法：reverse()和sort()。
	•	reverse() 逆序
	•	数组中已经存在两个可以直接用来排序的方法：reverse()和sort()。
	•	sort() 从小到大排序
	•	注意：
	•	sort方法的默认排序在数字排序上有些问题，因为数字排序和数字字符串排序的算法是一样的。
	•	我们必须修改这一特征，修改的方式，就是给sort(参数)方法传递一个函数参数。这点可以参考手册说明。

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script>
			var scoreArr = [45,65,89,76];
			alert(scoreArr.reverse());//76,89,65,45 将数组从后往前输出,改变原有数组的值
			alert(scoreArr);//76,89,65,45
			
			var scoreArr1 = [45,65,5,89,76];
			alert(scoreArr1.sort());//45,5,65,76,89 排序，改变原有数组的值。排序规则遵照字符串排序方式，先首位排序，再比较第二位依次第n位
			alert(scoreArr1.sort(function(x,y){
//				return y-x;//降序
				return x-y;//升序
			}));//5,45,65,76,89 sort参数传入排序规则
			alert(scoreArr1);//5,45,65,76,89
		</script>
	</head>
	<body>
	</body>
</html>
```

- 相关操作方法 concat() slice() splice()
```
	•	操作方法
	•	ECMAScript为操作已经包含在数组中的元素提供了很多方法。
	•	concat()方法可以基于当前数组创建一个新数组。
调用concat的对象arr1不改变，返回新数组。
			var arr1 = ["frank",6,"male"];
			alert(arr1.concat("english"));//frank,6,male,english
			alert(arr1);//frank,6,male

	•	slice()方法可以基于当前数组获取指定区域元素并创建一个新数组。
slice(n,m)截取下标n（包含n）到下标m（不包含m）的值返回，原有对象不改变
			var arr1 = ["frank",6,"male"];
			alert(arr1.slice(1,2));//6
			alert(arr1); //frank,6,male

	•	splice()主要用途是向数组的中部插入元素。 
	•	splice的删除功能 ：
	arr2 = arr1.splice(n,m):将arr1下标为n的字符往后数m位删除掉，返给arr2.arr1是删除后留下的数组。
			var arr1 = ["frank",6,"male"];
			alert(arr1.splice(1,2));//6,male
			alert(arr1);//frank

	•	splice的插入功能：
	arr2 = arr1.splice(n,0,value);将value插入到arr1中下标n的位置，arr1是新数组，arr2是空
			var arr1 = ["frank",6,"male"];
			alert(arr1.splice(1,0,"english"));//空
			alert(arr1);//frank，english,6,male

	•	splice替换功能：
	arr2 = arr1.splice(n,m,value);将arr1下标为n往后数m位删除掉，删除掉数据返回给arr2，将value插入到arr1下标n的位置，将新数组赋值给arr1
			var arr1 = ["frank",6,"male"];
			alert(arr1.splice(1,2,"english"));//6,male
			alert(arr1);//frank，english

总结：splice参数1：操作的起始下标
参数2：删除的个数。0代表不删除。
参数3：插入到参数1下标位置的值
调用函数返回的是删除的数据，
alert(arr1.splice(1,2,"english"));//6,male
调用方法的对象得到新的数组值。
alert(arr1);//frank，english
```

```
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script>
//			var arr1 = ["frank",6,"male"];
//			alert(arr1.concat("english"));//frank,6,male,english
//			alert(arr1);//frank,6,male

//			var arr1 = ["frank",6,"male"];
//			alert(arr1.slice(1,2));//6
//			alert(arr1); //frank,6,male

//			var arr1 = ["frank",6,"male"];
//			alert(arr1.splice(1,2));//6,male
//			alert(arr1);//frank

//			var arr1 = ["frank",6,"male"];
//			alert(arr1.splice(1,0,"english"));//空
//			alert(arr1);//frank，english,6,male

//			var arr1 = ["frank",6,"male"];
//			alert(arr1.splice(1,2,"english"));//6,male
//			alert(arr1);//frank，english
		</script>
	</head>
	<body>
	</body>
</html>
```

- 函数
```
	•	什么是函数？
	•	函数是一段命名的代码块，是可以重复使用的一组语句的组合。 
	•	将常用功能代码定义为函数，避免代码的重复编写，使程序结构清晰，易于维护。
	•	函数分类：自定义函数和系统内置函数两类。
	•	语法格式 
	•	function functionName( [参数1],[参数2],[参数3]…){代码块…[return 参数r]} 
	•	函数由以下几个部分组成
	•	function关键字，必须；
	•	functionName，函数名称，规则与变量的命名规则一样；函数名称不能与变量同名。 
	•	函数名称后紧跟括号( )，( )中包含参数。参数是函数将从调用者处获得的值，参数可有可无，数量根据需要而定。 
	•	由大括号{ }括起来的函数代码块,代码块在定义函数时并不执行,而是在调用时执行的. 
	•	函数中可以使用return语句向调用者返回值。retur n语句是可选的。return后紧跟的是要返回的值。return语句返回值，立即结束函数的执行。
	•	调用函数
	•	可在函数定义的程序文件中随时随地调用函数；
	•	调用函数时，指定参数与函数定义时的参数按顺序依次对应，多个参数间用逗号隔开。
	•	function中定义的的函数语句在函数定义时并不执行，而只有在被调用时才被执行。 
	•	函数参数
	•	参数是函数将从调用者处获得的值，参数可有可无，数量根据需要而定。
	•	定义函数参数时不需要指这参数的数据类型。
	•	实参列表：调用时指定的参数列表
	•	形参列表：函数定义时定义的参数列表 
数组里面没复制的、函数中typeof（未定义的变量）均为undefined
```

- 变量作用域
```
全局变量：所有方法都能用，其中一个方法改值，其余方法再访问是改后。
局部变量：只有当前方法可用，其余方法不能用。
全局变量和局部变量重名。局部变量起作用。
	•	变量作用域
	•	变量作用的范围（可以被使用的范围）称为变量作用域。 
	•	按作用域可以将JS变量分为全局变量和局部变量。 
	•	可以在当前脚本中任何地方使用的变量称为全局变量，它们具有全局作用域； 
	•	只能在对其进行定义的函数中使用的变量称为局部变量，它们具有局部作用域。
	•	在任何位置（包括函数内部）省略 var 关键字定义的变量均为全局变量。
	•	局部变量会在函数运行以后被删除，全局变量会在页面关闭后被删除。
	•	当全局变量与局部变量同名时
	•	当函数中定义的局部变量与全局变量同名时，局部变量将覆盖全局变量 
	•	也就是说，在函数中使用函数中定义的局部变量，而不使用函数之外定义的全局变量，也不会影响函数之外的全局变量。

注：在任何位置（包括函数内部）省略 var 关键字定义的变量均为全局变量。

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script>
			var ga = 5;
			function a(){
				var a1 = 5;
				alert(a1+","+ga);
				alert(a2);//没有反应
				alert(typeof(a2));//undefined
				ga = 55;
				gb = 22;
			}
			function b(){
				var a2 = 15;
				alert(a2+","+ga);//不点击testa按钮，输出ga是5.如果点击testa按钮，ga是55；
				alert(gb);//不点击testa按钮，没有反应
			}
		</script>
	</head>
	<body>	
		<input type="button" value="testa" onclick="a()" />
		<input type="button" value="testb" onclick="b()" />
	</body>
</html>
```

- 函数参数
```
	•	复合数据类型的参数
	•	调用函数时，如果将基本数据类型变量作为函数参数，直接将值传递给函数，函数内的操作对原变量本身没有影响； 形参改变不会影响实参。
	•	而将复合数据类型变量作为函数参数时，传递给函数的是存储位置的地址，在函数内对复合数据变量的操作同样影响函数外的原变量。形参改变影响实参。

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script>
			//如果参数是基本数据类型，形参改变不影响实参。因为基本数据类型是值传递
			function testBasic(){
				var v1 = 123;
				basicParaMethod(v1);
				alert(v1);//123
			}
			function basicParaMethod(value){
				value = 345;
			}
			testBasic();

			//如果参数是引用数据类型，形参改变影响实参，因为引用类型传地址
			function testReference(){
				var v1 = new Object();
				v1.age =35;
				referenceParaMethod(v1);
				alert(v1.age);//345
			}
			function referenceParaMethod(value){
				value.age = 345;
			}
			testReference();
		</script>
	</head>
	<body>		
	</body>
</html>
```

```
知识点补充：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script>
			//知识点引入：在一个函数中可以直接调用另一个函数，通过参数传值。
			function a(){
				var v1 = 123;
				b(v1);//一个函数可以调用另一个函数
			}
			function b(value){
				alert(value);//123
			}
			a();
		</script>
	</head>
	<body>		
	</body>
</html>
```

- 匿名函数
```
	•	当函数作为数据使用时，可以将函数定义直接指定给变量、数组元素、对象属性等，而不需要为函数指定名称，这种函数称为匿名函数。
	•	匿名函数的定义格式，是省略掉传统的函数定义格式中的函数名，将参数列表()直接跟在function

示例代码1：当网页加载完成后，调用匿名函数。
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script>
			window.onload=function(){
				alert("大家好");
			}
		</script>
	</head>
	<body>		
	</body>
</html>
```

```
示例代码2：增加一个数组元素，数组元素的值是一个匿名函数。
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script>
			var arr = new Array();//定义一个空数组
			arr[0] = function(num){
				return num*num*num;
			};
			var n = arr[0](10);//访问数组元素
			document.write(n);//1000
		</script>
	</head>
	<body>		
	</body>
</html>
```

- 函数作为数据使用
```
	•	使用函数赋值（例如：将函数赋值给变量，通过变量调用函数）
	•	JS函数作为一种对象，作为一种引用数据，可以像其他类型的变量一样进行使用，可以将函数赋给变量、数组元素、对象属性，甚至作为其它函数的参数，而其函数功能依然有效。
	•	在将函数作为数据使用时，是对函数本身的引用，是将对函数的引用赋予变量或者数组元素，需要直接使用函数名称。

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script>
			function my(){
				alert(123);//123
			}
			var a = my;
			a();
		</script>
	</head>
	<body>		
	</body>
</html>
```

- 函数对象、arguments属性
```
	•	函数对象
	•	JS函数实际上是功能完整的函数对象，是一种引用数据类型。当定义一个函数时，便定义了一个与函数同名的函数对象。
	•	arguments属性
	•	该属性为数组性属性，数组中包含了函数调用时接受的所有参数。该属性本身也是一个对象，拥有一个length属性，表示接受的参数的个数。 

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script>
			function my(){
				var result = "";
				for(var i=0;i<arguments.length;i++){
					result += arguments[i];	
				}
				alert(result);//12345
			}
			my(1,2,3,45);
		</script>
	</head>
	<body>		
	</body>
</html>
```

- 事件
```
14.1 什么是js事件
	•	HTML 事件是发生在 HTML 元素上的事情，当在 HTML 页面中使用 JavaScript 时， JavaScript 可以触发这些事件。 
	•	HTML 事件可以是浏览器行为，也可以是用户行为。
	•	以下是 HTML 事件的实例：
	•	HTML 页面完成加载
	•	HTML input 字段改变时
	•	HTML 按钮被点击
	•	在事件触发时 JavaScript 可以执行一些代码。

14.2 事件语法

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	<script>
		function my(){
			alert(123);
		}
		function mydb(){
			alert(456);
		}
		function myload(){
			alert("页面全部加载");
		}
	</script>
	</head>
	<body onload="myload()">
		<input type="radio" value="female" name="sex" onchange="my()"/>female
		<input type="radio" value="male" name="sex" onchange="my()"/>male
		<input type="button" ondblclick="mydb()" value="双击触发"/>
	</body>
</html>

运行结果：


当单选框的选择改变时：  
当双击”双击触发”按钮时：


14.3 常用事件

14.3.1 onmouseover、onmouseout
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style>
			img{
				width: 50px;
				height: 50px;
			}
		</style>
		<script>
			function bigScale(){
				var imgObj = document.getElementsByTagName("img")[0];	
				imgObj.style.width = "200px";
				imgObj.style.height = "200px";
			}
			function normalScale(imgObj){
				imgObj.style.width = "100px";
				imgObj.style.height = "100px";
			}
		</script>
	</head>
	<body>
		<img src="img/cartoon.png" onmouseover="bigScale()" onmouseout="normalScale(this)"/>
	</body>
</html>

运行结果：
网页加载完成之后：

当鼠标光标放到图片上之后：

当鼠标光标从图片上移开之后：
```


```
练习：使用js控制，当鼠标移入时字体红色，移出时字体黑色
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script>
//			//第一种做法
//			function myover(obj){
//				obj.style.color = "red";
//			}
//			function myout(obj){
//				obj.style.color = "black";
//			}

			//第二种做法
			var text = "";
			function myover(obj){
				if(text==""){
					text = obj.innerHTML;
				}	
				obj.innerHTML = text.fontcolor("red");
			}
			function myout(obj){
				obj.innerHTML = text.fontcolor("black");
			}
		</script>
	</head>
	<body>
		<div onmouseover="myover(this)" onmouseout="myout(this)" style="width: 200px;height: 200px;border: 1px solid red;"> 
			hello,everyone
		</div>
	</body>
</html>

运行结果：

当光标移入时：
当光标移出时：
```


- 事件-onkeydown
```
	• onkeydown：用户按下键盘按键
```

```
练习：输入框输入回车，将输入文字显示div中。输入esc键盘，清空输入。 
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script>
			function myEvent(event){
				var inObj = document.getElementsByName("inputBox")[0];
				var outObj = document.getElementById("outputBox");
				
				if(event.which == 13){
					outObj.innerHTML = inObj.value;
				}else if(event.which == 27){
					inObj.value = "";
					outObj.innerHTML = "";
				}
			}
		</script>
	</head>
	<body>
		<input type="text" name="inputBox" onkeydown="myEvent(event)"/>
		<div id="outputBox"></div>
	</body>
</html>

运行结果：

输入文字后，点击回车键：

点击Esc键：
```

- onload
```
	•	onload：页面结束加载之后触发。 
```


- js作用
```
	•	事件可以用于处理表单验证，用户输入，用户行为及浏览器动作:
	•	页面加载时触发事件
	•	页面关闭时触发事件
	•	用户点击按钮执行动作
	•	验证用户输入内容的合法性
```


- js表单验证


- 常规事件
```
4.1 针对 window 对象触发的事件 （应用到 <body> 标签）


4.2 应用到几乎所有 HTML 元素，但最常用在 form 元素中


4.3 键盘事件

onkeydown和onkeypress都是按下键盘时触发，前者对所有键盘都适用，后者对特殊功能按键不响应。

4.4 鼠标事件
```
