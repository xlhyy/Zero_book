# Go

##  Sublime text搭建Go语言开发环境

```
https://blog.csdn.net/u012855229/article/details/72642735
```

## 语言类型

```
Go语言是编译型的静态语言（和C语言一样），所以在运行Go语言程序之前，先要将其编译成二进制的可执行文件。
Go语言是面向过程的语言，但是可以通过struct和function实现面向对象。
```


## 语言优势

```
高并发编程
```


## go build与go run的区别

```
go build：命令用来启动编译，它可以将Go语言程序与相关依赖编译成一个可执行文件，然后手动执行。
go run：命令将编译和执行指令合二为一，会在编译之后立即执行Go语言程序，但是不会生成可执行文件。
```


## 数据类型

```
布尔
数字
字符串
派生类型（包括：指针、数组、结构化、Channel、函数、切片、接口、Map）
```


## 声明变量及赋值

### 单变量

```
var a
a = 100

var a = 100

var a int = 100

d := 100
```

### 多变量

```
var a, b, c = 1, 2, 3

a, b, c := 1, 2, 3

var a, b, c int
a, b, c = 1, 2, 3
```

### Go语言中变量可以在三个地方声明

```
函数内定义的变量称为局部变量；
函数外定义的变量称为全局变量；
函数定义中的变量称为形式参数。
```


## 值类型和引用类型

### 值类型

```
所有像int, float, bool, string这些基本类型都属于值类型，使用这些类型的变量直接指向存在内存中的值。
当使用=将一个变量的值赋值给另一个变量时，实际上是在内存中将变量的值进行了拷贝。
```

### 引用类型

```
引用类型的变量存储的是值所在的内存地址，或内存地址中第一个字所在的位置。（这个内存地址称为指针）。
当使用=时，只有引用（地址）被复制。
```


## 常量

### 普通常量

```
常量中的数据类型只可以是布尔、数字、字符串类型。
定义格式：const identifier [type] = value
```

### iota

```
iota，特殊常量，可以认为是一个可以被编译器修改的常量。
iota在const关键字出现时将被重置为0，const中每新增一行常量声明将使iota计数一次（iota可理解为const语句块中的行索引）。
```

### 实例

```
例子1:
package main

import (
	"fmt"
)

func main() {
	const (
		a = iota
		b = iota
		c = iota
	)
	fmt.Println(a, b, c)
}

0 1 2
```

```
例子2:
package main

import (
	"fmt"
)

func main() {
	const (
		a = 1
		b = iota
		c = iota
		d
		e
		f = 100
		g
		h
		i = "hello"
		j
		k = iota
		l
	)
	fmt.Println(a, b, c, d, e, f, g, h, i, j, k, l)
}

1 1 2 3 4 100 100 100 hello hello 10 11
```

```
例子3:
package main

import (
	"fmt"
)

func main() {
	const (
		i = 1<<iota
		j = 2<<iota
		k
		l
	)
	fmt.Println(i, j, k, l)
}

1 4 8 16
```


## 运算符

```
1）算术运算符
+ - * / % ++ --

2）关系运算符
== != > < >= <=

3）逻辑运算符
&& || !

4）位运算符
& | ^ << >>

5）赋值运算符
= += -= *= /= %= <<= >>= &= |= ^=

6）其他运算符
& 返回变量存储地址
* 指针变量(用来存储变量存储地址)
```

### 实例

```
例子:
package main

import (
	"fmt"
)

func main() {
	var a = 1
	var q *int
	q = &a

	fmt.Printf("a为%d\n", a)
	fmt.Printf("q为%d\n", q)
	fmt.Printf("*q为%d\n", *q)
}

a为1
q为824633811024
*q为1
```


## 运算符优先级

```
由高到低:
* / % << >> & &^
+ - | ^
== != < > <= >=
&&
||
```

```
注释：
&^（按位置零符号），将运算符左边数据相异的位保留，相同位清零。
a&^b 等同于 (a&b)^b
```


## Printf与Println的区别

```
Println: 可以打印出字符串，和变量。
Printf: 只可以打印出格式化的字符串,可以输出字符串类型的变量，不可以输出整形变量和整形。
```


