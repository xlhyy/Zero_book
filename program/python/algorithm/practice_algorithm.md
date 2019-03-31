### 数据结构与算法练习题


- 数据结构
```
计算机存储数据的形式。数据结构 = 数据 + 关系(结构)
```

- 数据结构分类：线性结构，树形结构，图形结构
```
线性结构：在存储关系上，每个元素都有一个前驱，都有一个后继（除了首节点，尾节点）
1-2-3-4-5-6-7
树形结构：在存储关系上，每个元素最多有一个前驱和多个后继
图形结构：在存储关系上，每个元素可以有多个前驱和多个后继。
```

- 算法
```
（1）时间复杂度：运行的快慢  T(n) = O(f(n))
时间复杂度定性描述了该算法的运行时间。
for i in range(10):  # 10次
	for j in range(10):	#10*10 = 10^2
		pass
		
T(n) = O(n^2)
T(n) = O(2*n^2)
T(n) = O(6*n^2)
T(n) = O(n^3) # 数量级

（2）空间复杂度：内存
空间复杂度是对一个算法在运行过程中临时占用存储空间大小的量度。
```


- 线性表
```
1）顺序表：数据存储时是连续的（列表）
a = 10  内存的存储
L = [1,2,3]

顺序表的操作：（列表）
创建空列表：L = []
列表的长度：len(L)
取出列表的某个元素：L.pop(1) 取出列表中下标为1的元素；若不写下标，默认取出列表中最后一个元素
插入：头插法：L.insert(0,数值)
	  尾插法：L.append(数值)，L.insert(len(L),数值)
	  任意位置插入：L.insert(,)
删除一个元素：L.remove(元素数值)
从列表里查询一个数：L.index(元素的数值) 返回值为下标值
列表的倒置：L.reverse() 返回值为倒置后的列表
列表元素的个数：L.count(元素的数值) 查询一个元素出现的次数
对列表进行排序：L.sort() 改变列表本身，进行排序，无返回值 --- sorted(L) 不改变列表本身，进行排序，返回值为排序后的列表

2）链表
链表与顺序表的区别：
顺序表：存储空间是连续的，插入和删除的时候，需要移动大量的数据，耗时的操作。
如果空间不够了，进行扩充的时候，需要重新申请内存空间，进行替换；
在初始申请内存空间的时候，必须指定大小。
链表：存储空间非连续；插入和删除的时候，不会移动大量的数据。
空间不够了，也不需要进行替换。

链表包括：数据域+指针域（链接域）
每个节点：数据 + 链接 

创建链表：
class Linklist(object):
	pass
	
linklist = Linklist()

操作方法：
（1）创建一个空链表
（2）是否为空 is_empty()
（3）链表的长度 length()
（4）遍历整个链表
（5）头插法
（6）尾插法
（7）指定位置插入
（8）删除一个链表节点
（9）查看一个数是不是在链表里

# 1.创建一个节点：数据 data + 链接 next
# node1 = Node(100)
class Node(object):
    def __init__(self,data):
        self.data = data
        self.next = None

# 2.创建链表：
# linklist = Linklist(node)
# linklist = Linklist()

class Linklist(object):
    def __init__(self, node=None):
        self.__head = node
单链表和单向循环链表
1.链表和顺序表的区别:
L = [1,2,3,4,5...]
顺序表：连续的内存空间；在插入，删除时，要移动大量的数据，耗时；在扩充时，需要进行大量的复制。
		在初始化时，必须指定大小；
链表：非连续的内存空间；在插入，删除时，不需要移动大量的数据；链表占用的空间大于顺序表

2.单向链表：
class Node(object):
	def __init__(self, data):
		self.data = data
		self.next = None
	
node = Node(100)

class Linklist(object):
	def __init__(self,node=None):
		self.__head = node

# l = Linklist()
操作：
创建链表
链表是不是空
链表长度
遍历
插入：头插法--尾插法---任意位置
删除节点
search(100)

单向链表：
class Node(object):
    def __init__(self, data):
        self.data = data
        self.next = None

# node = Node(100)
# l = Linklist(node)
# l = Linklist()

class Linklist(object):
    def __init__(self, node=None):
        self.__head = node

    def is_empty(self):
        return self.__head == None

    def length(self):
        count = 0
        cur = self.__head
        while cur: # cur != None
            count += 1
            cur = cur.next
        return count

    def travel(self):
        cur = self.__head
        while cur:
            print("%d " %cur.data, end="")
            cur = cur.next
        # 1 2 3
        # 1 2 3
        print("")

    def add(self, data):
        node = Node(data)
        node.next = self.__head
        self.__head = node

    def append(self, data):
        node = Node(data)
        cur = self.__head
        if self.__head == None:
            self.__head = node
        else:
            while cur.next:
                cur = cur.next
            cur.next = node

    def insert(self, pos, data):
        # pos 从0开始，下标
        if pos <= 0:
            self.add(data)
        elif pos > self.length() - 1:
            self.append(data)
        else:
            node = Node(data)
            count = 0
            cur = self.__head
            while count < pos-1:
                count += 1
                cur = cur.next
            node.next = cur.next
            cur.next = node

    def search(self, data):
        cur = self.__head
        while cur != None:
            if cur.data == data:
                return True
            else:
                cur = cur.next
        return False

    def remove(self, data):
        # 如果只有一个节点
        cur = self.__head
        pre = None
        while cur != None:
            if cur.data == data:
                # 如果删除的是头节点
                if cur == self.__head:
                    self.__head = cur.next
                else:
                    pre.next = cur.next
                break
            else:
                pre = cur
                cur = cur.next

if __name__ == "__main__":
    l  = Linklist()
    print(l.is_empty())
    print(l.length())
    l.append(1)
    l.append(2)
    l.add(3)
    # 3 1 2
    l.insert(1,4)
    # 3 4 1 2
    l.travel()
    print(l.search(4))
    print(l.search(5))
    l.remove(2)
l.travel()
```

