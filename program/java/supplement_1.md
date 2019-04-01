# 阶段补充1

## i++与++i

```
例1:
int i = 10;
int temp = i++;
System.out.println(temp);
System.out.println(i);

输出结果:
10
11
```

```
例2:
int i = 10;
System.out.println(i++);
System.out.println(i++);

输出结果:
10
11
```

```
例3:
int i = 10;
System.out.println(i++);
System.out.println(++i);
System.out.println(++i);
System.out.println(i++);
System.out.println(i);

输出结果:
10
12
13
13
14
```


## equals()方法和==

```
1) ==
如果是基本数据类型，将判断值是否相等
例:
int a = 10;
int b = 10;
a == b 返回:true

如果是引用数据类型，将判断是否引用同一个对象
例:
String a = new String("abc");
String b = new String("abc");
a == b 返回:false
b = a;
a == b; 返回:true

2) equals()
如果要判断引用数据类型的值是否相等，只能用equals()方法
例:
String a = new String("abc");
String b = new String("abc");
a.equals(b) 返回:true
a == b 返回:false

----------------------------
补充:
String a = "abc";	//此时为基本数据类型，当有new时为引用数据类型
String b = "abc";
a.equals(b) 返回:true
a==b 返回:true
```


## 基本数据类型和引用数据类型作为参数时的区别

```
1)
基本数据类型是在内存中的一个地址存放这些变量的值。
引用数据类型是在内存中引用一个内存地址而不是具体的值。

2) 在java中，参数传递都是按值拷贝传递。
如果参数是基本数据类型，传递的是真正的数据值。
如果参数是引用数据类型，传递的是地址。

3)
---------------------
基本数据类型作为参数，在方法内部改变参数的值，不会影响到外部。
public class Test{
    public void say(int num){
	num = 20;
	System.out.println(num);
    }

    public static void main(String[] args){
	Test test = new Test();
	int num = 10;
	test.say(num);
	System.out.println(num);
    }
}

输出结果:
20
10

---------------------
引用数据类型作为参数，在方法内部改变参数的状态，会影响到外部。
例: 当类对象作为参数传递时，在方法内部改变类对象属性值，会影响到外部。
public class Test{
    public void say(StringBuffer strb){
	strb.append("bbb");
	System.out.println(strb.toString());
    }

    public static void main(String[] args){
	Test test = new Test();
	StringBuffer strb = new StringBuffer("aaa");
	test.say(strb);
	System.out.println(strb.toString());
    }
}

输出结果:
aaabbb
aaabbb

---------------------
引用数据类型作为参数，在方法内部改变了引用对象，不会影响到外部。
例:
public class Test{
    public void say(StringBuffer strb){
	strb = new StringBuffer("bbb");
	strb.append("ccc");
	System.out.println(strb.toString());
    }
}

public static void main(String[] args){
    Test test = new Test();
    StringBuffer strb = new StringBuffer("aaa");
    test.say(strb);
    System.out.println(strb.toString());
}

输出结果:
bbbccc
aaa
```