## 条件语句

### if语句

```
if 布尔表达式 {
	xxx
}
```

### if...else语句

```
if 布尔表达式 {
	xxx
} else {
	xxx
}
```

### if语句嵌套

```
if 布尔表达式 {
    xxx
	if 布尔表达式 {
		xxx
	}
}
```

### switch语句

```
switch var1 {
    case value1:
        ...
    case value2:
        ...
}

switch语句中的表达式是可选的，可以省略。如果表达式被省略，则认为switch为true，并对每个case表达式求值，为真则执行相应的代码块,然后跳过剩下的case。
例子:
package main

import (  
    "fmt"
)

func main() {  
    num := 75
    switch {
    case num >= 0 && num <= 50:
        fmt.Println("num is greater than 0 and less than 50")
    case num >= 51 && num <= 100:
        fmt.Println("num is greater than 51 and less than 100")
    case num >= 101:
        fmt.Println("num is greater than 100")
    case num >= 51 && num <= 100:
        fmt.Println("num is greater than 51")
    }

}


num is greater than 51 and less than 100
```

```
Type Switch
用来判断某个interface变量中实际存储的变量类型。
switch x.(type) {
    case type1:
        xxx
    case type2:
        xxx
    default: //可选
        xxx
}

例子:
package main

import (
	"fmt"
)

func main() {
	var x interface{}

	switch x.(type) {
		case int:
			fmt.Printf("int")
		case nil:
			fmt.Printf("nil")
		default:
			fmt.Printf("default")
	}

}


nil
```

```
fallthrough
使用fallthrough回强制执行后面的case语句，fallthrough不会判断下一条case的表达式结果是否为true，而是直接执行（即默认为true直接执行）。
之后继续执行，遇到为false时停止case的判断。

例子:
package main

import (  
    "fmt"
)

func main() {  
    switch {
    case false:
    	fmt.Println("1")
    	fallthrough
    case true:
    	fmt.Println("2")
    	fallthrough
	case false:
    	fmt.Println("3")
    	fallthrough
	case true:
    	fmt.Println("4")
    case false:
    	fmt.Println("5")
    	fallthrough
    case true: 
    	fmt.Println("6")
    }
}

2
3
4
```


## 循环语句

### for循环

```
for condition {}
注释：若没有condition，默认为true。

例子：
package main

import (
	"fmt"
)

func main() {
	sum := 1
	for sum <= 10 {
		sum += sum
		fmt.Println(sum)
	}
	fmt.Println("result: ", sum)
}


2
4
8
16
result:  16
-------------------------------
for xxx; xxx; xxx {}

例子：
package main

import (
	"fmt"
)

func main() {
	sum := 0
	for i := 0; i <= 10; i++ {
		sum += i
	}
	fmt.Println(sum)
}

55
-------------------------------
for循环的range格式可以对slice、map、数组、字符串等进行迭代循环，格式如下：
for key, value := range oldMap {
    newMap[key] = value
}
```

### 循环嵌套

### 循环控制语句

```
break
continue
goto
```

```
例子：
package main

import (
	"fmt"
)

func main() {
	a := 1

	LOOP: for a < 10 {
		if a == 5 {
			// 跳过迭代
			a += 1
			goto LOOP  //此时作用同continue
		}
		fmt.Println(a)
		a ++
	}
}

1
2
3
4
6
7
8
9
```


## 函数

```
Go语言至少有个main()函数。
函数声明告诉了编译器函数的名称、返回类型、参数。
Go语言标准库提供了多种可动用的内置的函数。

Go语言函数定义格式如下：
func function_name([parameter list]) [return_types] {
    函数体
}
```

### 实例

```
例子1：
package main

import (
	"fmt"
)

func main() {
	a := 1
	b := 2
	var c int

	c = max(a, b)
	fmt.Println(c)
}

func max(num1, num2 int) int {
	var result int

	if num1 > num2 {
		result = num1
	} else {
		result = num2
	}

	return result
}

2
```

