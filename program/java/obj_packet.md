# 封装


- 1 什么是封装

```
封装，就是隐藏实现细节。
```

```
1) 将属性私有化，提供公有方法访问私有属性。
public class OracleStaff2{
    private String name;

    public String getName(){
	return name;
    }
    public void setName(String name){
	this.name = name;
    }
}

2) 通过这些公有方法访问私有属性
OracleStaff2 staff = new OracleStaff2();
staff.setName("小明");
String tName = staff.getName();
```


- 2 访问修饰符

```
名称			说明				备注

public			可以被任何类访问

protected		可以被同一包中的所有类访问	子类没有在同一包中也可以访问
			可以被所有子类访问

private			只能够被当前类的方法访问

缺省(无访问修饰符)	可以被同一包中的所有类访问	如果子类没有在同一个包中，也不能访问
```


- 3 构造方法

```
1) 什么是构造方法?
构造方法负责对象成员的初始化工作，为实例变量赋予合适的初始值。

2) 构造方法必须满足以下语法规则:
方法名与类名相同
没有返回类型

3) 使用new关键字调用构造方法:
public class Test{
    public static void main(String[] args){
	Test test = new Test();
    }
}

4) 带参数的构造方法:
public class OracleStaff6{
    private String name;
    private int age;
    private String education;
    private String position;

    //带参数的构造方法
    public OracleStaff6(String pName,int pAge,String pEducation,String pPosition){
	name = pName;
	age = pAge;
	education = pPosition;
	position = pPosition;
    }

    public String introduction(){
	return "大家好! 我是"+name+",我今年"+age+"岁,学历"+education+",目前职位是"+position;
    }
}

public class OracleStaff6Test{
    public static void main(String[] args){
	OracleStaff6 staff = new OracleStaff6("小明",23,"本科","咨询师");
	System.out.println(staff.introduction());
    }
}
```


- 4 方法重载

```
例: 构造方法重载
public class OracleStaff7{
    private String name;
    private String school = "北京中心";

    //构造方法1
    public OracleStaff7(String name){
	this.name = name;
    }
    //构造方法2
    public OracleStaff7(String name,String school){
	this.name = name;
	this.school = school;
    }

    public String introduction(){
	return "大家好! 我是"+school+"的"+name;
    }
}

public class OracleStaff7Test{
    public static void main(String[] args){
	OracleStaff7 staff1 = new OracleStaff7("小明");
	System.out.println(staff1.introduction());

	OracleStaff7 staff2 = new OracleStaff7("张欣","天津中心");
	System.out.println(staff2.introduction());
    }
}
```
