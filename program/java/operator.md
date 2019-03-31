============================================

1. 赋值运算符




============================================

2. 算术运算符

例: 从控制台输入一名学员的3门课程成绩,编写程序实现:

(1) Java课和SQL课分数之差

(2) 3门课的平均分



package mypackage;
import java.util.Scanner;	//指定Scanner类路径

public class Test {

	public static void main(String[] args) {
		Scanner input = new Scanner(System.in);
		
		System.out.println("STB的成绩是: ");
		int stb = input.nextInt();
		System.out.println("Java的成绩是: ");
		int java = input.nextInt();
		System.out.println("SQL的成绩是: ");
		int sql = input.nextInt();
		
		int diffen;	//分数差
		double avg;	//平均分
		
		System.out.println("STB"+"\t"+"Java"+"\t"+"SQL");
		System.out.println(stb+"\t"+java+"\t"+sql);
		
		diffen = java-sql;
		System.out.println("Java与SQL的成绩差: "+diffen);
		avg = (stb+java+sql)/3;
		System.out.println("3门功课的平均分是: "+avg);
	}
}

输出结果:
STB的成绩是: 
98
Java的成绩是: 
82
SQL的成绩是: 
87
STB	Java	SQL
98	82	87
Java与SQL的成绩差: -5
3门功课的平均分是: 89.0

============================================

3. 自动类型转换规则

(1) 如果一个操作数为double型，则整个表达式可提升为double型。

(2) 满足自动类型转换的条件

	两种类型要兼容: 数值类型(整型和浮点型)互相兼容
		目标类型大于源类型: 例如:double型大于int型



注:

int不可以自动转换成char

double不可以自动转换成int




============================================

4. 强制类型转换

(1) 语法

(类型名)表达式



例:

int before = 20;

double rise = 9.8;

int now = before + (int)rise;




============================================

5. 关系运算符

>
 < 
== 
!= 
>= 
<=


比较结果: boolean类型

真:true
 假:false



例:

int a1 = 4;

int a2 = 6;

boolean isBig = a1 > a2;

System.out.println(isBig);