```
例子2：
package main

import (
	"fmt"
)

func main() {
	a, b := swap("hello", "world")
	fmt.Println(a, b)
}

func swap(s1, s2 string) (string, string) {
	return s2, s1
}

world hello
```


## 函数参数传递

```
调用函数，可以通过两种方式来传递参数：
值传递：值传递是指在调用函数时将实际参数复制一份传递到函数中，这样在函数中如果对参数进行修改，将不会影响到实际参数。
引用传递：引用传递是指在调用函数时将实际参数的地址传递到函数中，那么在函数中对参数所进行的修改，将影响到实际参数。
```

### 实例

```
例子（值传递）：
package main

import (
	"fmt"
)

func main() {
	a := 1
	b := 2
	fmt.Printf("交换前a的值：%d\n", a)
	fmt.Printf("交换前b的值：%d\n", b)

	swap(a, b)
	fmt.Printf("交换后a的值：%d\n", a)
	fmt.Printf("交换后b的值：%d\n", b)
}

func swap(s1, s2 int) {
	temp := s2
	s2 = s1
	s1 = temp
}

调用前a的值：1
调用前b的值：2
调用后a的值：1
调用后b的值：2
```

```
例子（引用传递）：
package main

import (
	"fmt"
)

func main() {
	a := 1
	b := 2
	fmt.Printf("交换前a的值：%d\n", a)
	fmt.Printf("交换前b的值：%d\n", b)

	swap(&a, &b)
	fmt.Printf("交换后a的值：%d\n", a)
	fmt.Printf("交换后b的值：%d\n", b)
}

func swap(s1, s2 *int) {
	temp := *s2
	*s2 = *s1
	*s1 = temp
}

交换前a的值：1
交换前b的值：2
交换后a的值：2
交换后b的值：1
```


## 函数闭包

```
Go语言支持匿名函数，可作为闭包。
匿名函数的优越性在于可以直接使用函数内的变量，不必申明。
```

### 实例

```
例子：
package main

import (
	"fmt"
)

func main() {
	nextNumber := getSequence()
	fmt.Println(nextNumber())
	fmt.Println(nextNumber())
	fmt.Println(nextNumber())

	nextNumber1 := getSequence()
	fmt.Println(nextNumber1())
	fmt.Println(nextNumber1())
	fmt.Println(nextNumber1())
}

func getSequence() func() int {
	i := 0
	return func() int {
		i += 1
		return i
	}
}


1
2
3
1
2
3
```


## 函数方法

```
Go语言中同时有函数和方法。一个方法就是一个包含了接受者的函数，接受者可以是命名类型或者结构体类型的一个值或者是一个指针。
所有给定类型的方法属于该类型的方法集。语法格式如下：

func (variable_name variable_data_type) function_name() [return_type] {
    函数体
}
```

### 实例

```
例子：（下面定义了一个结构体类型和该类型的一个方法）

package main

import (
	"fmt"
)

//定义结构体
type Circle struct {
	radius float64
}

func main() {
	var c1 Circle
	c1.radius = 10.00
	fmt.Println("圆的面积 =", c1.getArea())
}

func (c Circle) getArea() float64 {
	//c.radius即为Circle类型对象中的属性
	return 3.14 * c.radius * c.radius
}


圆的面积 = 314
```


## 数组

```
数组是具有相同唯一类型的一组已编号且长度固定的数据项序列，这种类型可以是任意的原始类型。例如：整形、字符串或者自定义类型。
```

### 声明数组

```
package main

import (
	"fmt"
)

func main() {
	var b [3]int
	for i:=0; i<3; i++ {
		b[i] = i
	}

	for i:=0; i<3; i++ {
		fmt.Println(b[i])
	}
	fmt.Println(b)
}


0
1
2
[0 1 2]
```

### 初始化数组

```
package main

import (
	"fmt"
)

func main() {
	var b = [3]string{"a", "b", "c"}

	for i:=0; i<3; i++ {
		fmt.Println(b[i])
	}
	fmt.Println(b)
}


a
b
c
[a b c]
```

### 多维数组

```
声明方式：
var variable_name [size1][size2]...[sizen] variable_type
```

