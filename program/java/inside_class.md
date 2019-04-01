### 内部类


- 1 内部类
```
1) 内部类是Java独有的一种语法结构，即在一个类的内部定义另一个类，如:
public class ExteriorClass{
	private class InteriorClass{
	}
}

2) 此时，内部类InteriorClass就成为外部类ExteriorClass中的成员，访问权限遵循类成员的访问权限机制，可以是 public, protected, 缺省和private。

3) 内部类可以很方便地访问外部类中的其他成员。

4) 内部类主要为了解决类成员间相互访问的问题，类似于C++中友元类的做法。
```


- 2 关于内部类的更多知识
```
内部类实际上是外部类的成员，如果在外部类以外需要实例化内部类对象的话，则必须通过外部类的实例才可以。
class Outer{  //外部类
	public class Inner{  //内部类
	}
}

public class InnerClassDemo{
	public static void main(String[] args){
		Outer a = new Outer();  //实例化外部类的对象
		Outer.Inner b = a.new Inner();  //通过外部类的实例创建其内部类对象
	}
}

注: 内部类可以直接访问外部类的成员，但外部类不可以直接访问内部类的成员。
```