```
练习1：两个有序链表，合并成一个有序的链表：
		例如：链表A：1->3->5->None
			  链表B：2->4->None
			  1-2-3-4-5-None

class Node(object):
    def __init__(self, data):
        self.data = data
        self.next = None

class Linklist(object):
    def __init__(self, node=None):
        self.head = node
    def travel(self):
        cur = self.head
        while cur:
            print("%d " %cur.data, end="")
            cur = cur.next
        # 1 2 3
        # 1 2 3
        print("")
    def append(self, data):
        node = Node(data)
        cur = self.head
        if self.head == None:
            self.head = node
        else:
            while cur.next:
                cur = cur.next
            cur.next = node

def Merge(l1, l2):
    node = Node(0) # 创建一个节点
    l3 = Linklist(node) # l3: node-, 临时节点
    p = l1.head
    q = l2.head
    r = l3.head
    while p != None and q != None:
        if p.data < q.data:
            r.next = p # node--1--2--3--4--5
            r = p
            p = p.next
        else:
            r.next = q
            r = q
            q = q.next
    if p == None:
        r.next = q
    else:
        r.next = p
    l3.head = l3.head.next
    return l3

if __name__ == "__main__":
    l1 = Linklist()
    l2 = Linklist()
    # 1 3 5
    for i in [x*2+1 for x in range(3)]:
        l1.append(i)
    # 2 4
    l2.append(2)
    l2.append(4)
    # tarvel
    l1.travel()
    l2.travel()
    l3 = Merge(l1, l2)
    l3.travel()
```
		  

```
练习2：链表的倒置输出： 1-2-3-4-5-6-7
					   输出：7-6-5-4-3-2-1

class Node(object):
    def __init__(self,data):
        self.data = data
        self.next = None

class Linklist(object):
    def __init__(self, node=None):
        self.head = node

    def travel(self):
        cur = self.head
        while cur:
            print("%d " %cur.data, end="")
            cur = cur.next
        print("")

    def append(self, data):
        node = Node(data)
        cur = self.head
        if self.head == None:
            self.head = node
        else:
            while cur.next != None:
                cur = cur.next
            cur.next = node
    
     #　递归思想：
    def reverse(self,cur):
        if cur:
            if cur.next:
                self.reverse(cur.next)
        print("%d " %cur.data, end='')

if __name__ == "__main__":
    linklist = Linklist()
    linklist.append(1)
    linklist.append(2)
    linklist.append(3)
    linklist.append(4)
    linklist.append(5)
    linklist.travel()
linklist.reverse(linklist.head)
```

```
3.单向循环链表
定义：
import sys, os
# 1.创建一个节点：数据 data + 链接 next
# node1 = Node(100)
class Node(object):
    def __init__(self,data):
        self.data = data
        self.next = None

# 2.创建链表：
# linklist = Linklist(node)
# linklist = Linklist()

class Linklist(object):
    def __init__(self, node=None):
        self.__head = node
        # 1.创建单向循环链表
        if node:
            node.next = node

    def is_empty(self):
        return self.__head == None

    def length(self):
        # count从1开始
        count = 1
        cur = self.__head
        if self.__head == None:
            return 0
        while cur.next != self.__head:
            count += 1
            cur = cur.next
        return count

    def travel(self):
        cur = self.__head
        if self.__head == None:
            print("h")
            return
        else:
            while cur.next != self.__head:
                print("%d " %cur.data, end="")
                cur = cur.next
            print("%d" %cur.data)

    def add(self, data):
        node = Node(data)
        cur = self.__head
        if self.__head == None:
            self.__head = node
            node.next = node
        else:
            while cur.next != self.__head:
                cur = cur.next
            node.next = self.__head
            self.__head = node
            cur.next = self.__head

    def append(self, data):
        node = Node(data)
        cur = self.__head
        if self.__head == None:
            self.__head = node
node.next = node
        else:
            while cur.next != self.__head:
                cur = cur.next
            cur.next = node
        node.next = self.__head

    def insert(self, pos, data):
        if pos <= 0:
            self.add(data)
        elif pos > (self.length() - 1):
            self.append(data)
        else:
            cur = self.__head
            # 怎么让while停下来，我们要到pos的前一个位置
            # 那么也可以计数，count 到pos-1 停下来
            count = 0
            while count < (pos - 1):
                count += 1
                cur = cur.next
            node = Node(data)
            node.next = cur.next
            cur.next = node

    def search(self, data):
        cur = self.__head
        while cur.next != self.__head:
            if cur.data == data:
                return True
            else:
                cur = cur.next
		# 判断尾节点
        if cur.data == data: 
            return True 
        return False

    def remove(self, data):
        cur = self.__head
        pre = None
        if self.__head == None:
            return
        while cur.next != self.__head:
            if cur.data == data:
                # 判断当前节点是不是首节点
                if cur == self.__head:
                    rear = self.__head
                    while rear.next != self.__head:
                        rear = rear.next
                    self.__head = cur.next
                    rear.next = self.__head
                else:
                    pre.next = cur.next  # 当删除的节点为尾节点时，也可以。
                return #break
            else:
                pre = cur
                cur = cur.next
        # 处理尾节点
        if cur.data == data:
            # 判断只有一个节点，因为pre没有next，报错
            if cur == self.__head:
                self.__head = None
            else:
                pre.next = self.__head

if __name__ == "__main__":
    linklist = Linklist()
    print(linklist.is_empty())
    print(linklist.length())
    linklist.travel()
    linklist.append(1)
    linklist.append(2)
    linklist.append(3)
    # 此时为： 1,2,3
    linklist.add(4)
    # 此时为：4,1,2,3
    print(linklist.is_empty())
    print(linklist.length())
    linklist.travel()
    linklist.insert(2,10)
    # 4 1 10 2 3
    linklist.travel()
    print(linklist.search(3))
    print(linklist.search(5))
    linklist.remove(3)
    linklist.travel()
```

