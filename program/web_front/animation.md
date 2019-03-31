### animation


- 什么是动画
```
动画是使元素从一种样式逐渐变化为另一种样式的效果。
您可以改变任意多的样式任意多的次数。
请用百分比来规定变化发生的时间，或用关键词 "from" 和 "to"，等同于 0% 和 100%。
0% 是动画的开始，100% 是动画的完成。
为了得到最佳的浏览器支持，您应该始终定义 0% 和 100% 选择器。
```


- 动画animation
```
animation 属性是一个简写属性，用于设置六个动画属性：
animation-name：规定需要绑定到选择器的 keyframe 名称。 
animation-duration：规定完成动画所花费的时间，以秒或毫秒计。 
animation-timing-function：规定动画的速度曲线。
	linear动画从头到尾的速度是相同的。 
	ease默认。动画以低速开始，然后加快，在结束前变慢。 
	ease-in动画以低速开始。 
	ease-out动画以低速结束。 
	ease-in-out动画以低速开始和结束。 
	cubic-bezier(n,n,n,n)在 cubic-bezier 函数中自己的值。可能的值是从 0 到 1 的数值。 
animation-delay：规定在动画开始之前的延迟 时间，以秒或毫秒计。 
animation-iteration-count：规定动画应该播放的次数，具体次数或infinite（无限次）。 
animation-direction：规定是否应该轮流反向播放动画，normal或alternate值。 
例如：animation: keyframeName 15s linear 0s  1;
```


- 动画 animation-fill-mode
```
animation-fill-mode 属性规定动画在播放之前或之后，其动画效果是否可见。 
none不改变默认行为。 
forwards当动画完成后，保持最后一个属性值（在最后一个关键帧中定义）。 
backwards在 animation-delay 所指定的一段时间内，在动画显示之前，应用开始属性值（在第一个关键帧中定义）。 
both向前和向后填充模式都被应用。 
```


- 动画@keyframes规则
```
@keyframes 规则用于创建动画。在 @keyframes中规定某项CSS样式，就能创建由当前样式逐渐改为新样式的动画效果。 
语法 
@keyframes  myfirst{
	from{
		    样式：值； 
	}
	to{
		    样式：值； 
	}
}

也可以将form动画开始，to动画结束换成百分比。 
@keyframes  myfirst{
	0%{
		    样式：值； 
	}
	50%{
		    样式：值； 
	}
	100%{
		    样式：值； 
	}
} 
```


- 练习1：小方块运动
```
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style>
			#container1{
				width: 100px;
				height: 100px;
				background: red;
				animation: colorAnimation1 2s  ease 1 ;
				animation-fill-mode: backwards;
				position: relative;
				
			}
			@keyframes colorAnimation1{
				from{
					left: 0px;
				}
				to{
					left: 200px;
				}
			}
		</style>
	</head>
	<body>
		<div id="container1">nihao</div>
	</body>
</html>

运行结果：
```


- 练习2：小方块颜色渐变
```
宽高100px的正方形，在5秒内从红色变成绿色，再变成蓝色。

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style>
			#changeColor{
				width: 100px;
				height: 100px;
				animation: colorAnimation1 5s linear 1;
				animation-fill-mode: forwards;
				position: relative;
			}
			@keyframes colorAnimation1{
				0%{
					background: red;
				}
				50%{
					background: green;
				}
				100%{
					background: blue;
				}
			}
		</style>
	</head>
	<body>
		<div id="changeColor"hello world></div>
	</body>
</html>

运行结果：
```


