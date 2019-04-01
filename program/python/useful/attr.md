# 属性

- 类属性、实例属性

```
# coding=utf-8

"""
1.实例属性:
    在__init__(self,...)中初始化
    内部调用时都需要加上self.
    外部调用时用 实例化对象.属性名

2.类属性:
    在__init__()外初始化
    在内部用 类名.类属性名 调用
    外部既可以用 类名.类属性名 又可以用 实例化对象.类属性名来调用
"""

class Test(object):
    #类属性
    a = 100
    def __init__(self, b):
        #实例属性
        self.b = b

t = Test(100)

#通过实例化对象访问 类属性
print('t.a = %d'%t.a)

#通过类名访问 类属性
print('Test.a = %d'%Test.a)

#通过实例化对象访问 实例属性
print('t.b = %d'%t.b)

#通过类名访问 实例属性: 错误
#print('Test.b = %d'%Test.b) #error无法通过 类名.属性名 的方式访问实例属性
```


- 私有属性

```
# coding=utf-8

"""
3.私有属性:
    1)单下划线_开头:
        只是告诉别人这是私有属性，外部依然可以访问更改
    2)双下划线__开头:
        外部不可通过 实例化属性.属性名 来访问或者更改
        实际将其转化为了 _类名__属性名，只是在内部将变量名修改了，我们仍然可以通过 ._类名__属性名访问
"""

class Test1(object):
    a = 100
    def __init__(self):
        self.name = 'Test1'

class Test2(object):
    _a = 200
    def __init__(self):
        self.name = 'Test2'

class Test3(object):
    __a = 300
    def __init__(self):
        self.name = 'Test3'

print Test1.a
print Test1().a
print Test2._a
print Test2()._a
print Test3._Test3__a
print Test3()._Test3__a
```


- 修改类属性

```
# coding=utf-8

"""
    1.通过实例对象修改类属性的值，并没有在全局范围奏效，只是对于进行修改的实例对象中的类属性进行修改。
    2.通过类名修改的类属性，在全局范围奏效，也就是说确实修改了类属性的值。
    (所以在实际开发中，应该避免通过实例对象去修改类属性。)
"""

class Test1(object):
    a = 100
    def __init__(self):
        pass

t1 = Test1()
t2 = Test1()

print('通过实例对象t1修改类属性的值')
print('修改前: t1.a = %d, t2.a = %d, Test1.a = %d'%(t1.a, t2.a, Test1.a))
t1.a += 100
print('修改后: t1.a = %d, t2.a = %d, Test1.a = %d'%(t1.a, t2.a, Test1.a))


class Test2(object):
    a = 100
    def __init__(self):
        pass

t1 = Test2()
t2 = Test2()

print('通过类名修改类属性的值')
print('修改前: t1.a = %d, t2.a = %d, Test.a = %d'%(t1.a, t2.a, Test2.a))
Test2.a += 100
print('修改后: t1.a = %d, t2.a = %d, Test.a = %d'%(t1.a, t2.a, Test2.a))
```
