# 推导式

- 列表(list)推导式

```
	1) 使用[]生成list
		实例1:
		In [12]: a = [i for i in range(30) if i % 3 is 0]

		In [13]: a
		Out[13]: [0, 3, 6, 9, 12, 15, 18, 21, 24, 27]

		实例2:
		In [14]: def func(x):
		    ...:     return x*x
		    ...: a = [func(i) for i in range(30) if i % 3 is 0]
		    ...: print a
		    ...: 
		[0, 9, 36, 81, 144, 225, 324, 441, 576, 729]

	2) 使用()生成generator
		In [15]: a = (i for i in range(30) if i % 3 is 0)

		In [16]: a
		Out[16]: <generator object <genexpr> at 0x7f48aee41960>

		In [17]: print(type(a))
		<type 'generator'>

		In [18]: a.next()
		Out[18]: 0

		In [19]: a.next()
		Out[19]: 3
```


- 字典(dict)推导式

```
	实例1: 大小写key的value合并
	In [24]: d1 = {'a':10, 'b':20, 'A':12, 'Z':3}

	In [25]: result = {
	    ...:     i.lower(): d1.get(i.lower(), 0) + d1.get(i.upper(), 0)
	    ...:     for i in d1.keys()
	    ...:     if i.lower() in ['a', 'b']
	    ...: }

	In [26]: result
	Out[26]: {'a': 22, 'b': 20}

	实例2: 快速更换key和value
	In [29]: d1 = {'a':10, 'b':34}

	In [30]: d2 = {v: k for k, v in d1.items()}

	In [31]: d2
	Out[31]: {10: 'a', 34: 'b'}
```


- 集合(set)推导式

```
	In [20]: a = {x**2 for x in [1, 1, 2]}

	In [21]: a
	Out[21]: {1, 4}
```