- 练习3：小方块沿大方块内部运动
```
在一个宽高500px的大正方形中，有一个红色小正方形宽高50px，沿着大正方形边框内部运动。
方式一：使用left和top属性
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<style type="text/css">
			#bigBox{
				width: 500px;
				height: 500px;
				border: 1px solid black;
			}
			#smallBox{
				width: 50px;
				height: 50px;
				background: red;
				animation: 8s sportAnimation linear infinite;
				position: relative;
			}
			@keyframes sportAnimation{
				0%{
					left: 0px;
					top: 0px;
				}
				25%{
					left: 450px;
					top: 0px;
				}
				50%{
					left: 450px;
					top: 450px;
				}
				75%{
					left: 0px;
					top: 450px;
				}
				100%{
					left: 0px;
					top: 0px;
				}
			}
		</style>
	</head>
	<body>
		<div id="bigBox">
			<div id="smallBox"></div>
		</div>
	</body>
</html>

方式二：使用translate
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<style type="text/css">
			#bigBox{
				width: 500px;
				height: 500px;
				border: 1px solid black;
			}
			#smallBox{
				width: 50px;
				height: 50px;
				background: red;
				animation: 3s sportAnimation linear 1;
				animation-fill-mode: forwards;
				position: relative;
			}
			/*1) transform如果有多个值，用空格区分。2）translate和translateX tranlateY可以混合使用。不能和left top混合使用*/
			@keyframes sportAnimation{
				0%{
					transform: translateX(0px) translateY(0px);
				}
				25%{
					transform: translate(450px,0px);
				
				}
				50%{
					transform: translateX(450px) translateY(450px);
				}
				75%{
					transform: translateX(0px) translateY(450px);
				}
				100%{
					transform:  translate(0px,0px);
				}
			}
		</style>
	</head>
	<body>
		<div id="bigBox">
			<div id="smallBox"></div>
		</div>
	</body>
</html>

运行结果：
```


- transform:translate()
```
通过 translate() 方法，元素从其当前位置移动，根据给定的 left（x 坐标） 和 top（y 坐标） 位置参数。注意单位是px。

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<style type="text/css">
			#bigBox{
				width: 500px;
				height: 500px;
				border: 1px solid black;
			}
			#smallBox{
				width: 50px;
				height: 50px;
				background: red;
				animation: 3s sportAnimation linear 1;
				animation-fill-mode: forwards;
				position: relative;
			}
			@keyframes sportAnimation{
				0%{
					transform: translate(0px,0px);
				}
				100%{
					transform:  translate(450px,450px);
				}
			}
		</style>
	</head>
	<body>
		<div id="bigBox">
			<div id="smallBox"></div>
		</div>
	</body>
</html>

运行结果：
```


- transform:rotate
```
通过 rotate() 方法，元素顺时针旋转给定的角度。允许负值，元素将逆时针旋转。单位deg。 

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<style type="text/css">
			#bigBox{
				width: 500px;
				height: 500px;
				border: 1px solid black;
			}
			#smallBox{
				width: 50px;
				height: 50px;
				background: red;
				animation: 3s sportAnimation linear 1;
				animation-fill-mode: forwards;
				position: relative;
			}
			@keyframes sportAnimation{
				0%{
					transform: rotate(0deg);
				}
				100%{
					transform:rotate(1440deg);
				}
			}
		</style>
	</head>
	<body>
		<div id="bigBox">
			<div id="smallBox"></div>
		</div>
	</body>
</html>

运行结果：
```


- 练习：同心圆
```
同心圆，大圆红色，小圆黄色，从左往右滚动。

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<style type="text/css">
			#bigBox{
				width: 100px;
				height: 100px;
				background: black;
				border-radius: 50px;
				animation: 3s bigsport linear 1;
				animation-fill-mode: forwards;
				line-height: 100px;
				text-align: center;
				position: relative;
			}
			@keyframes bigsport{
				0%{
					transform: rotate(0deg);
					left: 0px;
				}
				100%{
					transform:rotate(1440deg);
					left: 450px;
				}
			}
			
			#smallBox{
				width: 50px;
				height: 50px;
				background: yellow;
				animation: 3s sportAnimation linear 1;
				animation-fill-mode: forwards;
				position: absolute;
				left: 25px;
				top: 25px;
				border-radius: 25px;
				line-height: 50px;
				text-align: center;
				
			}
			@keyframes sportAnimation{
				0%{
					transform: rotate(0deg);
				}
				100%{
					transform:rotate(1440deg);
				}
			}
		</style>
	</head>
	<body>
		<div id="bigBox">
			<div id="smallBox">hello</div>
		</div>
	</body>
</html>

运行结果：
```


