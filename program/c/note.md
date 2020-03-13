# C语言基础

## 常用基本数据类型及占用空间(可用sizeof()测量)

```
以64位机器为例:

char: 1字节
int: 4字节
float: 4字节
double: 8字节
void: 表示类型的缺失
```

```
1个字节为8位
```

## 类型书写

### 整数

```
默认为10进制,         10  20
以0开头为8进制,       045 021
以0b开头为2进制，     0b11101101
以0x开头为16进制,     0x21458adf
```

### 小数

```
单精度常量: 2.3f         float
双精度常量: 2.3          double
```

### 字符型常量

```
用英文单引号括起来，只保存一个字符'a','b','*', 还有转义字符'\n','\t'。
```

### 字符串常量

```
用英文双引号括起来，可以保存多个字符: "abc"。
```

## 数据类型转换

```
C 语言中如果一个表达式中含有不同类型的常量和变量，在计算时，会将它们自动转换为同一种类型；在 C 语言中也可以对数据类型进行强制转换；
```

### 自动转换规则

```
a) 浮点数赋值给整型，该浮点数小数被舍去。
b) 整数赋值给浮点型，数值不变，但是被存储到相应的浮点型变量中。
```

### 强制类型转换规则 (类型说明符)(表达式)

```
例:
# include <stdio.h>

int main(void)
{
    float f,x=3.6,y=5.2;
    int i=4,a,b;
    a=x+y;
    b=(int)(x+y);
    f=10/i;
    printf("a=%d,b=%d,f=%f,x=%f\n",a,b,f,x);
}

运行结果:
a=8,b=8,f=2.000000,x=3.600000
```

## 变量

### 变量的声明

```
变量的声明有两种情况:
1. 一种是需要建立存储空间的。 例如: int a在声明的时候就已经建立了存储空间。
2. 另一种是不需要建立存储空间的，通过使用extern关键字声明变量名而不定义它。 例如: extern int a 其中变量 a 可以在别的文件中定义的。
```

```
除非有extern关键字，否则都是变量的定义。

extern int i;   //声明，不是定义
int i;          //声明，也是定义
```

```
例1: 同一个文件中的变量
kaiqigu@bogon:~/dododo/cfile|⇒  cat test_1.c 
#include <stdio.h>

//函数外定义变量x和y
int x;
int y;

int addtwonum()
{
	//函数内声明变量x和y和外部变量
	extern int x;
	extern int y;
	//给外部变量(全局变量)x和y赋值
	x = 1;
	y = 2;
	return x+y;
}

int main()
{
	int result;
	//调用函数addtwonum
	result = addtwonum();

	printf("result为: %d\n", result);
	return 0;
}


结果:
kaiqigu@bogon:~/dododo/cfile|⇒  gcc -o test_1 test_1.c
kaiqigu@bogon:~/dododo/cfile|⇒  ./test_1                
result为: 3

```


```
例2: 不同文件

kaiqigu@bogon:~/dododo/cfile|⇒  cat addtwonum.c 
#include <stdio.h>

/*外部变量声明*/
extern int x;
extern int y;

int addtwonum()
{
	return x+y;
}

kaiqigu@bogon:~/dododo/cfile|⇒  cat test.c 
#include <stdio.h>

/*定义两个全局变量*/
int x=1;
int y=2;

/*函数声明*/
int addtwonum();

int main(void)
{
	int result;
	result = addtwonum();
	printf("result为: %d\n", result);
	return 0;
}


运行结果:
kaiqigu@bogon:~/dododo/cfile|⇒  gcc addtwonum.c test.c -o main
kaiqigu@bogon:~/dododo/cfile|⇒  ./main 
result为: 3

```

### C中的左值和右值

```
C 中有两种类型的表达式：
左值（lvalue）：指向内存位置的表达式被称为左值（lvalue）表达式。左值可以出现在赋值号的左边或右边。
右值（rvalue）：术语右值（rvalue）指的是存储在内存中某些地址的数值。右值是不能对其进行赋值的表达式，也就是说，右值可以出现在赋值号的右边，但不能出现在赋值号的左边。

变量是左值，因此可以出现在赋值号的左边。数值型的字面值是右值，因此不能被赋值，不能出现在赋值号的左边。下面是一个有效的语句：
int g = 20;
但是下面这个就不是一个有效的语句，会生成编译时错误：
10 = 20;
```

## 常量

### 整数常量

```
1) 整数常量可以是十进制、八进制或十六进制的常量。前缀指定基数：0x 或 0X 表示十六进制，0 表示八进制，不带前缀则默认表示十进制。
2) 整数常量也可以带一个后缀，后缀是 U 和 L 的组合，U 表示无符号整数（unsigned），L 表示长整数（long）。后缀可以是大写，也可以是小写，同时出现时U和L的顺序任意。
```

### 浮点常量

```
浮点常量由整数部分、小数点、小数部分和指数部分组成。您可以使用小数形式或者指数形式来表示浮点常量。

当使用小数形式表示时，必须包含整数部分、小数部分，或同时包含两者。
当使用指数形式表示时， 必须包含小数点、指数，或同时包含两者。带符号的指数是用 e 或 E 引入的。
```

```
下面列举几个浮点常量的实例：
3.14159       /* 合法的 */
314159E-5L    /* 合法的 */
510E          /* 非法的：不完整的指数 */
210f          /* 非法的：没有小数或指数 */
.e55          /* 非法的：缺少整数或分数 */
```

### 字符常量

```
字符常量是括在单引号中，例如，'x' 可以存储在 char 类型的简单变量中。

字符常量可以是一个普通的字符（例如 'x'）、一个转义序列（例如 '\t'），或一个通用的字符（例如 '\u02C0'）。
在 C 中，有一些特定的字符，当它们前面有反斜杠时，它们就具有特殊的含义，被用来表示如换行符（\n）或制表符（\t）等。
```

### 定义常量

```
在 C 中，有两种简单的定义常量的方式：
1. 使用 #define 预处理器。
2. 使用 const 关键字。
```

#### define 预处理器 (#define identifier value)

```
#include <stdio.h>
 
#define LENGTH 10   
#define WIDTH  5
#define NEWLINE '\n'
 
int main()
{
 
   int area;  
  
   area = LENGTH * WIDTH;
   printf("value of area : %d", area);
   printf("%c", NEWLINE);
 
   return 0;
}


结果:
value of area : 50
```

#### const 关键字 (const type variable = value;)

```
#define 是宏定义，它不能定义常量，但宏定义可以实现在字面意义上和其它定义常量相同的功能，本质的区别就在于 #define 不为宏名分配内存，
而 const 也不为常量分配内存，怎么回事呢，其实 const 并不是去定义一个常量，而是去改变一个变量的存储类，把该变量所占的内存变为只读！
```

```
#include <stdio.h>
 
int main()
{
   const int  LENGTH = 10;
   const int  WIDTH  = 5;
   const char NEWLINE = '\n';
   int area;  
   
   area = LENGTH * WIDTH;
   printf("value of area : %d", area);
   printf("%c", NEWLINE);
 
   return 0;
}


结果:
value of area : 50
```

## C存储类

```
auto 是局部变量的默认存储类, 限定变量只能在函数内部使用；
register 代表了寄存器变量，不在内存中使用；(用于定义存储在寄存器中而不是 RAM 中的局部变量。这意味着变量的最大尺寸等于寄存器的大小（通常是一个词），且不能对它应用一元的 '&' 运算符（因为它没有内存位置）。)
static是全局变量的默认存储类,表示变量在程序生命周期内可见；
extern 表示全局变量，即对程序内所有文件可见，类似于Java中的public关键字；
```

## C运算符

```
算术运算符
关系运算符
逻辑运算符
位运算符
赋值运算符
杂项运算符
```

### 算术运算符

```
+
-
*
/
%
++
--
```

### 关系运算符

```
==  !=  >   <   >=  <=
```

### 逻辑运算符

```
&&
||
!
```

### 位运算符

```
1) &	
按位与操作，按二进制位进行"与"运算。运算规则：
0&0=0;   
0&1=0;    
1&0=0;     
1&1=1;	(A & B) 将得到 12，即为 0000 1100

2) |	
按位或运算符，按二进制位进行"或"运算。运算规则：
0|0=0;   
0|1=1;   
1|0=1;    
1|1=1;
(A | B) 将得到 61，即为 0011 1101

3) ^	
异或运算符，按二进制位进行"异或"运算。运算规则：
0^0=0;   
0^1=1;   
1^0=1;  
1^1=0;
(A ^ B) 将得到 49，即为 0011 0001

4) ~	
取反运算符，按二进制位进行"取反"运算。运算规则：
~1=0;   
~0=1;	(~A ) 将得到 -61，即为 1100 0011，一个有符号二进制数的补码形式。

5) <<	
二进制左移运算符。将一个运算对象的各二进制位全部左移若干位（左边的二进制位丢弃，右边补0）。	A << 2 将得到 240，即为 1111 0000

6) >>	
二进制右移运算符。将一个数的各二进制位全部右移若干位，正数左补0，负数左补1，右边丢弃。
```

### 赋值运算符

```
=   +=  -=  /=  %=  <<=  >>=    &=  ^=  |=
```

### 杂项运算符

```
sizeof()	返回变量的大小	sizeof(a) 将返回 4，其中 a 是整数
&	        返回变量的地址	&a; 将给出变量的实际地址
*	        指向一个变量  	*a; 将指向一个变量
? :	        条件表达式	    如果条件为真 ? 则值为 X : 否则值为 Y
```

## C中运算符优先级

```
后缀 	    () [] -> . ++ - -  	                从左到右 
一元 	    + - ! ~ ++ - - (type)* & sizeof 	从右到左 
乘除 	    * / % 	                            从左到右 
加减 	    + - 	                            从左到右 
移位 	    << >> 	                            从左到右 
关系 	    < <= > >= 	                        从左到右 
相等 	    == != 	                            从左到右 
位与 AND 	& 	                                从左到右 
位异或 XOR 	^ 	                                从左到右 
位或 OR 	    | 	                                从左到右 
逻辑与 AND 	&& 	                                从左到右 
逻辑或 OR 	|| 	                                从左到右 
条件 	    ?: 	                                从右到左 
赋值 	    = += -= *= /= %=>>= <<= &= ^= |= 	从右到左 
逗号 	    , 	                                从左到右 
```

## 判断

```
if 语句	            一个 if 语句 由一个布尔表达式后跟一个或多个语句组成。
if...else 语句	    一个 if 语句 后可跟一个可选的 else 语句，else 语句在布尔表达式为假时执行。
嵌套 if 语句	        您可以在一个 if 或 else if 语句内使用另一个 if 或 else if 语句。
switch 语句	        一个 switch 语句允许测试一个变量等于多个值时的情况。
嵌套 switch 语句	    您可以在一个 switch 语句内使用另一个 switch 语句。
```