```
实例：

package main

import (
	"fmt"
)

func main() {
	// 定义一个3行2列的数组
	var a = [3][2]int{{0, 1}, {2, 3}, {4, 5}}
	var i, j int

	for i = 0; i < 3; i++ {
		for j = 0; j < 2; j++ {
			fmt.Printf("a[%d][%d] = %d\n", i, j, a[i][j])
		}
	}
}


a[0][0] = 0
a[0][1] = 1
a[1][0] = 2
a[1][1] = 3
a[2][0] = 4
a[2][1] = 5
```

### 向函数传递数组

```
方式一：行参设定数组大小
viod myFunction(param [10]int)
{
    ...
}

方式儿：形参未设定数组大小
void myFunction(param []int)
{
    ...
}
```

```
实例：

package main

import (
	"fmt"
)

func main() {
	// 未定义长度的数组只能传给不限制数组长度的函数
	var arr1 = []int{1, 2, 3, 4, 5}
	setArray1(arr1)

	// 定义了长度的数组只能传给限制了相同数组长度的函数
	var arr2 = [5]int{1, 2, 3, 4, 5}
	setArray2(arr2)
}

func setArray1(arr []int) {
	fmt.Println("该未定义长度的数组长度为：", len(arr))
}

func setArray2(arr [5]int) {
	fmt.Println("该已定义长度的数组长度为：", len(arr))
}


该未定义长度的数组长度为： 5
该已定义长度的数组长度为： 5
```


## 指针

```
Go语言的取地址符是&，放到一个变量前使用就会返回相应变量的内存地址。
指针声明格式如下：
var var_name *var_type
```

```
实例：
package main

import (
	"fmt"
)

func main() {
	var a int = 1
	var p *int

	p = &a
	fmt.Println(p)
	fmt.Println(*p)
}


0xc000088008
1
```

### 空指针

```
当一个指针被定义后没有分配到任何变量时，它的值为nil。
nil指针也称为空指针。

空指针判断：
if(ptr != nil) //ptr不是空指针
if(ptr == nil) //ptr是空指针
```

```
实例：
package main

import (
	"fmt"
)

func main() {
	var p1 *int
	fmt.Println(p1)
	
	if p1 == nil {
		fmt.Println("p1是空指针")
	} else {
		fmt.Println("p1不是空指针")
	}

	var p2 *int
	a := 1
	p2 = &a
	fmt.Println(p2)
	fmt.Println(*p2)
	
	if p2 == nil {
		fmt.Println("p2是空指针")
	} else {
		fmt.Println("p2不是空指针")
	}
}


<nil>
p1是空指针
0xc000088020
1
p2不是空指针
```


### 指针数组

```
声明格式如下：
var ptr_name [size]*type
```

```
实例：
package main

import (
	"fmt"
)

const (
	MAX int = 3
)

func main() {
	a := []int{10, 20, 30}
	var i int
	var ptr [MAX]*int

	for i = 0; i < MAX; i++ {
		ptr[i] = &a[i]
	}

	for i = 0; i < MAX; i++ {
		fmt.Println(*ptr[i])
	}
}


10
20
30
```


### 指向指针的指针

```
如果一个指针变量存放的是另一个指针变量的地址，则称这个指针变量为指向指针的指针变量。
声明格式如下：
var ptr **int
```

```
实例：
package main

import (
	"fmt"
)

func main() {
	var a int
	var ptr *int
	var pptr **int

	a = 100

	ptr = &a
	pptr = &ptr

	fmt.Println(a)
	fmt.Println(*ptr)
	fmt.Println(**pptr)
}


100
100
100
```

### 指针作为函数参数

```
实例：
package main

import (
	"fmt"
)

func main() {
	a := 100
	b := 200
	fmt.Println("交换前a的值为：", a)
	fmt.Println("交换前b的值为：", b)

	swap(&a, &b)
	fmt.Println("交换后a的值为：", a)
	fmt.Println("交换后b的值为：", b)
}

func swap(x *int, y *int) {
	var temp int
	temp = *y
	*y = *x
	*x = temp
}


交换前a的值为： 100
交换前b的值为： 200
交换后a的值为： 200
交换后b的值为： 100
```

