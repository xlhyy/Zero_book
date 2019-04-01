# 异常


- 1 Java的异常处理是通过5个关键字来实现

```
try，catch，finally，throw，throws

捕获异常: try ---> catch ---> finally
声明异常: throws
抛出异常: throw
```

```
例:
public void method(){
    try{
	//代码段1
	//产生异常的代码段2
	//代码段3
    }catch(异常类型ex){
	//对异常进行处理的代码段4
    }finally{
	//代码段5
    }
}
```


- 2

```
1) 在catch块中处理异常
加入用户自定义处理信息:
System.err.println("出现错误: 被除数和除数必须是整数，除数不能为零。");

2) 调用方法输出异常信息:
e.printStackTrace();

3) 异常对象常用的方法
---------------------------------------------------------------------------------
	方法名				说明
---------------------------------------------------------------------------------
void printStackTrace()		输出异常的堆栈信息
---------------------------------------------------------------------------------
String getMessage()		返回异常信息描述字符串，是printStackTrace()输出信息的一部分
---------------------------------------------------------------------------------
```


- 3 常见的异常类型

```
异 常 类 型			说    明
Exception 			异常层次结构的父类
ArithmeticException		算术错误情形，如以零作除数
ArrayIndexOutOfBoundsException	数组下标越界
NullPointerException		尝试访问 null 对象成员
ClassNotFoundException		不能加载所需的类
IllegalArgumentException	方法接收到非法参数
ClassCastException		对象强制类型转换出错
NumberFormatException		数字格式转换异常，如把"abc"转换成数字
```


- 4 多重catch块

```
public void method(){
    try{
	//代码段
	//产生异常(异常类型)
    }catch(异常类型1 ex){
	//对异常进行处理的代码段
    }catch(异常类型1 ex){
	//对异常进行处理的代码段
    }catch(异常类型1 ex){
	//对异常进行处理的代码段
    }
    //代码段
}

注:
1) try-catch块中存在return语句，是否还执行finally块?  答:仍然执行
```

```
例:
package mypackage;

public class Test {
	public static void main(String[] args) {
		Test t = new Test();
		System.out.println(t.Test1());
	}
	
	public boolean Test1(){
		boolean b = true;
		try{
			int i = 10/0;
			System.out.println("i = "+i);
			return true;
		}catch(Exception e){
			System.out.println("-- catch --");
			System.out.println("b: "+b);
			return b = false;
		}finally{
			System.out.println("-- finally --");
			System.out.println("b: "+b);
		}
	}
}

输出结果:
-- catch --
b: true
-- finally --
b: false
false

2)执行顺序
try-catch- finally块中，finally块唯一不执行的情况是什么? 答:
解一: try之前异常，系统报错,当然不会执行finally。
解二: try或catch块中，如果有exit()会使程序提前退出。(System.exit(0);  //终止程序)
```


- 5 异常分为Checked异常和运行时异常

```
1) Checked异常必须捕获或者声明抛出。(个人理解：所谓检查（Checked）是指编译器要检查这类异常)
2) 运行时异常不要求必须捕获或者声明抛出。
```


- 6 throw和throws关键字的区别

```
1) throws出现在方法函数头；而throw出现在函数体。
2) throws表示出现异常的一种可能性，并不一定会发生这些异常；throw则是抛出了异常，执行throw则一定抛出了某种异常对象。
```

- 7 抛出异常的三种形式: 系统自动抛出异常，throw，throws

```
1) 系统自动抛出异常
public static void main(String[] args) { 
    int a = 5, b =0; 
    System.out.println(5/b); 
    //function(); 
}

2) throw
public static void main(String[] args) { 
    String s = "abc"; 
    if(s.equals("abc")) { 
      throw new NumberFormatException(); 
    } else { 
      System.out.println(s); 
    } 
    //function(); 
}

3) throws
public class testThrows{
    public static void function() throws NumberFormatException{ 
	String s = "abc"; 
	System.out.println(Double.parseDouble(s)); 
    } 

    public static void main(String[] args){ 
	try { 
	    function(); 
	}catch(NumberFormatException e){ 
	    System.err.println("非数据类型不能强制类型转换。"); 
	    //e.printStackTrace(); 
	}
    }
}

输出结果:
非数据类型不能强制类型转换。
```
