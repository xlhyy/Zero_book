### 选择


- if
```
(1)------------

if(条件) {

    //代码块

}



注: 只有一条语句时,建议不省略{}



(2)------------

&& || !



(3)------------

if(条件){

    //代码块1

}else{

    //代码块2

}



(4)------------

多重if选择结构
:

if(条件){

    //代码块1

}else if(条件){

    //代码块2

}else{

    //代码块3

}



(5)------------

if嵌套
```


- switch
```
switch(表达式){

    case 常量1:

	语句;
	break;



    case 常量2:

	语句;

	break;


    ...



    default:
		语句;

	break;

}
```


```
例:
package mypackage;
import java.util.Scanner;

public class Test {

	public static void main(String[] args) {
		Scanner input = new Scanner(System.in);
		if(input.hasNextInt()){
			int mingCi = input.nextInt();
			
			switch(mingCi){
			case 1:
				System.out.println("参加麻省理工大学组织的夏令营");
				break;
			case 2:
				System.out.println("奖励惠普笔记本一部");
				break;
			case 3:
				System.out.println("奖励移动硬盘一个");
				break;
			default:
				System.out.println("没有任何奖励");
			}
		}else{
			System.out.println("请输入正确的数字");
		}
	}
}

运行结果:
3
奖励移动硬盘一个
```


- 知识点补充:
```
1. 产生随机数(0~9)的方法:
package mypackage;

public class Test {

	public static void main(String[] args) {
		int randomNum = (int)(Math.random()*10);
		System.out.println(randomNum);
	}
}

输出结果:
6


2. 通过键盘获取输入:
Scanner input = new Scanner(System.in);



3. 通过hasNextlnt()判断输入的是否是数字:

Scanner input = new Scanner(System.in);

if(input.hasNextlnt()){
    ...

}
else{

    System.out.println("请输入正确的数字");

}
```
