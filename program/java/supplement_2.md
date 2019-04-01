# 知识点补充

```
char字符ASK码的范围
（1）数字0到9： 48~57
（2）字母A到Z：65到90 a到z：97到122
（3）空格是32
```


```
乘方运算:
Math.pow(2,3);
```


```
开方:
Math.sqrt(25);
```


```
数组转字符串:
Arrays.toString(arrB));
```


```
把字符串里面的值赋值给一个字符型数组:
char[]arr=string.toCharArray();

long num = scanner.nextLong();  //获取输入

String str = Long.toString(num);  //把数字转化为String类型的

char[] ch = str.toCharArray();

int n = ch.length;
```


```
字符串包含:
str.contains("a");
```


```
1) Scanner默认使用的分隔符是空格、回车和tab

2) 可以使用useDelimiter改变分隔符:

Scanner scan = new Scanner(System.in).useDelimiter("\\s");
```


```
Scanner scan = new Scanner(System.in).useDelimiter("\\s");

int[]arrA = newint[50];
intm = 0;//数组的长度

while(scan.hasNextInt()){
	//不断给数组A赋值
	arrA[m++] =scan.nextInt();

}
```


```
题目：输入数组，最大的与第一个元素交换，最小的与最后一个元素交换，输出数组。


package mypackage;

import java.util.Arrays;
import java.util.Scanner;

public class Test {
	public static void main(String[] args){
		System.out.print("请输入一组数:");
		Scanner scan = new Scanner(System.in).useDelimiter("\\s");
		int[] arrA = new int[50];
		int m = 0;	//数组的长度
		while(scan.hasNextInt()){	//不断给数组A赋值
			arrA[m++] = scan.nextInt();
		}
		scan.close();	//关闭输入流
		
		int[] arrB = new int[m];	//创建数组B，要求刚好适应输入的数字的个数
		for(int i=0;i<m;i++){
			arrB[i] = arrA[i];	//把数组A不为零的数值赋值给数组B
		}
		
		int max = 0;
		int min = arrB[1];	//定义数组的最小值
		for(int i=0;i<arrB.length;i++){
			if(arrB[i]>max){	//求数组的最大值
				max = arrB[i];
			}
			if(arrB[i]<=min){	//求数组的最小值
				min = arrB[i];
			}
		}

		int max_i = 0;	//定义数组最大值的下标
		int min_i = 0;	//定义数组最小值的下标

		for(int i1=0;i1<arrB.length;i1++){
			if(max==arrB[i1]){
				max_i = i1;
			}
		}
			
		int temp = 0;	//定义一个交换值
		//把最大的值和第一个值交换
		temp = arrB[0];
		arrB[0] = arrB[max_i];
		arrB[max_i] = temp;
		//求数组最小值的下标
		for(int i2=0; i2<arrB.length; i2++){
			if(min==arrB[i2]){
				min_i = i2;
			}
		}
		//把最小的值和最小一个值交换
		temp = arrB[arrB.length-1];
		arrB[arrB.length-1] = arrB[min_i];
		arrB[min_i] = temp;
		System.out.println(Arrays.toString(arrB));
		scan.close();
	}
}
```


```
Scanner scanner=new Scanner(System.in);

String input=scanner.next();//获取输入的字符串

System.out.println("你输入的字符串是："+input);

System.out.println("你输入的字符串长度是："+input.length());

scanner.close();
```


```
字符串比较: 
booleanb=string1.compareTo(string2);
```


```
字符串排序:

public static void main(String[] args){

	String[] str = {"abc","cad","m","fa","f"};

	for(int i=str.length-1;i>=1;i--){
		for(int j=0;j<=i-1;j++){

			if(str[j].compareTo(str[j+1])<0){
				String temp = str [j];
				str[j] = str[j+1];

				str[j+1] = temp;

			}
		}

	}
}
```


```
题目：海滩上有一堆桃子，五只猴子来分。第一只猴子把这堆桃子凭据分为五份，多了一个，这只猴子把多的一个扔入海中，拿走了一份。第二只猴子把剩下的桃子又平均分成五份，又多了一个，它同样把多的一个扔入海中，拿走了一份，第三、第四、第五只猴子都是这样做的，问海滩上原来最少有多少个桃子？


public class Programme41 {
	public static void main(String[] args) {
			System.out.println(Peach(1));;
	}
	private static int Peach(inti) {

		if (i==5) {
	   			return 6;

		}
		returnPeach(i+1)*5+1;
	}

}

}
```