## 循环

### 循环类型

```
while 循环	        当给定条件为真时，重复语句或语句组。它会在执行循环主体之前测试条件。
for 循环	            多次执行一个语句序列，简化管理循环变量的代码。
do...while 循环	    除了它是在循环主体结尾测试条件外，其他与 while 语句类似。
嵌套循环	            您可以在 while、for 或 do..while 循环内使用一个或多个循环。
```

### 循环控制语句

```
break 语句	    终止循环或 switch 语句，程序流将继续执行紧接着循环或 switch 的下一条语句。
continue 语句	告诉一个循环体立刻停止本次循环迭代，重新开始下次循环迭代。
goto 语句	    将控制转移到被标记的语句。但是不建议在程序中使用 goto 语句。
```

## 数组

## 枚举

```
第一个枚举成员的默认值为整型的 0，后续枚举成员的值在前一个成员上加 1。

可以在定义枚举类型时改变枚举元素的值：
enum season {spring, summer=3, autumn, winter};
也就说 spring 的值为 0，summer 的值为 3，autumn 的值为 4，winter 的值为 5
```

### 枚举变量的定义

```
1、先定义枚举类型，再定义枚举变量

enum DAY
{
      MON=1, TUE, WED, THU, FRI, SAT, SUN
};
enum DAY day;
```

```
2、定义枚举类型的同时定义枚举变量

enum DAY
{
      MON=1, TUE, WED, THU, FRI, SAT, SUN
} day;
```

```
3、省略枚举名称，直接定义枚举变量

enum
{
      MON=1, TUE, WED, THU, FRI, SAT, SUN
} day;
```

```
例:
#include<stdio.h>
 
enum DAY
{
      MON=1, TUE, WED, THU, FRI, SAT, SUN
};
 
int main()
{
    enum DAY day;
    day = WED;
    printf("%d\n",day);
    return 0;
}


结果:
3
```

### 枚举类型的遍历(不连续的枚举类型不连续的，无法遍历)

```
例:
#include<stdio.h>
 
enum DAY
{
      MON=1, TUE, WED, THU, FRI, SAT, SUN
} day;
int main()
{
    // 遍历枚举元素
    for (day = MON; day <= SUN; day++) {
        printf("枚举元素：%d \n", day);
    }
}

结果:
枚举元素：1 
枚举元素：2 
枚举元素：3 
枚举元素：4 
枚举元素：5 
枚举元素：6 
枚举元素：7
```

### 枚举在switch中的使用

```
#include <stdio.h>
#include <stdlib.h>

int main()
{
 
    enum color { red=1, green, blue };
 
    enum  color favorite_color;
 
    /* ask user to choose color */
    printf("请输入你喜欢的颜色: (1. red, 2. green, 3. blue): ");
    scanf("%d", &favorite_color);
 
    /* 输出结果 */
    switch (favorite_color)
    {
    case red:
        printf("你喜欢的颜色是红色");
        break;
    case green:
        printf("你喜欢的颜色是绿色");
        break;
    case blue:
        printf("你喜欢的颜色是蓝色");
        break;
    default:
        printf("你没有选择你喜欢的颜色");
    }
 
    return 0;
}
```

### 将整数转换为枚举

```
例:
#include <stdio.h>
 
int main()
{
 
    enum day
    {
        saturday,
        sunday,
        monday,
        tuesday,
        wednesday,
        thursday,
        friday
    } workday;
 
    int a = 1;
    enum day weekend;
    weekend = ( enum day ) a;  //类型转换
    //weekend = a; //错误
    printf("weekend:%d\n",weekend);
    return 0;
}


结果:
weekend:1
```

## 指针

```
指针是一个变量，其值为另一个变量的地址，即，内存位置的直接地址。
```

### 声明指针

```
type *var-name;

例:
int    *ip;    /* 一个整型的指针 */
double *dp;    /* 一个 double 型的指针 */
float  *fp;    /* 一个浮点型的指针 */
char   *ch;     /* 一个字符型的指针 */
```

### 如何使用指针

```
使用指针时会频繁进行以下几个操作：
    定义一个指针变量、把变量地址赋值给指针、访问指针变量中可用地址的值。
    这些是通过使用一元运算符 * (*称为指针运算符,是一个一元运算符。)来返回位于操作数所指定地址的变量的值。
```

```
例:
#include <stdio.h>

int main()
{
	int var = 20;	/*实际变量的声明*/
	int *ip;		/*指针变量的声明*/

	ip = &var;	/*在指针变量中存储var的地址*/

	printf("Address of var variable: %p\n", &var);

	/*在指针变量中存储的地址*/
	printf("Address stored in ip variable: %p\n", ip);

	/*使用指针访问值*/
	printf("Value of *ip variable: %d\n", *ip);

	return 0;
}


结果:
Address of var variable: 0x7ffee2673a78
Address stored in ip variable: 0x7ffee2673a78
Value of *ip variable: 20
```

### C中的NULL指针

```
在变量声明的时候，如果没有确切的地址可以赋值，为指针变量赋一个 NULL 值是一个良好的编程习惯。赋为 NULL 值的指针被称为空指针。
NULL 指针是一个定义在标准库中的值为零的常量。
```

```
例:
实例
#include <stdio.h>
 
int main ()
{
   int  *ptr = NULL;
 
   printf("ptr 的地址是 %p\n", ptr  );
 
   return 0;
}


结果:
ptr 的地址是 0x0
```

```
在大多数的操作系统上，程序不允许访问地址为 0 的内存，因为该内存是操作系统保留的。然而，内存地址 0 有特别重要的意义，它表明该指针不指向一个可访问的内存位置。但按照惯例，如果指针包含空值（零值），则假定它不指向任何东西。
如需检查一个空指针，您可以使用 if 语句，如下所示：
if(ptr)     /* 如果 p 非空，则完成 */
if(!ptr)    /* 如果 p 为空，则完成 */
```

### C指针的算术运算

```
注意: 数组名的意义——它就代表数组第一个元素的地址，所以不需要&。
```

```
C 指针是一个用数值表示的地址。因此，您可以对指针执行算术运算。可以对指针进行四种算术运算：++、--、+、-。

假设 ptr 是一个指向地址 1000 的整型指针，是一个 32 位的整数，让我们对该指针执行下列的算术运算：
ptr++
在执行完上述的运算之后，ptr 将指向位置 1004，因为 ptr 每增加一次，它都将指向下一个整数位置，即当前位置往后移 4 个字节(即32位, 8位（bit）=1字节（Byte）,1024字节=1KB)。这个运算会在不影响内存位置中实际值的情况下，移动指针到下一个内存位置。如果 ptr 指向一个地址为 1000 的字符，上面的运算会导致指针指向位置 1001，因为下一个字符位置是在 1001。
```

```
递增一个指针:

例:
#include <stdio.h>

const int MAX = 3;

int main()
{
	int var[] = {10, 100, 200};
	int i, *ptr;

	/*指针中的数组地址*/
	ptr = var;

	for (i=0; i<MAX; i++)
	{
		printf("存储地址: var[%d] = %p\n", i, ptr);
		printf("存储值: var[%d] = %d\n", i, *ptr);
		
		/*移动到下一个位置*/
		ptr++;
	}

	return 0;
}


结果:
存储地址: var[0] = 0x7ffee548ea8c
存储值: var[0] = 10
存储地址: var[1] = 0x7ffee548ea90
存储值: var[1] = 100
存储地址: var[2] = 0x7ffee548ea94
存储值: var[2] = 200
```

```
递减一个指针:

例:
#include <stdio.h>
 
const int MAX = 3;
 
int main ()
{
   int  var[] = {10, 100, 200};
   int  i, *ptr;
 
   /* 指针中最后一个元素的地址 */
   ptr = &var[MAX-1];
   for ( i = MAX; i > 0; i--)
   {
 
      printf("存储地址：var[%d] = %p\n", i-1, ptr );
      printf("存储值：var[%d] = %d\n", i-1, *ptr );
 
      /* 移动到下一个位置 */
      ptr--;
   }
   return 0;
}

结果:
存储地址：var[2] = 0x7ffee7827a94
存储值：var[2] = 200
存储地址：var[1] = 0x7ffee7827a90
存储值：var[1] = 100
存储地址：var[0] = 0x7ffee7827a8c
存储值：var[0] = 10
```

```
指针的比较:

指针可以用关系运算符进行比较，如 ==、< 和 >。如果 p1 和 p2 指向两个相关的变量，比如同一个数组中的不同元素，则可对 p1 和 p2 进行大小比较。

例:
#include <stdio.h>
 
const int MAX = 3;
 
int main ()
{
   int  var[] = {10, 100, 200};
   int  i, *ptr;
 
   /* 指针中第一个元素的地址 */
   ptr = var;
   i = 0;
   while ( ptr <= &var[MAX - 1] )
   {
 
      printf("Address of var[%d] = %p\n", i, ptr );
      printf("Value of var[%d] = %d\n", i, *ptr );
 
      /* 指向上一个位置 */
      ptr++;
      i++;
   }
   return 0;
}

结果:
Address of var[0] = 0x7ffeebf19a8c
Value of var[0] = 10
Address of var[1] = 0x7ffeebf19a90
Value of var[1] = 100
Address of var[2] = 0x7ffeebf19a94
Value of var[2] = 200
```

## 函数指针 (注意: c语言中函数名和数组名都直接代表地址)

```
函数指针是指向函数的指针变量。
通常我们说的指针变量是指向一个整型、字符型或数组等变量，而函数指针是指向函数。
函数指针可以像一般函数一样，用于调用函数、传递参数。
```

### 函数指针变量的声明

```
typedef (*fun_ptr)(int, int) = &func_name;
// 声明一个指向同样参数、返回值的函数指针类型
//函数名前的&可以省略
```

### 实例

```
#include <stdio.h>

int max(int x, int y)
{
	return x>y ? x:y;
}

int main(void)
{
	/*p是函数指针*/
	int (*p)(int, int) = &max;  //&可以省略
	int a, b, c, d;

	printf("请输入三个数字:");
	scanf("%d %d %d", &a, &b, &c);

	/*与直接调用函数等价, d = max(max(a, b), c)*/
	d = p(p(a, b), c);

	printf("最大的数字是: %d\n", d);

	return 0;
}

结果:
请输入三个数字:1
2
3
最大的数字是: 3
```

## 回调函数

```
(注: size_t(相当于别名,为了增强程序可移植性) 类型为 unsigned int 类型,无符号,它的取值没有负数)
```