## 结构体

```
Go语言中数组可以存储同一类型的数据，但在结构体中可以为不同项定义不同的数据类型。
结构体是由一系列具有相同类型或不同类型的数据构成的数据集合。
```

```
结构体的定义格式如下：
type struct_variable_type struct {
    member definition
    member definition
    ...
    member definition
}

一旦定义了结构体类型，就能用于变量的声明，语法格式如下：
variable_name := structure_variable_type {value1, value2, ...}
或
variable_name := structure_variable_type {key1: value1, key2: value2, ...}
```

```
访问结构体成员的格式：
结构体.成员名
```

### 实例

```
package main

import (
	"fmt"
)

type Books struct {
	title string
	author string
	book_id int
}

func main() {
	fmt.Println(Books{"Python", "li", 1})
	fmt.Println(Books{title: "Python", author: "li", book_id: 1})
	fmt.Println(Books{title: "Python", author: "li"})
	fmt.Println(Books{title: "Python"})

	// var temp Books
	// temp = Books{"Python", "li", 1}
	temp := Books{"Python", "li", 1}
	fmt.Println(temp.title)
	fmt.Println(temp.author)
	fmt.Println(temp.book_id)
}


{Python li 1}
{Python li 1}
{Python li 0}
{Python  0}
Python
li
1
```

### 结构体作为函数参数

```
实例：

package main

import (
	"fmt"
)

type Books struct {
	title string
	author string
	book_id int
}

func main() {
	var book Books
	book = Books{"Python", "li", 1}
	printBook(book)
}

func printBook(book Books) {
	fmt.Println("title:", book.title)
	fmt.Println("author:", book.author)
	fmt.Println("book_id:", book.book_id)
}


title: Python
author: li
book_id: 1
```

### 结构体指针

```
格式如下：
var struct_pointer *Books
struct_pointer = &Book1
struct_pointer.title
```

```
package main

import (
	"fmt"
)

type Books struct {
	title string
	author string
	book_id int
}

func main() {
	var book Books
	book = Books {"Python", "li", 1}
	printBook(&book)
}

func printBook(book *Books) {
	fmt.Println("title:", book.title)
	fmt.Println("author:", book.author)
	fmt.Println("book_id:", book.book_id)
}


title: Python
author: li
book_id: 1
```


## 语言切片(Slice)

```
Go语言切片是对数组的抽象。
Go数组的长度不可改变，在特定场景这样的集合就不适用了。所以Go题哦那个了切片（动态数组）类型。
与数组相比，切片的长度是不固定的，可以追加元素，在追加时可能使切片的容量增大。
```

### 定义

```
1) 通过声明一个未指定大小的数组来定义切片
var slice1 []type
或
slice1 := []type

2) 通过make()函数来创建切片
var slice1 []type = make([]type, len)
或
slice1 := make([]type, len)

注释：
1) 可以指定最大容量cap(为可选参数)。
    make([]type, len, cap)
2) len是切片的初始长度。
```

### len()和cap()函数

```
切片是可索引的，并且可以由len()方法获取长度。
切片提供了计算容量的方法cap()可以测量切片最长可以达到多少。
```

### 空(nil)切片

```
一个切片在未初始前默认为nil，长度为0。

实例：
package main

import (
	"fmt"
)

func main() {
	var slice []int
	
	printSlice(slice)

	if(slice == nil) {
		fmt.Println("切片是空的")
	}
}

func printSlice(x []int) {
	fmt.Printf("len=%d cap=%d slice=%v\n", len(x), cap(x), x)
}


len=0 cap=0 slice=[]
切片是空的
```

### 切片截取

