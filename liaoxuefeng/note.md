# python查缺

https://www.liaoxuefeng.com/wiki/1016959663602400

## python数据类型

```
number（数字）、string（字符串）、Boolean（布尔值）、None（空值）
list（列表）、tuple（元组）、dict（字典）、set（集合）
```

## set集合的基本操作

```
set是一个无序且不重复的元素集合
注意在创建空集合的时候只能使用s=set()，因为s={}创建的是空字典

1. 比较
se = {11, 22, 33}
be = {22, 55}
temp1 = se.difference(be)        #找到se中存在，be中不存在的集合，返回新值
print(temp1)        #{33, 11}
print(se)        #{33, 11, 22}

temp2 = se.difference_update(be) #找到se中存在，be中不存在的集合，覆盖掉se
print(temp2)        #None
print(se)           #{33, 11},


2. 删除
discard()、remove()、pop()
se = {11, 22, 33}
se.discard(11)
se.discard(44)  # 移除不存的元素不会报错
print(se)

se = {11, 22, 33}
se.remove(11)
se.remove(44)  # 移除不存的元素会报错
print(se)

se = {11, 22, 33}  # 移除末尾元素并把移除的元素赋给新值
temp = se.pop()
print(temp)  # 33
print(se) # {11, 22}


3. 取交集
se = {11, 22, 33}
be = {22, 55}

temp1 = se.intersection(be)             #取交集，赋给新值
print(temp1)  # 22
print(se)  # {11, 22, 33}

temp2 = se.intersection_update(be)      #取交集并更新自己
print(temp2)  # None
print(se)  # 22


4. 判断
se = {11, 22, 33}
be = {22}

print(se.isdisjoint(be))        #False，判断是否不存在交集（有交集False，无交集True）
print(se.issubset(be))          #False，判断se是否是be的子集合
print(se.issuperset(be))        #True，判断se是否是be的父集合


5. 合并
se = {11, 22, 33}
be = {22}

temp1 = se.symmetric_difference(be)  # 合并不同项，并赋新值
print(temp1)    #{33, 11}
print(se)       #{33, 11, 22}

temp2 = se.symmetric_difference_update(be)  # 合并不同项，并更新自己
print(temp2)    #None
print(se)             #{33, 11}


6. 取并集
se = {11, 22, 33}
be = {22,44,55}

temp=se.union(be)   #取并集，并赋新值
print(se)       #{33, 11, 22}
print(temp)     #{33, 22, 55, 11, 44}


7. 更新
se = {11, 22, 33}
be = {22,44,55}

se.update(be)  # 把se和be合并，得出的值覆盖se
print(se)
se.update([66, 77])  # 可增加迭代项
print(se)


8. 集合的转换
se = set(range(4))
li = list(se)
tu = tuple(se)
st = str(se)
print(li,type(li))
print(tu,type(tu))
print(st,type(st))

OUTPUT:
[0, 1, 2, 3] <class 'list'>
(0, 1, 2, 3) <class 'tuple'>
{0, 1, 2, 3} <class 'str'>
```

## tuple元组

```
元组的元素不可修改，但是元组元素的元素是可以修改的

索引
name_tuple = (1,2,3)
print(name_tuple[0])


切片
name_tuple = (1,2,3)
print(name_tuple[0:2])


循环
for i in name_tuple:
    print(i)


长度
name_tuple = (1,2,3)
print(name_tuple[len(name_tuple)-1])


嵌套
元组的元素不可修改，但是元素的元素可以修改
In [7]: a
Out[7]: (11, 22, [1, 0])

In [8]: a[2] = ''
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
<ipython-input-8-7d45d04c9a4f> in <module>()
----> 1 a[2] = ''

TypeError: 'tuple' object does not support item assignment

In [9]: a[2] = []
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
<ipython-input-9-a3276450be37> in <module>()
----> 1 a[2] = []

TypeError: 'tuple' object does not support item assignment

In [10]: a[2] = [4, 5]
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
<ipython-input-10-25764ca527b4> in <module>()
----> 1 a[2] = [4, 5]

TypeError: 'tuple' object does not support item assignment

In [11]: a[2][0] = 4

In [12]: a[2][1] = 2

In [13]: a
Out[13]: (11, 22, [4, 2])
```


## 生成器

