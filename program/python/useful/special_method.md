### 特殊方法


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