```
实例：

package main

import (
	"fmt"
)

func main() {
	slice := []int{0, 1, 2, 3, 4, 5, 6, 7, 8}
	printSlice(slice)

	fmt.Println("slice ==", slice)
	fmt.Println("slice[1:4] ==", slice[1:4])
	fmt.Println("slice[:3] ==", slice[:3])
	fmt.Println("slice[4:] ==", slice[4:])

	slice1 := make([]int, 0, 5)
	printSlice(slice1)

	slice2 := slice[:2]
	printSlice(slice2)

	slice3 := slice[2:5]
	printSlice(slice3)
}

func printSlice(x []int) {
	fmt.Printf("len=%d cap=%d slice=%v\n", len(x), cap(x), x)
}


len=9 cap=9 slice=[0 1 2 3 4 5 6 7 8]
slice == [0 1 2 3 4 5 6 7 8]
slice[1:4] == [1 2 3]
slice[:3] == [0 1 2]
slice[4:] == [4 5 6 7 8]
len=0 cap=5 slice=[]
len=2 cap=9 slice=[0 1]
len=3 cap=7 slice=[2 3 4]
```

### append()和copy()函数

```
如果想增加切片的容量，必须创建一个新的更大的切片并把原分片的内容都拷贝过来。
```

```
实例：（拷贝切片的copy方法和追加新元素的append方法）
package main

import (
	"fmt"
)

func main() {
	var slice []int
	printSlice(slice)

	//向空切片追加元素
	slice = append(slice, 0)
	printSlice(slice)

	//向切片添加一个元素
	slice = append(slice, 1)
	printSlice(slice)

	//向切片同时添加多个元素
	slice = append(slice, 2, 3, 4)
	printSlice(slice)

	//创建一个容量是之前切片两倍的切片
	slice2 := make([]int, len(slice), cap(slice)*2)

	//拷贝slice的内容到slice2
	copy(slice2, slice)
	printSlice(slice2)
}

func printSlice(x []int) {
	fmt.Printf("len=%d cap=%d slice=%v\n", len(x), cap(x), x)
}


len=0 cap=0 slice=[]
len=1 cap=1 slice=[0]
len=2 cap=2 slice=[0 1]
len=5 cap=6 slice=[0 1 2 3 4]  //注释：此时为6而不是5，是因为在追加时切片的容量增大了
len=5 cap=12 slice=[0 1 2 3 4]
```

## 范围(Range)

```
Go语言中range关键字用于for循环中迭代数组(array)、切片(slice)、通道(channel)或集合(map)的元素。
在数组和切片中它返回元素的索引和索引对应的值，在集合中返回key-value对。

注释：字符串是字符数组。
```

```
实例：
package main

import (
	"fmt"
)

func main() {
	var arr = [4]int{1, 2, 3, 4}

	for i, num := range arr {
		fmt.Println(i, num)
	}
}


0 1
1 2
2 3
3 4
```

## Map(集合)

```
Map是一种无序的键值对的集合。Map最重要的一点是通过key来快速检索数据，key类似于索引，指向数据的值。
Map是无序的，我们无法决定对其进行迭代的返回顺序，这是因为Map是使用hash表来实现的。
```

### 定义

```
1)
var map_variable map[key_data_type]value_data_type  //声明
map_variable = make(map[key_data_type]value_data_type)  //初始化

2)
map_variable := make(map[key_data_type]value_data_type)  //声明并初始化
```

### 实例

```
package main

import (
	"fmt"
)

func main() {
	c := make(map[string]string)

	c["a"] = "啊"
	c["o"] = "哦"

	for i := range c {
		fmt.Println(i)
	}

	for i, j := range c {
		fmt.Println(i, j)
	}

	i, j := c["a"]
	fmt.Println(i, j)

	i, j = c["c"]
	fmt.Println(i, j)

	i = c["c"]
	fmt.Println(i)

	i = c["a"]
	fmt.Println(i)
}


a
o
a 啊
o 哦
啊 true
 false

啊
```

### delete()函数

```
实例：

package main

import (
	"fmt"
)

func main() {
	c := make(map[string]string)

	c["a"] = "啊"
	
	fmt.Println(c["a"])
	delete(c, "a")
	fmt.Println(c["a"])
}


啊

```


## 递归函数

```
语法格式如下：
func recursion() {
    recursion()
}

func main() {
    recursion()
}

注释：在使用递归时，要设置递归条件，否则递归将陷入无限循环中。
```

### 实例

