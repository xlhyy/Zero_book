### 装饰器

- 装饰器等效
```
# coding=utf-8

import time

def deco(func):
    '''
        功能: 计算程序运行时间
    '''
    start_time = time.time()
    func()
    end_time = time.time()
    process_time = end_time - start_time
    return process_time

def func():
    print('hello')
    time.sleep(1)
    print('world')

# 避免直接侵入原函数修改，但是生效需要再次执行函数
if __name__ == '__main__':
    f = func
    process_time = deco(f)
    print(process_time)
```


- 装饰器举例
```
# coding=utf-8

import time

def deco(func):
    def wrapper():
        start_time = time.time()
        func()
        end_time = time.time()
        process_time = end_time - start_time
        return process_time
    return wrapper

@deco
def func():
    print('hello')
    time.sleep(1)
    print('world')

if __name__ == '__main__':
    f = func
    process_time = f()
    print process_time
```


- 装饰器传参数
```
# coding=utf-8

import time

def deco(func):
    def wrapper(a, b):
        start_time = time.time()
        func(a, b)
        end_time = time.time()
        process_time = end_time - start_time
        print process_time
    return wrapper

@deco
def func(a, b):
    print('hello,here is a func for add:')
    time.sleep(1)
    print('result is %d' %(a+b))

if __name__ == '__main__':
    f = func
    f(3,4)
```


- 装饰器不定长参数
```
# coding=utf-8

import time

def deco(func):
    '''
        带有不定长参数的装饰器
    '''
    def wrapper(*args, **kwargs):
        start_time = time.time()
        func(*args, **kwargs)
        end_time = time.time()
        process_time = end_time - start_time
        print process_time
    return wrapper

@deco
def func1(a, b):
    print('hello_1,here is a func for add:')
    time.sleep(1)
    print('result_1 is %d' %(a+b))

@deco
def func2(a, b, c):
    print('hello_2,here is a func for add:')
    time.sleep(1)
    print('result_2 is %d' %(a+b+c))

if __name__ == '__main__':
    func1(3,4)
    func2(2,3,4)
```


- 拥有多个装饰器执行顺序
```
# coding=utf-8

import time

def deco1(func):
    def wrapper(*args, **kwargs):
        print('deco_1_strat----------')
        start_time = time.time()
        func(*args, **kwargs)
        end_time = time.time()
        process_time = end_time - start_time
        print process_time
        print('deco_1_end----------')
    return wrapper

def deco2(func):
    def wrapper(*args, **kwargs):
        print('deco_2_start----------')
        func(*args, **kwargs)
        print('deco_2_end----------')
    return wrapper

@deco1
@deco2
def func(a, b):
    print('func_start----------')
    time.sleep(1)
    print('func_end----------')

if __name__ == '__main__':
    func(3, 4)
```

```
# coding=utf-8

import time

def deco1(func):
    print('deco-1-enter')
    def one():
        print('deco_1_1----------')
        time.sleep(1)
        func()
        print('deco_1_2----------')
    return one

def deco2(func):
    print('deco-2-enter')
    def two():
        print('deco_2_1----------')
        time.sleep(1)
        func()
        print('deco_2_2----------')
    return two

@deco1
@deco2
def test():
    print('test func')

if __name__ == '__main__':
    test()
```
