### 类


- 1 类
```
public class 类名{

    //定义属性部分
    属性1的类型 属性1;

    ...



    //定义方法部分

    方法1;

    ...

}
```


- 2 创建和使用对象
```
(1) 创建对象

类名 对象名 = new 类名();

例: School center = new School();



(2) 引用对象成员

center.name = "沈阳中心";  //给name属性赋值

center.showCenter();  //调用showCenter()方法
```

```
例1:

mypackage/School.java文件:
package mypackage;

public class School {
	//定义属性
	String schoolName;	//中心名称
	int classNumber;	//教室数目
	int labNumber;		//机房数目
	
	//定义方法
	public void showCenter(){
		System.out.println(schoolName+"学员\n"+"配备: "+classNumber+"教室 "+labNumber+"机房");
	}
}

mypackage/Test.java文件:
package mypackage;

import java.util.Arrays;

public class Test {

	public static void main(String[] args) {
		School center = new School();
		
		System.out.println("***初始化成员变量前***");
		center.showCenter();
		
		center.schoolName = "沈阳中心";
		center.classNumber = 10;
		center.labNumber = 10;
		System.out.println("\n***初始化成员变量后***");
		center.showCenter();
	}
}

运行结果:
***初始化成员变量前***
null学员
配备: 0教室 0机房

***初始化成员变量后***
沈阳中心学员
配备: 10教室 10机房
```

```
例2:

mypackage/AutoLion.java文件:
package mypackage;

public class AutoLion {
	String color = "黄色";
	
	public void run(){
		System.out.println("正在跑");
	}
	public String bark(){
		String sound = "大声吼叫";
		return sound;
	}
	public String getColor(){
		return color;
	}
	public String showLion(){
		return "这是一个"+getColor()+"的玩具狮子!";
	}
}

mypackage/Test.java文件
package mypackage;

import java.util.Arrays;

public class Test {

	public static void main(String[] args) {
		AutoLion lion = new AutoLion();
		
		System.out.println(lion.showLion());
		lion.run();
		System.out.println(lion.bark());
	}
}

运行结果:
这是一个黄色的玩具狮子!
正在跑
大声吼叫
```


```
注释:

1) 方法不能返回多个值(错误举例: return weight, height;)


2) 同一个类中的方法之间允许相互调用，不需要知道方法的具体实现，实现重用，提高效率
```


- 3 成员变量和局部变量的区别
```
public class AutoLion{

    变量1类型 变量1;	//成员变量



    public 返回类型 方法1(){

	变量2类型 变量2;	//局部变量

    }

}



作用域不同:
	局部变量的作用域仅限于定义它的方法

成员变量的作用域在整个类内部都是可见的


初始值不同:
 Java会给成员变量一个初始值
，Java不会给局部变量赋予初始值
```


- 4 JavaDoc注释
```
使用"/**"开始和"*/"结束，用来注释类，属性和方法等。 


例:

/**

* ScoreCalc类

* @author 李逍遥

* @version 2.0 2018/11/16

*/

public class ScoreCalc{
    /** 各科成绩 */

    int java;

    int c;

    int db;

    //...
    /**

    * 计算总成绩
	     * @return total

    */

    public int calcTotalScore(){

	int total = java + c + db;

	return total;

    }

    //...
}



注释: 分别是 类的JavaDoc注释 属性的JavaDoc注释 方法的JavaDoc注释
```


- 5 生成JavaDoc文档
```
JavaDoc能够从源代码中抽取类，属性，方法等的注释，形成一个配套的API帮助文档。


生成JavaDoc文档:
1) 使用命令行方式生成
2) 使用MyEclipse工具生成
```


- 6 使用带参数的方法
```
例:

//定义带参数的方法
public class ZhaZhiJi{

    public String zhazhi(String fruit){

	String juice = fruit + "汁";

	return juice;

    }

}



//调用带参数的方法

ZhaZhiJi myZhazhiji = new ZhaZhiJi();

String myFruit = "苹果";

String myJuice = myZhazhiji.zhazhi(myFruit);

System.out.println(myJuice);



注:

1) 实参要与形参的类型一致

2) 调用方法时不能指定实参类型(例: 对象名.addName(String "张三");)

3) 数组，对象都可以作为参数
```


```
例: 对象作为参数的方法(部分代码)

//学生类

class Student{

    public int id;

    public String name;

    public int age;
	    public int score;


    public void showInfo(){
	System.out.println("信息页");

    }

}



//对象作为参数的方法

public void addStudent(Student stu){

    for(int i=0; i<students.length; i++) {

	if(student[i]==null){

	    students[i] = stu;

	    break;
			}

    }

}



//调用方法

studentsBiz.addStudent(student1);

studentsBiz.addStudent(student2);
```


- 7 如何创建包
```
package cn.jbit.classandobject;  //声明包


public class AccpSchool{

    //...
	    public String toString(){

	//...

    }

}


注释:

package cn.jbit.classandobject;  //声明包

1) 用package声明包，以分号结尾

2) 作为Java源代码第一条语句
```


- 8 包命名规范
```
1) 包名由小写字母组成，不能以圆点开头或结尾

package mypackage;



2) 包名之前最好加上唯一的前缀，通常使用组织倒置的网络域名

package net.javagroup.mypackage;



3) 包名后续部分依不同机构内部的规范不同而不同

package net.javagroup.research.powerproject;


(research为部门名，powerproject为项目名)
```


- 9 用MyEclipse创建包的两种方法:

```
1) 分别创建包和类

2) 创建类的过程中创建类所在的包
```


- 10 如何导入包
```
1) 导入java.util包中所有类: import java.util.*;

2) 导入指定包中指定类: import cn.jbit.classandobject.AccpSchool;
```

```
例:

AccpSchool.java位于cn.jbit.classandobject包中,HelloAccp.java位于 demo 包中,下面程序空缺部分需要填入代码吗?如果需要,是什么?


-------------------------------

package cn.jbit.classandobject;	//####此为新增代码####


public class AccpSchool{
    public void ShowMessage(){

	System.out.println("这是上海Accp中心");
    }

}


-------------------------------

package demo;  //####此为新增代码####

import cn.jbit.classandproject.*;  //####此为新增代码####


public class HelloAccp{

    public static void main(String[] args){

	AccpSchool center = new AccpSchool();

	center.showMessage();

    }

}
```
