### 字符串

- 1 使用String对象存储字符串
```
例:
package mypackage;

import java.util.Arrays;

public class Test {

	public static void main(String[] args) {
		//第一种方法
		//String s = "Hello World";
		
		//第二种方法
		//String s = new String();
		//s = "Hello World 2";
		
		//第三种方法
		String s = new String("Hello World 3");
		
		System.out.println(s);
	}
}

注释: String类位于java.lang包中，具有丰富的方法。
```

- 2 String对象常用方法
```
1）s.length()

2）s.equals()
注:
equals() 用于检查组成字符串内容的字符是否完全一致。
== 用于判断两个字符串在内存中的首地址，即判断是否是同一个字符串对象。

3) s.concat(s2)

4) 常用提取方法(例: s.indexOf("l"))
--------------------------------------------------------------------------
public int indexOf(int ch)		搜索第一个出现的字符ch(或字符串value)
public int indexOf(String value)
--------------------------------------------------------------------------
public int lastIndexOf(int ch)		搜索最后一个出现的字符ch(或字符串value)
public int lastIndexOf(String value)
--------------------------------------------------------------------------
public String substring(int index)	提取从位置索引开始的字符串部分
--------------------------------------------------------------------------
public String substring(int startindex,int endindex)	提取之间的字符串部分(包含startindex，不包含endindex)
--------------------------------------------------------------------------
public String trim()			返回一个前后不含任何空格的调用字符串的副本
--------------------------------------------------------------------------

5) s.split(" ");

6) s.equalsIgnoreCase(s2)
比较的参数只能是字符串，这里只要字符串的长度相等，字母的大小写是忽略的。认为A-Z和a-z是一样的。

7) s.toLowerCase()

8) s.toUpperCase()

9) s.valueOf("aaa")
```

- 3 StringBuffer类
```
1） StringBuffer: String增强版
    对字符串频繁修改(如字符串连接)时，使用StringBuffer类可以大大提高程序执行效率。

2) StringBuffer声明
StringBuffer sb = new StringBuffer();
StringBuffer sb = new StringBuffer("aaa");

3) StringBuffer的使用
sb.toString();		//转化为String类型
sb.append("*");		//追加字符串
sb.insert(1,"*");	//插入字符串
sb.length();		//获取字符串长度
sb.indexOf(".");
sb.valueOf("aaa");
```