```
你到一个商店买东西，刚好你要的东西没有货，于是你在店员那里留下了你的电话，过了几天店里有货了，店员就打了你的电话，然后你接到电话后就到店里去取了货。在这个例子里，你的电话号码就叫回调函数，你把电话留给店员就叫登记回调函数，店里后来有货了叫做触发了回调关联的事件，店员给你打电话叫做调用回调函数，你到店里去取货叫做响应回调事件。
```

```
例: 函数指针作为某个函数的参数
#include <stdio.h>
#include <stdlib.h>

//回调函数
void populate_array(int *array, size_t arraySize, int (*getNextValue)(void))
{
	for (size_t i=0; i<arraySize; i++)
	{
		array[i] = getNextValue();
	}
}

//获取随机值
int getNextRandomValue(void)
{
	return rand();
}

int main(void)
{
	int myarray[10];

	/*数组赋值*/
	populate_array(myarray, 10, getNextRandomValue);

	for (int i=0; i<10; i++)
	{
		printf("%d\n", myarray[i]);
	}

	printf("\n");

	return 0;
}

结果:
16807
282475249
1622650073
984943658
1144108930
470211272
101027544
1457850878
1458777923
2007237709
```

## 字符串

```
在 C 语言中，字符串实际上是使用 null 字符 '\0' 终止的一维字符数组。因此，一个以 null 结尾的字符串，包含了组成字符串的字符。

下面的声明和初始化创建了一个 "Hello" 字符串。由于在数组的末尾存储了空字符，所以字符数组的大小比单词 "Hello" 的字符数多一个。
char greeting[6] = {'H', 'e', 'l', 'l', 'o', '\0'};
依据数组初始化规则，您可以把上面的语句写成以下语句：
char greeting[] = "Hello";
```

### 实例

```
#include <stdio.h>

int main()
{
	char greeting_1[6] = {'h', 'e', 'l', 'l', 'o', '\0'};
	char greeting_2[] = "world";

	printf("greeting_1 message: %s\n", greeting_1);
	printf("greeting_2 message: %s\n", greeting_2);

	return 0;
}

结果:
greeting_1 message: hello
greeting_2 message: world
```

## 操作字符串的一些函数

```
strcpy(s1, s2);
复制字符串 s2 到字符串 s1。

strcat(s1, s2);
连接字符串 s2 到字符串 s1 的末尾。

strlen(s1);
返回字符串 s1 的长度。

strcmp(s1, s2);
如果 s1 和 s2 是相同的，则返回 0；如果 s1<s2 则返回小于 0；如果 s1>s2 则返回大于 0。

strchr(s1, ch);
返回一个指针，指向字符串 s1 中字符 ch 的第一次出现的位置。

strstr(s1, s2);
返回一个指针，指向字符串 s1 中字符串 s2 的第一次出现的位置。
```

### 实例

```
#include <stdio.h>
#include <string.h>
 
int main ()
{
   char str1[12] = "Hello";
   char str2[12] = "World";
   char str3[12];
   int  len ;
 
   /* 复制 str1 到 str3 */
   strcpy(str3, str1);
   printf("strcpy( str3, str1) :  %s\n", str3 );

   /* 连接 str1 和 str2 */
   strcat( str1, str2);
   printf("strcat( str1, str2):   %s\n", str1 );
 
   /* 连接后，str1 的总长度 */
   len = strlen(str1);
   printf("strlen(str1) :  %d\n", len );
 
   return 0;
}


结果:
strcpy( str3, str1) :  Hello
strcat( str1, str2):   HelloWorld
strlen(str1) :  10

```

### 字符串赋值方法 (重要)

#### 在定义时赋值

```
1. char a[10] = "hello"; (注意: char a[10]; a[10]="hello";这样是错误的。)
2. char a[10] = {'h', 'e', 'l', 'l', 'o'};

例:
#include <stdio.h>

int main()
{
	char array[5] = "hello";
	printf("array[5] = %s\n", array);

	return 0;
}

结果:
array[5] = hello
```

#### 通过指针赋值

```
例:
#include <stdio.h>

int main()
{
	char a_test = 'a';
	char *p;
	
	p = &a_test;
	
	*p = 'b';	

	printf("*p = %c\n", *p);

	return 0;
}


结果:
*p = b
```


```
#include <stdio.h>

int main()
{
	char array[5] = "hello";
	char *p = &array[1];

	printf("array[5] = %c\n", *p);

	return 0;
}


结果:
array[5] = e


#include <stdio.h>

int main()
{
	char array[5] = "hello";
	char *p = &array[1];

	printf("array[5] = %s\n", p);

	return 0;
}


结果:
array[5] = ello
```


```
注意: 数组指针取值时，指针变量前面不用加*。
```

```
例1:
#include <stdio.h>

int main()
{
	char *p = "hello";
	printf ("*p = %s\n", p);

	return 0;
}

结果:
*p = hello


例2:
#include <stdio.h>

int main()
{
	char array[5] = "hello";
	char *p = array;

	printf("array[5] = %s\n", p);

	return 0;
}


#include <stdio.h>

int main()
{
	char array[5] = "hello";
	char *p = &array[0];

	printf("array[5] = %s\n", p);

	return 0;
}


结果:
array[5] = hello
```

```
#include <stdio.h>

int main()
{
	char array[5] = "hello";
	char *p = array;

	printf("array[5] = %s\n", p);

	return 0;
}


array[5] = hello
```



### 使用指针访问数组元素

```
个人理解: 数组名相当于地址,前加*可用于取值
```

```
#include <stdio.h>
 
int main()
{
   int data[5], i;
   printf("输入元素: ");
 
   for(i = 0; i < 5; ++i)
     scanf("%d", data + i);
 
   printf("你输入的是: \n");
   for(i = 0; i < 5; ++i)
      printf("%d\n", *(data + i));
 
   return 0;
}
kaiqigu@bogon:~/dododo/cfile|⇒  ./g_3 
输入元素: 1 2 3 4 5 
你输入的是: 
1
2
3
4
5
```

#### 使用strcpy函数

```
#include <stdio.h>
#include <string.h>
 
int main ()
{
   char str1[12] = "Hello";
   char str3[12];
 
   /* 复制 str1 到 str3 */
   strcpy(str3, str1);
   printf("strcpy( str3, str1) :  %s\n", str3 );
 
   return 0;
}

结果:
strcpy( str3, str1) :  Hello
```

## 结构体

```
C 数组允许定义可存储相同类型数据项的变量，结构是 C 编程中另一种用户自定义的可用的数据类型，它允许您存储不同类型的数据项。
```

### 定义结构

```
为了定义结构，您必须使用 struct 语句。struct 语句定义了一个包含多个成员的新的数据类型，struct 语句的格式如下：

struct tag { 
    member-list
    member-list 
    member-list  
    ...
} variable-list ;5

tag 是结构体标签。
member-list 是标准的变量定义，比如 int i; 或者 float f，或者其他有效的变量定义。
variable-list 结构变量，定义在结构的末尾，最后一个分号之前，您可以指定一个或多个结构变量。
在一般情况下，tag、member-list、variable-list 这 3 部分至少要出现 2 个。

例:
struct Books
{
   char  title[50];
   char  author[50];
   char  subject[100];
   int   book_id;
} book;
```

### 定义举例

```
//此声明声明了拥有3个成员的结构体，分别为整型的a，字符型的b和双精度的c
//同时又声明了结构体变量s1
//这个结构体并没有标明其标签
struct 
{
    int a;
    char b;
    double c;
} s1;



//此声明声明了拥有3个成员的结构体，分别为整型的a，字符型的b和双精度的c
//结构体的标签被命名为SIMPLE,没有声明变量
struct SIMPLE
{
    int a;
    char b;
    double c;
};
//用SIMPLE标签的结构体，另外声明了变量t1、t2、t3
struct SIMPLE t1, t2[20], *t3;



//也可以用typedef创建新类型
typedef struct
{
    int a;
    char b;
    double c; 
} Simple2;
//现在可以用Simple2作为类型声明新的结构体变量
Simple2 u1, u2[20], *u3;
```

```
结构体的成员可以包含其他结构体，也可以包含指向自己结构体类型的指针，而通常这种指针的应用是为了实现一些更高级的数据结构如链表和树等。


//此结构体的声明包含了其他的结构体
struct COMPLEX
{
    char string[100];
    struct SIMPLE a;
};


 
//此结构体的声明包含了指向自己类型的指针
struct NODE
{
    char string[100];
    struct NODE *next_node;
};
```

```
如果两个结构体互相包含，则需要对其中一个结构体进行不完整声明，如下所示：


struct B;    //对结构体B进行不完整声明
 
//结构体A中包含指向结构体B的指针
struct A
{
    struct B *partner;
    //other members;
};
 
//结构体B中包含指向结构体A的指针，在A声明完后，B也随之进行声明
struct B
{
    struct A *partner;
    //other members;
};
```

### 结构体变量的初始化

```
例:
#include <stdio.h>
 
struct Books
{
   char  title[50];
   char  author[50];
   char  subject[100];
   int   book_id;
} book = {"C 语言", "RUNOOB", "编程语言", 123456};
 
int main()
{
    printf("title : %s\nauthor: %s\nsubject: %s\nbook_id: %d\n", book.title, book.author, book.subject, book.book_id);
}


结果:
title : C 语言
author: RUNOOB
subject: 编程语言
book_id: 123456
```

### 访问结构成员

```
#include <stdio.h>
#include <string.h>
 
struct Books
{
   char  title[50];
   char  author[50];
   char  subject[100];
   int   book_id;
};
 
int main( )
{
   struct Books Book1;        /* 声明 Book1，类型为 Books */
   struct Books Book2;        /* 声明 Book2，类型为 Books */
 
   /* Book1 详述 */
   strcpy( Book1.title, "C Programming");
   strcpy( Book1.author, "Nuha Ali"); 
   strcpy( Book1.subject, "C Programming Tutorial");
   Book1.book_id = 6495407;
 
   /* Book2 详述 */
   strcpy( Book2.title, "Telecom Billing");
   strcpy( Book2.author, "Zara Ali");
   strcpy( Book2.subject, "Telecom Billing Tutorial");
   Book2.book_id = 6495700;
 
   /* 输出 Book1 信息 */
   printf( "Book 1 title : %s\n", Book1.title);
   printf( "Book 1 author : %s\n", Book1.author);
   printf( "Book 1 subject : %s\n", Book1.subject);
   printf( "Book 1 book_id : %d\n", Book1.book_id);
 
   /* 输出 Book2 信息 */
   printf( "Book 2 title : %s\n", Book2.title);
   printf( "Book 2 author : %s\n", Book2.author);
   printf( "Book 2 subject : %s\n", Book2.subject);
   printf( "Book 2 book_id : %d\n", Book2.book_id);
 
   return 0;
}


结果:
Book 1 title : C Programming
Book 1 author : Nuha Ali
Book 1 subject : C Programming Tutorial
Book 1 book_id : 6495407
Book 2 title : Telecom Billing
Book 2 author : Zara Ali
Book 2 subject : Telecom Billing Tutorial
Book 2 book_id : 6495700
```

