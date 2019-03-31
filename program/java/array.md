### 数组


- 数组的使用方法:
```
(1) 声明数组	int[] a; 或 int a[];
(2) 分配空间	a = new int[5];
(3) 赋值	a[0] = 8;
(4) 处理数据	a[0] = a[0] * 10;
```

```
注释:

(1) 数组中的所有元素必须属于相同的数据类型

(2) 声明并分配空间: int[] scores = new int[2];

(3) 数组赋值的两种方式:
        
方式1：边声明边赋值:
    写法1：
	int[] score = {89, 79, 76};
    写法2：
	int[] score = new int[]{89,79,76};  //注意此种写法不能指定数组长度

方式2：动态地从键盘录入信息并赋值:

    Scanner input = new Scanner(System.in);
    for(int i=0; i<30; i++){

	score[i] = input.nextlnt();

    }
```


```
例:

package mypackage;

import java.util.Scanner;

public class Test {

	public static void main(String[] args) {
		int[] scores = new int[5];
		int sum = 0;
		
		Scanner input = new Scanner(System.in);
		System.out.println("请输入5位学员的成绩: ");
		
		for(int i=0;i<scores.length;i++){
			scores[i] = input.nextInt();
			sum = sum + scores[i];
		}
		
		System.out.println("平均分是: " + (double)sum/scores.length);
	}
}

输出结果:
请输入5位学员的成绩: 
60
70
80
60
70
平均分是: 68.0
```


- 知识点补充
1. 对数组元素进行排序
```
使用java.util.Arrays类
import java.util.*;
Arrays.sort(数组名);

例:
package mypackage;

import java.util.Arrays;

public class Test {

	public static void main(String[] args) {
		int[] scores = {94,82,76,88};

		Arrays.sort(scores);
		System.out.println("学员成绩按升序排列为: ");
		for(int i=0;i<scores.length;i++){
			System.out.print(scores[i] + " ");
		}
	}
}

输出结果:
学员成绩按升序排列为: 
76 82 88 94 
```


2. 求数组最大值
```
例:
package mypackage;

import java.util.Arrays;

public class Test {

	public static void main(String[] args) {
		int[] scores = {94,82,76,88};
		int max = 0;
		for(int i=0;i<scores.length;i++){
			if(scores[i]>max){
				max = scores[i];
			}
		}
		
		System.out.println("考试成绩最高分为: "+max);
	}
}

输出结果:
考试成绩最高分为: 94
```


3. 数组插入算法
```
例: 有一组学员的成绩为{99,85,82,63,60}，将它们按升序排列。要增加一个学员的成绩， 将它插入成绩序列， 并保持升序。

package mypackage;

import java.util.Arrays;

public class Test {

	public static void main(String[] args) {
		int[] list = new int[6];
		int index = 0;
		
		list[0] = 99;
		list[1] = 85;
		list[2] = 82;
		list[3] = 63;
		list[4] = 60;

		int num = 88;
		
		//找到新元素的插入位置
		for(int i=0;i<list.length;i++){
			if(num>list[i]){
				index = i;
				break;
			}
		}
		
		//元素后移
		for(int j=list.length-1;j>index;j--){
			list[j] = list[j-1];
		}
		
		//插入元素
		list[index] = num;
		
		//打印列表
		for(int i=0;i<list.length;i++){
			System.out.print(list[i]+" ");
		}
	}
}
```


4. 数组方法：
```
1) equals方法: 比较数组是否一样(里面的数据是否一样)

例: Arrays.equals(list,list2)

2) toString方法: 将数组转换成字符串

例: Arrays.toString(list)
结果例: [60, 70, 71, 88, 99]

3) fill方法: 将数组里面的元素都赋值为指定的值

例: Arrays.fill(list2,1);
    System.out.println(Arrays.toString(list2));
结果例: [1, 1, 1, 1, 1]

4) copyOf方法: 创建一个新的指定长度的数组,将原来的数组中的元素存进去

例：
package mypackage;
import java.util.Arrays;

public class Test {
	public static void main(String[] args) {
		int[] list = new int[5];
		int[] list2 = new int[5];
		int index = 0;
		
		list[0] = 60;
		list[1] = 70;
		list[2] = 71;
		list[3] = 88;
		list[4] = 99;
		
		//打印列表
		list2 = Arrays.copyOf(list,6);
		System.out.println(Arrays.toString(list2));
	}
}
结果例: [60, 70, 71, 88, 99, 0]

5) binarySearch方法: 查找元素在数组中的下标(注意:应用这个方法前要对数组进行升序排列)
例: Arrays.binarySearch(list,99));
```