- 动画transform:scale
```
通过 scale() 方法，元素的尺寸会增加或减少，根据给定的宽度（X 轴）和高度（Y 轴）参数： 
示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<style type="text/css">
			#bigBox{
				width: 100px;
				height: 100px;
				background: red;
				animation: 3s bigsport linear 1;
				animation-fill-mode: forwards;
				line-height: 100px;
				text-align: center;
				position: relative;
				margin: auto auto;
			}
			@keyframes bigsport{
				0%{
					transform: scale(0,0);
				}
				100%{
					transform:scale(1,2);
				}
			}
		</style>
	</head>
	<body>
		<div id="bigBox">
		</div>
	</body>
</html>

运行结果：
```


- 练习1：小恐龙动画
```
知识点说明
<input  type="button" value="forwards" onclick="go (0)"/>

fucntion go(flag){
	var obj =	document.getElementById("");
	删除掉原有的css
	obj.removeAtrribue("class");
	根据判断添加新的css
		obj.className = "";
}

示例代码：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style>
			.walk_appear{
				width: 50px;
				height: 50px;
				animation: 4s walkappear linear 1;
				animation-fill-mode: forwards;
			}
			@keyframes walkappear{
				0%{
					background: url(img/dest_0_0.jpg) no-repeat;
					transform: scale(0);
				}
				25%{
					background: url(img/dest_0_1.jpg) no-repeat;
					transform: scale(0.25);
				}
				50%{
					background: url(img/dest_0_2.jpg) no-repeat;
					transform: scale(0.5);
				}
				75%{
					background: url(img/dest_0_3.jpg) no-repeat;
					transform: scale(0.75);
				}
				100%{
					background: url(img/dest_0_0.jpg) no-repeat;
					transform: scale(1);
				}
			}
			
			.walk_disappear{
				width: 50px;
				height: 50px;
				animation: 4s walkdisappear linear 1;
				animation-fill-mode: forwards;
			}
			@keyframes walkdisappear{
				0%{
					background: url(img/dest_3_0.jpg) no-repeat;
					transform: scale(1);
				}
				25%{
					background: url(img/dest_3_1.jpg) no-repeat;
					transform: scale(0.75);
				}
				50%{
					background: url(img/dest_3_2.jpg) no-repeat;
					transform: scale(0.5);
				}
				75%{
					background: url(img/dest_3_3.jpg) no-repeat;
					transform: scale(0.25);
				}
				100%{
					background: url(img/dest_3_0.jpg) no-repeat;
					transform: scale(0);
				}
			}
			
			.walk_along{
				width: 50px;
				height: 50px;
				animation: 4s walkalong linear 1;
				animation-fill-mode: forwards;
			}
			@keyframes walkalong{
				0%{
					background: url(img/dest_0_0.jpg) no-repeat;
				}
				25%{
					background: url(img/dest_0_1.jpg) no-repeat;
				}
				50%{
					background: url(img/dest_0_2.jpg) no-repeat;
				}
				75%{
					background: url(img/dest_0_3.jpg) no-repeat;
				}
				100%{
					background: url(img/dest_0_0.jpg) no-repeat;
				}
			}
			
			.walk_back{
				width: 50px;
				height: 50px;
				animation: 4s walkback linear 1;
				animation-fill-mode: forwards;
			}
			@keyframes walkback{
				0%{
					background: url(img/dest_3_0.jpg) no-repeat;
				}
				25%{
					background: url(img/dest_3_1.jpg) no-repeat;
				}
				50%{
					background: url(img/dest_3_2.jpg) no-repeat;
				}
				75%{
					background: url(img/dest_3_3.jpg) no-repeat;
				}
				100%{
					background: url(img/dest_3_0.jpg) no-repeat;
				}
			}
			
			.walk_left{
				width: 50px;
				height: 50px;
				animation: 4s walkleft linear 1;
				animation-fill-mode: forwards;
			}
			@keyframes walkleft{
				0%{
					background: url(img/dest_1_0.jpg) no-repeat;
				}
				25%{
					background: url(img/dest_1_1.jpg) no-repeat;
				}
				50%{
					background: url(img/dest_1_2.jpg) no-repeat;
				}
				75%{
					background: url(img/dest_1_3.jpg) no-repeat;
				}
				100%{
					background: url(img/dest_1_0.jpg) no-repeat;
				}
			}
			
			.walk_right{
				width: 50px;
				height: 50px;
				animation: 4s walkright linear 1;
				animation-fill-mode: forwards;
			}
			@keyframes walkright{
				0%{
					background: url(img/dest_2_0.jpg) no-repeat;
				}
				25%{
					background: url(img/dest_2_1.jpg) no-repeat;
				}
				50%{
					background: url(img/dest_2_2.jpg) no-repeat;
				}
				75%{
					background: url(img/dest_2_3.jpg) no-repeat;
				}
				100%{
					background: url(img/dest_2_0.jpg) no-repeat;
				}
			}
		</style>
		<script>
			function walk(flag){
				if(flag==0){
					var obj = document.getElementById("box");
					obj.removeAttribute("class");
					obj.className="walk_appear";
				}
				else if(flag==1){
					var obj = document.getElementById("box");
					obj.removeAttribute("class");
					obj.className="walk_disappear";
				}
				else if(flag==2){
					var obj = document.getElementById("box");
					obj.removeAttribute("class");
					obj.className="walk_along";
				}
				else if(flag==3){
					var obj = document.getElementById("box");
					obj.removeAttribute("class");
					obj.className="walk_back";
				}
				else if(flag==4){
					var obj = document.getElementById("box");
					obj.removeAttribute("class");
					obj.className="walk_left";
				}
				else if(flag==5){
					var obj = document.getElementById("box");
					obj.removeAttribute("class");
					obj.className="walk_right";
				}			
			}
		</script>
	</head>
	<body>
		<div id="box"></div>
		<input type="button" value="出现" name="Wa" onclick="walk(0)"/>
		<input type="button" value="消失" name="Wd" onclick="walk(1)"/>
		<input type="button" value="向前走" name="W1" onclick="walk(2)"/>
		<input type="button" value="向后走" name="W2" onclick="walk(3)"/>
		<input type="button" value="向左走" name="W3" onclick="walk(4)"/>
		<input type="button" value="向右走" name="W4" onclick="walk(5)"/>
	</body>
</html>

运行结果：
```