### 结构作为函数参数

```
#include <stdio.h>
#include <string.h>
 
struct Books
{
   char  title[50];
   char  author[50];
   char  subject[100];
   int   book_id;
};
 
/* 函数声明 */
void printBook( struct Books book );
int main( )
{
   struct Books Book1;        /* 声明 Book1，类型为 Books */
   struct Books Book2;        /* 声明 Book2，类型为 Books */
 
   /* Book1 详述 */
   strcpy( Book1.title, "C Programming");
   strcpy( Book1.author, "Nuha Ali"); 
   strcpy( Book1.subject, "C Programming Tutorial");
   Book1.book_id = 6495407;
 
   /* Book2 详述 */
   strcpy( Book2.title, "Telecom Billing");
   strcpy( Book2.author, "Zara Ali");
   strcpy( Book2.subject, "Telecom Billing Tutorial");
   Book2.book_id = 6495700;
 
   /* 输出 Book1 信息 */
   printBook( Book1 );
 
   /* 输出 Book2 信息 */
   printBook( Book2 );
 
   return 0;
}
void printBook( struct Books book )
{
   printf( "Book title : %s\n", book.title);
   printf( "Book author : %s\n", book.author);
   printf( "Book subject : %s\n", book.subject);
   printf( "Book book_id : %d\n", book.book_id);
}


结果:
Book title : C Programming
Book author : Nuha Ali
Book subject : C Programming Tutorial
Book book_id : 6495407
Book title : Telecom Billing
Book author : Zara Ali
Book subject : Telecom Billing Tutorial
Book book_id : 6495700
```

### 指向结构的指针 (结构体指针指向成员变量时，要用->)

```
#include <stdio.h>
#include <string.h>
 
struct Books
{
   char  title[50];
   char  author[50];
   char  subject[100];
   int   book_id;
};
 
/* 函数声明 */
void printBook( struct Books *book );
int main( )
{
   struct Books Book1;        /* 声明 Book1，类型为 Books */
   struct Books Book2;        /* 声明 Book2，类型为 Books */
 
   /* Book1 详述 */
   strcpy( Book1.title, "C Programming");
   strcpy( Book1.author, "Nuha Ali"); 
   strcpy( Book1.subject, "C Programming Tutorial");
   Book1.book_id = 6495407;
 
   /* Book2 详述 */
   strcpy( Book2.title, "Telecom Billing");
   strcpy( Book2.author, "Zara Ali");
   strcpy( Book2.subject, "Telecom Billing Tutorial");
   Book2.book_id = 6495700;
 
   /* 通过传 Book1 的地址来输出 Book1 信息 */
   printBook( &Book1 );
 
   /* 通过传 Book2 的地址来输出 Book2 信息 */
   printBook( &Book2 );
 
   return 0;
}
void printBook( struct Books *book )
{
   printf( "Book title : %s\n", book->title);
   printf( "Book author : %s\n", book->author);
   printf( "Book subject : %s\n", book->subject);
   printf( "Book book_id : %d\n", book->book_id);
}


结果：
Book title : C Programming
Book author : Nuha Ali
Book subject : C Programming Tutorial
Book book_id : 6495407
Book title : Telecom Billing
Book author : Zara Ali
Book subject : Telecom Billing Tutorial
Book book_id : 6495700
```

## 位域

```
有些信息在存储时，并不需要占用一个完整的字节，而只需占几个或一个二进制位。例如在存放一个开关量时，只有 0 和 1 两种状态，用 1 位二进位即可。为了节省存储空间，并使处理简便，C 语言又提供了一种数据结构，称为"位域"或"位段"。
所谓"位域"是把一个字节中的二进位划分为几个不同的区域，并说明每个区域的位数。每个域有一个域名，允许在程序中按域名进行操作。这样就可以把几个不同的对象用一个字节的二进制位域来表示。
```

### 位域的定义和位域变量的说明

```
在结构内声明位域的形式如下：
struct
{
  type [member_name] : width ;
};


下面是有关位域中变量元素的描述：
元素	            描述
type	        整数类型，决定了如何解释位域的值。类型可以是整型、有符号整型、无符号整型。
member_name	    位域的名称。
width	        位域中位的数量。宽度必须小于或等于指定类型的位宽度。


例如：
struct bs{
    int a:8;
    int b:2;
    int c:6;
}data;
说明 data 为 bs 变量，共占两个字节。其中位域 a 占 8 位，位域 b 占 2 位，位域 c 占 6 位。
```

```
补充说明:

一个位域存储在同一个字节中，如一个字节所剩空间不够存放另一位域时，则会从下一单元起存放该位域。也可以有意使某位域从下一单元开始。例如：
struct bs{
    unsigned a:4;
    unsigned  :4;    /* 空域 */
    unsigned b:4;    /* 从下一单元开始存放 */
    unsigned c:4
}
在这个位域定义中，a 占第一字节的 4 位，后 4 位填 0 表示不使用，b 从第二字节开始，占用 4 位，c 占用 4 位。
由于位域不允许跨两个字节，因此位域的长度不能大于一个字节的长度，也就是说不能超过8位二进位。如果最大长度大于计算机的整数字长，一些编译器可能会允许域的内存重叠，另外一些编译器可能会把大于一个域的部分存储在下一个字中。
位域可以是无名位域，这时它只用来作填充或调整位置。无名的位域是不能使用的(注意：这里写的是无名位域)。例如：
struct k{
    int a:1;
    int  :2;    /* 该 2 位不能使用 */
    int b:3;
    int c:2;
};
从以上分析可以看出，位域在本质上就是一种结构类型，不过其成员是按二进位分配的。
```

### 实例

```
#include <stdio.h>
#include <string.h>
 
/* 定义简单的结构 */
struct
{
  unsigned int widthValidated;
  unsigned int heightValidated;
} status1;
 
/* 定义位域结构 */
struct
{
  unsigned int widthValidated : 1;
  unsigned int heightValidated : 1;
} status2;
 
int main( )
{
   printf( "Memory size occupied by status1 : %d\n", sizeof(status1));
   printf( "Memory size occupied by status2 : %d\n", sizeof(status2));
 
   return 0;
}


结果:
Memory size occupied by status1 : 8
Memory size occupied by status2 : 4
```

```
实例:
#include <stdio.h>
#include <string.h>
 
struct
{
  unsigned int age : 3;
} Age;
 
int main( )
{
   Age.age = 4;
   printf( "Sizeof( Age ) : %d\n", sizeof(Age) );
   printf( "Age.age : %d\n", Age.age );
 
   Age.age = 7;
   printf( "Age.age : %d\n", Age.age );
 
   Age.age = 8; // 二进制表示为 1000 有四位，超出
   printf( "Age.age : %d\n", Age.age );
 
   return 0;
}


结果:
Sizeof( Age ) : 4
Age.age : 4
Age.age : 7
Age.age : 0
```


### 位域的使用

```
位域的使用和结构成员的使用相同，其一般形式为：

位域变量名.位域名       (用于位域的变量)
位域变量名->位域名      (用于位域的指针变量)
```

```
实例:
#include <stdio.h>

int main(){
    struct bs{
        unsigned a:1;
        unsigned b:3;
        unsigned c:4;
    } bit,*pbit;
    bit.a=1;    /* 给位域赋值（应注意赋值不能超过该位域的允许范围） */
    bit.b=7;    /* 给位域赋值（应注意赋值不能超过该位域的允许范围） */
    bit.c=15;    /* 给位域赋值（应注意赋值不能超过该位域的允许范围） */
    printf("%d,%d,%d\n",bit.a,bit.b,bit.c);    /* 以整型量格式输出三个域的内容 */
    pbit=&bit;    /* 把位域变量 bit 的地址送给指针变量 pbit */
    pbit->a=0;    /* 用指针方式给位域 a 重新赋值，赋为 0 */
    pbit->b&=3;    /* 使用了复合的位运算符 "&="，相当于：pbit->b=pbit->b&3，位域 b 中原有值为 7，与 3 作按位与运算的结果为 3（111&011=011，十进制值为 3） */
    pbit->c|=1;    /* 使用了复合位运算符"|="，相当于：pbit->c=pbit->c|1，其结果为 15 */
    printf("%d,%d,%d\n",pbit->a,pbit->b,pbit->c);    /* 用指针方式输出了这三个域的值 */
}

结果:
1,7,15
0,3,15
```

## 共用体

```
共用体是一种特殊的数据类型，允许您在相同的内存位置存储不同的数据类型。
您可以定义一个带有多成员的共用体，但是任何时候只能有一个成员带有值。共用体提供了一种使用相同的内存位置的有效方式。
```

### 定义共用体

```
union [union tag]
{
   member definition;
   member definition;
   ...
   member definition;
} [one or more union variables];

union tag 是可选的，每个 member definition 是标准的变量定义，比如 int i; 或者 float f; 或者其他有效的变量定义。在共用体定义的末尾，最后一个分号之前，您可以指定一个或多个共用体变量，这是可选的。


下面定义一个名为 Data 的共用体类型，有三个成员 i、f 和 str：
union Data
{
   int i;
   float f;
   char  str[20];
} data;

在上面的实例中，Data 将占用 20 个字节的内存空间，因为在各个成员中，字符串所占用的空间是最大的。
```

### 实例

```
#include <stdio.h>
#include <string.h>
 
union Data
{
   int i;
   float f;
   char  str[20];
};
 
int main( )
{
   union Data data;        
 
   printf( "Memory size occupied by data : %d\n", sizeof(data));
 
   return 0;
}


结果:
Memory size occupied by data : 20
```

### 主要用法展示

```
实例:
#include <stdio.h>
#include <string.h>
 
union Data
{
   int i;
   float f;
   char  str[20];
};
 
int main( )
{
   union Data data;        
 
   data.i = 10;
   printf( "data.i : %d\n", data.i);
   
   data.f = 220.5;
   printf( "data.f : %f\n", data.f);
   
   strcpy( data.str, "C Programming");
   printf( "data.str : %s\n", data.str);
 
   return 0;
}


结果:
data.i : 10
data.f : 220.500000
data.str : C Programming
```

## typedef vs #define

### typedef