```
练习：约瑟夫环问题
N个人围成1个圈，编号1---N，从1开始报数，
报到第M个人，这个人退出，接着从第M+1个人开始报数，
还是从1开始报数，到第M个人，他退出。
问你？退出的顺序。最后剩余哪个人？

方式1：数学
方式2：单向循环链表
N=6，M=5

方式1：数学
a = [x for x in range(1,7)]
print(a)
# [1,2,3,4,5,6] ---- del a[4]
# [1,2,3,4,6] ---- del a[4]
del_num = 4
while len(a) > 1:
    print("%d" %a[del_num])
    del a[del_num]
    del_num = (del_num+4)%len(a) #8%5==3
print("最后的：%d" %a[0])

方式2：
class Node(object):
    def __init__(self,data):
        self.data = data
        self.next = None

# 创建长度为n的单向循环链表
def create_linklist(n):
    if n <= 0:
        return
    elif n == 1:
        return Node(1)
    else:
        head = Node(1)
        cur = head
        for i in range(2,n+1):
            node = Node(i)
            cur.next = node
            cur = cur.next
        cur.next = head # 循环链表
        return head

def travel(head):
    cur = head
    while cur.next != head:
        print("%d " %cur.data, end="")
        cur = cur.next
    print("%d" %cur.data)

def josephus(n,m):
    head = create_linklist(n)
    cur = head
    while cur.next != cur:
        # cur指向m-1，
        for i in range(2, m):
            cur = cur.next
        print(cur.next.data)
        cur.next = cur.next.next
        cur = cur.next
    print("最后活着的是%d" %cur.data)

if __name__ == "__main__":
josephus(6,5)
```


- 双向链表-栈-队列
```
1.双向链表
双向链表：有一个数据域和两个指针域（prev+next）
定义：
class Node(object):
    def __init__(self, data):
        self.data = data
        self.prev = None
        self.next = None

class Linklist(object):
    def __init__(self, node=None):
        self.__head = node

    def is_empty(self):
        return self.__head == None

    def length(self):
        cur = self.__head
        count = 0
        while cur != None:
            count += 1
            cur = cur.next
        return count

    def travel(self):
        cur = self.__head
        while cur:
            print("%d " %cur.data, end="")
            cur = cur.next
        print("")

    def add(self, data):
        node = Node(data)
        node.next = self.__head
        self.__head.prev = node
        self.__head = node

    def append(self, data):
        cur = self.__head
        node = Node(data)
        if self.__head == None:
            self.__head = node
        else:
            while cur.next != None:
                cur = cur.next
            cur.next =node
            node.prev = cur

    def insert(self, pos, data):
        if pos <= 0:
            self.add(data)
        elif pos > self.length()-1:
            self.append(data)
        else:
            node = Node(data)
            cur = self.__head
            count = 0
            while count < pos:
                count += 1
                cur = cur.next
            node.next = cur
            node.prev = cur.prev
            cur.prev = node
            node.prev.next = node

    def search(self, data):
        cur = self.__head
        while cur != None:
            if cur.data == data:
                return True
            else:
                cur = cur.next
        return False

    def remove(self, data):
        node = Node(data)
        cur = self.__head
        while cur:
            if cur.data == data:
                # 删除的是头节点
                if cur.prev == None:
					self.__head = cur.next
                    if cur.next:                      
                        cur.next.prev = None       
                else:
                    cur.prev.next = cur.next
                    if cur.next:
                        cur.next.prev = cur.prev
                break
            else:
                cur = cur.next

if __name__ == "__main__":
    l  = Linklist()
    l.append(1)
    l.append(2)
    l.add(3)
    l.insert(1,4)
    # 3 4 1 2
    l.travel()
    print(l.search(4))
    l.remove(2)
l.travel()
```


