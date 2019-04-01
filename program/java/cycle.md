# 循环结构


- 1 while循环

```
while(循环条件){

    循环操作

}

例:
package mypackage;

public class Test {

	public static void main(String[] args) {
		int i = 1;
		while(i <= 4){
			int a = 123;
			System.out.println(a);
			i++;
		}
	}
}
```


- 2 do-while循环

```
do{

    循环操作

}while(循环条件);
```


- 3 for循环


```
for(参数初始化; 条件判断; 更新循环变量){

    循环操作

}
```


- 4 循环嵌套

```
例:
package mypackage;

public class Test {

	public static void main(String[] args) {
		for(int i=0;i<5;i++){
			for(int j=4;j>i;j--){
				System.out.print(" ");
			}
			for(int j=0;j<=i*2;j++){
				System.out.print("*");
			}
			System.out.println("");
		}
	}
}
```


- 知识点补充

```
1. 比较两个String类型的值是否相等:
"字符串1".equals("字符串2")

2. 使用break;语句跳出循环


3. 使用continue;跳过循环体中剩余的语句而执行下一次循环
```