- 练习2：滚动小球
```
（1）老师的版本：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<style>
			#box{
				width: 1423px;
				height: 800px;
				margin: 0px auto;
				border: 1px solid red;
				position: relative;
			}
			#box div{
				width: 173px;
				height: 173px;
				position: absolute;
				top: 320px;
				/*left: -1000px;*/
				
			}
			#box div:nth-of-type(1){
				background: url(img/image_1.png) -190px -110px no-repeat;
				animation: 5s move1 linear 1;
				animation-fill-mode: forwards;
			}
			@keyframes move1{
				0%{left: 0px;}
				20%{left: 325px;}
				100%{left: 325px;}
			}
			#box div:nth-of-type(2){
				background: url(img/image_1.png) -370px -110px no-repeat;
				animation: 5s move2 linear 1;
				animation-fill-mode: forwards;
			}
			@keyframes move2{
				0%{left: 0px;}
				20%{left: 325px;}
				40%{left: 475px;}
				100%{left: 475px;}
			}
			#box div:nth-of-type(3){
				background: url(img/image_1.png) -550px -110px no-repeat;
				animation: 5s move3 linear 1;
				animation-fill-mode: forwards;
			}
			@keyframes move3{
				0%{left: 0px;}
				20%{left: 325px;}
				40%{left: 475px;}
				60%{left: 625px;}
				100%{left: 625px;}
			}
			#box div:nth-of-type(4){
				background: url(img/image_1.png) -730px -110px no-repeat;
				animation: 5s move4 linear 1;
				animation-fill-mode: forwards;
			}
			@keyframes move4{
				0%{left: 0px;}
				20%{left: 325px;}
				40%{left: 475px;}
				60%{left: 625px;}
				80%{left: 775px;}
				100%{left: 775px;}
			}
			#box div:nth-of-type(5){
				background: url(img/image_1.png) -910px -110px no-repeat;
				animation: 5s move5 linear 1;
				animation-fill-mode: forwards;
			}
			@keyframes move5{
				0%{
					left: 0px;
					transform: rotate(0deg);
				}
				20%{left: 325px;}
				40%{left: 475px;}
				60%{left: 625px;}
				80%{left: 775px;}
				100%{
					left: 925px;
					transform: rotate(2160deg);
				}
			}
		</style>
	</head>
	<body>
		<div id="box">
			<div></div>
			<div></div>
			<div></div>
			<div></div>
			<div></div>
		</div>
	</body>
</html>

（2）自己的版本：
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<style>
			.bodyBox{
				position: absolute;
				top: 50px;
				left: 240px;
				width: 1428px;
				height: 640px;
			}
			#circle1{
				width: 174px;
				height: 174px;
				background: url(img/image_1.png) -189px -110px no-repeat;
				animation: 4s roll1 linear 1;
				animation-fill-mode: forwards;
				position: absolute;
				margin-top: 322px;
			}
			#circle2{
				width: 174px;
				height: 174px;
				background: url(img/image_1.png) -369px -110px no-repeat;
				animation: 4s roll2 linear 1;
				animation-fill-mode: forwards;
				position: absolute;
				margin-top: 322px;
			}
			#circle3{
				width: 174px;
				height: 174px;
				background: url(img/image_1.png) -908px -110px no-repeat;		
				animation: 4s roll3 linear 1;
				animation-fill-mode: forwards;
				position: absolute;
				margin-top: 322px;
			}
			#circle4{
				width: 174px;
				height: 174px;
				background: url(img/image_1.png)  -550px -110px no-repeat;
				animation: 4s roll4 linear 1;
				animation-fill-mode: forwards;
				position: absolute;
				margin-top: 322px;
			}
			#circle5{
				width: 174px;
				height: 174px;
				background: url(img/image_1.png) -730px -110px no-repeat;
				animation: 4s roll5 linear 1;
				animation-fill-mode: forwards;
				position: absolute;
				margin-top: 322px;
			}
			
			@keyframes roll1{
				0%{
					left: 0px;
					top: 0px;
				}
				20%{
					left: 323px;
					top: 0px;
				}
				100%{
					left: 323px;
					top: 0px;
				}
			}
			@keyframes roll2{
				0%{
					left: 0px;
					top: 0px;
				}
				20%{
					left: 323px;
					top: 0px;
				}
				30%{
					left: 479px;
					top: 0px;
				}
				100%{
					left: 479px;
					top: 0px;
				}
			}
			@keyframes roll3{
				0%{
					left: 0px;
					top: 0px;
				}
				20%{
					left: 323px;
					top: 0px;
				}
				30%{
					left: 479px;
					top: 0px;
				}
				40%{
					left: 632px;
					top: 0px;
				}
				100%{
					left: 632px;
					top: 0px;
				}
			}
			@keyframes roll4{
				0%{
					left: 0px;
					top: 0px;
				}
				20%{
					left: 323px;
					top: 0px;
				}
				30%{
					left: 479px;
					top: 0px;
				}
				40%{
					left: 632px;
					top: 0px;
				}
				50%{
					left: 785px;
					top: 0px;
				}
				100%{
					left: 785px;
					top: 0px;
				}
			}
			@keyframes roll5{
				0%{
					transform: rotate(0deg);
					left: 0px;
					top: 0px;
				}
				20%{
					left: 323px;
					top: 0px;
				}
				30%{
					left: 479px;
					top: 0px;
				}
				40%{
					left: 632px;
					top: 0px;
				}
				50%{
					left: 785px;
					top: 0px;
				}
				60%{
					transform: rotate(720deg);
					left: 939px;
					top: 0px;
				}
				100%{
					transform: rotate(720deg);
					left: 939px;
					top: 0px;
				}
			}
		</style>
	</head>
	<body>
		<div class="bodyBox">
			<div id="circle1"></div>
			<div id="circle2"></div>
			<div id="circle3"></div>
			<div id="circle4"></div>
			<div id="circle5"></div>	
		</div>
	</body>
</html>
运行结果：
```


- 知识点补充：
```
（1）#box div:nth-of-type(1){...}
表示id为box下的第一个div
注：0代表第一个还是1代表第一个不一定，需要验证，此处为1
<div id=”box”>
	<div></div>
	<div></div>
	<div></div>
</div>

（2）background:url(../images/nav_bg.png) no-repeat -20px -150px；
背景：【背景图片链接】【平铺方式（无平铺）】【距左边边距（数值或left或百分比）】【距顶端边距（数值或top或百分比）】

（3）z-index：数字;
层：数字越大越靠近顶层
数字的最小为值0
```
