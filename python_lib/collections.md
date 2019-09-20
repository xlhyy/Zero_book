# 常用内建模块-collections


## collections

### namedtuple(个人理解为是创建了一个有属性对象)

```
看到(1, 2)，很难看出这个tuple是用来表示一个坐标的。
定义一个class又小题大做了，这时，namedtuple就派上了用场：
>>> from collections import namedtuple
>>> Point = namedtuple('Point', ['x', 'y'])
>>> p = Point(1, 2)
>>> p.x
1
>>> p.y
2

类似的，如果要用坐标和半径表示一个圆，也可以用namedtuple定义：
# namedtuple('名称', [属性list]):
Circle = namedtuple('Circle', ['x', 'y', 'r'])
```

### deque(双向列表，适用于队列和栈)

```
使用list存储数据时，按索引访问元素很快，但是插入和删除元素就很慢了，因为list是线性存储，数据量大的时候，插入和删除效率很低。

deque是为了高效实现插入和删除操作的双向列表，适合用于队列和栈：

>>> from collections import deque
>>> q = deque(['a', 'b', 'c'])
>>> q.append('x')
>>> q.appendleft('y')
>>> q
deque(['y', 'a', 'b', 'c', 'x'])
deque除了实现list的append()和pop()外，还支持appendleft()和popleft()，这样就可以非常高效地往头部添加或删除元素。

注: deque并不改变原有的列表
In [19]: l = ['a', 'b', 'c']

In [20]: q = deque(l)

In [21]: q.append('d')

In [22]: l
Out[22]: ['a', 'b', 'c']

In [23]: q
Out[23]: deque(['a', 'b', 'c', 'd'])

In [24]: l = list(q)

In [25]: l
Out[25]: ['a', 'b', 'c', 'd']
```

### OrderedDict

```
OrderedDict的Key会按照插入的顺序排列，不是Key本身排序：

>>> from collections import OrderedDict

>>> od = OrderedDict()
>>> od['z'] = 1
>>> od['y'] = 2
>>> od['x'] = 3
>>> list(od.keys()) # 按照插入的Key的顺序返回
['z', 'y', 'x']

>>> od = OrderedDict([('a', 1), ('b', 2), ('c', 3)])
>>> od # OrderedDict的Key会保持原有的顺序
OrderedDict([('a', 1), ('b', 2), ('c', 3)])

注: sorted可用于排序
In [40]: sorted(dict(od))
Out[40]: ['x', 'y', 'z']

In [41]: sorted(dict(od).iteritems())
Out[41]: [('x', 3), ('y', 2), ('z', 1)]

In [38]: d
Out[38]: {'a': 1, 'b': 2}

In [39]: sorted(d.iteritems())
Out[39]: [('a', 1), ('b', 2)]

In [40]: dict(sorted(d.iteritems()))
Out[40]: {'a': 1, 'b': 2}
```

```
OrderedDict可以实现一个FIFO（先进先出）的dict，当容量超出限制时，先删除最早添加的Key：

from collections import OrderedDict

class LastUpdatedOrderedDict(OrderedDict):

    def __init__(self, capacity):
        super(LastUpdatedOrderedDict, self).__init__()
        self._capacity = capacity

    def __setitem__(self, key, value):
        containsKey = 1 if key in self else 0
        if len(self) - containsKey >= self._capacity:
            last = self.popitem(last=False)
            print('remove:', last)
        if containsKey:
            del self[key]
            print('set:', (key, value))
        else:
            print('add:', (key, value))
        OrderedDict.__setitem__(self, key, value)
        
注:
__setitem__方法用法:
o = LastUpdatedOrderedDict(4)
o['a'] = 1
```

### Counter(个人认为，类似一个空字典)

```
Counter是一个简单的计数器，例如，统计字符出现的个数：

>>> from collections import Counter
>>> c = Counter()
>>> for ch in 'programming':
...     c[ch] = c[ch] + 1
...
>>> c
Counter({'g': 2, 'm': 2, 'r': 2, 'a': 1, 'i': 1, 'o': 1, 'n': 1, 'p': 1})

注: Counter实际上也是dict的一个子类
```