```
typedef 关键字可以使用它来为类型取一个新的名字。

下面的实例为单字节数字定义了一个术语 BYTE：
typedef unsigned char BYTE;

在这个类型定义之后，标识符 BYTE 可作为类型 unsigned char 的缩写，例如：
BYTE  b1, b2;

按照惯例，定义时会大写字母，以便提醒用户类型名称是一个象征性的缩写，但您也可以使用小写字母。
```

### #define

```
实例:
#include <stdio.h>
 
#define TRUE  1
#define FALSE 0
 
int main( )
{
   printf( "TRUE 的值: %d\n", TRUE);
   printf( "FALSE 的值: %d\n", FALSE);
 
   return 0;
}


结果:
TRUE 的值: 1
FALSE 的值: 0
```

## C输入&输出

### getchar() & putchar() 函数

```
int getchar(void) 函数从屏幕读取下一个可用的字符，并把它返回为一个整数。这个函数在同一个时间内只会读取一个单一的字符。您可以在循环内使用这个方法，以便从屏幕上读取多个字符。
int putchar(int c) 函数把字符输出到屏幕上，并返回相同的字符。这个函数在同一个时间内只会输出一个单一的字符。您可以在循环内使用这个方法，以便在屏幕上输出多个字符。
```

```
实例:
#include <stdio.h>
 
int main( )
{
   int c;
 
   printf( "Enter a value :");
   c = getchar( );
 
   printf( "\nYou entered: ");
   putchar( c );
   printf( "\n");
   return 0;
}

结果:
Enter a value :haha

You entered: h
```


### gets() & puts() 函数

```
char *gets(char *s) 函数从 stdin 读取一行到 s 所指向的缓冲区，直到一个终止符或 EOF。
int puts(const char *s) 函数把字符串 s 和一个尾随的换行符写入到 stdout。
```

```
实例:
#include <stdio.h>
 
int main( )
{
   char str[100];
 
   printf( "Enter a value :");
   gets( str );
 
   printf( "\nYou entered: ");
   puts( str );
   return 0;
}

结果:
warning: this program uses gets(), which is unsafe.
Enter a value :123

You entered: 123
```

### fgets() & fputs() 函数 (linux系统下运行 gets 与 puts 有警告信息, 需要用 fgets 和 fputs。)

```
实例:
#include <stdio.h>

int main()
{
    char c[100];
    printf("Enter a value:");
    fgets( c,100,stdin );

    printf("\nyou entered:");
    fputs( c,stdout );

    return 0;

}


结果:
Enter a value:123

you entered:123
```

### scanf() & printf()

```
int scanf(const char *format, ...) 函数从标准输入流 stdin 读取输入，并根据提供的 format 来浏览输入。
int printf(const char *format, ...) 函数把输出写入到标准输出流 stdout ，并根据提供的格式产生输出。
format 可以是一个简单的常量字符串，但是您可以分别指定 %s、%d、%c、%f 等来输出或读取字符串、整数、字符或浮点数。还有许多其他可用的格式选项，可以根据需要使用。
```

```
实例:
#include <stdio.h>
int main( ) {
 
   char str[100];
   int i;
 
   printf( "Enter a value :");
   scanf("%s %d", str, &i);
 
   printf( "\nYou entered: %s %d ", str, i);
   printf("\n");
   return 0;
}


结果:
Enter a value :haha 123

You entered: haha 123 
```


## C文件读写

### 打开文件 fopen()

```
FILE *fopen( const char * filename, const char * mode );
```

```
模式	    描述
r	    打开一个已有的文本文件，允许读取文件。
w	    打开一个文本文件，允许写入文件。如果文件不存在，则会创建一个新文件。在这里，您的程序会从文件的开头写入内容。如果文件存在，则该会被截断为零长度，重新写入。
a	    打开一个文本文件，以追加模式写入文件。如果文件不存在，则会创建一个新文件。在这里，您的程序会在已有的文件内容中追加内容。
r+	    打开一个文本文件，允许读写文件。
w+	    打开一个文本文件，允许读写文件。如果文件已存在，则文件会被截断为零长度，如果文件不存在，则会创建一个新文件。
a+	    打开一个文本文件，允许读写文件。如果文件不存在，则会创建一个新文件。读取会从文件的开头开始，写入则只能是追加模式。

如果处理的是二进制文件，则需使用下面的访问模式来取代上面的访问模式：
"rb", "wb", "ab", "rb+", "r+b", "wb+", "w+b", "ab+", "a+b"
```

### 关闭文件 fclose()

```
int fclose( FILE *fp );
```

### 写入文件 fputc fputs fprintf

```
int fputc( int c, FILE *fp );                   //单个字符
int fputs( const char *s, FILE *fp );           //字符串
```

```
也可以使用 int fprintf(FILE *fp,const char *format, ...) 函数来写把一个字符串写入到文件中。
```

```
例: 将字符串写入文件

#include <stdio.h>
#include <stdlib.h>  /* exit() 函数 */
 
int main()
{
   char sentence[1000];
   FILE *fptr;
 
   fptr = fopen("runoob.txt", "w");
   if(fptr == NULL)
   {
      printf("Error!");
      exit(1);
   }
   
   printf("输入字符串:\n");
   fgets(sentence, (sizeof sentence / sizeof sentence[0]), stdin);
 
   fprintf(fptr,"%s", sentence);
   fclose(fptr);
 
   return 0;
}
```


### 读取文件 fgetc fgets fscanf

```
int fgetc( FILE * fp );                         //单个字符
char *fgets( char *buf, int n, FILE *fp );      //字符串
```

```
也可以使用 int fscanf(FILE *fp, const char *format, ...) 函数来从文件中读取字符串，但是在遇到第一个空格字符时，它会停止读取。
```

```
例: 从文件中读取一行

#include <stdio.h>
#include <stdlib.h> //  exit() 函数
int main()
{
    char c[1000];
    FILE *fptr;
 
    if ((fptr = fopen("runoob.txt", "r")) == NULL)
    {
        printf("Error! opening file");
        // 文件指针返回 NULL 则退出
        exit(1);         
    }
 
    // 读取文本，直到碰到新的一行开始
    fscanf(fptr,"%[^\n]", c);
 
    printf("读取内容:\n%s\n", c);
    fclose(fptr);
    
    return 0;
}
```

### 实例

```
实例: 写入文件
kaiqigu@bogon:~/dododo/cfile|⇒  cat e_1.c 
#include <stdio.h>
 
int main()
{
   FILE *fp = NULL;
 
   fp = fopen("/tmp/test.txt", "w+");
   fprintf(fp, "This is testing for fprintf...\n");
   fputs("This is testing for fputs...\n", fp);
   fclose(fp);
}


结果:
kaiqigu@bogon:~/dododo/cfile|⇒  cat /tmp/test.txt 
This is testing for fprintf...
This is testing for fputs...
```


```
实例: 读取文件
kaiqigu@bogon:~/dododo/cfile|⇒  cat e_2.c 
#include <stdio.h>
 
int main()
{
   FILE *fp = NULL;
   char buff[255];
 
   fp = fopen("/tmp/test.txt", "r");
   fscanf(fp, "%s", buff);
   printf("1: %s\n", buff );
 
   fgets(buff, 255, (FILE*)fp);
   printf("2: %s\n", buff );
   
   fgets(buff, 255, (FILE*)fp);
   printf("3: %s\n", buff );
   fclose(fp);
 
}


结果:
kaiqigu@bogon:~/dododo/cfile|⇒  ./e_2 
1: This
2:  is testing for fprintf...

3: This is testing for fputs...

```

## C预处理器 (CPP)

```
C 预处理器不是编译器的组成部分，但是它是编译过程中一个单独的步骤。
简言之，C 预处理器只不过是一个文本替换工具而已，它们会指示编译器在实际编译之前完成所需的预处理。
```

### 预处理器指令

```
指令	            描述
#define	        定义宏
#include	    包含一个源代码文件
#undef	        取消已定义的宏
#ifdef	        如果宏已经定义，则返回真
#ifndef	        如果宏没有定义，则返回真
#if	            如果给定条件为真，则编译下面代码
#else	        #if 的替代方案
#elif	        如果前面的 #if 给定条件不为真，当前条件为真，则编译下面代码
#endif	        结束一个 #if……#else 条件编译块
#error	        当遇到标准错误时，输出错误消息
#pragma	        使用标准化方法，向编译器发布特殊的命令到编译器中
```

### 实例

```
#define MAX_ARRAY_LENGTH 20
这个指令告诉 CPP 把所有的 MAX_ARRAY_LENGTH 替换为 20。使用 #define 定义常量来增强可读性。

#include <stdio.h>
#include "myheader.h"
这些指令告诉 CPP 从系统库中获取 stdio.h，并添加文本到当前的源文件中。下一行告诉 CPP 从本地目录中获取 myheader.h，并添加内容到当前的源文件中。

#undef  FILE_SIZE
#define FILE_SIZE 42
这个指令告诉 CPP 取消已定义的 FILE_SIZE，并定义它为 42。

#ifndef MESSAGE
   #define MESSAGE "You wish!"
#endif
这个指令告诉 CPP 只有当 MESSAGE 未定义时，才定义 MESSAGE。

#ifdef DEBUG
   /* Your debugging statements here */
#endif
这个指令告诉 CPP 如果定义了 DEBUG，则执行处理语句。在编译时，如果您向 gcc 编译器传递了 -DDEBUG 开关量，这个指令就非常有用。它定义了 DEBUG，您可以在编译期间随时开启或关闭调试。
```

### 预定义宏

```
ANSI C 定义了许多宏。在编程中您可以使用这些宏，但是不能直接修改这些预定义的宏。

宏	        描述
__DATE__	当前日期，一个以 "MMM DD YYYY" 格式表示的字符常量。
__TIME__	当前时间，一个以 "HH:MM:SS" 格式表示的字符常量。
__FILE__	这会包含当前文件名，一个字符串常量。
__LINE__	这会包含当前行号，一个十进制常量。
__STDC__	当编译器以 ANSI 标准编译时，则定义为 1。
```

```
实例:
#include <stdio.h>

main()
{
   printf("File :%s\n", __FILE__ );
   printf("Date :%s\n", __DATE__ );
   printf("Time :%s\n", __TIME__ );
   printf("Line :%d\n", __LINE__ );
   printf("ANSI :%d\n", __STDC__ );

}


结果:
File :e_3.c
Date :Aug 27 2019
Time :18:26:43
Line :8
ANSI :1
```

### 预处理器运算符

#### 宏延续运算符

```
一个宏通常写在一个单行上。但是如果宏太长，一个单行容纳不下，则使用宏延续运算符（\）。例如：

#define  message_for(a, b)  \
    printf(#a " and " #b ": We love you!\n")
```