```
1. 列表[]变()后为生成器
>>> L = [x * x for x in range(10)]
>>> L
[0, 1, 4, 9, 16, 25, 36, 49, 64, 81]
>>> g = (x * x for x in range(10))
>>> g
<generator object <genexpr> at 0x1022ef630>
```

```
2. 生成器取值可以用print或next
1)
>>> g = (x * x for x in range(10))
>>> next(g)
0
>>> next(g)
1
>>> next(g)
4
>>> next(g)
9
>>> next(g)
16
>>> next(g)
25
>>> next(g)
36
>>> next(g)
49
>>> next(g)
64
>>> next(g)
81
>>> next(g)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
StopIteration

2)
>>> g = (x * x for x in range(10))
>>> for n in g:
...     print(n)
... 
0
1
4
9
16
25
36
49
64
81
```


```
3. 含有yield的函数是生成器(在每次调用next()的时候执行，遇到yield语句返回，再次执行时从上次返回的yield语句处继续执行。)
1)
def fib(max):
    n, a, b = 0, 0, 1
    while n < max:
        yield b
        a, b = b, a + b
        n = n + 1
    return 'done'

>>> f = fib(6)
>>> f
<generator object fib at 0x104feaaa0>

2)
def odd():
    print('step 1')
    yield 1
    print('step 2')
    yield(3)
    print('step 3')
    yield(5)

>>> o = odd()
>>> next(o)
step 1
1
>>> next(o)
step 2
3
>>> next(o)
step 3
5
>>> next(o)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
StopIteration


3)
把函数改成generator后，我们基本上从来不会用next()来获取下一个返回值，而是直接使用for循环来迭代:
def odd():
    print('step 1')
    yield 1
    print('step 2')
    yield(3)
    print('step 3')
    yield(5)

>>> for n in odd():
     print(n)

step 1
1
step 2
3
step 3
5
```


## 迭代器

```
表示的是一个数据流，可以把这个数据流看做是一个有序序列，但我们却不能提前知道序列的长度，只能不断通过next()函数实现按需计算下一个数据，所以Iterator的计算是惰性的，只有在需要返回下一个数据时它才会计算。

生成器都是Iterator对象，但list、dict、str虽然是Iterable，却不是Iterator
把list、dict、str等Iterable变成Iterator可以使用iter()函数


小结

凡是可作用于for循环的对象都是Iterable类型；
凡是可作用于next()函数的对象都是Iterator类型，它们表示一个惰性计算的序列；
集合数据类型如list、dict、str等是Iterable但不是Iterator，不过可以通过iter()函数获得一个Iterator对象。
Python的for循环本质上就是通过不断调用next()函数实现的，例如：

for x in [1, 2, 3, 4, 5]:
    pass

实际上完全等价于：

# 首先获得Iterator对象:
it = iter([1, 2, 3, 4, 5])
# 循环:
while True:
    try:
        # 获得下一个值:
        x = next(it)
    except StopIteration:
        # 遇到StopIteration就退出循环
        break
```


## 匿名函数lambda
```
lambda [arg1[, arg2, ... argN]]: expression

lambda是一个表达式，而不是一个语句（lambda is an expression, not a statement.）因此，lambda能够出现在Python语法不允许def出现的地方&mdash;&mdash;例如，在一个列表常量中或者函数调用的参数中。
lambda不能访问自有参数列表之外或全局名字空间里的参数

例子1:
In [25]: a = lambda x,y: x + y

In [26]: map(a, [2*x for x in range(5)], [2*x for x in range(5)])
Out[26]: [0, 4, 8, 12, 16]


例子2:
In [28]: l = [lambda x: x**2, lambda x: x**3, lambda x: x**4]

In [29]: for f in l:
    ...:     print f(2)
    ...:     
4
8
16
```

## 一些函数
```
map()

map()函数接收两个参数，一个是函数，一个是Iterable，map将传入的函数依次作用到序列的每个元素，并把结果作为新的Iterator返回。

例子1:
>>> def f(x):
...     return x * x
...
>>> r = map(f, [1, 2, 3, 4, 5, 6, 7, 8, 9])
>>> list(r)
[1, 4, 9, 16, 25, 36, 49, 64, 81]

例子2:
>>> list(map(str, [1, 2, 3, 4, 5, 6, 7, 8, 9]))
['1', '2', '3', '4', '5', '6', '7', '8', '9']
```

