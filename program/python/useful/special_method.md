# 特殊方法


- __str__、__repr__

```
# coding=utf-8

# __str__()方法用于显示给用户，而__repr__()用于显示给开发人员。
# 如果一个对象没有__str__函数，而Python又需要调用它的时候，解释器会用__repr__作为替代。

class Person1(object):

    def __init__(self, name, gender):
        self.name = name
        self.gender = gender

    def __str__(self):
        return '(Person:%s,%s)'%(self.name, self.gender)

# In [2]: p = Person1('li',1)
#
# In [3]: p
# Out[3]: <__main__.Person at 0x7f616ac5e350>
#
# In [4]: print p
# (Person:li,1)

#-------------------------------------------

class Person2(object):
    def __init__(self, name, gender):
        self.name = name
        self.gender = gender

    def __str__(self):
        return '(Person:%s,%s)'%(self.name, self.gender)

    def __repr__(self):
        return '(Name:%s,%s)'%(self.name, self.gender)

# In [9]: p = Person2('wang',0)
#
# In [10]: p
# Out[10]: (name:wang,0)
#
# In [11]: print p
# (Person:wang,0)
```


- __cmp__

```
- python2

# coding=utf-8

# 对int及str等内置数据类型排序时，Python的sorted()按照默认的比较函数cmp排序。但是，如果对一组Student类的实例排序时，就必须提供我们自己的特殊方法__cmp__():

class Student(object):
    def __init__(self, name, score):
        self.name = name
        self.score = score

    def __str__(self):
        return '(%s:%s)'%(self.name, self.score)
    
    __repr__ = __str__

    def __cmp__(self, s):
        if self.score < s.score:
            return -1
        elif self.score > s.score:
            return 1
        else:
            return 0

L = [Student('Da', 88), Student('Er', 99), Student('San', 77)]
print sorted(L)

# 当只有__str__(),而没有__repr__()时:
# [<__main__.Student object at 0x7f356af81f90>, <__main__.Student object at 0x7f356af81f10>, <__main__.Student object at 0x7f356af81f50>]

# 当__str__()和__repr__()都存在时:
# [(San:77), (Da:88), (Er:99)]
```


```
- python3
class Student(object):
    
    def __init__(self, name, score):
        self.name = name
        self.score = score

    def __str__(self):
        return '(%s:%s)'%(self.name, self.score)

    __repr__ = __str__

    def __lt__(self, s):
        return self.score < s.score

    def __gt__(self, s):
        return self.score > s.score

    def eg(self, s):
        return self.score == s.score

L = [Student('Da', 88), Student('Er', 99), Student('San', 77)]
print(sorted(L))
# [(San:77), (Da:88), (Er:99)]
```


- __len__

```
# coding=utf-8

# 要让len()函数工作正常，类必须提供一个特殊的方法__len__()，它返回元素的个数。

class Student(object):

    def __init__(self, *args):
        self.names = args

    def __len__(self):
        return len(self.names)

L = Student('Da','Er','San')
print(len(L))
# 3

L2 = [1,2,3,4,5]
print(len(L2))
# 5
```


- @property

```
# coding=utf-8

# 当我们考虑隐秘性的时候，我们会使用__属性来保证该属性，不会被外在所访问。

class Student(object):

    def __init__(self, name, score):
        self.name = name
        self.__score = score

    @property
    def score(self):
        return self.__score

    @score.setter
    def score(self, score):
        if score < 0 or score > 100:
            raise ValueError('invalid score')
        self.__score = score

s = Student('li',60)
print(s.score)
s.score = 99
print(s.score)
s.score = 1000
```


- __slots__

```
# coding=utf-8

# 如果要限制添加的属性，例如，Student类只允许添加name，gender和score这三个属性，就可以利用Python的一个特殊的__slots__来实现。

class Student(object):
    
    __slots__ = ('name', 'gender', 'score')

    def __init__(self, name, gender, score):
        self.name = name
        self.gender = gender
        self.score = score

s = Student('wang', 'woman', 60)
s.name = 'li'
s.gender = 'man'
s.grade = 'S'
# AttributeError: 'Student' object has no attribute 'grade'
```


- __call__

