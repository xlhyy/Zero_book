### 继承


- 继承举例
```
# coding=utf-8

# 继承有什么好处？最大的好处是子类获得了父类的全部功能。由于Animal实现了run()方法，因此，Dog和Cat作为它的子类，什么事也没干，就自动拥有了run()方法：

class Animal(object):
    def run(self):
        print 'Animal is running ...'

class Dog(Animal):
    pass

class Cat(Animal):
    pass

dog = Dog()
dog.run()

cat = Cat()
cat.run()

# 输出结果：
# Animal is running ...
# Animal is running ...
```


```
# coding=utf-8

# 继承的第二个好处是我们可以对父类的方法进行重写，调用时调用的是自身重写之后的方法。

class Animal(object):
    def run(self):
        print 'Animal is running ...'

class Dog(Animal):
    def run(self):
        print 'Dog is running ...'

class Cat(Animal):
    def run(self):
        print 'Cat is running ...'

dog = Dog()
dog.run()

cat = Cat()
cat.run()

# 输出结果：
# Dog is running ...
# Cat is running ...
```


- 多态举例
```
# coding=utf-8

# 当子类和父类都存在相同的run()方法时，我们说，子类的run()覆盖了父类的run()，在代码运行的时候，总是会调用子类的run()。这样，我们就获得了继承的另一个好处：多态。
# 要理解什么是多态，我们首先要对数据类型再作一点说明。当我们定义一个class的时候，我们实际上就定义了一种数据类型。我们定义的数据类型和Python自带的数据类型，比如str、list、dict没什么两样

class Animal(object):
    def run(self):
        print 'Animal is running ...'

class Dog(Animal):
    def run(self):
        print 'Dog is running ...'

class Cat(Animal):
    def run(self):
        print 'Cat is running ...'

animal = Animal()
dog = Dog()
cat = Cat()

print isinstance(animal, Animal)
print isinstance(animal, Dog)

print isinstance(dog, Dog)
print isinstance(dog, Animal)

# Dog可以看成Animal，但Animal不可以看成Dog

# 输出结果：
# True
# False
# True
# True
```

```
# coding=utf-8

class Animal(object):
    def run(self):
        print 'Animal is running ...'

def run_twice(animal):
        animal.run()
        animal.run()

class Dog(Animal):
    def run(self):
        print 'Dog is running ...'

class Cat(Animal):
    def run(self):
        print 'Cat is running ...'

class Tortoise(Animal):
    def run(self):
        print 'Tortoise is running slowly...'

run_twice(Animal())
run_twice(Dog())
run_twice(Cat())
run_twice(Tortoise())

"""
nimal的子类，不必对run_twice()做任何修改，实际上，任何依赖Animal作为参数的函数或者方法都可以不加修改地正常运行，原因就在于多态。

多态的好处就是，当我们需要传入Dog、Cat、Tortoise……时，我们只需要接收Animal类型就可以了，因为Dog、Cat、Tortoise……都是Animal类型，然后，按照Animal类型进行操作即可。由于Animal类型有run()方法，因此，传入的任意类型，只要是Animal类或者子类，就会自动调用实际类型的run()方法，这就是多态的意思：

对于一个变量，我们只需要知道它是Animal类型，无需确切地知道它的子类型，就可以放心地调用run()方法，而具体调用的run()方法是作用在Animal、Dog、Cat还是Tortoise对象上，由运行时该对象的确切类型决定，这就是多态真正的威力：调用方只管调用，不管细节，而当我们新增一种Animal的子类时，只要确保run()方法编写正确，不用管原来的代码是如何调用的。这就是著名的“开闭”原则：

对扩展开放：允许新增Animal子类；

对修改封闭：不需要修改依赖Animal类型的run_twice()等函数。
"""

# 输出结果：
# Animal is running ...
# Animal is running ...
# Dog is running ...
# Dog is running ...
# Cat is running ...
# Cat is running ...
# Tortoise is running slowly...
# Tortoise is running slowly...
```


- 总结
```
继承可以把父类的所有功能都直接拿过来，这样就不必重零做起，子类只需要新增自己特有的方法，也可以把父类不适合的方法覆盖重写；

有了继承，才能有多态。在调用类实例方法的时候，尽量把变量视作父类类型，这样，所有子类类型都可以正常被接收；

旧的方式定义Python类允许不从object类继承，但这种编程方式已经严重不推荐使用。任何时候，如果没有合适的类可以继承，就继承自object类。
```
