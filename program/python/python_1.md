# python初级


```
目录
1. string__________________________________________________________1
2. list_____________________________________________________________5
3. tuple___________________________________________________________7
4. dictionary____________________________________________________8
5. 函数_________________________________________________________11
6. 局部变量和全局变量______________________________________14
7. 匿名函数____________________________________________________17
8. 文件IO______________________________________________________22
9. 文件操作____________________________________________________24
10. 面向对象__________________________________________________25
11. 异常________________________________________________________27
12. 列表生成式________________________________________________29
13. 模块________________________________________________________30

1-string
索引、切片、加乘、操作（增删改查）
1.增、删、改
（1）string.count(str, beg=0, end=len(string))
		##功能：统计字符串中出现str的次数，
		##beg 代表起点下标
		##end 代表终点下标
		##返回值：为统计的个数

（2）string.endswith(str, beg=0, end=len(string))
		##功能： 判断字符串是否以str结尾，如果是返回True ，如果不是返回False
		##beg 和 end同上 ##代表搜索范围
		##返回值为True或者False
	
	（3）string.startswith(str, beg=0,end=len(string))
		##功能：判断是否以start定字符串为开头，如果是返回True，不是返回False，beg和end同上
		##返回值为True或者False


	（4）string.find(str, beg=0, end=len(string))
		##功能：从左至右查找str第一次出现的位置下标，如果未找到返回-1
		### beg=0, end=len(string) ##同上，限制搜索范围
##若找到,返回索引下标  
##若未找到,返回-1

	（5）string.rfind(str, beg=0, end=len(string))	
		##功能：从右往左查找str第一次出现的位置下标，如果未找到返回-1
		### beg=0, end=len(string) ##同上，限制搜索范围
		###返回值同上

（6）string.index(str, beg=0, end=len(string))
		##功能：功能同find，从左向右查找，返回第一次出现字符串的下标
		##但是区别，如果str不存在，会报错
		##返回值为索引下标

	（7）string.rindex()
##返回值同上

（8）string.replace(str1, str2,  num=string.count(str1))
		 ##功能：将字符串中出现的str1 替换成str2，从左往右替换，num指最大替换的次数
		 ##返回值为更改之后的字符串

（9）string.split(str="", num=string.count(str))
		##功能：默认按空白符进行分割，若干个子字符串，组成一个列表
				#空白符包括 " " \n \t ..
		##num=string.count(str) ##指定分隔的次数，分隔str.count(str)次
		##返回值：是一个列表

	（10）string.splitlines()
		##功能：同split，但是指按换行符进行分割，返回值为列表
		##如果加个参数1，被分割的子字符串中，含有\n换行符

	（11）string.join(seq) 
		##功能：能够将序列(指list)中的字符串元素，用string连接起来
		##注意参数序列中的元素，必须为字符串
		##返回值为更改后的值
		
（12）string.lower()函数
		##功能:将字符串的所有大写转换成小写
		##返回值为更改后的值

	（13）string.upper()函数
		#功能：将字符串中的所有小写转换成大写
		##返回值为更改后的值

	（14）string.ljust(width)
		#功能：返回一个字符串的左对齐，并用" "空格将字符串填充至宽度为width的新字符串
		##返回值为更改后的值

	（15）string.rjust(width)
		#功能：返回一个字符串的右对齐，并用" "空格将字符串填充至宽度为width的新字符串
		##返回值为更改后的值

	（16）string.center(width)
		#功能：返回一个字符串的居中对齐，并用" "空格将字符串填充至宽度为width的新字符串
		##返回值为更改后的值

	（17）string.lstrip([chars])	
		##删除空白符
##返回值为更改后的值
In [203]: name = "    hello world     "
		In [204]: name.strip() #默认删除左右两侧的空白符
		Out[204]: 'hello world'
		In [205]: name.lstrip()##默认删除左侧的空白符
		Out[205]: 'hello world     '
		In [206]: name.rstrip()##默认删除右侧的空白符
		Out[206]: '    hello world'	

	（18）string.rstrip([chars])
		##删除空白符
		##返回值为更改后的值

	（19）string.strip([chars])
##删除空白符
##返回值为更改后的值



（20）string.partition(str)
		#默认从左往右
		##功能：将string分隔成str前，str 和str后三部分，的一个元组
		##返回值为更改后的值
		
	（21）string.rpatition(str)
		#从右往左
		##功能：将string分隔成str前，str 和str后三部分，的一个元组
		##返回值为更改后的值

	（22）string.isalpha()
		##功能：判断字符串是否全为字母
		##如果是返回True，不是返回False

	（23）string.isdigit()
		##功能：判断字符串是否全为数字
		##如果是返回True，不是返回False
		
	（24）string.isalnum()
		##功能：判断字符串是否全为数字和字母
		##如果是返回True，不是返回False
			
	（25）string.isspace()
		##功能：判断字符串是否全为空格
		##如果是返回True，不是返回False

	（26）string.title()
		##将字符串中每个单词的首字母大写
		##返回值为更改后的值

	（27）string.swapcase()
		##将字符串中的字母大写转小写，小写转大写
		##返回值为更改后的值

	（28）string.islower()
		##判断字符串中的字母是否全为小写
		##如果是返回True，不是返回False

（29）string.isupper()
		##判断字符串中的字母是否全为大写
		##如果是返回True，不是返回False
2.查
	（1）索引
	（2）遍历
	（3）in和not in










2-list
索引、切片、加乘、操作（增删改查）
1.增
(1) list.append(obj)
			#功能：将元素增加加到列表尾

		(2) list.insert(index,obj)
			#功能：将元素插入到列表的指定位置
			##index 代表插入位置的下标

		(3)list.extend(seq)
			#功能：将序列中的元素，整体添加到列表尾

2.删
		(1)list.pop(index)
			##功能：默认删除列表中的最后一个元素,
			##如果传递参数代表下标，删除指定下标的元素
			##注意pop函数的返回值为删除掉的元素

		(2)list.remove(obj)
		   ###功能：根据指定的元素值进行删除列表中的元素
		   ###删除从左到右的第一个obj
		   ###注意，没有返回值，和pop有区别

		(3) del 删除 
		   ##功能：对指定的元素进行删除

3.改
		   ##修改，直接根据下标索引，通过赋值的方式进行修改
		        name[0] = 1 

4.查
		(1)下标索引
		(2)in 和 not in
		(3)list.index(obj)
	   ##功能：查找obj元素在列表中出现的位置
		   ##如果存在返下标，不存在报错
		   ##返回值为出现元素的位置下标

列表相关的方法
		(1)list.sort()
		   #功能：进行列表排序
In [10]: nums.sort() ##默认从小到大进行排序
In [14]: nums.sort(reverse = True) ###如果传递参数，从大到小排序

		(2)list.reverse()
		   ##功能：将列表进行倒置

		(3)list.count(obj)
		   ##功能：统计列表中出现obj的次数
		   ##返回值为obj的个数

import random  ##random模块
In [16]: l1 = range(1,36) ##l1保存了1-35个数的列表
In [17]: random.sample(l1,7) ##sample函数，从列表中随机取出7个数，返回一个元素个数为7的列表
Out[17]: [23, 18, 34, 8, 3, 32, 20] 






























3-tuple
   索引、切片、加乘、操作（查）
1.查
		(1)tuple.count(obj)
			##功能：统计obj出现的次数
			##返回值为次数

		(2)tuple.index(obj,start = 0,end = len(t1))
			##功能：查找obj出现的位置，返回出现位置的下标
			##默认查找返回从左到右第一次出现的下标位置

































4-dictionary
索引、操作（增删改查）
key不可以为列表（因为可变）
1.增
	(1)key值不存在，直接进行相加
			##返回值为更改之后的值
			In [3]: d1 = {"gong":100,"xi":700}
In [4]: d1["fa"] = 1000 ##如果"fa" key 不存在，创建key并添加值为100 这个键值对
			In [5]: d1
			Out[5]: {'fa': 1000, 'gong': 100, 'xi': 700}
		
	(2)d1.update(d2) 
			#功能：将d2中的所有元素，添加添加到d1字典中
	#如果d2字典中的key和d1字典中的key出现重复，最后重复key的值为d2中的值。
			##返回值为更改之后的值

2.删
	（1）del  d1["score"]
			#删除key为”score”的键值对
#返回值为更改之后的值

	（2）dict.pop(key,default)
			#功能：删除指定key对应的键值对
			#返回值，为删除key对应的value，也就是值

	（3）dict.popitem()
			#功能：随机删除字典中的一个键值对 
			#返回值为有键值对组成的元组 (key,value)

	（4）dict.clear() 
			#功能:清空字典中的元素
			#返回值为修改后的值

	（5）del  d1 
			In [45]: d3 = {"age":10000,"hello":"world"}
In [46]: del d3 ###删除字典

3.改
		d1["name"] = 1000 ###如果"name"key 存在直接修改key对应的值

4.查
	(1)通过key
			通过key直接进行索引

	(2)dict.get(key, default=None)
			key -- 字典中要查找的键。
			##如果指定键的值不存在时，返回default。
			##如果default未定义返回默认值None，无显示。
			In [50]: d2
			Out[50]: {'age': 18, 'score': 100}

In [51]: d2.get("age") ##如果key存在，直接返回key对应的值
			Out[51]: 18

In [52]: d2.get("hello") ##如果key不存在默认返回None
In [53]: d2.get("hello","I miss you!!") ##如果key不存在
			Out[53]: 'I miss you!!'

	(3)dict.setdefault(key, default=None)
			key -- 查找的键值。
			default -- 键不存在时，设置的默认键值。
			如果字典中包含有给定键，则返回该键对应的值，否则返回为该键设置的值。
In [57]: d2
			Out[57]: {'age': 18, 'score': 100}

			In [58]: d2.setdefault("age") #如果key存在直接返回key的值
			Out[58]: 18

			In [59]: d2.setdefault("score")#如果key存在直接放回key的值
			Out[59]: 100

			In [60]: d2.setdefault("hello")
#如果key不存在，在字典中添加key和对应的
						#值为default的值，默认为None

			In [61]: d2	###返回值为添加key对应的值即None
			Out[61]: {'age': 18, 'hello': None, 'score': 100}

			In [62]: d2.setdefault("world",(1,2,3))
			Out[62]: (1, 2, 3) #如果key不存在，在字典中添加key和对应的值
						  #返回值为添加key对应value
In [63]: d2
			Out[63]: {'age': 18, 'hello': None, 'score': 100, 'world': (1, 2, 3)}

	(4)in 和 not in
			##判断的是字典中是否有存在key键
			返回True或者False
	
5. 字典相关函数
	（1）name.keys() 
		##得到key的列表

	（2）name.values() 
		##得到value的列表
		
	（3）name.items() 
		##得到key和value组成的元组列表
		例：[(‘a’,1),(‘b’,2)]
		
	（4）name.has_key(key)  ##python3中已经废除这个函数
		##判断字典中是否存在key，如果有返回True，没有返回False

6.创建字典的其他方法
	(1) dict()函数
		In [19]: dict() ###创建了一个空的字典
		Out[19]: {}

	(2)	dict.fromkeys(seq,value) 
		#以序列中的元素作为字典中的键，value为字典中对应键的值
		In [27]: d1
		Out[27]: {}

		In [28]: d1.fromkeys([1,2,3],"haha")
		Out[28]: {1: 'haha', 2: 'haha', 3: 'haha'}















5-函数
1.函数分为：
(1)定义好的函数；
(2)自定义函数；

2.函数的四种形式：
(1)无参数，无返回值
(2)有参数，无返回值
(3)有参数，有返回值
(4)无参数，有返回值

3.函数的嵌套调用

4.可变对象传递和不可变对象传递：
(1)在python中，类型属于对象，变量是没有类型的，变量与对象间是引用的关系。
(2)python中对象的三要素：
id #身份标识
type #类型
value #值
(3)不可变类型：int 注意：-5~256之间定义的时候指向同一对象
(4)可变类型：list,dictionary

5.递归函数：
(1)递归的两种方式：直接调用自己 间接调用自己
(2)递归注意事项：
    递归的缺点：
        (a)容易造成死循环
        (b)内存消耗比较高
    递归的注意事项：
	(a)要有递归结束条件

6.返回多个值的方法：
(1)方法一：
return a,b,c #默认返回的是一个元组
(2)方法二：
l1 = [a,b,c] #返回列表的引用
return l1
(3)方法三：
return [a,b,c]
(4)方法四：
return (a,b,c)

7.参数：
(1)必备参数：
实参和形参的个数相匹配。

(2)缺省参数：
如果函数缺省参数位置没有传递实参，则为默认值；如果传递了实参，则为实参的值。
#coding=utf-8
def test(a,b = 10):
	print a,b
def main():
	a = 1
	test(a,b)
main()

(3) 命名参数：
给指定的形参变量赋值。
使用命名参数的前提条件：实参命名参数的变量名必须与形参的变量名相同。

(4)不定长参数：*args与**kwargs
#coding=utf-8
def test(a,b,c = 20,*args,**kwargs):
	print a
	print b
	print c
	print args
	print kwargs
	#print type(args) #类型为元组
	#print type(kwargs) #类型为字典
def main():
	test(1,2,3,4,5,6,7,8,name = "zhangsan",age = 18)
	#name="zhangsan"和age=18会以键值对的形式保存到字典中
	#注意name和age变量名在形参列表中一定要不存在
	#如果存在那就是命名参数了
main()

输出结果：
	1
	2
	3
	(4,5,6,7,8)
	{‘age’:18,’name’:’zhangsan’}

8.元组和字典的拆包：
#coding=utf-8

def test(*arg,**kwargs):

	print"test函数中未赋值前的kwargs %s"%kwargs
	kwargs["age"] = 10000
	print"test函数中赋值后的kwargs %s"%kwargs

def main():

	t1 = (1,2,3)
	d1 = {"name":"zhangsan","age":18}
	print"调用test函数前打印的d1 %s"%d1

	#test(t1,d1) #如果不加* **,将t1和d1保存到args中,kwargs依然空字典
	test(*t1,**d1) #加上* **,相当于元组和字典的拆包
	print"调用test函数后打印的d1 %s"%d1 #注意:"age"的值没有被修改,说明为两个字典对象

main()

输出结果：
	调用test函数前打印的d1{‘age’:18,’name’:’zhangsan’}
	test函数中未赋值前的kwargs{‘age’:18,’name’:’zhangsan’}
	test函数中赋值后的kwargs{‘age’:10000,’name’:’zhangsan’}
	调用test函数后打印的d1{‘age’:18,’name’:’zhangsan’}




















6-局部变量和全局变量
1.局部变量：
(1)定义在函数内部的变量叫做局部变量；
(2)局部变量的作用域只在局部有效；

2.全局变量：
(1)定义在函数外的变量就是全局变量；
(2)作用域具有全局作用域；

3.列表和字典作全局变量：
(1)当列表和字典当做全局变量的时候，可以不需要global声明，可以直接对全局变量进行修改。
例1：
#coding=utf-8

l1 = []
d1 = {}

def fun1():

	d1["name"] = "张三"
	l1.append(1)

def fun2():

	d1["age"] = 17
	l1.append(2)

print("fun1和fun2调用前打印l1:%s"%l1)
print("fun1和fun2调用前打印d1:%s"%d1)

fun1()
print("fun1调用后打印l1:%s"%l1)
print("fun1调用后打印d1:%s"%d1)

fun2()
print("fun2调用后打印l1:%s"%l1)
print("fun2调用后打印d1:%s"%d1)

执行结果：
fun1和fun2调用前打印l1:[]
fun1和fun2调用前打印d1:{}
fun1调用后打印l1:[1]
fun1调用后打印d1:{'name': '张三'}
fun2调用后打印l1:[1,2]
fun2调用后打印d1:{'age': 17, 'name': '张三'}

    对于不可变类型的全局变量来说，因其指向的数据不能修改，所以不使用global时无法修改全局变量；
    对于可变类型的全局变量来说，因其指向的数据可以修改，所以不使用global时也可修改全局变量；

(2)如果不加global关键字相当于定义了两个局部变量l1和d1，如果加上了global关键字相当于修改了全局变量l1和d1的指向。(加global可以改变可变对象的数据类型，不加只可以对原有的对象的值进行修改)
例1:
#coding=utf-8

l1 = []
d1 = {}

def fun():

	global l1,d1
	l1 = 3
	d1 = "hello"

print(l1)
print(d1)
fun()
print(l1)
print(d1)

执行结果：
[]
{}
3
hello

例2:
#coding=utf-8

l1 = []
d1 = {}

def fun():

	l1 = 3
	d1 = "hello"

print(l1)
print(d1)
fun()
print(l1)
print(d1)

执行结果：
[]
{}
[]
{}






























7-匿名函数
1.匿名函数：lambda 参数:表达式
(1)匿名函数的返回值即为表达式的值；
(2)匿名函数都有返回值；

2.带参的匿名函数：
def getSum(num1,num2):
	return num1+num2
getSum(3,5)
与
func = lambda x,y: x+y
func(3,5)
等价

3.无参的匿名函数：
def print_hello():
	return "hello world!!"
与
func = lambda :"hello world!!"
func()
等价

4.将匿名函数当做参数传递：
#coding=utf-8

def getNum(num1,num2,func):
	result = func(num1,num2)
	return result

def main():
	result = getNum(3,5,lambda x,y:x+y)
	print(result)
	result = getNum(3,5,lambda x,y:x-y)
	print(result)
	result = getNum(3,5,lambda x,y:x*y)
	print(result)
	result = getNum(3,5,lambda x,y:x//y)
	print(result)

main()

输出结果：
8
-2
15
0

5.eval()函数：将字符串中的表达式进行求值，通过返回值的形式返回。
例：
eval("3+2")
5

eval("a")
报错:name 'a' is not defined

eval("[1,2,3,4]")
[1,2,3,4]

eval("(1,2,3)")
(1,2,3)

eval("3")
3

eval("2 == 4")
False

6.将匿名函数当做返回值：

例：求一个数的n次方
#coding=utf-8

def powerNum():
	return lambda n : 2 ** n #返回一个lambda引用

def main():
	func = powerNum()
	result = func(3)
	print(result)

main()

7.匿名函数与list.sort()
list.sort(cmp = None, key = None, reverse = False)

(1)列表排序中默认的reverse = False
l1.sort() # 默认按照列表元组中的第一个元素进行排序，从小到大。
l1.sort(reverse = True) # 按照列表元组中的第一个元素进行排序，从大到小。

(2)通过cmp排序:比较两个数的大小
例：
cmp(3,5) # 如果第一个参数小于第二个参数，返回-1
-1

cmp(3,3) # 如果第一个参数等于第二个参数，返回0
0

cmp(5,3) # 如果第一个参数大于第二个参数，返回1
1

l1 = [("zhangsan",78),("wangwu",56),("lisi",100)]
l1.sort(cmp = lambda x,y : cmp(x[1],y[1]))
输出:
l1 = [("wangwu",56),("zhangsan",78),("lisi",100)]

l1.sort(cmp = lambda x,y : cmp(x[0],y[0]))
输出:
l1 = [("lisi",100),("wangwu",56),("zhangsan",78)]

def fun(x,y):
	return cmp(x[1],y[1])
l1.sort(cmp = fun)

func = lambda x,y : cmp(x[0],y[0])
l1.sort(cmp = func)

(3)通过key排序

l1 = [("zhangsan",67),("lisi",100),("wangwu",30)]
l1.sort(key = lambda x : x[1])
输出:
l1 = [("wangwu",30),("zhangsan",67),("lisi",100)]

练习：字典列表排序
l1 = [{"name":"lisi","score":23},
	{"name":"zhangsan","score":89},
	{"name":"wangwu","score":100}]
d1.sort(cmp = lambda x,y : cmp(x["score"],y["score"]))
d1.sort(key = lambda x : x["score"])

8.内置函数filter函数
filter(function, iterable) # 函数 可迭代对象

    filter()函数用于过滤序列，过滤掉不符合条件的元素，返回由符合条件元素组成的新列表。
    该接收两个参数，第一个为函数，第二个为序列，序列的每个元素作为参数传递给函数进行判定。然后返回True或False,最后将返回True的元素放到新列表中。

例：
l1 = [12,4,546,12,5]

def func(num):
	if num > 10:
		return True
	else:
		return False
newl1 = filter(func,l1)
与
newl1 = filter(lambda x : x > 10, l1)
等价

9.内置函数reduce函数
reduce(function, sequence[, initial]) -> value

    reduce函数，reduce函数会对参数序列中元素进行累积。
    function参数是一个有两个参数的函数，reduce依次从sequence中取出一个元素，和上一次调用function后的结果一起做函数参数，再次调用function。
    第一次调用function时，如果提供initial参数，会以sequence中的第一个元素和initial作为参数调用function,否则会以序列sequence中的前两个元素做参数调用function。

例：
reduce(lambda x,y: x+y, [1,2,3,4,5]) # 如果没有第三个参数，取出列表前两个元素进行累加
输出:15
# ((((1+2)+3)+4)+5)

reduce(lambda x,y: x+y, [1,2,3,4,5], 10) # 如果有第三个参数，从第三个参数开始累加
输出:25
# (((((10+1)+2)+3)+4)+5)

10.内置函数map函数
map(function, sequence[, sequence, ...]) -> list
功能：map函数会根据提供的函数对指定序列做映射。

(1)单个序列：
    通过定义可以看到，这个函数的第一个参数是一个函数，剩下的参数是一个或多个序列，返回值是一个集合。
    function可以理解为是一个一对一或多对一函数，map的作用是以参数序列中的每一个元素调用function函数。
    返回包含每次function函数返回值的list。

例：
map(lambda x: x+1, [1,2,3,4,5])
输出:
[2,3,4,5,6]

(2)两个序列：
    在参数存在多个序列时，会依次以每个序列中相同位置的元素做参数调用function函数。

例：
map(lambda x,y: [1,2,3,4], [4,3,2,1])
输出:
[5,5,5,5]



























8-文件IO
1.主要针对于文件的操作：
打开文件 --- 读或写 --- 关闭文件

2.open函数：
需要先用python内置的open()函数打开一个文件，创建一个file对象，相关的辅助方法才可以调用它进行读写。
file object = open(file_name,access_mode)

各个参数的细节如下：
file_name:file_name变量是一个包含了你要访问的文件名称的字符串值。
access_mode:access_mode决定了打开文件的模式：
只读，写入，追加等。所有可取值如下，这个参数是非强制的，默认文件访问模式为只读(r)。
#打开文件的方式：
"r":以只读的方式打开文件；
"r+":以可读可写的方式打开文件；
"w":以只写的方式打开文件，如果文件存在，打开文件并清空文件，若文件不存在，创建文件并打开；
"w+":以可读可写的方式打开文件，如果文件存在，打开文件并清空文件，若文件不存在，创建文件并打开；
"a":以附加的方式打开文件，只写，如果文件存在，直接打开，写入内容追加到文本尾，若文件不存在，创建文件并打开；
"a+":以附加的方式打开文件，可读可写，如果文件存在，直接打开，写入内容追加到文本尾，若文件不存在，创建文件并打开；
"rb":上面的打开方式，如果加上b以二进制的方式打开；

3.读取文件：
(1)一次性读取：
例：content = f.read()
(2)每次读取n个字符：
例：content = f.read(10)

3.向文件中写入内容：
f.write(str)#向文件中写入内容，str为写入的字符串

4.关闭文件：
f.close()

5.如果python3,运行时复制音乐等文件需要加b,python2不用。
例：
fr = open(filename,"rb")
fw = open(newfilename,"wb") 

6.读取文件和写入的几种形式：
读取文件：
(1)readline([size])
功能：一次读取一行，size参数可以省略不写，如果写上size可能只读取一部分。
返回值：读取出的内容字符串。

(2)readlines()
功能：将读取的一行内容作为list的成员，返回一个列表。
返回值：返回值是一个列表。

写入文件：
(1)file.writelines(list)
功能：将序列中的内容写入到文件中，注意序列中元素的类型应为str。
#将字符串列表中的字符串内容写到文件中。

(2)file.flush()
功能：刷新缓存区，将缓存区中的内容，写入硬盘。
注意：关闭文件时,也会自动刷新缓存区。

7.file.seek() #注意python2和python3有不同(python3中参数只有0好用,且file.seek()有返回值)(python2和python3中文件首为0，文件尾为最后一个元素)
(1)概述：
seek()方法用于移动文件读取指针到指定位置。
(2)语法：
seek()方法语法如下：
fileObject.seek(offset,[whence])
(3)参数：
offset -- 开始的偏移量，也就是代表需要移动偏移的字节数。
whence -- 可选，默认值为0。
给offset参数一个定义，表示要从哪个位置开始偏移：0代表从文件开头开始算起；1代表从当前位置开始算起；2代表从文件末尾算起。
(4)返回值：
该函数没有返回值。

8.获取文件指针的位置：(文件指针指向文件首时，文件指针为0；文件指针指向文件尾时，为指向最后一个元素。)
file.tell()

9.写入系统时间：
import time
s = time.strftime("%Y-%m-%d %X",time.localtime())
print(s)


9-文件操作
1.import os
(1)文件重命名：
os.rename("原文件名","新文件名")
(2)删除文件：
os.remove("将要删除的文件名")
(3)创建文件夹：
os.mkdir("将要创建的文件夹的名字")
(4)删除空文件夹：
os.rmdir("删除将要删除的文件夹的名字")
(5)删除文件夹及子文件夹中的文件：(功能同rm -r hehe)
import shutil
shutil.rmtree("将要删除的文件夹名")
(6)获取当前目录：(功能同pwd)
os.getcwd()
(7)修改默认工作路径：
os.chdir("路径")
(8)获取目标目录下的文件列表：
os.listdir("目录名")
(9)移动文件或重命名：(相当于linux系统中的mv命令)
shutil.move("源文件","目的地")

2.命令行传参：
import sys
sys.argv
len(sys.argv)
sys.argv[x]
例：
	#coding=utf-8
	import sys
	if len(sys.argv) < 3:
		print(“请在命令行传递参数:”)
		exit()
	print(sys.argv[0])
	print(sys.argv[1])
	print(sys.atgv[2])
运行命令：
	python 04-命令行传参.py 1 1
输出结果：
	04-命令行传参.py
	1
	1

10-面向对象
1.在利用对象调用属性的时候：
    如果属性存在，相当于修改属性的值；
    如果属性不存在，相当于添加属性及值；

2.当私有属性和get，set方法配合使用时，实现了对数据的隐藏。
    当属性被设置成私有属性后，可以通过get和set方法进行获取和设置；或者通过对象._类名私有方法名调用，比如iphone4._Phone__sendmsg()
例:
	def setAge(self,newAge):
		self.age = newAge
	def getAge(self):
		return self.age

3.类内的方法可以调用类内的私有方法。

4.对全局变量与函数的关系  属性与方法之间的关系进行总结：
(1)全局变量　函数间共享，可以修改和使用；
(2)不同对象间的属性不相互共享；
(3)对象中的方法可以修改和设置属性的值，可以简单理解为属性是对象中局部的全局变量；

5.继承：
(1)公有属性和公有方法可以被继承；
(2)私有属性和私有方法不可以被继承；
调用：
(1)一个类的私有属性和私有方法可以在这个类内部被访问和调用；
(2)子类的方法不能调用父类的私有属性和私有方法；

6.子类重写了父类的方法之后，再想调用父类方法的三种形式：(父类:Animal 子类:Dog 被重写的方法:bark)
(1)Animal.bark(self)	python2和python3都可以使用
(2)super(Dog,self).bark()	python2和python3都可以使用(不过使用python2时，需要Animal继承object类)
(3)super().bark()	只能在python3中使用

7.当子类重写了父类的__init__方法时，若子类的__init__中没有父类__init__的某些属性，而子类又需要调用这个属性的时候，要在子类的__init__中调用父类的__init__。调用方法如下：
(1)Animal.__init__(self)	python2和python3都可以使用
(2)super(Dog,self).__init__()	python2和python3都可以使用
(3)super().__init__()	只能在python3中使用

8.多继承的调用顺序:
class E(object) ---> class A(E),class B(E),class C(E) ---> class C(A,B,D)
(1)python2中经典类用的是深度搜索：
	C ---> A ---> E ---> B ---> D
(2)python2中新式类和python3中，用的是广度搜索：
	C ---> A ---> B ---> D ---> E

9.在面向对象语言中，接口的多种不同的实现方式即为多态。
个人理解：同一类的对象，当接到不同的命令时，会产生不同的状态。

10.类属性和实例属性：
(1)使用类属性时，可以通过 类名.类属性 或者 实例对象.类属性 更改类属性的值；
(2)实例对象之间不共享实例属性；

11.实例属性/类属性/实例方法/类方法/静态方法：
(1)通常用实例方法修改实例属性；
(2)通常用类方法修改类属性；
(3)实例方法：只能通过实例对象调用；
(3)类方法：类名和实例对象都可以调用；
(4)静态方法：类名和实例对象都可以调用；

12.注意：当用实例对象修改类属性的时候，相当于在实例对象中添加了新属性，所以并没有修改类属性的值。

13.__new__方法：
(1)__new__是object类中的方法，new方法需要有返回值。
例：cls.__instance = object.__new__(cls)
    return cls.__instance
(2)__new__方法要比__init__方法先调用；
(3)如果__init__方法有参数需要给__new__方法也添加参数；

14.类方法和__new__方法后为(cls)。

15.面向对象语言的三个重点：封装 继承 多态

16.单例模式：
例：
#coding=utf-8

class Dog(object):

	#第一种方法
	__instance = 0
	__temp = None

	def __new__(cls,name):
		if cls.__instance == 0:
			cls.__instance += 1
			cls.__temp = object.__new__(cls)
			return cls.__temp
		else:
			return cls.__temp

	'''
	#第二种方法
	__instance = None
	def __new__(cls,name):
		if cls.__instance == None:
			cls.__instance = object.__new__(cls)
			return cls.__instance
		else:
			return cls.__instance
			'''
	
	def __init__(self,name):
		print("hello world")
		self.name = name
	
	def eat(self):
		print("eating...")
	
dog1 = Dog("张三")#dog1和dog2的id相同,说明创建单例对象成功,说明为同一个对象
print(id(dog1))
print(dog1.name)

dog2 = Dog("李四")
print(id(dog2))
print(dog2.name)

dog3 = Dog("王五")
print(dog3.name)

17.简单工厂模式：
（简单工厂模式是由一个工厂对象决定创建出哪一种产品类的实例。）

例：华为手机多型号
#coding=utf-8

class HuaWeiStore(object):
	#高内聚低耦合
	def order(self,phone_type):
		if phone_type == "P":
			return P()
		elif phone_type == "Honor":
			return Honor()

class HuaWeiPhone(object):
	def call(self):
		print("正在打电话...")
	
	def music(self):
		print("正在播放音乐...")

class P(HuaWeiPhone):
	def introduce(self):
		print("我是华为P系列的手机!")

class Honor(HuaWeiPhone):
	def introduce(self):
		print("我是华为Honor系列的手机!")

def main():
	hua_store = HuaWeiStore()

	P7 = hua_store.order("P")
	P7.call()
	P7.music()
	P7.introduce()

	Honor6 = hua_store.order("Honor")
	Honor6.call()
	Honor6.music()
	Honor6.introduce()

main()

函数解耦：
#coding=utf-8

class HuaWeiStore(object):
	#高内聚低耦合
	def order(self,phone_type):
		return select_by_type(phone_type)
	
#定义一个函数,进行解耦
def select_by_type(phone_type):
	if phone_type == "P":
		return P()
	elif phone_type == "Honor":
		return Honor()

class HuaWeiPhone(object):
	def call(self):
		print("正在打电话...")
	
	def music(self):
		print("正在播放音乐...")

class P(HuaWeiPhone):
	def introduce(self):
		print("我是华为P系列的手机!")

class Honor(HuaWeiPhone):
	def introduce(self):
		print("我是华为Honor系列的手机!")

def main():
	hua_store = HuaWeiStore()

	P7 = hua_store.order("P")
	P7.call()
	P7.music()
	P7.introduce()

	Honor6 = hua_store.order("Honor")
	Honor6.call()
	Honor6.music()
	Honor6.introduce()

main()

方法解耦：
#coding=utf-8

class HuaWeiStore(object):
	#高内聚低耦合
	def order(self,phone_type):
		return HuaWeiFactory().select_by_type(phone_type)

#定义一个类,方法进行解耦
class HuaWeiFactory():
	def select_by_type(self,phone_type):
		if phone_type == "P":
			return P()
		elif phone_type == "Honor":
			return Honor()

class HuaWeiPhone(object):
	def call(self):
		print("正在打电话...")
	
	def music(self):
		print("正在播放音乐...")

class P(HuaWeiPhone):
	def introduce(self):
		print("我是华为P系列的手机!")

class Honor(HuaWeiPhone):
	def introduce(self):
		print("我是华为Honor系列的手机!")

def main():
	hua_store = HuaWeiStore()

	P7 = hua_store.order("P")
	P7.call()
	P7.music()
	P7.introduce()

	Honor6 = hua_store.order("Honor")
	Honor6.call()
	Honor6.music()
	Honor6.introduce()

main()





11-异常
1.什么是异常?
异常即是一个事件，该事件会在程序执行过程中发生，影响了程序的正常运行。
一般情况下，在python无法正常处理程序时就会发生一个异常。
异常是python对象，表示一个错误。
当python脚本发生异常时我们需要捕获处理它，否则程序会终止执行。

2.如何捕获单个异常：
try:
	可能产生异常的代码
except 异常名称:
	捕获异常名称对应的异常后,执行的代码

3.如何捕获多个异常：
try:
	可能产生异常的代码
except(异常名称1,异常名称2,...):
	捕获其中的一个异常名称后就执行的代码

4.打印输出异常的基本信息：
try:
	xxxxxx
except ... as result:(...代表单个异常或多个异常)
	xxxxxx

5.如何捕获所有异常：
try:
	xxxxxx
except Exception as result:
	xxxxxx

6.try --- except --- else
当没有产生任何异常时，执行else语句的代码。

7.try --- finally
不管产不产生异常，都要执行finally语句的代码。

8.异常的传递：
(1)异常嵌套：
    对于try嵌套，如果里面的try语句捕获到异常，则进行相应的异常处理，如果没有捕获，则会传递给外面的try语句。
    如果内外异常判断语句进行判断的异常条件相同，则如果在内try里面已经捕获过了，在外try判断时将捕获不到异常。

(2)函数中的异常嵌套：
    如果一个异常是在一个函数中产生的，例如：A引用B，B引用C，而异常是在函数C中产生的，那么如果函数C中没有对这个异常进行处理，那么这个异常会传递到函数B中，如果函数B中有异常处理，那么就会按照函数B的处理方式进行执行；如果函数B也没有异常处理，那么这个异常会继续传递，以此类推...如果所有的函数都没有处理，那么此时就会进行异常的默认处理。

9.抛出自定义异常：
可以用raise语句来引发一个异常。异常对象必须有一个名字，且它们应是Exception类的子类。
例：
#coding=utf-8
class BigNumExcept(Exception):
	def __init__(self,num):
		self.num = num
	def __str__(self):
		return "您输入的数字%d大于35了"%self.num
def main():
	for i in range(5):
		num = input("请输入您要购买的彩票号码:")
		if num > 35:
			try:
				raise BigNumExcept(num) 
			except BigNumExcept as result:
				print(result)
注意：print(result)和print(BigNumExcept())效果相同。

















12-列表生成式
1. a1 = [i for i in range(1,20)]
  a2 = [i for i in "abcd"] #for前面的i表达式的值作为列表中的元素

2. b = [i*2 for i in range(1,20)]

3. c = [i for i in range(10) if not i%2] #先执行for循环一次，然后执行一次if条件判断

4. d = [i for i in range(3) for j in range(3)] #for循环嵌套

5. e = [(i,j,k) for i in range(3) for j in range(3) for k in range(3)] #三重for循环嵌套
































13-模块
1.导入模块的几种方式：
(1)import moudle1,moudle2
注意：导入模块后，会将模块中的所有代码都执行一遍；
(2)from module import fun1,fun2
导入模块中的部分函数到命名空间；
(3)from module import *
将模块中的所有导入到命名空间；

2.as 导入模块重命名
注意：不是永久改变。
例：import time as t
    t.sleep

3.__name__：
(1)当mytest作为模块被导入时，mytest模块中__name__等于模块名"mytest"；
(2)当直接用python解释器运行mytest.py时，mytest模块中__name__的值为"__main__"；

4.模块中的__all__变量与from module import *
导入的值取决于__all__变量的值，名字在列表里的可以被导入；
例：__all__ = ["print_star"]
如果__all__的值只有一个print_star，那么main.py即使from mytest import *，但是调用print_jing和Cat()时，会报异常。

5.关于模块定位：
(1)当前目录；
(2)如果当前目录找不到，python会查看默认路径。UNIX下，默认路径一般为/usr/local/lib/python/；
(3)模块搜索路径存储在system模块的sys.path变量中。变量里包含当前目录，PYTHONPATH和由安装过程决定的默认目录；

6.包：
包将有联系的模块组织在一起，即放到同一个文件夹下，并且在这个文件夹创建一个名字为__init__.py文件，那么这个文件夹就称之为包。

7.模块的发布
(1)mymodule模块如下
(2)编辑setup.py文件：(创建在和模块文件夹同一级下)
from distutils.score import setup
setup(name="liGe",version="5.0",description="liGe's module",author="liGe",py_modules=["helloTest.mytest","helloTest.youtest"])
(3)构建模块：(当前位置位于模块文件夹级)
python setup.py build
(4)生成发布压缩包：(当前位置位于模块文件夹级)
python setup.py sdist

8.模块的安装和使用：
(1)找到模块的压缩包
(2)解压
(3)进入文件夹
(4)执行命令，python setup.py install

知识点补充：
(1)
i = str(input())  可直接键盘上输入整数，从而将其转换为字符串；若直接输入字符，比如w 会报错；因为输入数据要根据python格式输入，比如 1 'w' 等。

(2)
In [1]: class A():
   ...:     pass
   ...: 

In [2]: a = A()

In [3]: a1 = a

In [4]: a2 = a

In [5]: a3 = a

In [6]: import sys

In [7]: sys.getrefcount(a)
Out[7]: 5

In [8]: del a

In [9]: sys.getrefcount(a1)

(3)删除执行文件时产生的错误信息：
例：rm .main.py.swp
```