```
# coding=utf-8

# 一个类实例也可以变成一个可调用对象，只需要实现一个特殊方法__call__()。

class Person(object):

    def __init__(self, name, gender):
        self.name = name
        self.gender = gender

    def __call__(self):
        print('My name is %s.'%self.name)

p = Person('li','man')
p()
# My name is li.
```

```
注意: 类可调用与对象可调用的不同(注: 类都是可调用的; 实例对象要看有没有__call__方法;)：

例:
# coding: utf-8

class WaterMelon(object):
	def __init__(self):
		self.price = 0
		self.price_per_kilogram = 1.0
	
	def __call__(self, weight):
		self.price = self.price_per_kilogram * weight
		print("The price of the watermelon is:", self.price)

w = WaterMelon()

w(6)
w.__call__(7)
WaterMelon()(8)

print "--------------------------"

class Apple(object):
	def __init__(self):
		self.price_per_kilo = 2.0

print callable(Apple)
print callable(WaterMelon)
w = WaterMelon()
a = Apple()
print callable(w)
print callable(a)


运行结果:
('The price of the watermelon is:', 6.0)
('The price of the watermelon is:', 7.0)
('The price of the watermelon is:', 8.0)
--------------------------
True
True
True
False
```



```
__call__的另一个用途:

python可以进行元编程(元类(type)，自定义元类(使用__metaclass__))，又一个技巧是，当你不想让用户能够实例化一个类，而只能使用累的静态方法的时候，可以通过结合__call__()函数与元编程来实现:


例:
# coding: utf-8

class NoInstances(type):
	def __call__(self, *args, **kwargs):
		raise TypeError("Class is not allowed to be instantiated!")

class Cherry(object):
	__metaclass__ = NoInstances

	@staticmethod
	def about():
		print("我是王者之力，但是你不配拥有！")

Cherry.about()
print '---------------------------'
a = Cherry()


运行结果：
我是王者之力，但是你不配拥有！
---------------------------
Traceback (most recent call last):
  File "test__all__2.py", line 16, in <module>
    a = Cherry()
  File "test__all__2.py", line 5, in __call__
    raise TypeError("Class is not allowed to be instantiated!")
TypeError: Class is not allowed to be instantiated!

```

```
元类(metaclass)

1) 究竟什么是metaclass？
metaclass就是Python中用来创建class object的class。我们可以将其看做能够产生class的类工厂。我们可以通过如下例子理解这个关系：

class = metaclass()
object = class()


2) 类的__metaclass__ attribute
当定义class的时候，我们可以使用__metaclass__ attribute来指定用来初始化当前class的metaclass。如下面的例子所示：

class Foo(object):
    __metaclass__ = something
    [other statements...]

如果我们指定了__metaclass__，Python就是使用这个metaclass来生成class Foo。
当Python试图创建class Foo的时候，Python会首先在class的定义中寻找__metaclass__ attribute。如果存在__metaclass__，Python将会使用指定的__metaclass__来创建class Foo。如果没有指定的话，Python就会使用默认的type作为metaclas创建Foo。

```

- object与type的区别:

```
1) 个人理解：
Type 是指类型， 一个class 就是一个Type, 
object  是指类型的实例， 指代一个具体的对象。
打个浅显的比方， 所有的同类型的笔是一个 Type（类型）， 但是同一种笔可能有很多个体， 一个个体就是指一个object.


2) object和type对象的关系

>>> object.__class__
<type 'type'>

>>> type.__class__
<type 'type'>

>>> object.__bases__
()

>>> type.__bases__
(<type 'object'>,)


这几句语句包含了三个概念1.对象 2.继承 3.类型

__class__属性指的是该对象是什么类型的实例。
__bases__属性指的是该对象的类型的父类有哪些。

首先，在python中一切都是对象，包括object和type,
*(object和type对象是系统的原有值，python中本身存在的,我的理解是c创建的一个struct对象)。
第二，object是一切对象的基类，所有其他类型都是从该类型中继承而来的。
第三，object作为一个对象它是type类型的一个实例。
第四，type作为类型它继承自object类型。
```

- python元类: type (自定义时使用metaclass方式, 本质仍为type)