- 栈（Stack）
```
栈：线性表中的一种，它只允许在容器的一端加入数据，拿出数据（栈顶top）
	加入：push()，删除，顶出：pop()
	
栈的定义：
（1）创建一个栈
（2）栈是不是空
（3）栈的大小
（4）入栈
（5）出栈
（6）获得栈顶的元素

代码：
'''
用顺序表的list实现一个栈
'''

class Stack(object):
    def __init__(self):
        self.__list = []  #栈顶：尾部是栈顶，入栈（压栈），出栈【1,2,3....】

    def is_empty(self):
        return self.__list == []

    def size(self):
        return len(self.__list)

    def push(self, data):
        self.__list.append(data)

    def pop(self):
        return self.__list.pop()

    def peek(self):
        if self.__list:
            return self.__list[-1]
        else:
            return None

if __name__ == "__main__":
    s = Stack()
    s.push(1)
    s.push(2)
    s.push(3)
    # 123
    print(s.pop())
    print(s.pop())
print(s.pop())
```

```
练习：s = "3+4*5-2+8/4" 表达式的计算
算法：两个栈，一个存num数字，一个存symbol字符；
	  如果是数字，直接入数字栈；
	  如果是字符，当字符栈为空，入栈；否则，进行比较；
				  比较优先级的大小，优先级高，入栈，优先级不高，出栈运算。

'''
用顺序表的list实现一个栈
'''

（老师的版本）
class Stack(object):
    def __init__(self):
        self.__list = []  #栈顶：尾部是栈顶，入栈（压栈），出栈【1,2,3....】

    def is_empty(self):
        return self.__list == []

    def size(self):
        return len(self.__list)

    def push(self, data):
        self.__list.append(data)

    def pop(self):
        return self.__list.pop()

    def peek(self):
        if self.__list:
            return self.__list[-1]
        else:
            return None

if __name__ == "__main__":
    s = "3+4*5-2+8/4"
    num_s = Stack()
    symbol_s = Stack()
    i = 0
    while i < len(s):
        # 数字
        if s[i] >= '0' and s[i] <= '9':
            num_s.push(int(s[i]))
        # 字符
        else:
            # 是空，入栈
            if symbol_s.is_empty():
                symbol_s.push(s[i])
            else:# 不是空，比较  现有：*   >    栈顶：+ , 入栈；否则，计算
                x = symbol_s.peek() #栈顶
                y = s[i] #现有的字符
                if x == "*" or  x == "/":
                    x = 1
                if y == "*" or  y == "/":
                    y = 1
                if x == "+" or  x == "-":
                    x = 0
                if y == "+" or  y == "-":
                    y = 0
                if y <= x:
                    x = num_s.pop()
                    y = num_s.pop()
                    sym = symbol_s.pop()
                    if sym == "*":
                        num_s.push(y*x)
                    elif sym == "/":
                        num_s.push(y/x)
                    elif sym == "+":
                        num_s.push(y+x)
                    elif sym == "-":
                        num_s.push(y-x)
                    continue
                else:
                    symbol_s.push(s[i])
        i += 1

    while not symbol_s.is_empty():
        x = num_s.pop()
        y = num_s.pop()
        sym = symbol_s.pop()
        if sym == "*":
            num_s.push(y * x)
        elif sym == "/":
            num_s.push(y / x)
        elif sym == "+":
            num_s.push(y + x)
        elif sym == "-":
            num_s.push(y - x)
    res = num_s.pop()
print("result = %d" %res)

（自己的版本）
class Stack(object):
    def __init__(self):
        self.list = []

    def is_empty(self):
        return self.list == []

    def size(self):
        return len(self.list)

    def push(self, data):
        self.list.append(data)

    def pop(self):
        return self.list.pop()

    def peek(self):
        if self.list:
            return self.list[-1]
        else:
            return None

if __name__ == "__main__":
    s = Stack()
    num_stack = Stack()
    symbol_stack = Stack()
    string = "3+4*5-2+8/4"
    for i in string:
        print(num_stack.list)
        print(symbol_stack.list)
        print("="*20)
        if i in ["1","2","3","4","5","6","7","8","9","0"]:
            i = int(i)
            num_stack.push(i)
        if i in ["+","-","*","/"]:
            if symbol_stack.list == []:
                symbol_stack.push(i)
            else:
                if (i in ["+","-"]) and ("*" not in symbol_stack.list) and ("/" not in symbol_stack.list):
                    if symbol_stack.pop() == "+":
                        num_stack.push(num_stack.pop()+num_stack.pop())
                    else:
                        num1 = num_stack.pop()
                        num2 = num_stack.pop()
                        num_stack.push(num2 - num1)
                    symbol_stack.push(i)
                elif (i in ["*","/"]) and (("+" in symbol_stack.list) or ("-" in symbol_stack.list)):
                    symbol_stack.push(i)
                elif (i in ["+","-"]) and (("*" in symbol_stack.list) or ("/" in symbol_stack.list)):
                    while symbol_stack.list != []:
                        if symbol_stack.pop() == "*":
                            num_stack.push(num_stack.pop()*num_stack.pop())
                        elif symbol_stack.pop() == "/":
                            num_stack.push(num_stack.pop()/num_stack.pop())
                        if symbol_stack.pop() == "+":
                            num_stack.push(num_stack.pop()+num_stack.pop())
                        else:
                            num1 = num_stack.pop()
                            num2 = num_stack.pop()
                            num_stack.push(num2-num1)
                    symbol_stack.push(i)

    print(num_stack.list)
    print(symbol_stack.list)
    print("="*20)

    while symbol_stack.list != []:
        num1 = num_stack.pop()
        num2 = num_stack.pop()
        x = symbol_stack.pop()
        if x == "/":
            num_stack.push(num2/num1)
        elif x == "*":
            num_stack.push(num2*num1)
        elif x == "+":
            num_stack.push(num2+num1)
        elif x == "-":
            num_stack.push(num2-num1)

    print(num_stack.list)
    print(symbol_stack.list)
print(num_stack.pop())
```