```
1) 阶乘

package main

import (
	"fmt"
)

func main() {
	i := 4
	fmt.Printf("%d的阶乘是%d\n", i, factorial(uint64(i)))
}

func factorial(i uint64)(result uint64) {
	if (i > 0) {
		result = factorial(i-1) * i
		return result
	}

	return 1
}


4的阶乘是24
```

```
2) 斐波那契数列
package main

import (
	"fmt"
)

func main() {
	for i := 0; i < 10; i++ {
		fmt.Println(fibonacci(i))
	}
}

func fibonacci(n int) int {
	if (n < 2) {
		return n
	}
	return fibonacci(n-2) + fibonacci(n-1)
}


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


## 类型转换

```
类型转换用于将一种数据类型的变量转换为另外一种类型的变量，格式如下：
type_name(expression)
```

### 实例

```
package main

import (
	"fmt"
)

func main() {
	var sum int = 13
	var count int = 4
	var result int
	var result2 float32

	result = sum/count
	fmt.Println(result)

	result2 = float32(sum)/float32(count)
	fmt.Println(result2)
}


3
3.25
```


## 接口

```
接口是Go语言提供的一种数据类型，它把所有的具有共性的方法定义在一起，任何其他类型只要实现了这些方法就是实现了这个接口。
```

```
实现格式为：

//定义接口
type interface_name interface {
    method_name1 [return_type]
    ...
    method_namen [return_type]
}

//定义结构体
type struct_name struct {
    ...
}

//实现接口方法
func (struct_name_variable struct_name) method_name1() [return_type] {
    ...
}
...
func (struct_name_variable struct_name) method_namen() [return_type] {
    ...
}
```

### 实例

```
package main

import (
	"fmt"
)

type Phone interface {
	call()
}

type NokiaPhone struct {}

func (nokiaPhone NokiaPhone) call() {
	fmt.Println("nokiaPhone call")
}

type IPhone struct {}

func (iPhone IPhone) call() {
	fmt.Println("iPhone call")
}

func main() {
	var phone Phone

	phone = new(NokiaPhone)
	phone.call()

	phone = new(IPhone)
	phone.call()
}


nokiaPhone call
iPhone call
```

## 错误处理

### 使用defer与recover()

```
错误处理前：
package main

import (
	"fmt"
)

func main() {
	test()
	fmt.Println("发生异常之后的代码")
}

func test() {
	num1 := 10
	num2 := 0
	result := num1/num2
	fmt.Println(result)
}


panic: runtime error: integer divide by zero
（异常后程序崩溃退出）
```

```
错误处理后：
package main

import (
	"fmt"
)

func main() {
	test()
	fmt.Println("发生异常之后的代码")
}

func test() {
	defer func() {
		err := recover()
		if err != nil {
			fmt.Println(err)
		}
	}()

	num1 := 10
	num2 := 0
	result := num1/num2
	fmt.Println(result)
}


runtime error: integer divide by zero
发生异常之后的代码
（异常后程序继续执行）
```

### 自定义错误

```
1、errors.New("错误说明")，会返回一个error类型的值，表示一个错误
2、panic()内置函数，可以接收error类型的变量，输出错误信息，并退出程序。
```

```
package main

import (
	"fmt"
	"errors"
)

func main() {
	test()
	fmt.Println("main()后面的代码")
}

func test() {
	num1 := 10
	num2 := 0

	err := isZero(num2)
	if err != nil {
		panic(err)
	}

	fmt.Printf("%d/%d = %d\n", num1, num2, num1/num2)
	fmt.Println("test()后面的代码")
}

func isZero(i int) (err error) {
	if i == 0 {
		return errors.New("除数为0")
	} else {
		return nil
	}
}


panic: 除数为0

goroutine 1 [running]:
main.test()
	/Users/kaiqigu/Desktop/go/test.go:19 +0x5a
main.main()
	/Users/kaiqigu/Desktop/go/test.go:9 +0x22
exit status 2
（异常后程序崩溃退出）
```


## 并发

```
Go语言支持并发，我们只需要通过go关键字来开启goroutine即可。
goroutine是轻量级线程，goroutine的调度是由Golang运行时进行管理的。

