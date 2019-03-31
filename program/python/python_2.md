### python高级


```
目录
1.元类____________________________________________________________1
2.生成器、迭代器________________________________________________4
3.闭包函数、代理模式__________________________________________9
4.比较、拷贝、私有属性________________________________________14
5.垃圾回收_____________________________________________________22



元类
1、元类：
a)一切皆对象：对象分两种，实例对象，类型对象
b)元类：用来创建类型对象
c)type：就是元类 type(类名，父类的元组，类的属性字典)

d)自定义元类：__metaclass__ = 自定义的元类，当python在实例化class对象时，会先查找class中时候有__metaclass__属性，如果有根据这个数据去实例化class对象，如果没有，直接用type实例化

2、添加实例方法和类方法
#coding=utf-8
import types

class Person(object):

	__slots__ = ("sleep", ) # 限制给实例添加的属性,元组元素以外的属性不能添加

	def __init__(self):
		pass

def sleep(self):
	print("sleeping...")

def buy(self):
	print("buying...")

@classmethod
def eat(cls):
	print("eating...")

@staticmethod
def play():
	print("playing...")

Person.buy = buy # 给实例添加方法,用该类实例出的任何实例都可以调用
p = Person()
p.buy()

p.sleep = types.MethodType(sleep, p)
# 给实例添加一个只属于当前实例的方法,只有当前这个实例可以调用
p.sleep()

Person.eat = eat
# 类方式 给类添加一个方法 专门供类调用 虽然实例也能调用但是没意义
Person.play = play

p2 = Person()
p2.eat()

#p2.name = "xiaoming"
# 由于slots限制,添加name属性会报错

3、函数的形式和类的形式自定义元类
#coding=utf-8

# 自定义元类,将类中所有的属性变成大写
# 函数的形式自定义元类
def attr_upper(classname, parents, classattrs):
	newattrs = {}
	for key, value in classattrs.items():
		if not key.startswith("__"):
			newattrs[key.upper()] = value
		else:
			newattrs[key] = value
	return type(classname, parents, newattrs)

# 类的形式自定义元类
class AttrUpper(type):

	def __new__(cls, classname, parents, classattrs):
		newattrs = {}
		for key, value in classattrs.items():
			if not key.startswith("__"):
				newattrs[key.upper()] = value
			else:
				newattrs[key] = value
		#return type(classname, parents, newattrs)
		return type.__new__(cls, classname, parents, newattrs)
		#return super(AttrUpper, cls).__new__(cls, classname, parents, newattrs)

4、给类添加一个方法，名字叫 farsight，方法输出 华清大法好
#coding=utf-8

class Far(type):

	def __new__(cls, classname, parents, classattrs):
		classattrs["farsight"] = Far.farsight

		return super(Far, cls).__new__(cls, classname, parents, classattrs)

	@classmethod
	def farsight(cls):
		print("华清大法好")

#class ANT(object, metaclass = Far): # python3用法
class ANT(object):
	#python2用法
	__metaclass__ = Far

ANT.farsight()

5、函数形式自定义元类
#coding=utf-8

def attr_upper(classname, parents, classattrs):
	newattrs = {}
	for key, value in classattrs.items():
		if not key.startswith("__"):
			newattrs[key.upper()] = value
		else:
			newattrs[key] = value
	print("haha")
	return type(classname, parents, newattrs)


#class ANT(object, metaclass = attr_upper): # python3用法
class ANT(object):
	#python2用法
	__metaclass__ = attr_upper
	
ant = ANT()









生成器、迭代器
1、生成器：
a)优点：省内存，它是记录每个元素的算法，在需要的时候会计算出一个元素
b)创建方法1：将列表生成式的[] 变成()

c)访问元素的方式：
i.for循环

ii.next()   一般不在循环中使用

例：
#coding=utf-8

g = (x for x in range(2))
print(next(g))
print(next(g))

try:
	print(next(g))
except StopIteration:
	print("异常已被捕捉")
print("正常结束")
输出结果：
	0
	1
	异常已被捕捉
	正常结束

d)创建方法2：利用函数  关键字yield  当执行next的时候会触发函数运行，运行到yield函数暂停，并且保存函数中变量的状态

e)斐波那契数列： 0 1 1 2 3 5 8 13 。。。。。。

例：
#coding=utf-8

#生成器用法2
def fun():
	i = 0
	while i < 10:
		print("before %d"%i)
		yield i #产出i的值
		print("after %d"%i)
		i += 1

#当函数中有yield时,此处gf是生成器,注意gf并不是一个指向函数的引用,也不是函数返回值
gf = fun()

print("-"*10)
print(next(gf))
#每次执行next,程序执行完yield语句时,会暂停。当下一次执行next()时再上次暂停处(即yield后)开始执行。
print("-"*10)
print(next(gf))
print("-"*10)
print(next(gf))
print("-"*10)
print(next(gf))
print("-"*10)
print(next(gf))
print("-"*10)
输出结果：
----------
before 0
0
----------
after 0
before 1
1
----------
after 1
before 2
2
----------
after 2
before 3
3
----------
after 3
before 4
4
----------

f)生成器的send()函数：生成器调用send(参数)时会将参数赋值给arg，注意第一次使用生成器不可以使用send()

例：生成器交互
#coding=utf-8

def fun():
	i = 0
	num1 = 0
	num2 = 1
	while True:
		print("before %d"%num2)
		arg = yield num2
		print("after %d %s"%(num2,arg))
		temp = num2
		num2 = num1 + num2
		num1 = temp

gf = fun()
print("-"*10)
next(gf)#next相当于给交互提供一个入口,因为只有当在yield 处暂停时,才可改变arg 的值
print("-"*10)
gf.send("2333")#只有传参给arg ,语句arg = yield num2才会打印num2的值;
			#其执行过程相当于执行一次next() ,语句yield num2会打印num2的值;
print("-"*10)
gf.send("2333")
print("-"*10)
gf.send("2333")
print("-"*10)
gf.send("2333")
print("-"*10)
gf.send("2333")
print("-"*10)
输出结果：
----------
before 1
----------
after 1 2333
before 1
----------
after 1 2333
before 2
----------
after 2 2333
before 3
----------
after 3 2333
before 5
----------
after 5 2333
before 8
----------

2、迭代器：用来遍历的东西（迭代器不能被复制）
a)list  tuple  str   dict   set（？） generator（生成器）（生成器即是可迭代对象又是迭代器） （以上这些可迭代对象除了generator以外都不是迭代器）
（可以直接作用于for循环的对象统称为可迭代对象（Iterable），如list、tuple、dict、str、set等）
b)内置函数iter()，获得一个序列的迭代器
c)只有iterable（可迭代的）的对象才可以使用iter函数生成迭代器，只有iterator（迭代器）对象可以使用next
例：
#coding=utf-8

#能用for xx in xx 遍历的都是可迭代的
l = [1,2,3,4,5,6]
d = {"name":"xiaoming","age":18}
s = "qwertyuiop"
t = (9,8,7,6,5,4)

i = iter(d) #通过iter()获得一个迭代器

print(next(i))
print(next(i))

try:
	print(next(i))
	print(next(i))
	print(next(i))
	print(next(i))
except StopIteration:
	pass




















闭包函数、代理模式
1、闭包：（精髓:外部函数生命周期变长）
a)函数中定义内部函数，并且将内部函数作为返回值
b)调用内部函数时，外部函数的局部变量生命周期和内部函数对象一样
c)内部函数可以任意的读外部函数的局部变量
d)内部函数在python中只能写外部函数的可变对象，在python3中可以写通过nonlocal关键字声明内部函数的变量是外部函数的，从而进行写操作


例：闭包
#coding=utf-8
'''
#在python2和python3中,这种方法都可以使用
def fun():
	data = [0] #注意:此处是可变的数据类型
	def inner():
		data[0] += 1
		print('fun inner %d'%data[0])
	
	return inner
	'''
#python3中可用
def fun():
	data = 0 #注意:此处可以是不可变类型变量
	def inner():
		nonlocal data #python3专有用法
		data += 1
		print('fun inner %d'%data)
	
	return inner
	
f = fun()
f()
f()
f()

2、装饰器：
a)高内聚-低耦合：能自己做的事自己做，不求别人
b)开放-封闭：
i.开放：代码具有可扩展性
ii.封闭：扩展功能的同时不修改原来的代码
c)设计模式-代理模式：
i.面向切面的编程
ii.装饰器：python对代理模式的实现
d)
i.函数fun被装饰器clearer修饰，那么在调用fun时，执行的就是clearer返回的内部函数
ii.闭包函数clearer的函数参数f，指向被他修饰的函数
e)装饰器的参数：
i.修饰的函数带参数：装饰器的内部函数要有相同的参数
ii.修饰的函数带返回值：在内部函数中获得修饰函数的返回值，并返回
iii.装饰器本身带参数：在原有的闭包函数基础上，在最外层再加一层函数，用来接收装饰器的参数，这时中间层的函数也需要被返回


例1：装饰器
#coding=utf-8

def cleaner(f): #参数是一个函数,指向@cleaner 修饰的函数
				#cleaner(f) 函数是一个闭包

	def inner():
		print("净水器")
		f()
	return inner

@cleaner
def fun():
	print("老王家的水")

fun() #此处调用fun() ,实际上是执行了cleaner(f)返回的内部函数

例2：装饰器修饰的函数带参数
#coding=utf-8

def cleaner(f): #参数是一个函数,指向@cleaner 修饰的函数
				#cleaner(f) 函数是一个闭包

	def inner(name):
		print("净水器")
		f(name)
	return inner

@cleaner
def fun(name):
	print("老王家的水 %s"%name)

fun("haha") #此处调用fun() ,实际上是执行了cleaner(f)返回的内部函数

例3：装饰器和其修饰的函数都带参数
#coding=utf-8

def cleaner(arg): #最外层的装饰器负责获得装饰器本身的参数

	def mid(f): #中间层装饰器,负责获得修饰的函数
		def inner(*args,**kwargs):
			print("净水器 %s"%arg)
			ok = f(*args,**kwargs)
			return ok
		return inner #内层和中间层内部函数都要返回,但是执行的还是内层
	return mid

@cleaner("cleaner的参数")
def fun(*args,**kwargs):
	print(args)
	print(kwargs)
	print("老王家的水 %s"%args[1])
	return "fun的返回值"

temp = fun("haha",'aaa',a = "dad")
print(temp)

例4：练习：打印日志信息
#coding=utf-8
import time

class TestClass(object):

	def get_time(a):
		def inner(self):
			f = open("./test.txt","a")
			a(self)
			temp = time.strftime("%Y-%m-%d %X",time.localtime())
			f.write("%s %s "%(a,temp))
			f.close
		return inner
	
	@get_time
	def test1(self):
		time.sleep(1)
		print("test1 fun")
	
	@get_time
	def test2(self):
		time.sleep(1)
		print("test2 fun")
	@get_time
	def test3(self):
		time.sleep(1)
		print("test3 fun")

tc = TestClass()
tc.test1()
tc.test2()
tc.test3()
































比较、拷贝、私有属性
1、比较：
a)is：比较两个引用是否指向同一个对象
b)==：比较两个对象是否相等
i.定义函数 __eq__ 制定比较规则
ii.当判断序列中是否包含一个对象的时候，python也是使用==进行判断
例1：用is比较两个引用是否指向同一个对象
#coding=utf-8

l1 = [1,2,3]
l2 = l1

l3 = [1,2,3]
l4 = [1,2,3]

print(l1 is l2)
print(l3 is l4)
输出结果：
True
False

例2：用==比较两个对象是否相等
#coding=utf-8

l1 = [1,2,3]
l2 = [1,2,3]

print(l1 == l2)

class Person(object):

	def __init__(self,height,weight,name):
		self.name = name
		self.weight = weight
		self.height = height
	
	def __eq__(self,other): #equals 使用== 比较类对象时会调用这个函数来比较
		return self.name == other.name and self.weight == other.weight and\
		self.height == other.height

xiaoming = Person(160,150,"mingming")
xiaoqiang = Person(160,150,"mingming")

print(xiaoming == xiaoqiang)
输出结果：
	True
	True

例3：用in判断一个类对象是否在列表中
#coding=utf-8

l = []

class Person(object):

	def __init__(self,height,weight,name):
		self.name = name
		self.weight = weight
		self.height = height
	
	def __eq__(self,other): #equals 使用== 比较类对象时会调用这个函数来比较
		return self.name == other.name and self.weight == other.weight and\
		self.height == other.height

xiaoming = Person(160,150,"mingming")
l.append(xiaoming)

xiaoqiang = Person(160,150,"mingming")

print(xiaoming in l)
print(xiaoqiang in l)
输出结果：
True
True
无__eq__方法时的输出结果：
True
False

2、拷贝：使用在动态生成对象时
a)导入模块  copy
b)浅拷贝：copy.copy()拷贝对象时，如果对象中包含引用，那么仅仅对引用进行拷贝

例：调用copy模块进行对象浅拷贝
#coding=utf-8
import copy

class Person(object):

	def __init__(self, height, weight):
		self.height = height
		self.weight = weight
	
	def __eq__(self, other):
		return self.height == other.height and self.weight == other.weight

p1 = Person(1, 1)
p2 = copy.copy(p1)

print(p1 == p2)
print("%d %d"%(id(p1), id(p2)))
输出结果：
	True
	3073003084 3073003116

c)深拷贝：copy.deepcopy()拷贝对象时，对对象中包含的引用，进行递归的拷贝
（递归式复制举例：当要复制的目录下存在子目录，且子目录中存在子目录或文件的时候，将逐一复制它们。）

d)一般情况下我们都使用浅拷贝，省内存省时间；当想对深层的对象进行唯一性（不影响别的对象）的写操作的时候，使用深拷贝

例：调用copy模块进行深拷贝
#coding=utf-8
import copy

class Person(object):

	def __init__(self, height, weight):
		self.height = height
		self.weight = weight
	
	def __eq__(self, other):
		return self.height == other.height and self.weight == other.weight

mother = Person(99, 99)

xiaoming = Person(180,120)
xiaoming.mother = mother

xiaoqiang = copy.deepcopy(xiaoming)

print("%d %d"%(id(xiaoming.mother), id(xiaoqiang.mother)))
输出结果：
	3072601772 3072601996

3、私有属性：
a)定义私有属性：__属性名
b)访问私有1：_类名__属性名，因为python根本没有访问权限的限制，所以仅仅是对属性名进行了一个修改
c)访问私有2：getter和setter
例：
#coding=utf-8

class Person(object):
	
	def __init__(self,height,weight):
		self.__height = height
		self.__weight = weight
	
	def get_height(self):
		if self.__height < 100:
			return "身高无可奉告"
		return self.__height

	def get_weight(self):
		if self.__weight < 100:
			return "体重无可奉告"
		return self.__weight

	def set_height(self,height):
		if not isinstance(height,int):
			return "傻啊"
		self.__height = height
	
	def set_weight(self,weight):
		if not isinstance(weight,int):
			return "傻啊"
		self.__weight = weight

p = Person(180,120)
print(p.set_height("nihao"))
p.set_weight(70)

print("%s %s"%(p.get_height(),p.get_weight()))
#print(_Person__height)
#print(_Person__weight)
输出结果：
	傻啊
	180 体重无可奉告

d)访问私有3：property 来优化
i.定义类property对象的类属性
ii.创建property对象有两个参数分别 get方法和set方法
iii.对property对象 赋值 就是调用set方法
iv.直接使用property对象时，就是调用get方法

例：
#coding=utf-8

class Person(object):
	
	def __init__(self,height,weight):
		self.__height = height
		self.__weight = weight
	
	def get_height(self):
		if self.__height < 100:
			return "身高无可奉告"
		return self.__height

	def get_weight(self):
		if self.__weight < 100:
			return "体重无可奉告"
		return self.__weight

	def set_height(self,height):
		if not isinstance(height,int):
			return "傻啊"
		self.__height = height
	
	def set_weight(self,weight):
		if not isinstance(weight,int):
			return "傻啊"
		self.__weight = weight
	
	height = property(get_height,set_height)
	weight = property(get_weight,set_weight)

p = Person(180,120)
p.height = 170
p.weight = 150

print("%d %d"%(p.height,p.weight))
输出结果：
	170 150

e)使用property直接对方法进行修饰，使用装饰器
i.用@property修饰属性的get方法
ii.使用@get方法的名字.setter 修饰属性的set方法
iii.建议getter 和setter命名为一样的

例：
#coding=utf-8

class Person(object):

	def __init__(self,height,weight):
		self.__height = height
		self.__weight = weight
	
	@property
	def height(self):
		if self.__height < 100:
			return "身高无可奉告"
		return self.__height

	@property
	def weight(self):
		if self.__weight < 100:
			return "体重无可奉告"
		return self.__weight

	@height.setter
	def height(self,height):
		if not isinstance(height,int):
			return "傻啊"
		self.__height = height
	
	@weight.setter
	def weight(self,weight):
		if not isinstance(weight,int):
			return "傻啊"
		self.__weight = weight
	
p = Person(180,120)
p.height = 170
p.weight = 150

print("%s %s"%(p.height,p.weight))
输出结果：
	170 150

4、路径命名，文件命名，函数变量名等：
a)由数字、字母、下划线组成
b)不要有数字开头
c)区分大小写
d)不要用敏感的字（关键字等，靠经验）


















垃圾回收
1、内存中变量的分配：
a)静态  静态区的变量，生命周期在程序结束才释放   优点：生命周期比较长  缺点：生命周期太长，不用的时候也不会释放
b)栈	栈空间的变量，生命周期在变量所在的作用域开始执行的时候被创建，当作用域执行完成，变量自动释放  优点：自动释放省内存  缺点：生命周期太短
c)堆	自定义生命周期，习惯性的将类的实例放在堆空间   优点：生命周期自定义 缺点：自己不释放，永远占内存
2、Python的垃圾回收机制（回收堆空间）
a)引用计数法
b)标记-清除法
c)Python使用引用加标记-清除相结合的方式管理，引用计数为主，标记-清除为辅

d)gc模块：用来回收垃圾的模块

在python中，采用分代收集的方法。把对象分为三代，一开始，对象在创建的时候，放在零代中，如果在一次零代的垃圾检查中，该对象存活下来，就会被放到一代中；同理在一次一代的垃圾检查中，该对象存活下来，就会被放到二代中。
gc模块里面会有一个长度为3的列表的计数器，可以通过gc.get_count()获取。
例如（488,3,0），其中488是指距离上一次零代垃圾检查，python分配内存的数目减去释放内存的数目，注意是内存分配，而不是引用计数的增加。例如：
print gc.get_count() # (590, 8, 0)
a = ClassA()
print gc.get_count() # (591, 8, 0)
del a
print gc.get_count() # (590, 8, 0)
3是指距离上一次一代垃圾检查，零代垃圾检查的次数，同理，0是指距离上一次二代垃圾检查，一代垃圾检查的次数。
gc模块有一个自动垃圾回收的阀值，即通过gc.get_threshold函数获取到的长度为3的元组，例如(700,10,10)
每一次计数器的增加，gc模块就会检查增加后的计数是否达到阀值的数目，如果是，就会执行对应的代数的垃圾检查，然后重置计数器
例如，假设阀值是(700,10,10)：
当计数器从(699,3,0)增加到(700,3,0)，gc模块就会执行gc.collect(0),即检查零代对象的垃圾，并重置计数器为(0,4,0)
当计数器从(699,9,0)增加到(700,9,0)，gc模块就会执行gc.collect(1),即检查零、一代对象的垃圾，并重置计数器为(0,0,1)
当计数器从(699,9,9)增加到(700,9,9)，gc模块就会执行gc.collect(2),即检查零、一、二代对象的垃圾，并重置计数器为(0,0,0)
其他
如果循环引用中，两个对象都定义了__del__方法，gc模块不会销毁这些不可达对象，因为gc模块不知道应该先调用哪个对象的__del__方法，所以为了安全起见，gc模块会把对象放到gc.garbage中，但是不会销毁对象。

3、内置属性：

a)__del__ ：类中定义__del__ ，在对象形成孤岛的时候，垃圾回收器将不会自动回收这个对象
b)__bases__：是类实例（class）的属性
例：
#coding=utf-8

class Test(object):
	'class test'
	pass

class Xiaoming(Test):
	pass

t = Test()
t.name = "xiaoming"
t.age = 18

print(t.__dict__)
print(t.__class__)
print(t.__doc__)
print(Xiaoming.__bases__)
print(Test.__bases__)
输出结果：
{'age': 18, 'name': 'xiaoming'}
<class '__main__.Test'>
class test
(<class '__main__.Test'>,)
(<type 'object'>,)

c)__getattribute__：注意不要形成死递归

4、内置函数：	
a)map()：将多个序列合并成一个序列
i.参数1：函数，合并规则，函数的参数取决于要合并的序列
ii.参数2：要合并的序列，要合并的序列必须是一样长

b)filter()：对一个序列进行过滤
i.参数1：判断条件的函数，一个参数接收序列中的一个值，返回值是真或假，会将返回值为真的元素添加到新的序列中
ii.参数2：需要过滤的序列

例：
#coding=utf-8

l1 = [1,2,3,4,5,6]
l2 = [2,3,4,5,6,7]

l3 = map(lambda x,y: x+y, l1, l2)
print(l3)

l4 = filter(lambda x: not x%2, l1)
print(l4)
输出结果：
[3, 5, 7, 9, 11, 13]
[2, 4, 6]

c)reduce()：将序列进行累计
i.参数1：累计规则的函数，两个参数
ii.参数2：要累计的序列
iii.参数3：如果有，将参数3中序列的第一个值作为初始累计值

d)sorted()：对序列进行排序，并且返回新的序列
i.参数1：要排序的序列
ii.参数2：比较规则的函数，两个参数参数1大于参数2 返回正数，参数1小于参数2返回负数，参数1等于参数2返回0
iii.参数3：如果是字典或者类，需要指定比较的属性，返回要比较的属性即可
iv.参数4：False升序  True降序，默认是False


例1：
	#coding=utf-8
l5 = [{"age":89},
		{"age":3},
		{"age":18},
		{"age":78},
		{"age":30}]

def mycmp(a,b):
	if a > b:
		return -1
	elif a == b:
		return 0
	else:
		return 1

l = sorted(l5, key = lambda obj: obj["age"])

print(l)
输出结果：
[{'age': 3}, {'age': 18}, {'age': 30}, {'age': 78}, {'age': 89}]
例2：
	#coding=utf-8
l5 = [{"age":89},
		{"age":3},
		{"age":18},
		{"age":78},
		{"age":30}]

def mycmp(a,b):
	if a > b:
		return -1
	elif a == b:
		return 0
	else:
		return 1

l = sorted(l5, cmp = mycmp, key = lambda obj: obj["age"])

print(l)
输出结果：
	[{'age': 89}, {'age': 78}, {'age': 30}, {'age': 18}, {'age': 3}]

5、set集合：存放不重复，无序的数据
a)创建set：使用内置函数set()  参数是一个序列 
b)set操作：所有操作都是生成一个新的set对象
i.交集  &  求两个set 的公共元素
ii.并集  |   将两个set合成一个
iii.差集  -    a-b 找a中b没有的部分  b-a 找b中a没有的部分
iv.对称差 ^  不要公共部分
例：
#coding=utf-8

l1 = set((1, 2, 3, 4))
l2 = set([3, 4, 5, 6])
l7 = set("abc")

l3 = l1 | l7
print(l3)

l4 = l1 & l2
print(l4)

l5 = l1 - l2
print(l5)

l6 = l1 ^ l2
print(l6)
输出结果：
set(['a', 1, 2, 3, 4, 'b', 'c'])
set([3, 4])
set([1, 2])
set([1, 2, 5, 6])

c)for in     迭代器
例：
#coding=utf-8

class Person(object):

	def __init__(self,name,age):
		self.name = name
		self.age = age

s = set() # set()对象比较时,先比较哈希值,再比较__eq__
s.add(Person("xiao1",1))
s.add(Person("xiao2",2))
s.add(Person("xiao3",3))

for i in s:
	print i.age
输出结果：
1
2
3

d)自定义的类作为set的元素，必须写__eq__()和__hash__()两个函数，否则set无法分辨对象是否相等
例：
#coding=utf-8

class Person(object):

	def __init__(self,name,age):
		self.name = name
		self.age = age

	def __eq__(self,other):
		return self.name == other.name and self.age == other.age

	def __hash__(self):
		return self.age # 此处可以视为:将self.age作为哈希值返回
					# 这里应该有一套很复杂的算法

s = set() # set()对象比较时,先比较哈希值,再比较__eq__
s.add(Person("xiao1",1))
s.add(Person("xiao2",2))
s.add(Person("xiao3",3))

p = Person("xiao1",1)

print(p in s)
输出结果：
	Ture
注：如果没有__eq__和__hash__，输出结果为False

6、functools模块：存放一些工具的函数
a)partial：给指定函数生成默认参数
i.参数1：指定的函数
ii.参数2[…]：指定函数的参数，参数的数量取决于指定的函数

例：
#coding=utf-8

import functools

def fun(a):
	print(a)

newfun = functools.partial(fun,"haha")

newfun()
newfun()
newfun()
输出结果：
haha
haha
haha

b)warps：当一个函数被装饰器装饰后，该函数的__doc__  __module__  __name__属性都是装饰器的信息，使用warps可以指定为原函数的信息

例：
#coding=utf-8

import functools

def log(fun):

	@functools.wraps(fun)
	#若不加此句,调用fun1()时,会输出inner()的信息，而不是fun1()的信息
	def inner():
		"inner fun"
		fun()
	return inner

@log
def fun1():
	"fun1 fun"
	print("fun 1")

print(fun1.__doc__, fun1.__module__, fun1.__name__)
输出结果：
('fun1 fun', '__main__', 'fun1')
注：若不加@functools.wraps(fun)，输出结果为('inner fun', '__main__', 'inner')
```
