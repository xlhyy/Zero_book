# reduce函数


- 参数

```
function -- 函数，有两个参数
iterable -- 可迭代对象
initializer -- 可选，初始参数
```

- 返回值

```
返回函数计算结果
```

- 实例

```
>>>def add(x, y) :            # 两数相加
...     return x + y
... 
>>> reduce(add, [1,2,3,4,5])   # 计算列表和：1+2+3+4+5
15
>>> reduce(lambda x, y: x+y, [1,2,3,4,5])  # 使用 lambda 匿名函数
15
```