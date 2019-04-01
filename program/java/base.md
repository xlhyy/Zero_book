### 基础

- 1
```
package mypackage;

public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.print("hello world!");
	}

}



注释方法:		/**/	//

输出信息到控制台:	System.out.println()
```


- 2
```
数据类型	大小位	取值范围	说明

byte	字节型	8	-128~127	数据存储在内存中的最原始形态

short	短整形	16	-32768~32767

int	整型	32	-2^31~2^31-1

long	长整型	64	-2^63~2^63-1

float	浮点型	32	略

double	双精度	64	略

char	字符型	16	'\u0000'~'\uFFFF'	用于存储字符,以Unicode编码方式

boolean	布尔型	1	true/false	用于存储真值/假值


(重要: int double char String)
```


- 3 变量声明及使用
```
package mypackage;

public class Test {

	public static void main(String[] args) {
		// 第一种方法
		//int money;	//声明变量(根据数据类型在内存申请空间)
		//money = 1000;	//赋值(将数据存储在对应的内存空间)
		
		//第二种方法
		int money = 1000;
		
		System.out.println(money);
	}
}



注: 变量必须声明并且赋值后才可使用。

错误例:

package mypackage;

public class Test {

	public static void main(String[] args) {
		String title;
		System.out.println(title);
	}
}
package mypackage;

public class Test {

	public static void main(String[] args) {
		String title;
		System.out.println(title);
	}
}
```


- 4 数据类型举例
```
package mypackage;

public class Test {

	public static void main(String[] args) {
		double score = 98.5;
		String name = "李逍遥";
		char sex = '男';	//注意此处的引号必须为单引号
		
		System.out.println("成绩: "+score);
		System.out.println("姓名: "+name);
		System.out.println("性别: "+sex);
	}
}



输出结果:
成绩: 98.5
姓名: 李逍遥
性别: 男
```


- 5 变量命名规则
```
变量名 = 首字母(1.字母 2.下划线 3.'$'符号) + 其余部分
(任意多的：1.数字 2.字母 3.下划线 4.'$'符号)
			

变量命名规范:

    简短且能清楚地表明变量的作用,通常第一个单词的首字母小写,其后单词的首字母大写。例:myScore
```