#### 字符串常量化运算符

```
在宏定义中，当需要把一个宏的参数转换为字符串常量时，则使用字符串常量化运算符（#）。在宏中使用的该运算符有一个特定的参数或参数列表。例如：
#include <stdio.h>

#define  message_for(a, b)  \
    printf(#a " and " #b ": We love you!\n")

int main(void)
{
   message_for(Carole, Debra);
   return 0;
}

当上面的代码被编译和执行时，它会产生下列结果：
Carole and Debra: We love you!
```


#### 标记粘贴运算符

```
宏定义内的标记粘贴运算符（##）会合并两个参数。它允许在宏定义中两个独立的标记被合并为一个标记。例如：
#include <stdio.h>

#define tokenpaster(n) printf ("token" #n " = %d", token##n)

int main(void)
{
   int token34 = 40;
   
   tokenpaster(34);
   return 0;
}


当上面的代码被编译和执行时，它会产生下列结果：
token34 = 40

这是怎么发生的，因为这个实例会从编译器产生下列的实际输出：
printf ("token34 = %d", token34);
这个实例演示了 token##n 会连接到 token34 中，在这里，我们使用了字符串常量化运算符（#）和标记粘贴运算符（##）。
```

##### defined() 运算符

```
预处理器 defined 运算符是用在常量表达式中的，用来确定一个标识符是否已经使用 #define 定义过。如果指定的标识符已定义，则值为真（非零）。如果指定的标识符未定义，则值为假（零）。下面的实例演示了 defined() 运算符的用法：
#include <stdio.h>

#if !defined (MESSAGE)
   #define MESSAGE "You wish!"
#endif

int main(void)
{
   printf("Here is the message: %s\n", MESSAGE);  
   return 0;
}

当上面的代码被编译和执行时，它会产生下列结果：
Here is the message: You wish!
```

### 参数化的宏

```
CPP 一个强大的功能是可以使用参数化的宏来模拟函数。例如，下面的代码是计算一个数的平方：
int square(int x) {
   return x * x;
}

我们可以使用宏重写上面的代码，如下：
#define square(x) ((x) * (x))
```

```
在使用带有参数的宏之前，必须使用 #define 指令定义。参数列表是括在圆括号内，且必须紧跟在宏名称的后边。宏名称和左圆括号之间不允许有空格。例如：
#include <stdio.h>

#define MAX(x,y) ((x) > (y) ? (x) : (y))

int main(void)
{
   printf("Max between 20 and 10 is %d\n", MAX(10, 20));  
   return 0;
}

当上面的代码被编译和执行时，它会产生下列结果：
Max between 20 and 10 is 20
```

## 头文件

```
头文件是扩展名为 .h 的文件，包含了 C 函数声明和宏定义，被多个源文件中引用共享。
有两种类型的头文件：程序员编写的头文件和编译器自带的头文件。
```

### 引用头文件的语法

```
C 语言中 include <> 与include "" 的区别?

#include < > 引用的是编译器的类库路径里面的头文件。
#include " " 引用的是你程序目录中的头文件，如果在程序目录没有找到引用的头文件则到编译器的类库路径的目录下找该头文件。
```

### 有条件引用

```
有时需要从多个不同的头文件中选择一个引用到程序中。例如，需要指定在不同的操作系统上使用的配置参数。您可以通过一系列条件来实现这点，如下：
#if SYSTEM_1
   # include "system_1.h"
#elif SYSTEM_2
   # include "system_2.h"
#elif SYSTEM_3
   ...
#endif

但是如果头文件比较多的时候，这么做是很不妥当的，预处理器使用宏来定义头文件的名称。这就是所谓的有条件引用。它不是用头文件的名称作为 #include 的直接参数，您只需要使用宏名称代替即可：
 #define SYSTEM_H "system_1.h"
 ...
 #include SYSTEM_H
```


## C强制类型转换

```
(type_name) expression
```

### 实例

```
#include <stdio.h>
 
int main()
{
   int sum = 17, count = 5;
   double mean;
 
   mean = (double) sum / count;
   printf("Value of mean : %f\n", mean );
 
}

结果:
Value of mean : 3.400000

这里要注意的是强制类型转换运算符的优先级大于除法，因此 sum 的值首先被转换为 double 型，然后除以 count，得到一个类型为 double 的值。
```

### 整数提升

```
整数提升是指把小于 int 或 unsigned int 的整数类型转换为 int 或 unsigned int 的过程。
```

```
实例:
#include <stdio.h>
 
int main()
{
   int  i = 17;
   char c = 'c'; /* ascii 值是 99 */
   int sum;
 
   sum = i + c;
   printf("Value of sum : %d\n", sum );
 
}

结果:
Value of sum : 116

在这里，sum 的值为 116，因为编译器进行了整数提升，在执行实际加法运算时，把 'c' 的值转换为对应的 ascii 值。
```

### 常用的算术转换

```
常用的算术转换是隐式地把值强制转换为相同的类型。编译器首先执行整数提升，如果操作数类型不同，则它们会被转换为下列层次中出现的最高层次的类型：

int -> unsigned int -> long -> unsigned long -> long long -> unsigned long long -> float -> double -> long double
```

```
#include <stdio.h>
 
int main()
{
   int  i = 17;
   char c = 'c'; /* ascii 值是 99 */
   float sum;
 
   sum = i + c;
   printf("Value of sum : %f\n", sum );
 
}


结果:
Value of sum : 116.000000
```

## C错误处理

```
在发生错误时，大多数的 C 或 UNIX 函数调用返回 1 或 NULL，同时会设置一个错误代码 errno，该错误代码是全局变量，表示在函数调用期间发生了错误。
可以在 errno.h 头文件中找到各种各样的错误代码。
所以，C 程序员可以通过检查返回值，然后根据返回值决定采取哪种适当的动作。开发人员应该在程序初始化时，把 errno 设置为 0，这是一种良好的编程习惯。0 值表示程序中没有错误。
```

### errno、perror()、strerror()

```
errno 错误代码，若程序没有错误，则为0。
perror() 函数显示您传给它的字符串，后跟一个冒号、一个空格和当前 errno 值的文本表示形式。
strerror() 函数，返回一个指针，指针指向当前 errno 值的文本表示形式。
```

#### 实例

```
#include <stdio.h>
#include <errno.h>
#include <string.h>
 
extern int errno ;
 
int main ()
{
   FILE * pf;
   int errnum;
   pf = fopen ("unexist.txt", "rb");
   if (pf == NULL)
   {
      errnum = errno;
      fprintf(stderr, "错误号: %d\n", errno);
      perror("通过 perror 输出错误");
      fprintf(stderr, "打开文件错误: %s\n", strerror( errnum ));
   }
   else
   {
      fclose (pf);
   }
   return 0;
}


结果:
错误号: 2
通过 perror 输出错误: No such file or directory
打开文件错误: No such file or directory
```

### 程序退出状态

```
通常情况下，程序成功执行完一个操作正常退出的时候会带有值 EXIT_SUCCESS。在这里，EXIT_SUCCESS 是宏，它被定义为 0。
如果程序中存在一种错误情况，当您退出程序时，会带有状态值 EXIT_FAILURE，被定义为 -1。
```

```
#include <stdio.h>
#include <stdlib.h>
 
int main()
{
   int dividend = 20;
   int divisor = 5;
   int quotient;
 
   if( divisor == 0){
      fprintf(stderr, "除数为 0 退出运行...\n");
      exit(EXIT_FAILURE);
   }
   quotient = dividend / divisor;
   fprintf(stderr, "quotient 变量的值为: %d\n", quotient );
 
   exit(EXIT_SUCCESS);
}


结果:
quotient 变量的值为: 4
```

## C递归

### 数的阶乘

```
#include <stdio.h>
 
double factorial(unsigned int i)
{
   if(i <= 1)
   {
      return 1;
   }
   return i * factorial(i - 1);
}
int  main()
{
    int i = 15;
    printf("%d 的阶乘为 %f\n", i, factorial(i));
    return 0;
}


结果:
15 的阶乘为 1307674368000.000000
```

### 斐波那契数列

```
#include <stdio.h>
 
int fibonaci(int i)
{
   if(i == 0)
   {
      return 0;
   }
   if(i == 1)
   {
      return 1;
   }
   return fibonaci(i-1) + fibonaci(i-2);
}
 
int  main()
{
    int i;
    for (i = 0; i < 10; i++)
    {
       printf("%d\t\n", fibonaci(i));
    }
    return 0;
}


结果:
0	
1	
1	
2	
3	
5	
8	
13	
21	
34
```


## C可变(参数个数)参数

```
C语言不允许直接传递数组，要使用相应的指针。因为若直接传递数组，则传递的只是指向第一个元素的指针。
```

```
int func(int, ... ) 
{
   .
   .
   .
}
 
int main()
{
   func(2, 2, 3);
   func(3, 2, 3, 4);
}

请注意，函数 func() 最后一个参数写成省略号，即三个点号（...），省略号之前的参数是辅助功能的参数，自定义，具体传什么要看自己需要什么。
为了使用这个功能，您需要使用 stdarg.h 头文件，该文件提供了实现可变参数功能的函数和宏。

具体步骤如下：
定义一个函数，最后一个参数为省略号，省略号前面可以设置自定义参数。
在函数定义中创建一个 va_list 类型变量，该类型是在 stdarg.h 头文件中定义的。
使用第一个参数 和 va_start 宏来初始化 va_list 变量为一个参数列表。宏 va_start 是在 stdarg.h 头文件中定义的。
使用 va_arg 宏和 va_list 变量来访问参数列表中的每个项。
使用宏 va_end 来清理赋予 va_list 变量的内存。
```

### 实例1

```
实例: (例子中的自定义参数传的是参数个数，用于函数中的for循环)
#include <stdio.h>
#include <stdarg.h>

double average(int num, ...)
{
	va_list valist;

	double sum = 0.0;
	int i;

	/*为num个参数初始化 valist*/
	va_start(valist, num);

	/*访问所有赋给valist的参数*/
	for (i=0; i<num; i++)
	{
		sum += va_arg(valist, int);
	}

	/*清理为valist保留的内存*/
	va_end(valist);

	return sum/num;
}

int main()
{
	printf("Average of 2, 3, 4, 5 = %f\n", average(4, 2,3,4,5));
	printf("Average of 5, 10, 15 = %f\n", average(3, 5,10,15));
}


结果:
Average of 2, 3, 4, 5 = 3.500000
Average of 5, 10, 15 = 10.000000
```

### 实例2

