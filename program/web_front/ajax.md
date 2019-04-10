# ajax


- ajax简介

```
传统的网页（不使用 AJAX）如果需要更新内容，必需重载整个网页面。 
AJAX 是一种在无需重新加载整个网页的情况下，更新部分网页的技术。
AJAX = 异步 JavaScript 和 XML。
通过在后台与服务器进行少量数据交换，AJAX 可以使网页实现异步更新。
AJAX 是一种用于创建快速动态网页的技术。 
有很多使用 AJAX 的应用程序案例：新浪微博、Google 地图、开心网等等
```


- jquery与ajax

```
jQuery 提供多个与 AJAX 有关的方法。
通过 jQuery AJAX 方法，您能够使用 HTTP Get 和 HTTP Post 从远程服务器上请求文本、HTML、XML 或 JSON - 同时您能够把这些外部数据直接载入网页的被选元素中。
编写常规的 AJAX 代码并不容易，因为不同的浏览器对 AJAX 的实现并不相同。这意味着您必须编写额外的代码对浏览器进行测试。不过，jQuery 团队为我们解决了这个难题，我们只需要一行简单的代码，就可以实现 AJAX 功能。 
```


- ajax-get方法

```
示例代码：
test.html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script type="text/javascript" src="js/jquery-3.0.0.js" ></script>
		<script type="text/javascript">
			$(function(){
				$("#btn").click(function(){
					$.get("test_ajax_get.txt",function(data,status){
						alert("Data: " + data + "Status: " + status);
						$('#T1').html(data);
					});
				});
			});
		</script>
	</head>
	<body>
		<div id="T1" style="border:1px solid black;height:40px;width:300px;padding:5">dd</div><br />
		<button id="btn">Click</button>
	</body>
</html>

test_ajax_get.txt
this is get.

运行结果：

点击”Click”按钮之后：
```


- ajax-post方法

```
示例代码：
test.html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script type="text/javascript" src="js/jquery-3.0.0.js" ></script>
		<script type="text/javascript">
			$(function(){
				$("#btn").click(function(){
					$.get("demo_test_post.html",function(data,status){
						alert("Data: " + data + "Status: " + status);
						$('#T1').html(data);
					});
				});
			});
		</script>
	</head>
	<body>
		<div id="T1" style="border:1px solid black;height:40px;width:300px;padding:5">dd</div><br />
		<button id="btn">Click</button>
	</body>
</html>

demo_test_post.html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		this is post.
	</body>
</html>

运行结果：

点击”Click”按钮之后：
```


- ajax-load方法

```
示例代码:
test.html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script type="text/javascript" src="js/jquery-3.0.0.js" ></script>
		<script type="text/javascript">
			$(function(){
				$("#btn").click(function(){
					$("#T1").load("test_ajax_load.txt",function(responseTxt,statusTxt,xhr){
						alert(responseTxt+";"+statusTxt+";");
						
						if(statusTxt=="success")
							alert("External content loaded successfully!");
						if(statusTxt=="error")
							alert("Error: "+xhr.status+": "+xhr.statusText);
					});
				});
			});
		</script>
	</head>
	<body>
		<div id="T1" style="border:1px solid black;height:40px;width:300px;padding:5">dd</div><br />
		<button id="btn">Click</button>
	</body>
</html>

test_ajax_load.txt
this is load.

运行结果:

点击”Click”按钮之后：
```


- ajax-ajax方法

```
name值如下：
名称/值含义如下：
url:规定发送请求的 URL。默认是当前页面。
async :布尔值，表示请求是否异步处理。默认是 true。 
success :当请求成功时运行的函数。 
error:如果请求失败要运行的函数。 
data :规定要发送到服务器的数据。 例如： data: "name=John&location=Boston" 
type :规定请求的类型（GET 或 POST）。 
dataType :预期的服务器响应的数据类型。 取值：xml,html,script,json,text 
timeout :设置本地的请求超时时间（以毫秒计）。 

示例代码：
test.html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script type="text/javascript" src="js/jquery-3.0.0.js" ></script>
		<script type="text/javascript">
			$(function(){
				$("#btn").click(function(){
					$.ajax({
						url:"test_ajax_ajax.txt",
						async:true,
						success:function(result){
							$('#T1').html(result);
						}
					});
				});
			});
		</script>
	</head>
	<body>
		<div id="T1" style="border:1px solid black;height:40px;width:300px;padding:5">dd</div><br />
		<button id="btn">Click</button>
	</body>
</html>

test_ajax_ajax.txt
this is ajax.

运行结果:

点击”Click”按钮之后：
```


- 图片轮播

```
示例代码：
turnStyle.css
#box{
	width: 520px;
	height: 280px;
	position: relative;
	left: 300px;
	top: 200px;
	
}

#imgBox img{
	width: 520px;
	height: 280px;
	position: absolute;
	left: 0px;
	top: 0px;
}
#circleBox{
	background: #808080;
	height: 20px;
	width: 140px;
	border-radius: 10px;
	position: absolute;
	left: 190px;
	top: 240px;
	
}
.circleDot{
	width: 14px;
	height: 14px;
	border-radius: 7px;
	background: white;
	float: left;
	margin: 3px 7px;
}
.circleDotOn{
	background: red;
}

test.html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<link rel="stylesheet" href="css/turnStyle.css" />
		<script type="text/javascript" src="js/jquery-3.0.0.js" ></script>
		<script>
			$(function(){
				$("#imgBox img").hide();
				$("#imgBox img:first").show();
				$(".circleDot").eq(0).addClass("circleDotOn");
				
				var dotIndex = 0;
				$(".circleDot").click(function(){
					dotIndex = $(this).index();
					$("#imgBox>img").eq(dotIndex).show().siblings().hide();
					$(this).addClass("circleDotOn").siblings().removeClass("circleDotOn");
				});
				
				//轮播
				function play(){
					dotIndex = (dotIndex+1)%5;
					$("#imgBox>img").eq(dotIndex).show().siblings().hide();
					$(".circleDot").eq(dotIndex).addClass("circleDotOn").siblings().removeClass("circleDotOn");
				}
				
				var autoPlay = setInterval(play,2000);
				
				$("#imgBox>img").hover(function(){
					clearInterval(autoPlay);
				},function(){
					autoPlay = setInterval(play,2000);
				});
			})
		</script>
	</head>
	<body>
		<div id="box">
			<div id="imgBox">
				<img src="img/index_lb1.jpg" />
				<img src="img/index_lb2.jpg" />
				<img src="img/index_lb3.jpg" />
				<img src="img/index_lb4.jpg" />
				<img src="img/index_lb5.jpg" />
			</div>
			<div id="circleBox">
				<div class="circleDot"></div>
				<div class="circleDot"></div>
				<div class="circleDot"></div>
				<div class="circleDot"></div>
				<div class="circleDot"></div>
			</div>
		</div>
	</body>
</html>

运行结果：
```