- 队列
```
队列：它只允许在一端插入（入队），一端删除（出队）。先进先出的线性表（FIFO）
		允许插入的一端为队尾，允许删除的一端是队头。
		
定义：
'''
用list实现queue
'''
创建队列：
是不是空：
队列的大小：
出队：
入队：

class Queue():
    def __init__(self):
        self.__list = []
    def is_empty(self):
        return self.__list == []
    def size(self):
        return len(self.__list)
    '''
    让列表尾当队尾[1,2,3...]
    '''
    def enqueue(self, data):
        self.__list.append(data)

    def dequeue(self):
        return self.__list.pop(0)

if __name__ == "__main__":
    q = Queue()
    q.enqueue(1)
    q.enqueue(2)
    q.enqueue(3)
    print(q.dequeue())
    print(q.dequeue())
print(q.dequeue())
```

-双端队列
```
（队列+栈: 双端队列在功能上相当于队列和栈;
在双端队列的一端可以插入与删除，相当于入栈和出栈）
```

```
class Queue():
    def __init__(self):
        self.__list = []
    def is_empty(self):
        return self.__list == []
    def size(self):
        return len(self.__list)
    '''
    让列表尾当队尾[1,2,3...]
    '''
    def add_first(self, data):
        self.__list.insert(0, data)

    def add_last(self, data):
        self.__list.append(data)

    def pop_first(self):
        return  self.__list.pop(0)
    def pop_last(self):
        return self.__list.pop()

if __name__ == "__main__":
    q = Queue()
    q.enqueue(1)
    q.enqueue(2)
    q.enqueue(3)
    print(q.dequeue())
    print(q.dequeue())
print(q.dequeue())
```


- 排序和查找
```
1.排序
排序算法的稳定性：
(2,2),(1,7),(1,4),(3,1)
结果：
(1,7)(1,4)(2,2)(3,1)  :当排序时，出现的子序列(1,7)(1,4)和原有的序列的顺序是一致的话，这个就是稳定
(1,4)(1,7)(2,2)(3,1)  :当排序时，出现的子序列(1,4)(1,7)和原有的序列的顺序是不一致的话，这个就是不稳定
```

```
（1）冒泡排序 Bubble_sort()
重复的遍历整个序列，每次比较2个元素，如果前一个大于后一个，对这两个元素进行交互位置，直到没有在需要交换的元素；
从头到尾的每次交换，能找到一个最大值。

'''
方式1：
def bubble_sort(l):
    n = len(l)
    for i in range(1,n): #1,n或n-1
        for j in range(n-i):
            if l[j] > l[j+1]:
                l[j], l[j+1] = l[j+1], l[j]

'''

'''
方式2：
def bubble_sort(l):
    n = len(l)
    for i in range(n-1): #1,n或n-1 -- i:0,1,2...
        for j in range(n-(i+1)): #j:0,1,2...  n-1,n-2,n-3
            if l[j] > l[j+1]:
                l[j], l[j+1] = l[j+1], l[j]
'''
'''
方式3：
def bubble_sort(l):
    n = len(l)
    for i in range(n-1,0,-1): #1,n或n-1 -- i:0,1,2...
        for j in range(i): #j:0,1,2...  n-1,n-2,n-3..1
            if l[j] > l[j+1]:
                l[j], l[j+1] = l[j+1], l[j]
'''

#优化
def bubble_sort(l):
    n = len(l)
    for i in range(1, n): #1,n或n-1 -- i:0,1,2...
        count = 0
        for j in range(n-i): #j:0,1,2...  n-1,n-2,n-3..1
            if l[j] > l[j+1]:
                l[j], l[j+1] = l[j+1], l[j]
                count += 1
        if count == 0:
            print("第%d次排序退出" %i)
            break

if __name__ == "__main__":
    #l = [16, 22, 24, 30, 44, 56, 88, 95]
    l = [56, 24, 44, 16, 95, 22, 88, 30]
    bubble_sort(l)
    print(l)
```

