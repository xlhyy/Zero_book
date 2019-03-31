### 迭代器


```
# coding=utf-8

class MyIter(object):
    def __init__(self, iterable):
        self.iterable = iterable
        self.index = 0

    def __iter__(self):
        print('call __iter__')
        return self

    def next(self):
        print('call __next__')
        if self.index < len(self.iterable):
            value = self.iterable[self.index]
            self.index += 1
            return value
        else:
            raise StopIteration

if __name__ == '__main__':
    iterable = [1,2,3]
    myIterator = MyIter(iterable)
    for i in range(5):
        print(next(myIterator))
```
