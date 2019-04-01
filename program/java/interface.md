### 接口


- 1 什么是接口？
```
public interface MyInterface{
    public void foo();
    //其他方法
}

注: 接口中的所有方法都是public abstract
```


- 2 接口特性
```
1) 接口不可以被实例化
2) 实现类必须实现接口的所有方法
3) 实现类可以实现多个接口
4) 接口中的变量都是静态常量
```


- 3 接口编码流程:
```
1) 编写接口
public interface UsbInterface{
    /**
     *USB接口提供服务
     */
    void service();
}

2) 实现接口
public class UDisk implements UsbInterface{
    public void service(){
	System.out.println("连接USB口，开始传输数据。");
    }
}

3) 使用接口
UsbInterface uDisk = new UDisk();
uDisk.service();
```

```
注:
1) public class UDisk implements UsbInterface{ ... }
implements 为实现接口使用的关键字。
UsbInterface 处若要实现多个接口，要使用","分隔。

2）UsbInterface uDisk = new UDisk();
此处为用接口实现多态。

3) 接口可以被多继承。
```

- 4 知识点补充
```
1) is-a

is-a代表类之间或类与接口之间的继承关系。 
比如，猫和狗，都是动物，都继承了动物的特性，在面向对象语言中，将猫狗定义为两种不同的类，都继承了动物类。



2) has-a

has-a代表对象和它的成员的从属关系。同一个类的对象，通过它们属性的不同值来区别。比如张三和李四都是人，他们都是“人”这一个类，但具有不同的姓名属性，姓名和人是属于has-a关系，是一个整体和部分之间的关系。
```

- 5 面向接口编程
```
程序设计时:
1) 关心实现类有何能力，而不关心实现细节。
2) 面向接口的约定而不考虑接口的具体实现。
```

```
例:
实现防盗门功能:
防盗门是一个门  --->  is-a的关系
防盗门有一个锁  --->  has-a的关系
上锁/开锁  	--->  能力
```

```
例:
---------------------(这是Java接口，相当于主板上的PCI插槽的规范)
public interface PCI{
    void start();
    void stop();
}

---------------------(声卡，网卡都实现了PCI插槽的规范，但行为完全不同)
class SoundCard implements PCI{
    public void start(){
	System.out.println("Du du...");
    }
    public void stop(){
	System.out.println("Sound stop!");
    }
}

class NetworkCard implements PCI{
    public void start(){
	System.out.println("Send...");
    }
    public void stop(){
	System.out.println("Network stop!");
    }
}

---------------------(通过这个方法，主板上可以插入任意符合PCI插槽规范的卡)
public class MainBoard{
    public void usePCICard(PCI p){
	p.start();
	p.stop();
    }
}

---------------------(可以通过更换实现接口的类来更换系统的实现)
public class Assembler{
    public static void main(String[] args){
	MainBoard mb = new MainBoard();

	//在主板上插入网卡
	NetworkCard nc = new NetworkCard();
	mb.usePCICard(nc);

	//在主板上插入声卡
	SoundCard sc = new SoundCard();
	mb.usePCICard(sc);
    }
}
```


- 6 static关键字(可否通过类名直接访问成员变量)
```
1) 使用static定义变量:
class Penguin{
    static final String SEX_MALE = "Q仔";
    static final String SEX_FEMALE = "Q妹";
}

2) 使用static定义方法:
static void print(){}

3) 使用类名直接访问成员变量
Penguin pgn1 = new Penguin();
pgn1.sex = Pengiun.SEX_MALE;
Penguin.print();

注:
用final修饰的变量称为常量，其值固定不变。
static final 为静态常量。
***在方法里不可以定义static变量。
```

- 7 static修饰与非static修饰的区别
```
		static,非private修饰	非static,private修饰
------------------------------------------------------------
属性		类属性，类变量		实例属性，实例变量
------------------------------------------------------------
方法		类方法			实例方法
------------------------------------------------------------
调用方式	类名.属性		对象.属性
		类名.方法()		对象.方法()
		对象.属性
		对象.方法()
------------------------------------------------------------
归属		类			单个对象
------------------------------------------------------------
```

```
例:
public class OrcaleStudent{
    public static final int FEMALE = 1;  //代表女性
    public static final int MALE = 2;  //代表男性
    private int sex;

    public void setSex(int sex){
	if(sex == FEMALE){
	    System.out.println("这是一名女学生");
	}else if(sex == MALE){
	    System.out.println("这是一名男学生");
	}
	this.sex = sex;
    }
}
```


- 8 总结
```
1) Java中的接口
属性全都是全局静态变量。
方法都是全局抽象方法。
无构造方法。

2) 一个类可以实现多个接口，非抽象类实现接口时必须实现接口中的全部方法。

3) 抽象类利于代码复用，接口利于代码维护。
```


- 9 思想总结
```
OO基本特征	定义			具体实现方式		优势
------------------------------------------------------------------------------------
封装		隐藏实现细节，对外提供	属性私有化，添加公有的	增强代码的可维护性
		公共的访问接口		setter，getter方法
------------------------------------------------------------------------------------
继承		从一个已有的类派生出新	继承需要符合的关系:is-a	1.实现抽象
		的类，子类具有父类的一				2.增强代码的可复用性
		般特性，以及自身特殊的
		特性
------------------------------------------------------------------------------------
多态		同一个实现接口，使用不	通过Java接口/继承来定义	增强代码的可扩展性、可维护性
		同的实例而执行不同操作	统一的实现接口；通过方
					法重写为不同的实现类/子
					类定义不同的操作
------------------------------------------------------------------------------------
```