```
（2）选择排序 select_sort
L = [56, 24, 44, 16, 95, 22, 88, 30]

思路：假定整个序列由2部分组成，一部分有序，一部分无序；我们从无序的序列中找到其中的最小值，放到有序的末端。
	  初始时，默认有序的序列为[],整个序列都是无序的，找到其中的最小值，用 min 记录，最后用min对应的值和l[i=0]互换。
	  以此类推，同时默认每次的min的初始值都为无序的首个元素的下标

def select_sort(l):
    n = len(l)
    for i in range(n-1): # 一共n-1次  n-1 --- 1, n
        min = i
        for j in range(i+1, n): #i:0--n-1  1---n-2  2---n-3
            # min = 0/1/2/3...
            if l[min] > l[j]: #j:1/2/3...
                min = j
        l[min], l[i] = l[i], l[min]

if __name__ == "__main__":
    #l = [16, 22, 24, 30, 44, 56, 88, 95]
    l = [56, 24, 44, 16, 95, 22, 88, 30]
    select_sort(l)
    print(l)
```
	
```
（3）插入排序 insert_sort
认为列表有两部分，一部分有序，一部分无序；有序此时默认的是第一个元素。
然后用后面的无序序列中的第一个和有序序列比较，从后往前比较，看看是不是比前面的元素小，小就互换。

'''
def insert_sort(l):
    n = len(l)
    for i in range(1,n): # 1,n 或 n-1
        for j in range(i): #j:0
            if l[i] < l[i-1]:
                l[i], l[i-1] = l[i-1], l[i]
            i -= 1
'''
'''
def insert_sort(l):
    n = len(l)
    for i in range(1,n): # 1,n 或 n-1 n:1,2,3,4
        for j in range(i): #j:0,1 j=0,1
            if l[i] < l[j]:
                l[i], l[j] = l[j], l[i]
'''

def insert_sort(l):
    '''
     i = 1
    if l[i] < l[i-1]:
        l[i], l[i-1] = l[i-1] ,l[i]

    i = 2
    if l[i] < l[i - 1]:
        l[i], l[i - 1] = l[i - 1], l[i]
    i -= 1
    '''
    n = len(l)
    for i in range(1,n):
        while i > 0:
            if l[i] < l[i - 1]:
                l[i], l[i - 1] = l[i - 1], l[i]
            i -= 1

if __name__ == "__main__":
    #l = [16, 22, 24, 30, 44, 56, 88, 95]
    l = [56, 24, 44, 16, 95, 22, 88, 30]
    insert_sort(l)
    print(l)
```
	

```
（4）快速排序 quick_sort()
从序列中取出第一个数，作为边界条件，判断此数应该在哪个位置。
用一个mid接收这个数，然后用两个游标low和high进行左右夹击，找到第一个数的具体位置，此时low=high，
把mid放到这个位置

'''
递归的思想：函数自身调用自身，把规模较大的问题，转化成规模较小的问题
    递归注意：终止条件
    缺点：容易造成死循环，消耗内存空间。
'''
def quick_sort(l, start, end):
    #n = len(l)
    if start >= end:  # 只有一个元素的时候，就不用找了
        return

    low = start #0，0，6
    high = end #7，4，7
    mid_vaule = l[start] #0

    while low < high:
        while low < high and l[high] >= mid_vaule: # 30>56
            high -= 1
        l[low] = l[high]

        while low < high and l[low] < mid_vaule: # 95>56
            low += 1
        l[high]=l[low]
    l[low] = mid_vaule

    quick_sort(l, start, low-1) # 0--4
    quick_sort(l, low+1,end) #6-7

if __name__ == "__main__":
    l = [34, 56, 24, 44, 56, 16, 95, 22, 56, 88, 30]
    n = len(l)
    quick_sort(l,0,n-1)
    print(l)
```

```
（5）归并排序
思想：先递归分散解组，再合成一个新的序列

def merge_sort(l): #  最后一次：l = [56, 24]
    # 拆分
    n = len(l)
    if n<=1:
        print(l)
        return l
    mid = int(n/2) # n//2 8/2=4
    # l --mid
    #l[:mid] #[:4] 0,1,2,3
    #l[mid:]
    left_list = merge_sort(l[:mid]) # [56]
    right_list = merge_sort(l[mid:]) # [24]
	
	# 上面的merge_sort不执行到结束，不会往下面去执行:left=0和right=0
	# merge_sort 一旦有返回值，那么left_list和right_list就有新的列表
	# merge_sort 结束的条件是：或者是 return ret 但是这个在函数的最后面，在解组列表前都不会执行到
	#if n<=1:
    #    print(l)
    #    return l
	
    left = 0 #游标
    right = 0 #游标
    ret = []
    while left < len(left_list) and right < len(right_list):
        if left_list[left] < right_list[right]:
            ret.append(left_list[left])
            left += 1
        else:
            ret.append(right_list[right])
            right += 1
    ret += left_list[left:]
    ret += right_list[right:]
    print(ret)
    return ret

if __name__ == "__main__":
    l = [56, 24, 44, 16, 95, 22, 88, 30]
    new = merge_sort(l)
    print(new)
	
输出：代码的执行顺序
[56]
[24]
[24, 56]
[44]
[16]
[16, 44]
[16, 24, 44, 56]
[95]
[22]
[22, 95]
[88]
[30]
[30, 88]
[22, 30, 88, 95]
[16, 22, 24, 30, 44, 56, 88, 95]
[16, 22, 24, 30, 44, 56, 88, 95]
```

