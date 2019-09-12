## python设计模式


### 单例模式(创建型模式)

```
单例模式（Singleton Pattern）是一种常用的软件设计模式，该模式的主要目的是确保某一个类只有一个实例存在。当你希望在整个系统中，某个类只能出现一个实例时，单例对象就能派上用场。

比如，某个服务器程序的配置信息存放在一个文件中，客户端通过一个 AppConfig 的类来读取配置文件的信息。如果在程序运行期间，有很多地方都需要使用配置文件的内容，也就是说，很多地方都需要创建 AppConfig 对象的实例，这就导致系统中存在多个 AppConfig 的实例对象，而这样会严重浪费内存资源，尤其是在配置文件内容很多的情况下。事实上，类似 AppConfig 这样的类，我们希望在程序运行期间只存在一个实例对象
```

#### 实例

```
# coding: utf-8


class Singleton(object):
	def __init__(self):
		pass

	def __new__(cls, *args, **kwargs):
		if not hasattr(Singleton, "_instance"):
			Singleton._instance = object.__new__(cls)
		return Singleton._instance

obj1 = Singleton()
obj2 = Singleton()
print obj1, obj2


结果:
<__main__.Singleton object at 0x105255950> <__main__.Singleton object at 0x105255950>
```

### 工厂模式(创建型模式)

```
工厂模式是一个在软件开发中用来创建对象的设计模式。

工厂模式包涵一个超类。这个超类提供一个抽象化的接口来创建一个特定类型的对象，而不是决定哪个对象可以被创建。

为了实现此方法，需要创建一个工厂类创建并返回。 

当程序运行输入一个“类型”的时候，需要创建于此相应的对象。这就用到了工厂模式。在如此情形中，实现代码基于工厂模式，可以达到可扩展，可维护的代码。当增加一个新的类型，不在需要修改已存在的类，只增加能够产生新类型的子类。
```

#### 实例

```
# coding: utf-8

#汽车父类
class Car(object):
	def move(self):
		print("车在移动...")
	
	def music(self):
		print("正在播放音乐...")
	
	def stop(self):
		print("车在停止...")


#具体汽车类
class Suonata(Car):
	pass

class Yilante(Car):
	pass

##################################

#工厂类
class Factory(object):
	#具体实现
	def select_car_by_type(self, car_type):
		if car_type == "索纳塔":
			return Suonata()
		elif car_type == "伊兰特":
			return Yilante()

##################################

#汽车店
class CarStore(object):
	#创建工厂，返回工厂对象引用
	def __init__(self):
		self.factory = Factory()

	#实现业务
	def order(self, car_type):
		return self.factory.select_car_by_type(car_type)


if __name__ == '__main__':
	car_store = CarStore()
	car = car_store.order("索纳塔")
	car.move()
	car.music()
	car.stop()


结果:
车在移动...
正在播放音乐...
车在停止...
```

### 适配器模式(结构型模式)

```
所谓适配器模式是指是一种接口适配技术，它可通过某个类来使用另一个接口与之不兼容的类，运用此模式，两个类的接口都无需改动。

适配器模式主要应用于希望复用一些现存的类，但是接口又与复用环境要求不一致的情况，比如在需要对早期代码复用一些功能等应用上很有实际价值。

应用场景:系统数据和行为都正确,但接口不符合时,目的是使控制范围之外的一个原有对象与某个接口匹配,适配器模式主要应用于希望复用一些现存的类,但接口又与复用环境不一致的情况
```

```

```

#### 实例

```

```

### 补充

```
（1）_xxx      "单下划线 " 开始的成员变量叫做保护变量，意思是只有类对象（即类实例）和子类对象自己能访问到这些变量，需通过类提供的接口进行访问；不能用'from module import *'导入
（2）__xxx     类中的私有变量/方法名 （Python的函数也是对象，所以成员方法称为成员变量也行得通。）," 双下划线 " 开始的是私有成员，意思是只有类对象自己能访问，连子类对象和类对象（即类实例）也不能访问到这个数据。
（3）__xxx__   系统定义名字，前后均有一个“双下划线” 代表python里特殊方法专用的标识，如 __init__() 代表类的构造函数。
```

