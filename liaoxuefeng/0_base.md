# 基础

https://www.liaoxuefeng.com/wiki/1016959663602400

## python数据类型

```
number（数字）、string（字符串）、Boolean（布尔值）、None（空值）
list（列表）、tuple（元组）、dict（字典）、set（集合）
```

## set集合的基本操作

```
set是一个无序且不重复的元素集合
注意在创建空集合的时候只能使用s=set()，因为s={}创建的是空字典

1. 比较
se = {11, 22, 33}
be = {22, 55}
temp1 = se.difference(be)        #找到se中存在，be中不存在的集合，返回新值
print(temp1)        #{33, 11}
print(se)        #{33, 11, 22}

temp2 = se.difference_update(be) #找到se中存在，be中不存在的集合，覆盖掉se
print(temp2)        #None
print(se)           #{33, 11},


2. 删除
discard()、remove()、pop()
se = {11, 22, 33}
se.discard(11)
se.discard(44)  # 移除不存的元素不会报错
print(se)

se = {11, 22, 33}
se.remove(11)
se.remove(44)  # 移除不存的元素会报错
print(se)

se = {11, 22, 33}  # 移除末尾元素并把移除的元素赋给新值
temp = se.pop()
print(temp)  # 33
print(se) # {11, 22}


3. 取交集
se = {11, 22, 33}
be = {22, 55}

temp1 = se.intersection(be)             #取交集，赋给新值
print(temp1)  # 22
print(se)  # {11, 22, 33}

temp2 = se.intersection_update(be)      #取交集并更新自己
print(temp2)  # None
print(se)  # 22


4. 判断
se = {11, 22, 33}
be = {22}

print(se.isdisjoint(be))        #False，判断是否不存在交集（有交集False，无交集True）
print(se.issubset(be))          #False，判断se是否是be的子集合
print(se.issuperset(be))        #True，判断se是否是be的父集合


5. 合并
se = {11, 22, 33}
be = {22}

temp1 = se.symmetric_difference(be)  # 合并不同项，并赋新值
print(temp1)    #{33, 11}
print(se)       #{33, 11, 22}

temp2 = se.symmetric_difference_update(be)  # 合并不同项，并更新自己
print(temp2)    #None
print(se)             #{33, 11}


6. 取并集
se = {11, 22, 33}
be = {22,44,55}

temp=se.union(be)   #取并集，并赋新值
print(se)       #{33, 11, 22}
print(temp)     #{33, 22, 55, 11, 44}


7. 更新
se = {11, 22, 33}
be = {22,44,55}

se.update(be)  # 把se和be合并，得出的值覆盖se
print(se)
se.update([66, 77])  # 可增加迭代项
print(se)


8. 集合的转换
se = set(range(4))
li = list(se)
tu = tuple(se)
st = str(se)
print(li,type(li))
print(tu,type(tu))
print(st,type(st))

OUTPUT:
[0, 1, 2, 3] <class 'list'>
(0, 1, 2, 3) <class 'tuple'>
{0, 1, 2, 3} <class 'str'>
```

## tuple元组

```
元组的元素不可修改，但是元组元素的元素是可以修改的

索引
name_tuple = (1,2,3)
print(name_tuple[0])


切片
name_tuple = (1,2,3)
print(name_tuple[0:2])


循环
for i in name_tuple:
    print(i)


长度
name_tuple = (1,2,3)
print(name_tuple[len(name_tuple)-1])


嵌套
元组的元素不可修改，但是元素的元素可以修改
In [7]: a
Out[7]: (11, 22, [1, 0])

In [8]: a[2] = ''
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
<ipython-input-8-7d45d04c9a4f> in <module>()
----> 1 a[2] = ''

TypeError: 'tuple' object does not support item assignment

In [9]: a[2] = []
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
<ipython-input-9-a3276450be37> in <module>()
----> 1 a[2] = []

TypeError: 'tuple' object does not support item assignment

In [10]: a[2] = [4, 5]
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
<ipython-input-10-25764ca527b4> in <module>()
----> 1 a[2] = [4, 5]

TypeError: 'tuple' object does not support item assignment

In [11]: a[2][0] = 4

In [12]: a[2][1] = 2

In [13]: a
Out[13]: (11, 22, [4, 2])
```
