============================================
1. Java API (Java应用程序编程接口)
常用Java API:
java.lang
java.util
java.io
java.sql
...


﻿============================================
2. 包装类
1) 包装类把基本类型数据转换为对象。
2) 每个基本类型在java.lang包中都有一个相应的包装类。
3) 包装类有何作用:
    提供了一系列实用的方法。
    集合不允许存放基本数据类型数据，存放数字时，要用包装类。

Object{
	Boolean
	Character
	Number{
		Byte
		Short
		Integer
		Long
		Float
		Double
	}
}


﻿============================================
3. 包装类的构造方法
1) 所有包装类都可将与之对应的基本数据类型作为参数，来构造它们的实例。
public Type (type value)
例: Integer i = new Integer(1);

2) 除Character类外，其他包装类可将一个字符串作为参数构造它们的实例。
public Type (String value)
例: Integer i = new Integer("123");

注:
    Boolean类构造方法参数为String类型时，若该字符串内容为true(不考虑大小写)，则该Boolean对象表示true，否则表示false。
    当包装类构造方法参数为String类型时，字符串不能为null，且该字符串必须可解析为相应的基本数据类型的数据，否则编译通过，运行时NumberFormatException异常。


﻿============================================
4. 包装类的常用方法
1) 所有包装类都有如下方法:
public static Type valueOf(type value)
如: Integer intValue = Integer.valueOf(21);

2) 除Character类外，其他包装类都有如下方法:
public static Type valueOf(String s)
如: Integer intValue = Integer.valueOf("21");

3)
{Byte, Short, Integer, Long, Float, Double} 这些包装类的常用方法有:
byteValue(), intValue(), longValue(), shortValue(), doubleValue(), floatValue()

4) XXXValue(): 包装类转换成基本类型。
例:
Integer integerId = new Integer(25);
int intId = integerId.intValue();

5) toString(): 以字符串形式返回包装对象表示的基本数据类型。
例:
String sex = Character.toString('男');
String id = Integer.toString(25);

String sex = '男' + "";
String id = 25 + "";

6) parseXXX(): 把字符串转换为相应的基本数据类型数据(Character除外)
例:
int num = Integer.parseInt("36");
boolean bool = Boolean.parseBoolean("false");


﻿============================================
5. 装箱和拆箱
1) 装箱: 基本类型转换为包装类的对象。
2) 拆箱: 包装类对象转换为基本类型的值。
例:
Integer intObject = 5;
int intValue = intObject;


﻿============================================
6. 包装类的特点
1) 所有包装类都是final类型，不能创建它们的子类。
2) JDK1.5后，允许基本数据类型和包装类型进行混合数学运算。
3) 包装类并不是用来取代基本数据类型的:
    在基本数据类型需要用对象表示时使用。


﻿============================================
7. Math类
java.lang.Math类提供了常用的数学运算方法和两个静态常量E(自然对数的底数)和PI(圆周率)。
例:
Math.abs(-3.5);  //返回3.5
Math.max(2.5, 90.5);  //返回90.5
int random = (int)(Math.random()*10);  //生成一个0-9之间的随机数


﻿============================================
8. Random类
生成随机数的其他方式: java.util.Random类
例:
Random rand = new Random();  //创建一个Random对象
for(int i=0;i<20;i++){  //随机生成20个随机整数，并显示
	int num = rand.nextInt(10);  //返回下一个伪随机数，整型的
	System.out.println("第"+(i+1)+"个随机数是: "+num);
}


﻿============================================
9. 操作日期时间
1) 如何获取当前日期？
java.util.Date类: 表示日期和时间

2) 提供操作日期和时间各组成部分的方法:
Java.util.Date
java.text.SimpleDateFormat类
用于定制日期时间的格式

例:
//创建日期对象
Date date = new Date();
//定制日期格式
SimpleDateFormat formater = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String now = formater.format(date);
System.out.println(now);

3) Calendar类
抽象类，java.util.Calendar
用于设置和获取时间/时间数据的待定部分。
Calendar类提供一些方法和静态字段来操作日历。

-------------------------------------------
方法或属性		说明
-------------------------------------------
int get(int field)	返回给定日历字段的值
-------------------------------------------
YEAR			指示年
-------------------------------------------
MONTH			指示月
-------------------------------------------
DAY_OF_MONTH		指示一个月中的某天
-------------------------------------------
DAY_OF_WEEK		指示一个星期中的某天
-------------------------------------------

注: Calendar.DAY_OF_WEEK中Sunday是1。

例:
Calendar t = Calendar.getInstance();
System.out.println("今天是"+t.get(Calendar.YEAR)+"年"+t.get(Calendar.MONTH)+"月"+t.get(Calendar.DAY_OF_MONTH)+"日");
System.out.println("今天是星期"+(t.get(Calendar.DAY_OF_WEEK)-1));


