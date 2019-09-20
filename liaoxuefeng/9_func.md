# 函数


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

- map()

```
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

- reduce()

```
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

- filter()

```
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

- sorted()

```
sorted()函数就可以对list进行排序, 有返回值。

例子1:
>>> sorted([36, 5, -12, 9, -21], key=abs)
[5, 9, -12, -21, 36]

例子2:
>>> sorted(['bob', 'about', 'Zoo', 'Credit'], key=str.lower, reverse=True)
['Zoo', 'Credit', 'bob', 'about']
```


## 偏函数

```
需要简化时，使用functools.partial可以创建一个新的函数，这个新函数可以固定住原函数的部分参数，从而在调用时更简单。

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
