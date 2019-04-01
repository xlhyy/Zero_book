# 多态


- 1 什么是多态

```
简单来说，多态具有表现多种形态的能力的特征。
同一个实现接口，使用不同的实例而执行不同的操作。

例:
public class HQ1{
    public void judge(OracleJavaStaff2 t){
	t.introduction();
	t.giveLesson();
    }
    public void judge(OracleDotNetStaff2 t){
	t.introduction();
	t.giveLesson();
    }

    public static void main(String[] args){
	HQ1 hq = new HQ1();
	hq.judge(new OracleJavaStaff2("李逍遥","北京中心"));
	hq.judge(new OracleDotNetStaff2("赵灵儿","天津中心"));
    }
}
```


- 2 实现多态的步骤

```
1) 子类重写父类的方法。
2) 编写方法时，使用父类定义的方法。
3) 运行时，根据实际创建的对象类型动态决定使用哪个方法。
```

```
例1:
public class OracleStaff{
    public void giveLesson(){
	System.out.println("开始编码");
    }
}

1) ----------
public class OracleDBStaff extends OracleStaff{
    public void giveLesson(){
	System.void giveLesson("启动Oracle");
	super.giveLesson();
    }
}

2) ----------
public class HQ3{
    public void judge(OracleStaff t){
	t.giveLesson();
    }
}

3) ----------
public class Test{
    public static void main(String[] args){
	HQ3 hq = new HQ3();
	hq.judge(new OracleDBStaff());
    }
}
```

```
例2:
class Base{
    public String name;
    public Base(){
	name = "Base";
    }
    public Base(String pName){
	name = pName;
    }
    public void method(){
	System.out.println(name);
    }
}

class Child extends Base{
    public Child(){
	super("Child1");
	name = "Child2";
    }
}

public class Sample{
    public static void main(String[] args){
	Child c = new Child();
	c.method();
    }
}
```

```
例3:
public class OracleStaff{
    public void giveLesson(){
	System.out.println("开始编码");
    }
}

public class OracleDBStaff extends OracleStaff{
    public void giveLesson(){
	System.out.println("启动SqlServer");
    }
}

public class Test{
    public static void main(String[] args){
	OracleStaff t = new OracleDBStaff();
	t.giveLesson();
    }
}
```


- 3 父类到子类的转换

```
向下转型(强制类型转换):
Pet pet = new Dog("雪纳瑞");
Dog dog = (Dog)pet;
```


- 4 instanceof运算符

```
1) 语法: 对象 instanceof 类或接口。
2) 经验: instanceof通常和强制类型转换结合使用。
```

```
例:
---------------------
mypackage/Pet.java文件
package mypackage;

public class Pet {
	Pet(){
		System.out.println("这是父类Pet");
	}
}

---------------------
mypackage/Dog.java文件
package mypackage;

public class Dog extends Pet{
	Dog(){
		System.out.println("这是子类Dog");
	}
	public void catchingFlyDisc(){
		System.out.println("这是子类Dog的catchingFlyDisc方法");
	}
}

---------------------
mypackage/Penguin.java文件
package mypackage;

public class Penguin extends Pet{
	Penguin(){
		System.out.println("这是子类Penguin");
	}
	public void swimming(){
	    System.out.println("这是子类Penguin的swimming方法");	
	}
}

---------------------
mypackage/Master.java文件
package mypackage;

public class Master {
	public void play(Pet pet){
		if(pet instanceof Dog){
			Dog dog = (Dog)pet;
			dog.catchingFlyDisc();
		}else if(pet instanceof Penguin){
			Penguin pgn = (Penguin)pet;
			pgn.swimming();
		}
	}
}

---------------------
mypackage/Test.java文件
package mypackage;

import java.util.Arrays;

public class Test {
	public static void main(String[] args) {
		Dog dog = new Dog();
		Penguin penguin = new Penguin();
		Master master = new Master();
		master.play(dog);
		master.play(penguin);
	}
}
```