```
实例:
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

int demo(char *msg, ... )  
{  
    va_list argp;                    /* 定义保存函数参数的结构 */  
    int argno = 0;                    /* 纪录参数个数 */  
    char *para;                        /* 存放取出的字符串参数 */                                      
    va_start( argp, msg );          /* argp指向传入的第一个参数 */ 
    
    while (1) 
    {  
        para = va_arg( argp, char *);                 /* 取出当前的参数，类型为char *. */  
        if ( strcmp( para, "/0") == 0 )  
                                                      /* 采用空串指示参数输入结束 */  
            break;  
        printf("Parameter #%d is: %s\n", argno, para);  
        argno++;  
    }  
    va_end( argp );                                   /* 将argp置为NULL */  
    return 0;  
}

int main( void )  
{  
    demo("DEMO", "This", "is", "a", "demo!" ,"333333", "/0");  
}  


结果:
Parameter #0 is: This
Parameter #1 is: is
Parameter #2 is: a
Parameter #3 is: demo!
Parameter #4 is: 333333
```

## C内存管理

```
C 语言为内存的分配和管理提供了几个函数。这些函数可以在 <stdlib.h> 头文件中找到。

序号	    函数和描述
1	    void *calloc(int num, int size);
        在内存中动态地分配 num 个长度为 size 的连续空间，并将每一个字节都初始化为 0。所以它的结果是分配了 num*size 个字节长度的内存空间，并且每个字节的值都是0。

2	    void free(void *address); 
        该函数释放 address 所指向的内存块,释放的是动态分配的内存空间。

3	    void *malloc(int num); 
        在堆区分配一块指定大小的内存空间，用来存放数据。这块内存空间在函数执行完成后不会被初始化，它们的值是未知的。

4	    void *realloc(void *address, int newsize); 
        该函数重新分配内存，把内存扩展到 newsize。

注意：void * 类型表示未确定类型的指针。C、C++ 规定 void * 类型可以通过类型转换强制转换为任何其它类型的指针。
```

### 动态分配内存

```
编程时，如果您预先知道数组的大小，那么定义数组时就比较容易。例如，一个存储人名的数组，它最多容纳 100 个字符，所以您可以定义数组，如下所示：
char name[100];
但是，如果您预先不知道需要存储的文本长度，例如您向存储有关一个主题的详细描述。在这里，我们需要定义一个指针，该指针指向未定义所需内存大小的字符，后续再根据需求来分配内存，如下所示：


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
 
int main()
{
   char name[100];
   char *description;
 
   strcpy(name, "Zara Ali");
 
   /* 动态分配内存 */
   description = (char *)malloc( 200 * sizeof(char) );
   if( description == NULL )
   {
      fprintf(stderr, "Error - unable to allocate required memory\n");
   }
   else
   {
      strcpy( description, "Zara ali a DPS student in class 10th");
   }
   printf("Name = %s\n", name );
   printf("Description: %s\n", description );
}

结果:
Name = Zara Ali
Description: Zara ali a DPS student in class 10th

上面的程序也可以使用 calloc() 来编写，只需要把 malloc 替换为 calloc 即可。
```

### 重新调整内存的大小和释放内存

```
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
 
int main()
{
   char name[100];
   char *description;
 
   strcpy(name, "Zara Ali");
 
   /* 动态分配内存 */
   description = (char *)malloc( 30 * sizeof(char) );
   if( description == NULL )
   {
      fprintf(stderr, "Error - unable to allocate required memory\n");
   }
   else
   {
      strcpy( description, "Zara ali a DPS student.");
   }
   /* 假设您想要存储更大的描述信息 */
   description = (char *) realloc( description, 100 * sizeof(char) );
   if( description == NULL )
   {
      fprintf(stderr, "Error - unable to allocate required memory\n");
   }
   else
   {
      strcat( description, "She is in class 10th");
   }
   
   printf("Name = %s\n", name );
   printf("Description: %s\n", description );
 
   /* 使用 free() 函数释放内存 */
   free(description);
}


结果:
Name = Zara Ali
Description: Zara ali a DPS student.She is in class 10th
```


## C命令行参数


```
命令行参数是使用 main() 函数参数来处理的，其中，argc 是指传入参数的个数，argv[] 是一个指针数组，指向传递给程序的每个参数。
```

```
#include <stdio.h>

int main( int argc, char *argv[] )  
{
   if( argc == 2 )
   {
      printf("The argument supplied is %s\n", argv[1]);
   }
   else if( argc > 2 )
   {
      printf("Too many arguments supplied.\n");
   }
   else
   {
      printf("One argument expected.\n");
   }
}

结果:
kaiqigu@bogon:~/dododo/cfile|⇒  ./f_9 
One argument expected.
kaiqigu@bogon:~/dododo/cfile|⇒  ./f_9 aaa
The argument supplied is aaa
kaiqigu@bogon:~/dododo/cfile|⇒  ./f_9 aaa bbb
Too many arguments supplied.
```

```
注意: 多个命令行参数之间用空格分隔，但是如果参数本身带有空格，那么传递参数的时候应把参数放置在双引号 "" 或单引号 '' 内部。
```


## C排序算法

### 冒泡排序

```
冒泡排序（英语：Bubble Sort）是一种简单的排序算法。它重复地走访过要排序的数列，一次比较两个元素，如果他们的顺序（如从大到小、首字母从A到Z）错误就把他们交换过来。
过程演示：
```

```
实例
#include <stdio.h>
void bubble_sort(int arr[], int len) {
    int i, j, temp;
    for (i = 0; i < len - 1; i++)
        for (j = 0; j < len - 1 - i; j++)
            if (arr[j] > arr[j + 1]) {
                temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
}

int main() {
    int arr[] = { 22, 34, 3, 32, 82, 55, 89, 50, 37, 5, 64, 35, 9, 70 };
    int len = (int) sizeof(arr) / sizeof(*arr);
    bubble_sort(arr, len);
    int i;
    for (i = 0; i < len; i++)
        printf("%d ", arr[i]);
    return 0;
}
```


### 选择排序

```
选择排序（Selection sort）是一种简单直观的排序算法。它的工作原理如下。首先在未排序序列中找到最小（大）元素，存放到排序序列的起始位置，然后，再从剩余未排序元素中继续寻找最小（大）元素，然后放到已排序序列的末尾。以此类推，直到所有元素均排序完毕。
过程演示：
```


```
实例
void swap(int *a,int *b) //交換兩個變數
{
    int temp = *a;
    *a = *b;
    *b = temp;
}

void selection_sort(int arr[], int len) 
{
    int i,j;
 
    for (i = 0 ; i < len - 1 ; i++) 
    {
        int min = i;
        for (j = i + 1; j < len; j++)     //走訪未排序的元素
            if (arr[j] < arr[min])    //找到目前最小值
                min = j;    //紀錄最小值
           swap(&arr[min], &arr[i]);    //做交換
    }
}
```

### 插入排序

```
插入排序（英语：Insertion Sort）是一种简单直观的排序算法。它的工作原理是通过构建有序序列，对于未排序数据，在已排序序列中从后向前扫描，找到相应位置并插入。插入排序在实现上，通常采用in-place排序（即只需用到 {\displaystyle O(1)} {\displaystyle O(1)}的额外空间的排序），因而在从后向前扫描过程中，需要反复把已排序元素逐步向后
挪位，为最新元素提供插入空间。
```


```
实例
void insertion_sort(int arr[], int len){
    int i,j,temp;
    for (i=1;i<len;i++){
            temp = arr[i];
            for (j=i;j>0 && arr[j-1]>temp;j--)
                    arr[j] = arr[j-1];
            arr[j] = temp;
    }
}
```

### 希尔排序

```
希尔排序，也称递减增量排序算法，是插入排序的一种更高效的改进版本。希尔排序是非稳定排序算法。
希尔排序是基于插入排序的以下两点性质而提出改进方法的：
插入排序在对几乎已经排好序的数据操作时，效率高，即可以达到线性排序的效率
但插入排序一般来说是低效的，因为插入排序每次只能将数据移动一位
```


```
实例
void shell_sort(int arr[], int len) {
    int gap, i, j;
    int temp;
    for (gap = len >> 1; gap > 0; gap = gap >> 1)
        for (i = gap; i < len; i++) {
            temp = arr[i];
            for (j = i - gap; j >= 0 && arr[j] > temp; j -= gap)
                arr[j + gap] = arr[j];
            arr[j + gap] = temp;
        }
}
```

### 归并排序

```
把数据分为两段，从两段中逐个选最小的元素移入新数据段的末尾。
可从上到下或从下到上进行。
```

```
迭代法
int min(int x, int y) {
    return x < y ? x : y;
}
void merge_sort(int arr[], int len) {
    int* a = arr;
    int* b = (int*) malloc(len * sizeof(int));
    int seg, start;
    for (seg = 1; seg < len; seg += seg) {
        for (start = 0; start < len; start += seg + seg) {
            int low = start, mid = min(start + seg, len), high = min(start + seg + seg, len);
            int k = low;
            int start1 = low, end1 = mid;
            int start2 = mid, end2 = high;
            while (start1 < end1 && start2 < end2)
                b[k++] = a[start1] < a[start2] ? a[start1++] : a[start2++];
            while (start1 < end1)
                b[k++] = a[start1++];
            while (start2 < end2)
                b[k++] = a[start2++];
        }
        int* temp = a;
        a = b;
        b = temp;
    }
    if (a != arr) {
        int i;
        for (i = 0; i < len; i++)
            b[i] = a[i];
        b = a;
    }
    free(b);
}
```

```
递归法
void merge_sort_recursive(int arr[], int reg[], int start, int end) {
    if (start >= end)
        return;
    int len = end - start, mid = (len >> 1) + start;
    int start1 = start, end1 = mid;
    int start2 = mid + 1, end2 = end;
    merge_sort_recursive(arr, reg, start1, end1);
    merge_sort_recursive(arr, reg, start2, end2);
    int k = start;
    while (start1 <= end1 && start2 <= end2)
        reg[k++] = arr[start1] < arr[start2] ? arr[start1++] : arr[start2++];
    while (start1 <= end1)
        reg[k++] = arr[start1++];
    while (start2 <= end2)
        reg[k++] = arr[start2++];
    for (k = start; k <= end; k++)
        arr[k] = reg[k];
}
void merge_sort(int arr[], const int len) {
    int reg[len];
    merge_sort_recursive(arr, reg, 0, len - 1);
}
```

### 快速排序

```
在区间中随机挑选一个元素作基准，将小于基准的元素放在基准之前，大于基准的元素放在基准之后，再分别对小数区与大数区进行排序。
```