```
reduce()

reduce把一个函数作用在一个序列[x1, x2, x3, ...]上，这个函数必须接收两个参数，reduce把结果继续和序列的下一个元素做累计计算，其效果就是：
其效果就是：
reduce(f, [x1, x2, x3, x4]) = f(f(f(x1, x2), x3), x4)

例子1:
>>> from functools import reduce
>>> def add(x, y):
...     return x + y
...
>>> reduce(add, [1, 3, 5, 7, 9])
25

例子2:
>>> from functools import reduce
>>> def fn(x, y):
...     return x * 10 + y
...
>>> reduce(fn, [1, 3, 5, 7, 9])
13579
```


```
filter()

filter()函数用于过滤序列。
和map()类似，filter()也接收一个函数和一个序列。和map()不同的是，filter()把传入的函数依次作用于每个元素，然后根据返回值是True还是False决定保留还是丢弃该元素。

例子1:
def is_odd(n):
    return n % 2 == 1

list(filter(is_odd, [1, 2, 4, 5, 6, 9, 10, 15]))
# 结果: [1, 5, 9, 15]


例子2: (注意python2与python3的区别)
kaiqigu@bogon:~/dododo|⇒  cat tt_1.py 
# coding=utf-8

def is_odd(n):
	return n%2 == 1

if __name__ == '__main__':
	l = [1,2,3,4]
	tt = list(filter(is_odd, l))
	print(tt)
kaiqigu@bogon:~/dododo|⇒  python3 tt_1.py
[1, 3]
kaiqigu@bogon:~/dododo|⇒  python2 tt_1.py
[1, 3]


kaiqigu@bogon:~/dododo|⇒  cat tt_1.py 
# coding=utf-8

def is_odd(n):
	return n%2 == 1

if __name__ == '__main__':
	l = [1,2,3,4]
	tt = filter(is_odd, l)
	print(tt)
kaiqigu@bogon:~/dododo|⇒  python2 tt_1.py
[1, 3]
kaiqigu@bogon:~/dododo|⇒  python3 tt_1.py
<filter object at 0x102db5a20>
```

```
sorted()

sorted()函数就可以对list进行排序, 有返回值。

例子1:
>>> sorted([36, 5, -12, 9, -21], key=abs)
[5, 9, -12, -21, 36]

例子2:
>>> sorted(['bob', 'about', 'Zoo', 'Credit'], key=str.lower, reverse=True)
['Zoo', 'Credit', 'bob', 'about']
```


## 装饰器

```
在代码运行期间动态增加功能的方式，称之为“装饰器”（Decorator）。

例子1: 两层嵌套
def log(func):
    def wrapper(*args, **kw):
        print('call %s():' % func.__name__)
        return func(*args, **kw)
    return wrapper

@log
def now():
    print('2015-3-25')

>>> now()
call now():
2015-3-25

注: 把@log放到now()函数的定义处，相当于执行了语句：
now = log(now)


例子2: 三层嵌套(decorator本身需要传入参数时)
def log(text):
    def decorator(func):
        def wrapper(*args, **kw):
            print('%s %s():' % (text, func.__name__))
            return func(*args, **kw)
        return wrapper
    return decorator
    
@log('execute')
def now():
    print('2015-3-25')
    
>>> now()
execute now():
2015-3-25

注: 和两层嵌套的decorator相比，3层嵌套的效果是这样的：
>>> now = log('execute')(now)
```


## 偏函数

```
当函数的参数个数太多，需要简化时，使用functools.partial可以创建一个新的函数，这个新函数可以固定住原函数的部分参数，从而在调用时更简单。

例子:
int()函数默认按十进制转换：
>>> int('12345')
12345


但int()函数还提供额外的base参数，默认值为10。如果传入base参数，就可以做N进制的转换(N->10)：
>>> int('12345', base=8)
5349
>>> int('12345', 16)
74565


假设要转换大量的二进制字符串为十进制，每次都传入int(x, base=2)非常麻烦，于是，我们想到，可以定义一个int2()的函数，默认把base=2传进去：
def int2(x, base=2):
    return int(x, base)
这样，我们转换二进制就非常方便了：
>>> int2('1000000')
64
>>> int2('1010101')
85


functools.partial就是帮助我们创建一个偏函数的，不需要我们自己定义int2()，可以直接使用下面的代码创建一个新的函数int2：
>>> import functools
>>> int2 = functools.partial(int, base=2)
>>> int2('1000000')
64
>>> int2('1010101')
85
```