```
题目：打印出杨辉三角形（要求打印出10行如下图）

package mypackage;

import java.util.Arrays;

public class Test {
	public static void main(String[] args){
		int[][] arr = new int[10][10];
		for(int i=0;i<arr.length;i++){
			arr[i][0] = 1;	//控制第一列的数等于1
		}
		for(int i=1;i<arr.length;i++){
			for(int j=1;j<arr.length;j++){
				arr[i][j] = arr[i-1][j-1]+arr[i-1][j];	//赋值
			}
		}
		//打印结果
		for(int i=0;i<arr.length;i++){
			for(int k=arr.length-i;k>0;k--){	//空格的控制，为了好看
				System.out.print(" ");
			}
			for(int j=0;j<arr.length;j++){	//打印出数组的数字
				if(arr[i][j]!=0){	//把没赋值的零去掉
					System.out.print(arr[i][j]+" ");
				}
			}
			System.out.println();	//控制换行
		}
	}
}

输出结果:
          1 
         1 1 
        1 2 1 
       1 3 3 1 
      1 4 6 4 1 
     1 5 10 10 5 1 
    1 6 15 20 15 6 1 
   1 7 21 35 35 21 7 1 
  1 8 28 56 70 56 28 8 1 
 1 9 36 84 126 126 84 36 9 1 
```


```
题目：有n个人围成一圈，顺序排号。从第一个人开始报数（从1到3报数），凡报到3的人退出圈子，问最后留下的是原来第几号的那位。

package mypackage;

import java.util.Arrays;
import java.util.Scanner;

public class Test {
	public static void main(String[] args){
		System.out.print("请输入一个整数:");
		Scanner scan = new Scanner(System.in);
		int n = scan.nextInt();
		scan.close();
		//定义数组变量标识某人是否还在圈内
		boolean[] isIn = new boolean[n];
		for(int i=0;i<isIn.length;i++){
			isIn[i] = true;
		}
		int inCount = n;	//定义圈内人数
		int countNum = 0;	//定义报数
		int index = 0;	//定义索引
		
		while(inCount>1){	//最后一人时退出循环
			if(isIn[index]){	//判断下一个人是否在圈内
				countNum++;	//在的话报数
				if(countNum==3){	//如果这个数等于3
					isIn[index] = false;	//把他定义为出圈
					countNum = 0;	//报数清零，下一个好从1开始
					inCount--;	//圈内人数减一
				}
			}
			index++;	//下一人的位置索引值
			if(index==n){	//当索引到最后之后再从头开始
				index = 0;
			}
		}
		for(int i=0;i<n;i++){
			if(isIn[i]){	//最后只有一个符合条件的
				System.out.println("留下的是: "+(i+1));
			}
		}
	}
}
```


```
题目：有五个学生，每个学生有3门课的成绩，从键盘输入以上数据（包括学生号，姓名，三门课成绩），计算出平均成绩，将原有的数据和计算出的平均分数存放在磁盘文件"stu.txt"中。

package mypackage;

import java.io.*;

public class Test {
	//定义学生模型
	String[] number = new String[5];
	String[] name = new String[5];
	float[][] grade = new float[5][3];
	float[] sum = new float[5];
	
	public static void main(String[] args) throws Exception{
		Test stud = new Test();
		stud.input();
		stud.output();
	}
	
	//输入学号、姓名、成绩
	void input() throws IOException{
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		//录入状态标识
		boolean isRecord = true;
		while(isRecord){
			try{
				for(int i=0;i<5;i++){
					System.out.print("请输入学号:");
					number[i] = br.readLine();
					System.out.print("请输入姓名:");
					name[i] = br.readLine();
					for(int j=0;j<3;j++){
						System.out.print("请输入第"+(j+1)+"门课成绩:");
						grade[i][j] = Integer.parseInt(br.readLine());
					}
					System.out.println();
					sum[i] = grade[i][0] + grade[i][1] + grade[i][2];
				}
				isRecord = false;
			}catch(NumberFormatException e){
				System.out.println("请输入一个数字!");
			}
		}
	}
	
	//输出文件
	void output() throws IOException{
		 FileWriter fw = new FileWriter("E://java50//stud.txt");
		 BufferedWriter bw = new BufferedWriter(fw);
		 bw.write("No.  "+"Name  "+"grade1  "+"grade2  "+"grade3  "+"average");
		 bw.newLine();
		 for(int i=0;i<5;i++){
			 bw.write(number[i]);
			 bw.write(" "+name[i]);
			 for(int j=0;j<3;j++){
				 bw.write(" "+grade[i][j]);
			 }
			 bw.write(" "+(sum[i]/5));
			 bw.newLine();
		 }
		 bw.close();
	}
}
```
