# itertools

```
In [1]: import itertools

In [2]: itertools.izip([1,2,3,4],['a','b'])
Out[2]: <itertools.izip at 0x7fb685aefab8>

In [3]: for i, j in itertools.izip([1,2,3,4],['a','b']):
   ...:     print i
   ...:     print j
   ...:     print '---------'
1
a
---------
2
b
---------
```