```
用type函数创建一个类:

# coding: utf-8

class A(object):
	pass

# 类名 = type(类名-str, 父类-typle, 属性-dict)
# 此条命令创建类相当于上个class创建类,效果是一样的
B = type('B', (object, ), {})

print A
print B

结果:
<class '__main__.A'>
<class '__main__.B'>
```

```
定义带有属性的类:

class Foo(object):
    bar = True

# 相当于
Foo = type("Foo", (object, ), {'bar': True})
```

```
定义带有方法的类:

class Dog(object):
    def bark(self):
        print('wang wang ..')

    @classmethod
    def eat(self):
        print('i am eating...')

# ----------------------------
# 上面创建的类可以用type实现，就相当于：
def bark(self):
    print('wang wang ..')

# @staticmethod也是这样用
@classmethod  
def eat(self):
    print('i am eating...')

Dog = type('Dog', (object,), {'bark': bark, 'eat': eat})

# -----------------------------
# 来试验一下：
dog = Dog()
dog.eat()
dog.bark()

结果:
i am eating...
wang wang ..
```

```
__metaclass__自定义元类:

1) python3中:
def say_hello(self):
    print('hello, I am ' + str(self))

def my_type(class_name, class_fathers, class_attr):
    class_attr['say_hello'] = say_hello  # 给属性列表中加入say_hello
    return type(class_name, class_fathers, class_attr)

class Foo(object, metaclass=my_type):  # 用指定的元类来创建类(python3中需要这样用metaclass)
    pass

print(Foo)
a = Foo()
print(a)
a.say_hello()  # Foo对象拥有了say_hello的方法


2) python2中：
def say_hello(self):
    print('hello, I am ' + str(self))

def my_type(class_name, class_fathers, class_attr):
    class_attr['say_hello'] = say_hello  # 给属性列表中加入say_hello
    return type(class_name, class_fathers, class_attr)

class Foo(object):  # 用指定的元类来创建类
    __metaclass__ = my_type   # (python2中需要这样用metaclass)

print(Foo)
a = Foo()
print(a)
a.say_hello()  # Foo对象拥有了say_hello的方法

```

- 使用 __getitem__ 和 __iter__ 可以使类成为一个迭代器

```
# coding: utf-8

class Library(object):

	def __init__(self):
		self.books = {'title': 'a', 'title2': 'b', 'title3': 'c'}

	def __getitem__(self, i):
		return self.books[i]

	def __iter__(self):
		# 方法1: 使用生成器
		for titles in self.books:
			yield self.books[titles]
		# 方法2: 使用迭代器
		# return self.books.itervalues()
	
library = Library()

# 1. 普通方法
print library.books['title']
print '--------------------'

# 2. 使用__getitem__
print library['title']
print '--------------------'

# 3. 迭代器
for book in library:
	print book
print '--------------------'


结果:
a
--------------------
a
--------------------
b
c
a
--------------------
```

- __init__、__float__

```
# coding=utf-8

# 为了能够将那个Rational函数变为int，我们可以使用int()。
# 在类里面我们可以使用特殊的函数转化。比如命名为'__init__()'。

class Rational(object):

    def __init__(self, p, q):
        self.p = p
        self.q = q

    def __int__(self):
        return self.p//self.q

    def __float__(self):
        return self.p*1.0/self.q

print(int(Rational(7,2)))
print(float(Rational(7,2)))
print(float(Rational(1,3)))
# 3
# 3.5
# 0.333333333333
```


- 常用的特殊方法

```

1.字符串/字节序列表示形式:
__repr__, __str__, __format__, __bytes__

2.数值转换:
__abs__, __bool__, __complex__, __init__, __float__, __hash__, __index__

3.集合模拟:
__len__, __getitem__, __setitem__, __delitem__, __contains__

4.迭代枚举:
__iter__, __reversed__, __next__

5.可调用模拟:
__call__

6.上下文管理:
__enter__, __exit__

7.实例创建和销毁:
__new__, __init__, __del__

8.属性管理:
__getattr__, __getattribute__, __setattr__, __delattr__, __dir__

9.属性描述符号:
__get__, __set__, __delete__

10.跟类相关的服务:
__prepare__, __instancecheck__, __subclasscheck__
```
