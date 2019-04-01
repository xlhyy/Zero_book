# 内置函数


- func.py

```
# coding=utf-8

def func1():
    print 'call func1'

def func2():
    print 'call func2'

def func3():
    print 'call func3'


### call_func.py
import func

def main():
    fc = getattr(func, 'func1', None)
    fc()

main()
```


- 内置函数

```
30 31 55 57    property   bytearray  compile  memoryview


5.staticmethod()
python staticmethod返回函数的静态方法。
该方法不强制要求传递参数，如下声明一个静态方法:
In [18]: class C(object):
    ...:     @staticmethod
    ...:     def f():
    ...:         print('Hello World')
    ...:         

In [19]: C.f() # 静态方法无需实例化
Hello World

In [20]: c = C()

In [21]: c.f() # 也可以实例化后调用
Hello World

6.all()
用于判断给定的可迭代参数iterable中的所有元素是否都为True，如果是返回True，否则返
回False。
元素除了是0，空，FALSE外都算True。
In [22]: all(['a','b','','d'])
Out[22]: False

In [23]: all(['a','b','c','d'])
Out[23]: True

In [24]: all([])
Out[24]: True

In [25]: all(())
Out[25]: True

7.enumerate()
枚举函数
In [32]: seq = ['one','two','three']

In [33]: for i,element in enumerate(seq):
    ...:     print i,element
    ...:     
0 one
1 two
2 three

8.int()

9.ord()
以一个字符(长度为1的字符串)作为参数，返回ASCII码值，或者Unicode数值。
In [34]: ord('a')
Out[34]: 97

10.str()

11.any()
一真即真，全假为假
In [35]: any(['a','b','c'])
Out[35]: True

In [36]: any(['a','','c'])
Out[36]: True

In [37]: any([False,'',0])
Out[37]: False

12.eval()
返回表达式的值
In [40]: eval('3*7')
Out[40]: 21

In [41]: n = 91

In [42]: eval('n+2')
Out[42]: 93

13.isinstance()
判断两个类型是否相同
isinstance()与type()区别:
	type()不会认为子类是一种父类类型，不考虑继承关系。
	isinstance()会认为子类是一种父类类型，考虑继承关系。
如果要判断两个类型是否相同，推荐使用isinstance()。
In [45]: class A:
    ...:     pass
    ...: class B(A):
    ...:     pass
    ...: 

In [46]: isinstance(A(),A)
Out[46]: True

In [47]: isinstance(B(),A)
Out[47]: True

14.pow()
pow(x,y)方法返回x的y次方的值。
In [66]: pow(2,3)
Out[66]: 8

15.sum()
In [67]: sum([0,1,2])
Out[67]: 3

In [68]: sum((2,3,4),1)
Out[68]: 10

16.basestring()
basestring()方法是str和unicode的超类(父类)，可以被用来判断一个对象是否为str或者unicode的实例，isinstance(obj,basestring)等价于isinstance(obj,(str,unicode))。
In [69]: isinstance('hello',str)
Out[69]: True

In [70]: isinstance('hello',basestring)
Out[70]: True

In [71]: isinstance('hello',unicode)
Out[71]: False

In [72]: isinstance(u'hello',unicode)
Out[72]: True

17.execfile()
execfile(文件名):用来执行一个文件。

18.issubclass()
issubclass(class,classinfo):用于判断参数class是否是类型参数classinfo的子类。
In [73]: class A:
    ...:     pass
    ...: class B(A):
    ...:     pass
    ...: 

In [74]: issubclass(B,A)
Out[74]: True

19.print()

20.super()

21.bin()
In [76]: bin(10)
Out[76]: '0b1010'

In [77]: bin(20)
Out[77]: '0b10100'

22.file()
它有一个别名:open()

23.iter()
用来生成迭代器

24.tuple()

25.bool()
In [78]: bool(0)
Out[78]: False

In [79]: bool(1)
Out[79]: True

In [80]: issubclass(bool,int)
Out[80]: True

26.filter()
语法:filter(function, iterable)
In [82]: def is_odd(n):
    ...:     return n%2 == 1
    ...: newlist = filter(is_odd,[1,2,3,4,5])
    ...: 

In [83]: newlist
Out[83]: [1, 3, 5]

27.len()

28.range()

29.type()

30.

31.

32.float()

33.list()

34.raw_input()

35.unichr()
unichr()函数和chr()函数功能基本一样，只不过是返回unicode的字符。
In [88]: unichr(12)
Out[88]: u'\x0c'

In [89]: unichr(97)
Out[89]: u'a'

36.callable()
用于检查一个对象是否是可调用的。

37.format()
格式化函数
In [92]: '{0},{1}'.format('hello','world')
Out[92]: 'hello,world'

In [93]: '{:.2f}'.format(3.1415926)
Out[93]: '3.14'

In [94]: class A(object):
    ...:     def __init__(self,value):
    ...:         self.value = value
    ...: a = A(6)
    ...: 

In [95]: 'value为: {0.value}'.format(a)
Out[95]: 'value\xe4\xb8\xba: 6'

38.locals()
会以字典类型返回当前位置的全部局部变量。

39.reduce()
用传给reduce中的函数function(有两个参数)先对集合中的1，2个元素进行操作，得到的结果再与第三个数据用function函数运算，最后得到一个结果。
In [98]: def add(x, y):
    ...:     return x + y
    ...: 

In [99]: reduce(add, [1,2,3,4,5])
Out[99]: 15

In [100]: reduce(lambda x, y: x+y, [1,2,3,4,5])
Out[100]: 15

40.chr()
用一个范围在range(256)内的整数作参数，返回值是当前整数对应的ascii字符。
In [107]: print chr(0x30), chr(0x31), chr(0x61) # 十六进制
0 1 a

In [108]: print chr(48), chr(49), chr(97) # 十进制
0 1 a

41.frozenset()
返回一个冻结的集合，冻结后集合不能再添加或删除任何元素。
语法:class forzenset(iterable)
返回值:返回新的frozenset对象，如果不提供任何参数，默认会生成空集合。
In [120]: a = frozenset(range(5))

In [121]: a
Out[121]: frozenset({0, 1, 2, 3, 4})

In [122]: len(a)
Out[122]: 5

In [123]: for i in a:
     ...:     print i
     ...:     
0
1
2
3
4

42.long()
描述:将数字或数字字符串转换为一个长整形。
In [128]: long()
Out[128]: 0L

In [129]: long(1)
Out[129]: 1L

In [130]: long('123')
Out[130]: 123L

43.reload()
reload(module):用于重新载入之前载入的模块。

44.vars()
语法:vars()
用于返回对象属性和属性值的键值对组成的字典对象。
In [152]: x = 1

In [153]: temp = vars()

In [154]: temp['x']
Out[154]: 1

45.classmethod修饰符
classmethod修饰符对应的函数不需要实例化，不需要self参数，但第一个参数是表示自身类的cls参数。
In [166]: class A(object):
     ...:     bar = 1
     ...:     def func1(self):
     ...:         print('hello func1')
     ...:     @classmethod
     ...:     def func2(cls):
     ...:         print('hello func2')
     ...:         print(cls.bar)
     ...:         cls().func1()
     ...: 

In [167]: A.func2()
hello func2
1
hello func1

46.getattr()
返回一个对象属性值
In [172]: class A(object):
     ...:     bar = 1
     ...: a = A()
     ...: 

In [173]: getattr(a,'bar')
Out[173]: 1

In [174]: getattr(a,'bar2')
---------------------------------------------------------------------------
AttributeError                            Traceback (most recent call last)
<ipython-input-174-11317c24acf5> in <module>()
----> 1 getattr(a,'bar2')

AttributeError: 'A' object has no attribute 'bar2'

In [175]: getattr(a,'bar2',2)
Out[175]: 2

47.map()
第一个参数function以参数序列中的每一个元素调用function函数，返回包含每次function函数返回值的新列表。
In [176]: def square(x):
     ...:     return x ** 2
     ...: 

In [177]: map(square,[1,2,3,4,5])
Out[177]: [1, 4, 9, 16, 25]

In [178]: map(lambda x: x ** 2,[1,2,3,4,5])
Out[178]: [1, 4, 9, 16, 25]

48.repr()
描述:将对象转化为供解释器读取的形式。
返回值:返回一个对象的string格式。
In [179]: s = 'hello'

In [180]: repr(s)
Out[180]: "'hello'"

In [181]: dict = {'a':1,'b':2,'c':3}

In [182]: repr(dict)
Out[182]: "{'a': 1, 'c': 3, 'b': 2}"

In [183]: a = repr(s)

In [184]: a
Out[184]: "'hello'"

In [185]: a[0]
Out[185]: "'"

49.xrange()
函数用法与range()完全相同
不同的是xrange()生成的不是一个数组，而是一个生成器
语法:
In [202]: xrange(8)
Out[202]: xrange(8)

In [203]: list(xrange(8))
Out[203]: [0, 1, 2, 3, 4, 5, 6, 7]

In [204]: xrange(3,5)
Out[204]: xrange(3, 5)

In [205]: list(xrange(3,5))
Out[205]: [3, 4]

In [206]: xrange(0,6,2)
Out[206]: xrange(0, 6, 2)

In [207]: list(xrange(0,6,2))
Out[207]: [0, 2, 4]

50.cmp()
用于比较两个对象
In [208]: cmp(80,100)
Out[208]: -1

In [209]: cmp(100,80)
Out[209]: 1

In [210]: cmp(100,100)
Out[210]: 0

In [211]: cmp('a','b')
Out[211]: -1

In [212]: cmp('a','A')
Out[212]: 1

51.globals()
以字典类型返回当前位置的全部全局变量

52.max()
返回给定参数的最大值，参数可以为序列。
In [216]: max(80,100,100)
Out[216]: 100

In [217]: max(-80,-20,60)
Out[217]: 60

In [218]: max([11,23,18,44])
Out[218]: 44

53.reverse()
用于反向列表中的元素
In [219]: l = [123,'xyz','zara','abc','xyz']

In [220]: l.reverse()

In [221]: l
Out[221]: ['xyz', 'abc', 'zara', 'xyz', 123]

54.zip()
zip()函数用于将可迭代的对象作为参数，将对象中对应的元素打包成一个个元组，然后返回由这些元组组成的列表。
如果各个迭代器的元素个数不一致，则返回列表长度与最短的对象相同。
利用*号操作符，可以将元组解压为列表。
In [229]: a = [1,2,3]

In [230]: b = [4,5,6]

In [231]: c = [3,4,5]

In [232]: zipped = zip(a,b) # 打包为元组的列表

In [233]: zipped
Out[233]: [(1, 4), (2, 5), (3, 6)]

In [234]: zip(a,c) # 元素个数与最短的列表一致
Out[234]: [(1, 3), (2, 4), (3, 5)]

In [235]: zip(*zipped) # 与zip相反，*zipped可理解为解压，返回二维矩阵式
Out[235]: [(1, 2, 3), (4, 5, 6)]

55.

56.hasattr()
用于判断对象是否包含对应的属性
In [236]: class A(object):
     ...:     x = 1
     ...:     y = 2
     ...:     z = 3
     ...:     

In [237]: a = A()

In [238]: hasattr(a, 'x')
Out[238]: True

In [239]: hasattr(a, 'w')
Out[239]: False

In [240]: class A(object):
     ...:     def __init__(self):
     ...:         self.name = 'li'
     ...:         

In [241]: a = A()

In [242]: hasattr(a, 'name')
Out[242]: True

In [243]: hasattr(a, 'age')
Out[243]: False

57.

58.round()
返回浮点数的四舍五入值
In [248]: round(80.23456)
Out[248]: 80.0

In [249]: round(80.23456,2)
Out[249]: 80.23

In [250]: round(80.23456,4)
Out[250]: 80.2346

In [251]: round(-100.000056,3)
Out[251]: -100.0

59.__import__()
用于动态加载类和函数
如果一个模块经常变化就可以使用__import__()来动态导入
In [257]: import sys

In [258]: __import__('a') # 导入a.py模块
Out[258]: <module 'a' from 'a.py'>

60.complex()
用于创建一个值为real+imag*j的复数，或者转化一个字符串或数为复数。
如果第一个参数为字符串，则不需要指定第二个参数。
In [259]: complex(1,2)
Out[259]: (1+2j)

In [260]: complex(1)
Out[260]: (1+0j)

In [261]: complex('1')
Out[261]: (1+0j)

In [262]: complex('1+2j') # 注意:这个地方在'+'号两边不能有空格，否则会报错
Out[262]: (1+2j)

In [263]: complex(' 1+2j ')
Out[263]: (1+2j)

In [264]: complex('1 + 2j')
---------------------------------------------------------------------------
ValueError                                Traceback (most recent call last)
<ipython-input-264-fd0fa4b53d7c> in <module>()
----> 1 complex('1 + 2j')

ValueError: complex() arg is a malformed string

61.hash()
用于获取一个对象(字符串或者数值等)的哈希值。
hash()函数可以应用于数字，字符串和对象，不能直接应用于list，set，dictionary。
In [265]: hash(1) # 数字
Out[265]: 1

In [266]: hash('1') # 字符串
Out[266]: 6272018864

In [267]: hash('test')
Out[267]: 2314058222102390712

In [268]: hash(str([1,2,3])) # 集合
Out[268]: 1335416675971793195

In [269]: hash(str({'a':1})) # 字典
Out[269]: 2735334611319722934

In [270]: hash(str((1,2,3))) # 元组
Out[270]: 1046599932067235776

62.min()

63.set()

64.delattr()
用于删除属性
语法:delattr(object,name)
参数:object--对象  name--必须是对象的属性

65.help()
用于查看函数或模块用途的详细说明。
语法:help(object)

66.next()
返回迭代器的下一个项目。
语法:next(iterator[, default])
参数:iterator--可迭代对象  default--可选，用于设置在没有下一个元素时返回该默认值，如果不设置，又没有下一个元素则会触发StopIteration异常。

67.slice()
实现切片对象，主要用在切片操作函数里的参数传递。
语法:class slice(stop)  class slice(start, stop[, step])
参数:start--起始位置  stop--结束位置  step--间距
返回值:返回一个切片对象
In [271]: myslice = slice(5) # 设置截取5个元素的切片

In [272]: myslice
Out[272]: slice(None, 5, None)

In [273]: arr = range(10)

In [274]: arr
Out[274]: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

In [275]: arr[myslice] # 截取5个元素
Out[275]: [0, 1, 2, 3, 4]
```