- 查找
```
折半查找（二分法查找）-----针对有序的序列
优点：比较次数少，查询速度快
缺点：必须是有序的序列表

l = [14,34,44,56,66,71,80,98]
low = 0
high = n-1
折半：(low+high)/2

递归和非递归：
（1）递归形式：
def half_search(l, data):
    n = len(l)
    if n > 0:
        mid = int(n/2)
        if data == l[mid]:
            return (mid, l[mid])
        elif data < l[mid]:
            return half_search(l[:mid] ,data)
        else:
            return half_search(l[mid+1:], data)
    return None

if __name__ == "__main__":
    l = [13, 23, 33, 35, 56, 67, 77, 82, 95]
    print(l)
    m = half_search(l,33)
    if m:
        print("[%s]:%s" %m)
    else:
        print(None)
		
（2）非递归形式：
def half_search(a, x):
    n = len(a)
    l = 0
    h = n-1
    while l<=h:
        m = int((l+h)/2)
        if a[m] == x:
            return (m, a[m])
        elif x < a[m]:
            h = m-1
        else:
            l = m+1
    return None

if __name__ == "__main__":
    l = [13, 23, 33, 35, 56, 67, 77, 82, 95]
    print(l)
    m = half_search(l,33)
    if m:
        print("[%s]:%s" %m)
    else:
        print(None)
```


- 二叉树
```
1. 树形结构
(1)特点：树中的每个节点，都有一个前驱和多个后继节点（除了根节点）
(2)二叉树：Binary Tree 每个节点最多有2个子节点。
(3)树的概念：
节点的度：节点的分支数，父节点有多少个子节点，这个就是度
叶子节点(终端节点)：度为0的节点
节点的层次：树的根节点的层数为1
树的深度：树的层数
树的度：树中最大的节点度数，二叉树的度：最大是2
左子树：
右子树：
（4）二叉树的种类：
完全二叉树：假设树的深度是n,除了n层外，其余的各层的节点数目均达到最大值。并且叶子节点从左向右依次不间断排布。

满二叉树：除了根节点外，其余每个节点都有左右两个子节点，并且叶子节点只能在最底层。

平衡二叉树：当且仅当任何节点的两颗左右子树的高度差<=1

知识点补充：
平衡二叉树(AVL)：它或者是一颗空树，或者具有以下性质的二叉树：它的左子树和右子树的深度之差(平衡因子)的绝对值不超过1，且它的左子树和右子树都是一颗平衡二叉树。

完全二叉树：若设二叉树的高度为h，除第 h 层外，其它各层 (1～h-1) 的结点数都达到最大个数，第h层有叶子结点，并且叶子结点都是从左到右依次排布，这就是完全二叉树。

（5）二叉树的特性：
二叉树的每个节点都有序号：
根节点：1
根的左子节点：2
根的右子节点：3

(针对完全二叉树)有一个节点它的编号是i，其左子节点的编号：2*i
						其右子节点的编号是：2*i+1
1).在第i层上，最多有多少个节点：（2^(i-1)）
2).深度为k的二叉树，最多有多少个节点：2^k - 1（a1*(1-q^n)/1-q: 1*(1-2^i)/1-2）
3).如果当前二叉树的叶子节点数为N0，度数为2的节点数为N2， N2+1 = N0

（6）二叉树的遍历：
先序遍历：根 - 左子树 - 右子树
中序遍历：左 - 根 - 右 
后序遍历：左 - 右 - 根

（7）二叉树的定义
import time

class Node(object):
    def __init__(self, data):
        self.data = data
        self.lchild = None
        self.rchild = None

# 创建一个二叉树
class BinaryTree(object):
    def __init__(self):
        self.root = None

    '''
    层次遍历：广度遍历
    '''
    # 添加一个节点
    def add(self, data):
        node = Node(data)
        if self.root is None:
            self.root = node
            return # 注意一定加上return
        queue = [self.root] #队列
        while queue:
            cur_node = queue.pop(0)
            if cur_node.lchild is None:
                cur_node.lchild = node
                return
            else:
                queue.append(cur_node.lchild)
            if cur_node.rchild is None:
                cur_node.rchild = node
                return
            else:
                queue.append(cur_node.rchild)

    # 层次遍历输出,广度遍历
    def breadth_travel(self):
        if self.root is None:
            return
        queue = [self.root]
        while queue:
            cur_node = queue.pop(0) # d,e,
            print("%s " %cur_node.data, end="")

            if cur_node.lchild is not None:
                queue.append(cur_node.lchild)
            if cur_node.rchild is not None:
                queue.append(cur_node.rchild)
        print("")

    # 前序遍历
    def pre_order(self, node):
        if node is None:
            return # A-B-D-C
        print("%s " %node.data, end="")
        self.pre_order(node.lchild)
        self.pre_order(node.rchild)

    # 中序遍历
    def in_order(self, node):
        if node is None:
            return # A
        self.in_order(node.lchild) # B
        print("%s " %node.data, end="")
        self.in_order(node.rchild)

    # 后序遍历
    def post_order(self, node):
        if node is None:
            return
        self.post_order(node.lchild)
        self.post_order(node.rchild)
        print("%s " %node.data, end="")

if __name__ == "__main__":
    tree = BinaryTree()
    tree.add('A')
    tree.add('B')
    tree.add('C')
    tree.add('D')
    tree.add('E')
    tree.add('F')
    tree.add('G')
    tree.add('H')
    tree.add('I')
    tree.add('J')
    tree.breadth_travel()
    tree.pre_order(tree.root) # A
    print("")
    tree.in_order(tree.root)
    print("")
    tree.post_order(tree.root)
    print("")
```

