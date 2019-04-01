# 生成器


- 生成器简单举例

```
# coding=utf-8

import sys

def my_gen():
    n = 1
    print('first')
    yield n

    n += 1
    print('second')
    yield n

    n += 1
    print('third')
    yield n

if __name__ == '__main__':
    a = my_gen()
    # 每次调用a的时候，函数都从之前保存的状态执行
    try:
        print(next(a))
        print(next(a))
        print(next(a))
        print(next(a))
    except:
        print(sys.exc_info())
```


- 生成器使用循环

```
# coding=utf-8

def rev_str(strx):
    str_len = len(strx)
    for i in range(str_len-1, -1, -1):
        yield strx[i]

if __name__ == '__main__':
    strx = 'hello'
    print type(rev_str(strx)) # rev_str(strx)是一个生成器
    print type(rev_str) # rev_str是一个函数
    for i in rev_str(strx):
        print i
```


- 生成器概念

```
# coding=utf-8

# 函数有了yield之后，函数名+()就变成了生成器
# return在生成器中代表生成器的终止，直接报错
# next的作用是唤醒并继续执行
# send的作用是唤醒并继续执行，发送一个信息到生成器内部

def create_counter(n):
    '''
        功能: 计数器
    '''
    print('create_counter')
    while True:
        yield n
        print('increment n')
        n += 1

if __name__ == '__main__':
    gen = create_counter(2)
    print(create_counter.__doc__)
    print(gen.next())
    print(gen.next())
    print(gen.next())
```


- 知识点

```
# coding=utf-8

# 生成器
a = (x for x in range(10))
print(a.next())
print(next(a))

print('----------')

# 迭代器
b = [x for x in range(10)]
b = iter(b)
print(next(b))
print(b.next())

'''
1) 可迭代对象：可以进行for循环都是可迭代对象，原因是其内部实现了一个__iter__方法2) 迭代器：能够进行next(迭代器对象)，都是迭代器对象，其内部实现了__iter__和__next__方法
3) 生成器：元祖推导式和函数里使用yield的函数都是生成器

生成器属于迭代器
迭代器属于可迭代对象

生成器只能遍历一次
'''
```


- fibonacci数列

```
- fibonacci数列

# coding=utf-8
# fibonacci数列

def fib(num):
    n, a, b = 0, 0, 1
    while n < num:
        a, b = b, a+b
        n = n+1
        print a
    return 'done'

if __name__ == '__main__':
    result = fib(10)
    print result
```

```
- 生成器生成fibonacci数列

# coding=utf-8

def fib(num):
    n, a, b = 0, 0, 1
    while n < num:
        yield b
        a, b = b, a+b
        n = n+1
    return

if __name__ == '__main__':
    a = fib(10) # a是生成器
    while True:
        try:
            x = next(a)
            print('generate:',x)
        except StopIteration:
            print('生成器已无值可取')
            break 
```


- 生成器实现单线程并发

```
# coding=utf-8

# 通过yield实现在单线程的情况下实现并发运算的效果

import time

def consumer(name):
    print('%s 准备学习啦!' %name)
    while True:
        lesson = yield
        print('课程[%s]开始上课了，[%s]老师来讲课了!' %(lesson, name))

def producer():
    c1 = consumer('A')
    c2 = consumer('B')
    c1.next()
    c2.next()
    print('同学们开始上课啦!')
    for i in range(10):
        time.sleep(1)
        print('到了两个同学!')
        c1.send(i)
        c2.send(i)

if __name__ == '__main__':
    producer()
```