goroutine语法格式：
go 函数名(参数列表)

例如：
go f(x, y, z)
开启一个新的goroutine：
f(x, y, z)

Go允许使用go语句开启一个新的运行期线程，即goroutine，以一个不同的、新创建的goroutine来执行一个函数。
同一个程序中的所有goroutine共享同一个地址空间。
```

```
实例：
package main

import (
	"fmt"
	"time"
)

func main() {
	go say("hello")
	say("world")
	say("qqq")
}

func say(s string) {
	for i := 0; i < 5; i++ {
		time.Sleep(100 * time.Millisecond)
		fmt.Println(s)
	}
}


hello
world
world
hello
hello
world
world
hello
hello
world
qqq
qqq
qqq
qqq
qqq
```

### 通道(channel)

```
通道(channel)是用来传递数据的一个数据结构。
通道可用于两个goroutine之间通过传递一个指定类型的值来同步运行和通讯。
操作符<-用于指定通道的方向，发送或接受。

ch <- v  //把v发送到通道ch
v := <-ch  //从ch接收数据并把值赋给v

声明一个通道很简单，使用chan关键字即可，通道在使用前必须先创建：
ch := make(chan int)

注意：默认情况下，通道是不带缓存区的。发送端发送数据，同时必须有接收端相应的接收数据。
```

```
实例：
package main

import (
	"fmt"
)

func sum(s []int, c chan int) {
	sum := 0
	for _, v := range s {
		sum += v
	}
	c <- sum  //把sum发送到通道c
}

func main() {
	s := []int{7, 2, 8, -9, 4, 0}

	c := make(chan int)
	go sum(s[:len(s)/2], c)
	go sum(s[len(s)/2:], c)

	x, y := <-c, <-c  //从通道c冲接收

	fmt.Println(x, y, x+y)
}


-5 17 12
```

### 通道缓存区

```
通道可以设置缓存区，通过make的第二个参数指定缓存区大小：
ch := make(chan int, 100)

带缓存区的通道允许发送端的数据发送和接收端的数据获取处于异步状态，就是说发送端发送的数据可以放在缓存区里面，可以等待接收端去获取数据，而不是立刻需要接收端去获取数据。
不过由于缓存区的大小是有限的，所以还是必须有接收端来接收数据的，否则缓存区一满，数据发送端就无法再发送数据了。

注意：
如果通道不带缓冲，发送方回阻塞知道接收方从通道中接收了值。
如果通道带缓冲，发送方则会阻塞直到发送的值被拷贝到缓冲区内；如果缓冲区已满，则意味着需要等待直到某个接收方获取到一个值。接收方在有值可以接收之前会一直阻塞。
```

```
实例：
package main

import (
	"fmt"
)

func main() {
	//定义一个可以存储整数类型的带缓冲通道
	ch := make(chan int, 2)

	//因为ch是带缓冲的通道，我们可以同时发送两个数据，而不用立刻需要去同步读取数据
	ch <- 1
	ch <- 2

	//获取这两个数据
	fmt.Println(<-ch)
	fmt.Println(<-ch)
}


1
2
```


### 遍历通道与关闭通道

```
Go通过range关键字来实现遍历读取到的数据，类似于数组或切片。格式如下：
v, ok := <-ch

如果通道接收不到数据后ok为false，这时通道就可以使用close()函数来关闭。
```

```
实例：
package main

import (
	"fmt"
)

func main() {
	c := make(chan int, 10)
	go fibonacci(cap(c), c)
	//range函数遍历每个从通道接收到的数据，因为c在发送完10个数据之后就关闭了通道，所以这里我们range函数在接收到10个数据之后就结束了。
	//如果上面的c通道不关闭，那么range函数就不会结束，从而在接收第11个数据的时候会阻塞。

	for i := range c {
		fmt.Println(i)
	}
}

func fibonacci(n int, c chan int) {
	x, y := 0, 1
	for i := 0; i < n; i++ {
		c <- x
		x, y = y, x+y
	}
	close(c)
}


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

