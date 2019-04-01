### 继承


- 1 如何使用继承
```
1) 编写父类
class Pet{
    //公共的属性和方法
}

2) 编写子类,继承父类
class Dog extends Pet{
    //子类特有的属性和方法
}

注:
extends为继承关键字。
编写子类继承父类时，只能继承一个父类。

注:
继承是代码重用的一种方式
将子类共有的属性和行为放到父类中
```

- 2 子类访问父类成员
```
1) 访问父类构造方法(在子类构造方法中调用且必须是第一句)
super()
super(name)

2) 访问父类属性
super.name;

3) 访问父类方法
super.print();

例:
mypackage/Car.java文件
package mypackage;

public class Car {
	private int site = 4;
	
	Car(){
		System.out.println("载客量是"+site+"人");
	}
	
	public void setSite(int site){
		this.site = site;
	}
	
	void print(){
		System.out.print("载客量是"+site+"人");
	}
}

class Bus extends Car{
	Bus(int site){
		setSite(site);
	}
}

mypackage/Test.java文件
package mypackage;

import java.util.Arrays;

public class Test {
	public static void main(String[] args) {
		Bus bus = new Bus(20);
		bus.print();
	}
}
```


- 3 访问修饰符总结
```
访问修饰符	本类	同包	子类	其他
private		True
默认(friendly)	True	True
protected	True	True	True
public		True	True	True	True
```


- 4 小结
```
1) 构造方法不能被继承，因此不能重写。

2) 方法重载与方法重写
------------------------------------------------------------------------------
		位置	方法名	参数表	返回值			访问修饰符
------------------------------------------------------------------------------
方法重写	子类	相同	相同	相同或者是其子类	不能比父类更严格
------------------------------------------------------------------------------
方法重载	同类	相同	不相同	无关			无关
------------------------------------------------------------------------------
```


- 5 super关键字来访问父类的成员
```
super只能出现在子类的方法和构造方法中。
super调用构造方法时，只能是第一句。
super不能访问父类的private成员。
```

- 6 抽象
```
1）抽象类
    使用了关键词abstract声明的类叫作“抽象类”。如果一个类里包含了一个或多个抽象方法，类就必须指定成abstract（抽象）。“抽象方法”,属于一种不完整的方法，只含有一个声明，没有方法主体。

2) 抽象方法
抽象方法没有方法体。
抽象方法必须在抽象类里。
抽象方法必须在子类中被实现，除非子类是抽象类。

注:
1) 抽象方法必须在子类中被实现。
2) 一个普通类继承了抽象类后必须要将抽象类中所有的抽象方法根据自己业务的需要进行实现，说白了就是，抽象方法没有具体代码，实现的过程就是编码的过程。
3) 抽象类可以没有抽象方法，但是如果你的一个类已经声明成了抽象类，即使这个类中没有抽象方法，它也不能再实例化，即不能直接构造一个该类的对象。
4) 如果一个类中有了一个抽象方法，那么这个类必须声明为抽象类，否则编译通不过。
5) 普通类可以继承普通类，也可以继承抽象类。
   继承抽象类的时候要对抽象类里面的抽象方法进行实现。

例:
抽象方法没有方法体，只有定义。
如: public abstract void a();

当某个类继承上面的类是，必须实现那个方法a。
如:
void a(){
    //...
}
```


- 7 final用法
```
1) 类不希望再被其他类继承:
public final class Penguin extends Pet{
    //...
}

2) 方法不希望被重写:
public final void print(){
    //...
}

3) 属性值不希望被修改:
public class Penguin{
    final String home = "南极";
    public void setHome(String name){
	this.home = home;  //错误，不可再赋值
    }
}
```


- 8 总结
```
1) 继承
符号is-a关系
使用extends关键字
代码复用

2) 方法重写的规则
方法名相同
参数列表相同
返回值类型相同或者是其子类
访问权限不能严于父类

3) super关键字来访问父类的成员
super只能出现在子类的方法和构造方法中
super调用构造方法时，只能是第一句
super不能访问子类的private成员

4) 抽象类和抽象方法
抽象类不能被实例化
可以有0-多个抽象方法
非抽象类必须重写父类的所有抽象方法

注: 抽象类可以被继承但不能被实例化。

5) final修饰符
修饰的类，不能再被继承
修饰的方法，不能被子类重写
修饰的变量将变成常量，只能在初始化时进行赋值
```
