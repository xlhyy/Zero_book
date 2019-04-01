# 参数


- 缺省参数

```
# coding=utf-8

"""
1.缺省参数:
    定义有默认参数的函数时，这些默认值参数位置必须都在非默认值参数后面。
    调用时给有默认值的参数值时，使用提供的值，否则使用默认值。
"""

def foo(text, num=0):
    print text, num

foo('asd')  # asd 0
foo('def', 100)  # def 100
```


- 命名参数

```
# coding=utf-8

"""
2.命名参数
"""

def foo(ip, port):
    print "%s:%d" % (ip, port)

# 没有指定参数名，按照顺序传参数。
foo("192.168.1.0", 3306)  # 192.168.1.0:3306
# 指定参数名，可以按照参数名称传参数。
foo(port=8080, ip="127.0.0.1")  # 127.0.0.1:8080
```


- 不定长参数

```
# coding=utf-8

"""
3.不定长参数:
    可以把tupleArg及dictArg看成两个默认参数。
    多余的非关键字参数，函数调用时被放在元组参数tupleArg中；
    多余的关键字参数，函数调用时被放在字典参数dictArg中。
"""

def foo(arg, *tupleArg, **dictArg):
    print "arg =",arg
    print "tupleArg =",tupleArg
    print "dictArg =",dictArg

foo("asdasd")
# arg = asdasd
# tupleArg = ()
# dictArg = {}

foo("asdasd", "qqq", *(1,2,3), a=2, **{"b":123})
# arg = asdasd
# tupleArg = ('qqq', 1, 2, 3)
# dictArg = {'a': 2, 'b': 123}
```


- 不定长参数举例

```
# coding=utf-8

"""
    参数中如果使用"*"元组参数或者"**"字典参数，这两种参数应该放在参数列表最后。并且"*"元组参数位于"**"字典参数之前。
    元组对象前面如果不带"*"，字典对象前面如果不带"**"，则作为普通的对象传递参数。
"""

def foo(arg1, arg2="OK", *tupleArg, **dictArg):
    print "arg1 =",arg1
    print "arg2 =",arg2
    print "tupleArg =",tupleArg
    print "dictArg =",dictArg

myList = ["my1", "my2"]
myDict = {"name":"Tom", "age":22}

foo("qqq", arg2="www", a=1)
# arg1 = qqq
# arg2 = www
# tupleArg = ()
# dictArg = {'a': 1}

foo(123, myList, myDict)
# arg1 = 123
# arg2 = ['my1', 'my2']
# tupleArg = ({'age': 22, 'name': 'Tom'},)
# dictArg = {}

foo(123, rt=123, *myList, **myDict)
# arg1 = 123
# arg2 = my1
# tupleArg = ('my2',)
# dictArg = {'rt': 123, 'age': 22, 'name': 'Tom'}
```