```
练习：让用户输入10个节点，输入完毕后，前序，中序，后序，进行输出

class Node(object):
    def __init__(self, data):
        self.data = data
        self.lchild = None
        self.rchild = None

class BinaryTree(object):
    def __init__(self):
        self.root = None

    def add(self, data):
        node = Node(data)
        if self.root is None:
            self.root = node
            return
        queue = [self.root]
        while queue:
            cur_node = queue.pop(0)
            if cur_node.lchild is None:
                cur_node.lchild = node
                return
            else:
                queue.append(cur_node.lchild)
            if cur_node.rchild is None:
                cur_node.rchild = node
                return
            else:
                queue.append(cur_node.rchild)

    def breadth_travel(self):
        if self.root is None:
            return
        queue = [self.root]
        while queue:
            cur_node = queue.pop(0)
            print("%d " %cur_node.data, end="")
            if cur_node.lchild is not None:
                queue.append(cur_node.lchild)
            if cur_node.rchild is not None:
                queue.append(cur_node.rchild)

    def pre_order(self, node):
        if node is None:
            return
        print("%d " %node.data, end="")
        self.pre_order(node.lchild)
        self.pre_order(node.rchild)

    def in_order(self, node):
        if node is None:
            return
        self.in_order(node.lchild)
        print("%d " %node.data, end="")
        self.in_order(node.rchild)

    def post_order(self, node):
	    def post_order(self, node):
        if node is None:
            return
        self.post_order(node.lchild)
        self.post_order(node.rchild)
        print("%s " %node.data, end="")

if __name__ == "__main__":
    tree = BinaryTree()
    data = []
    print("请输入10个节点的数据：")
    for i in range(10):
        data.append(int(input("数据%d：" %(i+1))))
    print(data)
    for i in data:
        tree.add(i)
    tree.pre_order(tree.root)
    print("")
    tree.in_order(tree.root)
    print("")
    tree.post_order(tree.root)
    print("")
```

```
（8）常见的操作：
1.当前树的叶子节点数：

递归方式：
def leaves_count(self, node):
	if node is None:
		return 0
	if node.lchild is None and node.rchild is None:
		return 1
	else:
		return self.leaves_count(node.lchild) +  self.leaves_count(node.rchild)

非递归方式：
def leaves_count(self):
	queue = [self.root]
	count = 0
	while queue:
		cur_node = queue.pop(0)
		if cur_node.lchild is not None:
			queue.append(cur_node.lchild) # 2
		if cur_node.rchild is not  None:
			queue.append(cur_node.rchild)
		if cur_node.lchild is None and cur_node.rchild is None:
			count += 1
	return  count

2.统计当前树的节点数
def get_size(self):
	if self.root is None:
		return 0
	queue = [self.root]
	size = 0
	while queue:
		cur_node = queue.pop(0)
		size += 1
		if cur_node.lchild:
			queue.append(cur_node.lchild)
		if cur_node.rchild:
			queue.append(cur_node.rchild)
	return size
	
3. 非递归实现前序，中序，后序遍历
用栈实现先序遍历：stack = []  ---- 列表尾：栈顶： -出栈pop() --入栈：append()

def pre_order(self, node):
	if node is None:
		return
	cur_node = node
	stack = []
	while stack or cur_node:
		while cur_node:  # 4.循环操作【根-左】操作
			print("%s " %cur_node.data, end="") #1. A,B 只用这个print打印当前的节点，最开始打印根节点
			stack.append(cur_node) #3.[A,B] 因为下次移动游标后，无法找到右子节点，为了获得右节点，把根节点存入到stack,用根节点.rchild找到右子节点
			cur_node = cur_node.lchild #2. cur_node = B cur_node移动到左子节点，为了打印左子节点。
		# 5.循环退出后，根-左 都已经输出，此时从树的最底层，处理右子节点，即从栈顶拿出右子节点的父节点
		cur_node = stack.pop() #B,A
		cur_node = cur_node.rchild #None,C # cur_node指向右节点，进入到上面的循环
		
中序：
def in_order(self, node):
	if node is None:
		return
	stack = []
	cur_node = node
	while stack or cur_node:
		while cur_node:
			stack.append(cur_node) # [C]
			cur_node = cur_node.lchild #B,None
		cur_node = stack.pop()
		print("%s " %cur_node.data, end="") #B
		cur_node = cur_node.rchild #None,C

后序：
def post_order(self, node):
	if node is None:
		return
	cur_node = node
	stack1 = []
	stack2 = [] #存放后序遍历的所有数据，根，右，左
	stack1.append(cur_node)
	while stack1:
		cur_node = stack1.pop() # []
		if cur_node.lchild:
			stack1.append(cur_node.lchild) # B
		if cur_node.rchild:
			stack1.append(cur_node.rchild) # C
		stack2.append(cur_node) # A [B,C]

	while stack2:
		cur_node = stack2.pop() # 左右根
		print("%s " %cur_node.data, end="")
```