```
迭代法
typedef struct _Range {
    int start, end;
} Range;
Range new_Range(int s, int e) {
    Range r;
    r.start = s;
    r.end = e;
    return r;
}
void swap(int *x, int *y) {
    int t = *x;
    *x = *y;
    *y = t;
}
void quick_sort(int arr[], const int len) {
    if (len <= 0)
        return; // 避免len等於負值時引發段錯誤（Segment Fault）
    // r[]模擬列表,p為數量,r[p++]為push,r[--p]為pop且取得元素
    Range r[len];
    int p = 0;
    r[p++] = new_Range(0, len - 1);
    while (p) {
        Range range = r[--p];
        if (range.start >= range.end)
            continue;
        int mid = arr[(range.start + range.end) / 2]; // 選取中間點為基準點
        int left = range.start, right = range.end;
        do
        {
            while (arr[left] < mid) ++left;   // 檢測基準點左側是否符合要求
            while (arr[right] > mid) --right; //檢測基準點右側是否符合要求
 
            if (left <= right)
            {
                swap(&arr[left],&arr[right]);
                left++;right--;               // 移動指針以繼續
            }
        } while (left <= right);
 
        if (range.start < right) r[p++] = new_Range(range.start, right);
        if (range.end > left) r[p++] = new_Range(left, range.end);
    }
}
```

```
递归法
void swap(int *x, int *y) {
    int t = *x;
    *x = *y;
    *y = t;
}
void quick_sort_recursive(int arr[], int start, int end) {
    if (start >= end)
        return;
    int mid = arr[end];
    int left = start, right = end - 1;
    while (left < right) {
        while (arr[left] < mid && left < right)
            left++;
        while (arr[right] >= mid && left < right)
            right--;
        swap(&arr[left], &arr[right]);
    }
    if (arr[left] >= arr[end])
        swap(&arr[left], &arr[end]);
    else
        left++;
    if (left)
        quick_sort_recursive(arr, start, left - 1);
    quick_sort_recursive(arr, left + 1, end);
}
void quick_sort(int arr[], int len) {
    quick_sort_recursive(arr, 0, len - 1);
}
```


## 补充

### 求数组长度及字符串长度

```
#include <stdio.h>
#include <string.h>

int main()
{
	int arr[4] = {1, 2, 3, 4};
	char str[5] = "hello";
	int len_arr, len_str;

	len_arr = (int) (sizeof(arr)/sizeof(*arr));
	len_str = strlen(str);

	printf("len_arr: %d\n", len_arr);
	printf("len_str: %d\n", len_str);

	return 0;
}


结果:
len_arr: 4
len_str: 5


求字符串长度的第二种方法:
// 计算字符串 s1 长度
for(i = 0; s1[i] != '\0'; ++i);


例:
#include <stdio.h>
int main()
{
    char s1[100], s2[100], i, j;
 
    printf("输入第一个字符串: ");
    scanf("%s", s1);
 
    printf("输入第二个字符串: ");
    scanf("%s", s2);
 
    // 计算字符串 s1 长度
    for(i = 0; s1[i] != '\0'; ++i);
 
    for(j = 0; s2[j] != '\0'; ++j, ++i)
    {
        s1[i] = s2[j];
    }
 
    s1[i] = '\0';
    printf("连接后: %s", s1);
 
    return 0;
}
```

### 字符串与数组的区别

```
1) 字符串以字符"\0"结尾。
2) 赋初值方式不同。
```

### 注意点

```
数组名就是首地址
```

### 改变变量本身值的方法(通过地址)

```

void swap(int *a,int *b) //交換兩個變數
{
    int temp = *a;
    *a = *b;
    *b = temp;
}

void selection_sort(int arr[], int len) 
{
    int i,j;
 
    for (i = 0 ; i < len - 1 ; i++) 
    {
        int min = i;
        for (j = i + 1; j < len; j++)     //走訪未排序的元素
            if (arr[j] < arr[min])    //找到目前最小值
                min = j;    //紀錄最小值
           swap(&arr[min], &arr[i]);    //做交換
    }
}


函数传参传地址是为了改变参数本身的值，若只传值，不会改变其本身，而是对相同值的变量进行操作。
```

### 指针及数组/字符串操作实例

```
#include <stdio.h>

const int MAX = 3;

int main()
{
	int var[] = {10, 100, 200};
	int i, *ptr;

	/*指针中的数组地址*/
	ptr = var;

	for (i=0; i<MAX; i++)
	{
		printf("存储地址: var[%d] = %p\n", i, ptr);
		printf("存储值: var[%d] = %d\n", i, *ptr);
		
		/*移动到下一个位置*/
		ptr++;
	}

	return 0;
}

==========================================

#include <stdio.h>
 
const int MAX = 3;
 
int main ()
{
   int  var[] = {10, 100, 200};
   int  i, *ptr;
 
   /* 指针中最后一个元素的地址 */
   ptr = &var[MAX-1];
   for ( i = MAX; i > 0; i--)
   {
 
      printf("存储地址：var[%d] = %p\n", i-1, ptr );
      printf("存储值：var[%d] = %d\n", i-1, *ptr );
 
      /* 移动到下一个位置 */
      ptr--;
   }
   return 0;
}

==========================================
#include <stdio.h>
 
const int MAX = 3;
 
int main ()
{
   int  var[] = {10, 100, 200};
   int  i, *ptr;
 
   /* 指针中第一个元素的地址 */
   ptr = var;
   i = 0;
   while ( ptr <= &var[MAX - 1] )
   {
 
      printf("Address of var[%d] = %p\n", i, ptr );
      printf("Value of var[%d] = %d\n", i, *ptr );
 
      /* 指向上一个位置 */
      ptr++;
      i++;
   }
   return 0;
}

==========================================
#include <stdio.h>

int max(int x, int y)
{
	return x>y ? x:y;
}

int main(void)
{
	/*p是函数指针*/
	int (*p)(int, int) = &max;  //&可以省略
	int a, b, c, d;

	printf("请输入三个数字:");
	scanf("%d %d %d", &a, &b, &c);

	/*与直接调用函数等价, d = max(max(a, b), c)*/
	d = p(p(a, b), c);

	printf("最大的数字是: %d\n", d);

	return 0;
}

==========================================
#include <stdio.h>
#include <string.h>
 
int main ()
{
   char str1[12] = "Hello";
   char str2[12] = "World";
   char str3[12];
   int  len ;
 
   /* 复制 str1 到 str3 */
   strcpy(str3, str1);
   printf("strcpy( str3, str1) :  %s\n", str3 );

   /* 连接 str1 和 str2 */
   strcat( str1, str2);
   printf("strcat( str1, str2):   %s\n", str1 );
 
   /* 连接后，str1 的总长度 */
   len = strlen(str1);
   printf("strlen(str1) :  %d\n", len );
 
   return 0;
}

==========================================
#include <stdio.h>
 
int main()
{
   int data[5], i;
   printf("输入元素: ");
 
   for(i = 0; i < 5; ++i)
     scanf("%d", data + i);
 
   printf("你输入的是: \n");
   for(i = 0; i < 5; ++i)
      printf("%d\n", *(data + i));
 
   return 0;
}

==========================================
#include <stdio.h>

int main()
{
	char array[5] = "hello";
	printf("array[5] = %s\n", array);

	return 0;
}

==========================================
#include <stdio.h>

int main()
{
	char array[5] = "hello";
	char *p = &array[1];

	printf("array[5] = %c\n", *p);

	return 0;
}

==========================================
#include <stdio.h>

int main()
{
	char array[5] = "hello";
	char *p = &array[1];

	printf("array[5] = %s\n", p);

	return 0;
}

==========================================
#include <stdio.h>

int main()
{
	char *p = "hello";
	printf ("*p = %s\n", p);

	return 0;
}

==========================================
#include <stdio.h>

int main()
{
	char array[5] = "hello";
	char *p = array;

	printf("array[5] = %s\n", p);

	return 0;
}

==========================================
#include <stdio.h>

int main()
{
	char array[5] = "hello";
	char *p = &array[0];

	printf("array[5] = %s\n", p);

	return 0;
}

==========================================
#include <stdio.h>

int main()
{
	char array[5] = "hello";
	char *p = array;

	printf("array[5] = %s\n", p);

	return 0;
}

==========================================
#include <stdio.h>
 
int main()
{
   int data[5], i;
   printf("输入元素: ");
 
   for(i = 0; i < 5; ++i)
     scanf("%d", &data[i]);
 
   printf("你输入的是: \n");
   for(i = 0; i < 5; ++i)
      printf("%d\n", data[i]);
 
   return 0;
}

==========================================
#include <stdio.h>
 
int main()
{
   int data[5], i;
   printf("输入元素: ");
 
   for(i = 0; i < 5; ++i)
     scanf("%d", data + i);
 
   printf("你输入的是: \n");
   for(i = 0; i < 5; ++i)
      printf("%d\n", *(data + i));
 
   return 0;
}

==========================================
注意:
data[5] = “hello”中
data[1]为值，data+1为地址(取值用*)。


#include <stdio.h>

int main()
{
	char data[5] = "hello";
	
	char *p = &data[0];
	char *q = data;

	for(int i=0; i<5; i++)
	{
		printf("%c\n", *p);
		p++;
		printf("%c\n", *(q+i));
		printf("%c\n", data[i]);
		printf("%c\n", *(data+i));
	}
}

==========================================
#include<stdio.h>
 
void cyclicSwap(int *a,int *b,int *c);
 
int main()
{
    int a, b, c;
 
    printf("输入 a, b 和 c 的值: ");
    scanf("%d %d %d",&a,&b,&c);
 
    printf("交换前:\n");
    printf("a = %d \nb = %d \nc = %d\n",a,b,c);
 
    cyclicSwap(&a, &b, &c);
 
    printf("交换后:\n");
    printf("a = %d \nb = %d \nc = %d",a, b, c);
 
    return 0;
}
void cyclicSwap(int *a,int *b,int *c)
{
 
    int temp;
 
    // 交换
    temp = *b;
    *b = *a;
    *a = *c;
    *c = temp;
}

==========================================
#include<stdio.h>
 
void test(int *a);
 
int main()
{
    int a;
 
    printf("输入a: ");
    scanf("%d",&a);

	test(&a);

    return 0;
}

void test(int *a)
{
	printf("%p\n", a);
	printf("%d\n", *a);
}


结果:
输入a: 1
0x7ffee38a8aa8
1


注释:
p=point
也就是用来输出指针的
格式为16进制。 
输出值为地址。 
用%p的好处是，可以根据系统位数，确定地址长度，而正确输出整体指针值。

与%p最类似的是%x。 不过%x是针对int的，如果是64位系统，只能输出低32位。

```