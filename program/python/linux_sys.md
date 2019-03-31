### linux系统开发


```
目录
1.Linux系统编程-进程_________________________________________1
2.Linux系统编程-进程间通信_______________________________22
3.Linux系统编程-线程________________________________________29
4.Linux网络编程-UDP________________________________________40
5.Linux网络编程-TCP________________________________________53
6.Linux网络编程-服务器与客户端__________________________61
7.Linux网络编程-正则表达式_______________________________67
8.Linux网络编程-web服务器_______________________________77



Linux系统编程-进程
1.并发和并行
并发：看起来像一起运行，5个任务4个CPU
并行：真正是一起运行的，3个任务4个CPU

2.
多任务：用户可以在同一时间内运行多个应用程序，每个应用程序都是一个任务。

3.进程
程序：可执行的代码
进程：正在执行的程序

区别：程序是静态的，进程是动态的；

4.创建进程
（1）创建进程
fork()
大于0：父进程
==0： 子进程
注：os.fork()不支持windows系统

例1：
import os

os.fork() # 创建子进程,子进程运行进度与主进程相同
print("hello")
输出结果：
hello
hello

练习1：创建一个子进程，父进程循环输出：“father”, 子进程循环输出“child”
#coding=utf-8
import os
import time

x = os.fork()
# os.fork()的返回值在主进程中>0,在子进程中=0,所以说os.fork()有两个返回值

# 输出结果体现了时间片轮转
if x > 0:
	while True:
		print("father")
		time.sleep(1)
else:
	while True:
		print("child")
		time.sleep(1)
输出结果：
father
child
father
	child
	father
	child
		…

（2）fork返回值

os.fork()：大于0，进程号，PID，进程的唯一标识符；
PPID：父进程号

os.getpid():获得当前进程的pid
os.getppid():获得当前的父进程号PPID

练习2：获得父进程的pid，获得子进程的pid和PPID
	#coding=utf-8
import os

ret = os.fork()

if ret == 0:
	print("子进程的pid: %s" %(os.getpid()))
	print("子进程的ppid: %s" %(os.getppid()))
else:
	print("父进程的pid: %s" %(os.getpid()))
输出结果：
父进程的pid:2970
子进程的pid:2971
子进程的ppid:2970
	
（3）父进程和子进程结束
例1：
#coding=utf-8
import os
import time

ret = os.fork()

# linux系统只有在父进程结束后才会给一个提示栏
if ret == 0:
	print("子进程开始")
	for i in range(5):
		print("hello")
		time.sleep(1)
		print(os.getppid())
	print("子进程结束")

else:
	print("父进程")
	time.sleep(1)
	print("父进程结束")
输出结果：
父进程
子进程开始
hello
父进程结束
2994
hello
linux@ubuntu:~/farsight/03-linux系统编程/01-进程$ 1
hello
1
hello
1
hello
1
子进程结束

例2：
#coding=utf-8
import os
import time

ret = os.fork()

# linux系统只有在父进程结束后才会给一个提示栏
if ret == 0:
	print("子进程开始")
	for i in range(5):
		print("hello")
		time.sleep(1)
		print(os.getppid())
	print("子进程结束")

else:
	print("父进程")
	#time.sleep(6)
	os.wait() # 父进程等待子进程结束后再结束
			  # 阻塞等待
	print("父进程结束")
输出结果：
父进程
子进程开始
hello
3028
hello
3028
hello
3028
hello
3028
hello
3028
子进程结束
父进程结束

os.wait():阻塞等待子进程结束；回收子进程结束时的资源；
（子进程的资源：退出时的状态，pid）

os.wait()返回值：元组;包括：退出时的状态：0--子进程正常退出，正整数--子进程异常退出；
返回值为包含两个元素的元组，包括已完成的子进程号pid，以及子进程的退出状态。
	
（4）
孤儿进程：父先结束，子进程在结束，叫做孤儿进程；回收是由init（pid=1）进程(第一启动进程)回收。
僵尸进程：子进程先结束，父进程后结束，但是父进程没有回收子进程的资源，叫做僵尸进程；

危害：（僵尸进程）
1).占用内存空间，
2).如果僵尸进程太多，占用pid，导致系统无法创建新进程
处理：两次fork（），父-子-孙   然后结束子进程

（5）查看进程号
ps -ef:查看当前系统下的所有的进程号
top:动态的显示进程号
kill pid

（6）全局变量和父子进程
import os
import time

num = 10

ret = os.fork()

if ret == 0:
	global num
	num += 1
	print("子进程num = %d" %num)

else:
	time.sleep(1)
	print("父进程num = %d" %num)
	os.wait()
输出结果：
子进程num = 11
父进程num = 10
	
父子进程互不影响，全局变量也不共享；

（7）多次fork()
例1：
#coding=utf-8
import os

ret = os.fork()
if ret > 0:
	print("111")
else:
	print("222")

ret = os.fork()
if ret > 0:
	print("333")
else:
	print("444")
输出结果：
111
333
linux@ubuntu:~/farsight/03-linux系统编程/01-进程$ 222
333
444
444

例2：
#coding=utf-8
import os
import time

pid = os.fork()

if pid == 0:
	print("111")
else:
	print("222")
	pid = os.fork()
if pid == 0:
		print("333")
	else:
		print("444")
	time.sleep(1)
输出结果：
222
444
111
333

练习1：
import os

os.fork()	
os.fork()
os.fork()

print"*" #输出8次	
输出结果：
*
*
*
*
*
*
linux@ubuntu:~/farsight/03-linux系统编程/01-进程$ *
*

（8）避免僵尸进程的产生：
两次fork：父进程fork()产生一个子进程，子进程再fork()一次，产生孙子进程，立刻把子进程退出；
孙子进程变成孤儿进程，由init进程回收孙子进程的资源。由系统回收父进程的资源。

（9）multiprocessing

类Process：创建进程模块（多平台）

例：
#coding=utf-8
from multiprocessing import Process
import time

def test():
	while True:
		print("子进程")
		time.sleep(1)

p = Process(target = test) # 创建一个进程实例化对象
p.start() # 开启进程

while True:
	print("父进程")
	time.sleep(1)
输出结果：
父进程
子进程
父进程
子进程
父进程
子进程
…

Process是一个类，用的时候要创建一个实例化对象，然后启动

（10）父进程等待子进程结束Process

例：
#coding=utf-8

from multiprocessing import Process
import time

def test():
	for i in range(5):
		time.sleep(1)
		print("子进程在运行")

p = Process(target = test) # 运行时包含子进程资源回收
p.start()

print("父进程结束")
输出结果：
父进程结束
子进程在运行
子进程在运行
子进程在运行
子进程在运行
子进程在运行

注：没有弹出提示框，是因为父进程阻塞等待子进程结束，当子进程结束后，父进程才结束。

（11）给子进程传递参数：args, name为当前子进程的别名

p = Process(target=test, args=(name, ), name="Mary")

例1：
#coding=utf-8

from multiprocessing import Process
import time

name = "hello"

def test(name):
	for i in range(5):
		time.sleep(1)
		print("name = %s "%name)

p = Process(target = test, args = (name,), name = "Mary") # 运行时包含子进程资源回收
p.start()
print(p.name) # 若Process中未定义name = "Mary",输出process-n,n从1开始递增
print(p.pid) # 创建的子进程的进程号
print(p.is_alive()) # 判断子进程是否还存在
p.join() # 默认让父类无限等待(此时参数为None);传n,代表等待n秒
		 # 此条语句作用为阻塞等待(当子进程结束后才继续执行)
print("父进程结束")

输出结果：
Mary
3329
True
name = hello 
name = hello 
name = hello 
name = hello 
name = hello 
父进程结束

例2：
#coding=utf-8

from multiprocessing import Process
import time

name = "hello"

def test(name):
	for i in range(5):
		time.sleep(1)
		print("name = %s "%name)

p = Process(target = test, args = (name,)) # 运行时包含子进程资源回收
p.start()
print(p.name) # 若Process中未定义name = "Mary",输出process-n,n从1开始递增
print(p.name) # 若Process中未定义name = "Mary",输出process-n,n从1开始递增
print(p.pid) # 创建的子进程的进程号
print(p.is_alive()) # 判断子进程是否还存在
#p.join() # 默认让父类无限等待(此时参数为None);传n,代表等待n秒
		 # 此条语句作用为阻塞等待(子进程结束后,父进程才可以结束)

print("父进程结束")
输出结果：
Process-1
Process-1
3378
True
父进程结束
name = hello 
name = hello 
name = hello 
name = hello 
name = hello

例3：
#coding=utf-8
from multiprocessing import Process
import time

name = "hello"

def test(name):
	for i in range(5):
		time.sleep(1)
		print("name=%s"%name)

p = Process(target=test,args=(name,))
p.start()
print(p.name)
print(p.pid)
print(p.is_alive())
p.join()

p = Process(target=test,args=(name,))
print(p.name)

print("父进程结束")
输出结果:
	Process-1
3452
True
name=hello
name=hello
name=hello
name=hello
name=hello
Process-2
父进程结束
注：
（1）Process的特点是父进程不会先结束，一直等待子进程，子进程结束了，再退出程序
（2）打印的“父进程结束”，不代表父进程结束，只代表父进程最后输出的内容是那个
（3）join是保证父进程在此处阻塞等待子线程结束，不再执行父线程后面的代码
（4）不加join，父进程会一直执行代码，直到没有程序可执行，再去等待子进程结束

（12）Process常见的属性和方法

name: 创建的子进程的别名， 默认的名字：Process-N N从1开始递增
pid:创建的子进程的进程号
is_alive(): 判断子进程是不是还存在。存在：True ,否则：False
join():父进程阻塞等待子进程结束，回收资源。

（13）Process子类创建进程
例：
from multiprocessing import Process

class MyProcess(Process):

	def __init__(self, name): #创建对象时执行
		Process.__init__(self)
		#super(MyProcess, self).__init__()
		self.name = name
	
	def run(self): #start时执行
		print("子进程")
		print("name = %s" %self.name)

p = MyProcess("2")
print("父进程 name = %s" %p.name)
p.name = "xiaowang"
p.start()
p.name = "xiaoli"
print("父进程 name = %s" %p.name)

print("父进程")

输出结果：
父进程 name = 2
父进程 name = xiaoli
父进程
子进程
name = xiaowang

（14）进程池
例1：
#coding=utf-8
from multiprocessing import Pool
import os
import time

def test(i):
	print("子进程%d pid: %s"%(i,os.getpid()))
	time.sleep(1)

#创建进程池
pool = Pool(3) # 若不写个数,默认创建电脑内核个数个

for i in range(10):
	pool.apply_async(test, (i,))

time.sleep(2)
print("父进程结束")
输出结果：
子进程0 pid: 3472
子进程1 pid: 3473
子进程2 pid: 3474
子进程3 pid: 3473
子进程4 pid: 3472
子进程5 pid: 3474
父进程结束

例2：
#coding=utf-8
from multiprocessing import Pool
import os
import time

def test(i):
	print("子进程%d pid: %s"%(i,os.getpid()))
	time.sleep(1)

#创建进程池
pool = Pool(3) # 若不写个数,默认创建电脑内核个数个

for i in range(10):
	pool.apply_async(test, (i,))

pool.close() # 除了以上程序中的请求以外的请求都不接收
#pool.apply_async(test, (i,)) # 由于pool.close限制,报错

#time.sleep(2)
#pool.terminate() # 不管进程池有没有结束,都立马退出 
pool.join() # pool.join()必须在pool.close()后使用,不然会报错

print("父进程结束")
输出结果：
子进程0 pid: 3672
子进程1 pid: 3673
子进程2 pid: 3674
子进程3 pid: 3673
子进程4 pid: 3672
子进程5 pid: 3674
子进程6 pid: 3672
子进程7 pid: 3674
子进程8 pid: 3673
子进程9 pid: 3672
父进程结束

练习：
#coding=utf-8
from multiprocessing import Pool
import os,time,random

def test(i):
	print("请%d号客户到%s窗口办理业务"%(i, os.getpid()%100))
	time.sleep(random.randint(1,3))

#创建进程池
pool = Pool(3)

for i in range(10):
	pool.apply_async(test, (i,))
	#非阻塞,将请求依次放入队列中,进程池再从队列中取请求


pool.close()
pool.join()
print("暂停服务")
输出结果：
请0号客户到25窗口办理业务
请1号客户到27窗口办理业务
请2号客户到26窗口办理业务
请3号客户到25窗口办理业务
请4号客户到27窗口办理业务
请5号客户到26窗口办理业务
请6号客户到25窗口办理业务
请7号客户到27窗口办理业务
请8号客户到27窗口办理业务
请9号客户到26窗口办理业务
暂停服务

（15）多进程执行不同的函数Pool（2个CPU）
#coding=utf-8
from multiprocessing import Pool, Process
import os, time, random


s1 = time.time()

def fun1():
	print("fun1")
	time.sleep(1)
def fun2():
	print("fun2")
	time.sleep(1)
def fun3():
	print("fun3")
	time.sleep(1)
def fun4():
	print("fun4")
	time.sleep(1)


l = [fun1,fun2,fun3,fun4]
pool = Pool(4)

for i in range(4):
	pool.apply_async(l[i])

pool.close()
pool.join()

s2 = time.time()
print("程序运行时间为:%.2f秒"%(s2-s1))
输出结果:
	fun1
fun2
fun4
fun3
程序运行时间为:1.03秒

（16）多进程执行不同的函数Pool（2个CPU）
#coding=utf-8
from multiprocessing import Pool, Process
import os, time, random


s1 = time.time()

def fun1():
	print("fun1")
	time.sleep(1)
def fun2():
	print("fun2")
	time.sleep(1)

l = [fun1,fun2]
pool = Pool(2)

for i in range(2):
	pool.apply_async(l[i])

pool.close()
pool.join()

s2 = time.time()
print("程序运行时间为:%.2f秒"%(s2-s1))
输出结果：
fun1
fun2
程序运行时间为:1.04秒

注：结果证明，CPU数量对于在同一时刻有多少个进程池同时运行无直接影响。

（17）多进程执行不同的函数Process（2个CPU）
#coding=utf-8
from multiprocessing import Pool, Process
import os, time, random


s1 = time.time()

def fun1():
	print("fun1")
	time.sleep(1)
def fun2():
	print("fun2")
	time.sleep(1)

p1 = Process(target=fun1)
p2 = Process(target=fun2)
p1.start()
p2.start()

os.wait()
s2 = time.time()
print("程序运行时间为:%.2f秒"%(s2-s1))
输出结果:
fun2
fun1
程序运行时间为:1.01秒

（18）多进程执行不同的函数Process（2个CPU）
#coding=utf-8
from multiprocessing import Pool, Process
import os, time, random


s1 = time.time()

def fun1():
	print("fun1")
	time.sleep(1)
def fun2():
	print("fun2")
	time.sleep(1)
def fun3():
	print("fun3")
	time.sleep(1)
def fun4():
	print("fun4")
	time.sleep(1)

p1 = Process(target=fun1)
p2 = Process(target=fun2)
p3 = Process(target=fun3)
p4 = Process(target=fun4)
p1.start()
p2.start()
p3.start()
p4.start()

os.wait()
s2 = time.time()
print("程序运行时间为:%.2f秒"%(s2-s1))
输出结果：
fun2
fun1
fun4
fun3
程序运行时间为:1.02秒

注：结果表明，CPU数量对在同一时刻有多少个进程同时执行无直接影响。

（14）回调函数
例：
#coding=utf-8
from multiprocessing import Pool
import time

def read(i):
	temp = open(i, "r")
	ret = temp.read()
	temp.close()
	return ret

def write(ret):
	new = open("./new.txt", "a")
	new.write(ret)
	new.close()

def main():
	pool = Pool(3)
	file_name = ["a.txt", "b.txt", "c.txt"]
	for i in file_name:
		pool.apply_async(read, (i, ), callback = write)
	pool.close()
	pool.join()

if __name__ == "__main__":
	main()
输出结果：
linux@ubuntu:~/farsight/03-linux系统编程/01-进程$ cat a.txt
aaaaaaaaaaaaaaaaaaaaa
linux@ubuntu:~/farsight/03-linux系统编程/01-进程$ cat b.txt
bbbbbbbbbbbbbbbbbbbb
linux@ubuntu:~/farsight/03-linux系统编程/01-进程$ cat c.txt
ccccccccccccccccccccccccccc
linux@ubuntu:~/farsight/03-linux系统编程/01-进程$ cat new.txt 
aaaaaaaaaaaaaaaaaaaaa
bbbbbbbbbbbbbbbbbbbb
ccccccccccccccccccccccccccc

知识点补充：
1.os.wait()回收子进程资源pid，阻塞等待

2.进程池的好处：
1). 加快了进程的创建速度
2). 提高了进程的利用率
3). 充当缓存区，当请求比较快的时候，起到限流的作用

3.常用的函数
pool = Pool(容量) #最大的进程数
pool.apply_async(执行的目标, (执行目标的参数,)) #非阻塞
pool.close() 进程池不再接受新的请求，如果接受新的请求，抛出异常。
pool.terminate() 不管进程池结束没有，都立马退出。
pool.join() 必须使用的，主进程阻塞等待进程池的所有的子进程结束，在执行
		 必须close之后使用

4.进程池的特点：
（1）初始化进程池时可以指定最大进程数；
（2）当有新的请求提交到进程池时，如果池还没满，就创建新的进程用来执行该请求；
（3）如果进程池已满，那么该请求就会等待，直到池中有进程结束，才会创建新的进程来执行；
（4）主进程不会等待进程池的结束，需要使用Pool.join()函数等待进程池的结束。
			
5.
if __name__ == '__main__':
	main()
	
#__name__ == "__main__":代表xxx.py执行的时候，为真，执行里面的代码；
#当xxx.py当做模块被导入时，为假，不执行里面的代码

6.random.random()获得0-1秒之间的随机秒数

7.回调函数使用情景：
当进程池的子进程一旦处理结束，主进程想立马分析数据，可以使用回调函数。

8. apply_async() 非阻塞
apply() 阻塞: 当只有一个进程池时，可以理解为:只有当上一个请求执行结束时，才能接受下一个请求。当有多个进程池时，参考下面实例。

例1：apply练习（一个进程池）
#coding=utf-8
from multiprocessing import Pool
import os
import time

def test(i):
	print("子进程%d pid: %s"%(i,os.getpid()))
	time.sleep(1)

#创建进程池
pool = Pool(1) # 若不写个数,默认创建电脑内核个数个

for i in range(10):
	pool.apply(test, (i,))

print("父进程结束")
输出结果：
子进程0 pid: 4040
子进程1 pid: 4040
子进程2 pid: 4040
子进程3 pid: 4040
子进程4 pid: 4040
子进程5 pid: 4040
子进程6 pid: 4040
子进程7 pid: 4040
子进程8 pid: 4040
子进程9 pid: 4040
父进程结束

例2：apply练习（3个进程池）
#coding=utf-8
from multiprocessing import Pool
import os
import time

def test(i):
	print("子进程%d pid: %s"%(i,os.getpid()))
	time.sleep(1)

#创建进程池
pool = Pool(3) # 若不写个数,默认创建电脑内核个数个

for i in range(10):
	pool.apply(test, (i,))

time.sleep(2)
print("父进程结束")
输出结果：
子进程0 pid: 4081
子进程1 pid: 4082
子进程2 pid: 4083
子进程3 pid: 4081
子进程4 pid: 4082
子进程5 pid: 4083
子进程6 pid: 4081
子进程7 pid: 4082
子进程8 pid: 4083
子进程9 pid: 4081
父进程结束





















Linux系统编程-进程间通信
1.进程间通信：
在c语言：消息队列，共享内存，管道，信号，信号量，socket
在Python：队列，管道，socket

（1）Queue队列
from multiprocessing import Queue
q = Queue(3) #3:容量，队列的最大长度
q.empty() #队列是不是空的
q.full() #队列是不是满了
q.qsize() #队列的数据个数
q.put(obj, block, timeout)	#block:默认True，阻塞；timeout:默认None,可以大小
#q.put("1") 默认当队列满时，一直阻塞，直到有人从队列取出一个数据；
value = q.get(block, timeout) #block:默认True，阻塞；timeout:默认None,可以大小
#value = q.get() 默认当队列为空时，一直阻塞等待获取，直到有人往队列里放数据。
q.put_nowait(obj) #如果队列满了，直接抛出异常 queue.Full
value = q.get_nowait() #如果队列为空， 直接抛出异常， queue.Empty

练习1：
创建2个进程，一个负责往队列写入数据，一个从Queue读取数据，并打印。
#coding=utf-8

from multiprocessing import Process, Queue
import time

from Queue import Empty 
#此条语句中的Queue,若在python2中为Queue,在python3中为queue

def read(q):
	#读数据
	time.sleep(1)
	while True:
		'''
		if q.empty():
			break
		else:
			value = q.get()
			print("get %d" %value)
			time.sleep(1)
			'''
		
		try:
			value = q.get_nowait()
			print("get %d" %value)
			time.sleep(1)
		except Empty:
			break

def write(q):
	#写数据
	for i in range(5):
		q.put(i)
		print("put %d to queue" %i)
		time.sleep(1)

def main():
	#1.创建队列q
	q = Queue(3) # Queue支持Process,不支持进程池

	#2.创建2个进程read,write,把q当做参数传到进程
	pw = Process(target = write, args = (q, ))
	pr = Process(target = read, args = (q, ))

	pw.start()
	pr.start()

	pw.join()
	pr.join()
	print("数据接收完成")

if __name__ == "__main__":
	main()
输出结果：
put 0 to queue
get 0
put 1 to queue
get 1
put 2 to queue
get 2
put 3 to queue
get 3
put 4 to queue
get 4
数据接收完成


（2）multiprocessing.Manager().Queue()
Manager().Queue()针对于进程池

#coding=utf-8

from multiprocessing import Pool, Manager
import time, Queue

def write(q):
		for i in range(3):
			q.put(i)
			print("put %d to queue" %i)
			time.sleep(1)

def read(q):
	while True:
		if q.empty():
			print("数据接收OK")
			break
		else:
		 	value = q.get()
			print("get %d" %value)
			time.sleep(1)

def main():
	q = Manager().Queue()
	pool = Pool(3)
	pool.apply_async(write, (q, ))
	pool.apply_async(read, (q, ))

	pool.close()
	pool.join()

if __name__ == "__main__":
	main()
输出结果：
put 0 to queue
get 0
put 1 to queue
get 1
put 2 to queue
get 2
数据接收OK

知识点总结：
1)
Pool有Pool.close()和Pool.join()
Process没有Process.close(),只有Process.join()

2)
from multiprocessing import Process, Queue
from Queue import Empty # 此条语句中的Queue,若在python2中为Queue,在python3中为queue
q = Queue(3) # Queue支持Process,不支持进程池

3)
from multiprocessing import Pool, Manager
q = Manager().Queue() # Manager().Queue()针对于进程池

（3）Pipe 管道  单/双工 

单工：单方向的通信，指定方向，例如：广播电台
单双工：不能在同一时刻发送和接收，例如：对讲机
双工：在任何时刻可以发送和接收，例如：手机

创建管道：
from multiprocessing import Pipe
pipe = Pipe() #参数：默认True：代表双工，Fasle:单工
#pipe是元组，(out_pipe, in_pipe)
#如果是单工，第一个out_pipe一定是输出端，第二个一定是输入端
#如果是双工可以互相通信

out_pipe, in_pipe = pipe
发送：in_pipe.send(obj)
接收：value = out_pipe.recv()

注意：在同一个进程内必须关闭一个管道端口，在另外一个进程内必须关闭另外一个端口
并且这两个端口必须是一个输入端和一个输出端。

管道退出：当已经通信的管道，关闭输入端，并且输出端无法再从管道获取数据后，
抛出异常EOFError

练习1：
#coding=utf-8

from multiprocessing import Pipe, Process
import time

def test(out_pipe,in_pipe):
	while True:
		try:
			in_pipe.close()
			msg = out_pipe.recv()
			print("msg: %d" %msg)
			time.sleep(1)
		except EOFError: # 文件以EOF表示结束,一行文件以\n表示结束
			print("输入端已经关闭,退出!")
			break

def main():
	out_pipe, in_pipe = Pipe() # Pipe()默认参数为True,代表双工;当为False,代表单工
	p = Process(target = test, args = (out_pipe, in_pipe))
	p.start()

	out_pipe.close()
	for i in range(10):
		in_pipe.send(i)
		time.sleep(1)
	
	in_pipe.close()

if __name__ == "__main__":
	main()
输出结果：
msg: 0
msg: 1
msg: 2
msg: 3
msg: 4
msg: 5
msg: 6
msg: 7
msg: 8
msg: 9
输入端已经关闭,退出!

项目：多进程拷贝文件
>>> for i in range(10):
...     print(i)
... 
0
1
2
3
4
5
6
7
8
9
>>> for i in range(10):
...     print(i, end="") #输出不换行，python3的用法
... 
0123456789>>> 

>>> print("abcd\rmnopqrst") #\r回车，光标回到当前行的首位置，产生类似覆盖的效果
mnopqrst
>>> print("abcdefgh\rmn")
mncdefgh

>>> print("%.2f" %a)
0.80
>>> print("%.2f%%" %a) #输出%，用两个%，相当于转义效果
0.80%
>>> print("%.2f%%" %(a*100)) #输出%,别忘记乘以100
80.00%
>>> print("%.f%%" %(a*100))
80%
>>> print("%d%%" %(a*100))
80%

练习1：
实现进度条，输出：当前进度是n% ,每隔一秒涨1%。
并且在同一行输出。
#coding=utf-8
import time

i = 0
n = 100
while i <= n:
	rate = i/n
	#print "\r%d%%"%(i), # 1.行缓存满了 2.程序结束,刷新缓存区 3.强制中断 4.换行符
	print("当前进度是%d%%" %(rate*100), end = "\r")
	#print("\r当前进度是%d%%"%(i),end="")
	time.sleep(1)
	i += 1
输出结果：
	当前进度是2%

练习2：多进程文件拷贝
#coding=utf-8
import os
from multiprocessing import Pool, Manager

def copy_file(name, old_dir_name, new_dir_name, q):
	#old_dir_name: 01-进程 
	fr = open(old_dir_name + "/" + name, "r")
	fw = open(new_dir_name + "/" + name, "w")

	content = fr.read()
	fw.write(content)

	fr.close()
	fw.close()

	q.put(name)

def main():
	#1.创建目录：输入目录名：“01-进程”
	old_dir_name = input("请输入目录名：")
	new_dir_name = old_dir_name + "-副本"
	os.mkdir(new_dir_name)
	#2.获得文件名
	all_file_name = os.listdir(old_dir_name)

	pool = Pool(5)
	q = Manager().Queue(10)

	for name in all_file_name:
		pool.apply_async(copy_file, (name,old_dir_name, new_dir_name, q))

	i = 0
	n = len(all_file_name)

	while i < n:
		q.get()
		i += 1
		rate = i/n
		print("\r当前的进度是%.2f" %(rate*100), end="")

	print("\n拷贝完成！")

	pool.close()
	pool.join()

if __name__ == '__main__':
		main()
输出结果：
请输入目录名：01-进程
当前的进度是100.00
拷贝完成！

注：当所要拷贝的文件夹内有文件夹时，文件夹不能被拷贝，且程序不能结束
例：
请输入目录名：01-进程
当前的进度是96.88

知识点补充：put()和get()是阻塞的。



























Linux系统编程-线程
1.线程
（1）线程与进程的区别和联系
进程：一个程序的执行过程，资源分配的基本单位。
线程：轻量级的进程，线程依赖进程存在，进程创建线程，进程退出了，线程就不存在了。
	  程序执行的基本单位，CPU调度的基本单位。

一个进程执行起来后，里面都有一个线程，叫主线程。

（2）创建线程
from threading import Thread

def test(s):
	print(s)

t = Thread(target = test, args = ("hello", ))
t.start()
输出结果：
hello

（3）Thread子类
from threading import Thread
import time

class MyThread(Thread):
	def run(self):
		for i in range(3):
			msg = self.name + "@" + str(i)
			time.sleep(1)
			print(msg)

if __name__ == "__main__":
	t = MyThread()
	t.start()
输出结果：
Thread-1@0
Thread-1@1
Thread-1@2

Thread-N: N:从1开始递增

（4）线程的执行顺序
练习：创建3个线程（i），每个线程都输出"线程%d" %i
	  验证：线程的输出顺序。
#coding-utf-8

from threading import Thread
import time

'''
def test(args):
	while True:
		print("线程%d" %args)
		time.sleep(1)

if __name__ == "__main__":
	for i in range(3):
		t = Thread(target = test, args = (i, ))
		t.start()
		'''
class MyThread(Thread):
	def __init__(self, args):
		Thread.__init__(self)
		self.args = args
	
	def run(self):
		while True:
			print("线程%d" %self.args)
			time.sleep(1)

if __name__ == "__main__":
	for i in range(3):
		t = MyThread(i)
		t.start()
输出结果：
线程0
线程1
线程2
线程0
线程1
线程2
线程0
线程1
线程2
…

（5）线程和全局变量
from threading import Thread
import time
num = 10

def test1():
	global num
	num += 1
	print("test1:num = %d" %num)


def test2():
	global num
	print("test2:num = %d" %num)

if __name__ == "__main__":
	t1 = Thread(target = test1)
	t1.start()
	time.sleep(1)
	t2 = Thread(target = test2)
	t2.start()	
输出结果：
test1:num = 11
test2:num = 11

知识点总结:
(1)线程共享所处进程中的资源
(2)进程间的全局变量不共享,多进程间也互不影响
(3)多线程也互不影响,但在同一进程内,多线程可以共享所有的资源

（6）线程与全局变量混乱的BUG
from threading import Thread
import time

n = 0

def test1():
	global n
	for i in range(1000000):
		n += 1
	print("test1: n = %d" %n)

def test2():
	global n
	for i in range(1000000):
		n += 1
	print("test2: n = %d" %n)

if __name__ == "__main__":
	t1 = Thread(target=test1)
	t1.start()
	t2 = Thread(target=test2)
	t2.start()
输出结果：
test1: n = 1167314
test2: n = 1301877

（7）避免BUG的方法： 
from threading import Thread
import time

n = 0

#避免混乱的方法2
flag = 1

def test1():
	global n
	global flag
	if flag == 1:
		for i in range(100000):
			n += 1
		print("test1:n = %d" %n)
		flag = 0

def test2():
	global n
	global flag
	while True: #轮询
		if flag == 0:
			for i in range(100000):
				n += 1
			print("test2:n = %d" %n)
			flag = 1
			break

#由于时间片轮转,两个线程中会不停地对n进行两次赋值,造成混乱

if __name__ == "__main__":
	t1 = Thread(target = test1)
	t1.start()

	#避免混乱的方法1
	#time.sleep(2) #加延时可以避免混乱,不过时间不能确定

	t2 = Thread(target = test2)
	t2.start()
输出结果：
test1:n = 100000
test2:n = 200000

（8）互斥锁 mutex
	 
	 n=0 :共有资源，临界资源（全局变量）
	 
Thread 1     	 Thread 2
上锁（抢到）	上锁 （阻塞等待）
操作n	 		操作n
解锁	 		解锁

from threading import Lock

创建互斥锁：mutex = Lock()
上锁：mutex.acquire()
解锁：mutex.release()

上锁：
acquire(blocking=True, timeout=-1)
blocking：阻塞
timeout=-1：永远阻塞

练习：避免全局变量使用的BUG，使用互斥锁的形式。
from threading import Thread, Lock
import time

n = 0
mutex = Lock()

def test1():
	global n
	mutex.acquire()	
	for i in range(100000):
		n += 1
	mutex.release()
	print("test1:n = %d" %n)

def test2():
	global n
	for i in range(100000):
		mutex.acquire()	
		n += 1 # 操作共有资源时,时间越短越好
		mutex.release()
	print("test2:n = %d" %n)

if __name__ == "__main__":
	t1 = Thread(target = test1)
	t1.start()
	t2 = Thread(target = test2)
	t2.start()
输出结果：
test1:n = 100000
test2:n = 200000

（9）死锁

两个锁mutexA和mutexB
两个线程Thread_1 和 Thread_2

Thread_1					Thread_2
mutexA.acquire():			mutexB.acquire():
	time.sleep(1)				time.sleep(1)
	mutexB.acquire				mutexA.acquire()

（10）避免死锁

方式1：在程序设计时，避免死锁产生
方式2：添加延时时间，timeout=N 

#coding=utf-8
from threading import Thread, Lock
import time

mutexA = Lock()
mutexB = Lock()

"""创建死锁"""
class Thread1(Thread):
	def run(self):
		if mutexA.acquire():
			print("A1")
			time.sleep(1)
			if mutexB.acquire(timeout=1):
				print("B1")
				mutexB.release()
		mutexA.release()

class Thread2(Thread):
	def run(self):
		if mutexB.acquire():
			print("B2")
			time.sleep(1)
			if mutexA.acquire(timeout=1):
				print("A2")
				mutexA.release()
		mutexB.release()

if __name__ == "__main__":
	t1 = Thread1()
	t2 = Thread2()
	t1.start()
	t2.start()
输出结果：
A1
B2
A2

知识点补充：
因为是死锁，死在输出A1和B2之后，此时如果不加timeout=1,那么就卡死了，加了之后，因为线程1先执行，在1秒的延时内，他没有获得到锁，那么返回False，代码不会被执行，但是因为此时A被解锁，所以线程2可以上锁，继续执行代码。

（11）
同步：协调步调，程序按照约定的顺序去执行
例如：两个线程，一个负责收集数据，一个负责分析数据，如果分析数据的线程没有得到数据，就一直阻塞等待，
直到有数据。这就是同步。

异步：上面两个线程，分析线程没有得到数据，不阻塞等待，而是执行下面的操作。
当有收集数据线程得到数据后，通知下分析线程。

Thread1, Thread2, Thread3

同步例子：
练习：3个线程，每个线程输出"Test1-2-3" 
	  用：互斥锁，3个互斥锁，初始：2个锁上，1个没上锁。
	 
from threading import Thread, Lock
import time

lock1 = Lock()
lock2 = Lock()
lock3 = Lock()

class Test1(Thread):
	def run(self):
		while True:
			if lock1.acquire():
				print("Test1")
				time.sleep(1)
				lock2.release()

class Test2(Thread):
	def run(self):
		while True:
			if lock2.acquire():
				print("Test2")
				time.sleep(1)
				lock3.release()

class Test3(Thread):
	def run(self):
		while True:
			if lock3.acquire():
				print("Test3")
				time.sleep(1)
				lock1.release()

if __name__ == "__main__":
	t1 = Test1()
	t2 = Test2()
	t3 = Test3()

	lock2.acquire()
	lock3.acquire()

	t1.start()
	t2.start()
	t3.start()
输出结果：
Test1
Test2
Test3
Test1
Test2
Test3
…

异步例子：
#coding=utf-8
from multiprocessing import Pool
import time, os

def test():
	print("子进程: pid = %d, ppid = %d" %(os.getpid(), os.getppid()))
	for i in range(3):
		print("%d" %i)
		time.sleep(1)
	return "hello"

def fun(args):
	print("fun: args = %s" %args)
	print("fun: %d" %os.getpid())

if __name__ == "__main__":
	pool = Pool(3)
	pool.apply_async(func = test, callback = fun)
	while True:
		print("主进程: %d" %os.getpid())
		time.sleep(1)
	#pool.close()
	#pool.join()
输出结果：
主进程: 5752
子进程: pid = 5754, ppid = 5752
0
主进程: 5752
1
主进程: 5752
2
主进程: 5752
fun: args = hello
fun: 5752
主进程: 5752
主进程: 5752
主进程: 5752
主进程: 5752
…

知识点补充：
Pool可以使用回调函数
例：pool = Pool(3)
pool.apply_async(func = test, callback = fun)

（12）GIL全局解释器锁
python中有全局解释器锁，由于全局解释器锁的存在，所以在同一时间内，python解释器只能运行一个线程的代码，这大大影响了python多线程的性能。
python GIL 之所以会影响多线程等性能，是应为在多线程的情况下，只有当线程获得了一个全局锁的时候，那么该线程的代码才能运行，而全局锁只有一个，所以使用python多线程，在同一时刻也只有一个线程在运行，因此在即使在多核的情况下也只能发挥出单核的性能。

例1：单线程死循环
while True：
	pass

CPU占用率100%

例子2：双线程死循环

from threading import Thread

def test():
	while True:
		pass

t = Thread(target=test)
t.start()
while True:
	pass

CPU占用率50%+50%

为了使用线程，同时也为了提高使用率，提高效率，关键代码用c语言去实现。

vi a.c

void DealThread()
{
	while(1)
	{
		;
	}
}

编译：gcc a.c -shared -o libdealthread.so
from threading import Thread
# ctypes是c语言和Python相兼容的一个模块，主要cdll（c语言的动态链接库）
from ctypes import *

#Python去调用c语言的程序
lib = cdll.LoadLibrary("./libdealthread.so")

t = Thread(target=lib.DealThread) # 调用c程序的具体函数
t.start()
while True:
	pass

现在的CPU的占用率是100%

知识点补充：
（1）eval()可以将str(data)形成的字符串变为data
例：
>>> b = "{'weight':20,'server':100}"
>>> c = eval(b)
>>> print(c)
{'weight': 20, 'server': 100}
>>> type(c)
<class 'dict'>
>>> b = "[1,2,3]"
>>> c = eval(b)
>>> print(c)
[1, 2, 3]
>>> type(c)
<class 'list'>
（2）int  4字节(Byte)（win32和win64系统中）
	 char  1字节(Byte)

Linux网络编程-UDP
1. 网络
网络的目的：实现不同电脑的进程间通信。

3. TCP/IP协议：Internet网的世界语言

协议：完成进程间通信的规范
TCP/IP协议是一个协议族

4.网络体系结构

TCP/IP模型（4层）							OSI模型（7层）

应用层：应用程序 HTTP SMTP 					应用层
											表示层
											会话层
											
传输层: TCP UDP								传输层

网络层: IP ICMP ARP RARP						网络层

网络接口层									数据链路层
											物理层

作用:

应用层：应用程序间的通信，数据的处理，数据的加密
传输层：提供传输的方式，建立端对端的连接
网络层：选择路由器
网络接口层：数据转化成数据帧，包括数据帧的发送和接收

5.端口

端口：标记应用程序，每个应用程序都有一个端口号。
端口号：0-65535

分类：
（1）知名端口 0-1023
80端口：基于网络--HTTP服务
21端口：FTP服务--文件传输

（2）动态端口：1024-65535
不分配给固定的服务，随机分配的。
6.IP地址（IPv4 32位，IPv6 128位）

作用：标记唯一一台电脑（逻辑上）

分类：每个IP地址都包含两部分：网络地址和主机地址，一共是4个字节，32位
1）A类  0	+	7位网络号	+	24位主机号		范围：1.0.0.0 -- 126.255.255.254
2）B类	10	+	14位网络号	+	16位主机号		范围：128.1.0.1 -- 191.255.255.254
3）C类	110	+	21位网络号	+	8位主机号		范围：192.0.1.1 -- 223.255.255.254

192.168.2.0: 网络号
192.168.2.255: 广播地址

公有IP地址：全球可以访问的地址，针对外网
私有的IP地址：局域网内使用的IP，常用：192.168.0.0 --- 192.168.255.255

7.socket套接字
（套接字是通信端点的抽象，就是这个通信端点的逻辑代表。）

sendto和recvfrom都是阻塞等待的
绑定端口号一般都是放在发送和接收之前

（1）socket 网络通信的标识符

特殊的接口 可以进行 网络通信
数据类型： int >= 3

（2）socket分类

流式套接字：SOCK_STREAM  --- TCP
数据报套接字：SOCK_DGRAM --- UDP
原始套接字：SOCK_RAW --- IP/ICMP

（3）创建套接字socket
#coding=utf-8

import socket

#创建socket
udpSocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) 
#参数1：AF_INET IPv4协议， 参数2：socket的类型

sendData = "hello"
sendAddr = ("192.168.2.5", 8080) #元组：IP地址，端口号
udpSocket.sendto(sendData, sendAddr) #参数1：发送的数据， 参数2：发送给谁
udpSocket.close()

绑定：
Addr = ("192.168.2.254", 8000)
udpSocket.bind(Addr)

接收：
recv = udpSocket.recvfrom(1024) #参数：每次接收的数据的大小，字节
返回值：元组，包括：接收的数据，地址（也是一个元组，包括：发送方IP地址，发送方的端口号）
print data

练习：用虚拟机接收数据。
#coding=utf-8
import socket

udpSocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

udpSocket.bind(("192.168.2.125", 8000))

while True:
	recv = udpSocket.recvfrom(1024)
	print recv
	
udpSocket.close()

Python3中sendto()的使用：（之所以与python2不同，是因为python3中string位置的字符串是以字节形式存在的。例：0x01…，但python为了使用户观看方便，只是在字符串前加上了b，来代表字节形式）

（1）bytes(string, encoding="utf-8")
在Python中，默认的编码格式：Unicode
编码格式：utf-8 --- 全球统一的编码格式
gbk --- windows系统上的中文格式

（从网络上获得的数据一般是utf-8格式的，但是中文网站可能用gbk格式，Windows系统上的中文也是gbk格式的）
（utf-8是针对全世界所有国家需要都通用的编码格式，gbk只是针对中文的）

（2）编码"utf-8"：发送数据使用
encode:作用：将Unicode编码格式的字符串转化成其他编码格式的字节码
sendData.encode("utf-8")

例：
#coding=utf-8
import socket
udpSocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

#python2用法
#sendData = raw_input("请输入要传输的信息:")

#python3第一种用法
sendData = input("请输入要传输的信息:")
sendData = bytes(sendData, encoding = "utf-8")

#python3第二种用法
#sendData = input("请输入要传输的信息:")
#sendData = sendData.encode("utf-8")

sendAddr = ("192.168.43.161", 8080)
udpSocket.bind(("192.168.2.125", 8000))
udpSocket.sendto(sendData, sendAddr)
recv = udpSocket.recvfrom(1024)
print(recv)	
udpSocket.close()

（3）解码：接收数据使用
decode：作用：将其他编码格式的字节码转化成Unicode格式的字符串
string.decode("utf-8")
string.decode("gbk")

例：
#coding=utf-8
import socket
udpSocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

#python2用法
#sendData = raw_input("请输入要传输的信息:")

#python3用法一
sendData = input("请输入要传输的信息:")
sendData = bytes(sendData, encoding = "utf-8")

#python3用法二
#sendData = input("请输入要传输的信息:")
#sendData = sendData.encode("utf-8")

sendAddr = ("192.168.43.161", 8080)
udpSocket.bind(("192.168.2.125", 8000))
udpSocket.sendto(sendData, sendAddr)
recv = udpSocket.recvfrom(1024)
data, addr = recv

#print(data) # 输出为b’string’
print(data.decode("gbk")) # 输出为’string’

print(addr)
udpSocket.close()

注：带b只是代表是字节形式的字符串

UDP的通信过程：

应用层：hello								hello
传输层：端口号 hello							端口号 hello
网络层：IP地址 端口号 hello					IP地址 端口号 hello
网络接口层：MAC地址 IP地址 端口号 hello    	MAC地址 IP地址 端口号 hello
	|											|
	|											|
	|	发送方组包					接收方解包	|
	_____________________________________________

练习1：局域网聊天室：
#coding=utf-8

from socket import *

udpSocket = socket(AF_INET, SOCK_DGRAM)
udpSocket.bind(("", 8000)) # 如果写空字符串,默认为自己电脑的ip地址
while True:
	data, addr = udpSocket.recvfrom(1024)
	print("%s:%s" %(data.decode("gbk"), addr))	

练习2：模拟QQ聊天
用线程去模拟，2个线程，send, recv
send:写入对方的IP地址，对方的port端口号
写入发送的数据，"<<"
recv：进行数据的接收，打印，输出">>"+内容

from threading import Thread
from socket import *
import sys

#根据数据类型初始化,如果是对象,用None
udpSocket = 0
destIP = ""
destPort = 0

def send_infos():
	global udpSocket
	while True:
		sendData = input("<< ")
		udpSocket.sendto(sendData.encode("gbk"), (destIP, destPort))

def recv_infos():
	global udpSocket
	while True:
		data, addr = udpSocket.recvfrom(1024)
		print("\r>> %s:%s" %(addr, data.decode("gbk")))
		#print("<< ", end = "") #此时行未满,且没有换行符，不会刷新缓存区,即不会进行打印
		#sys.stdout.flush() # 刷新缓存区

def main():
	global udpSocket
	global destIP
	global destPort

	udpSocket = socket(AF_INET, SOCK_DGRAM)
	udpSocket.bind(("", 8000))

	destIP = input("对方的IP: ")
	destPort = int(input("对方的Port: "))

	ts = Thread(target = send_infos)
	tr = Thread(target = recv_infos)
	ts.start()
	tr.start()
	ts.join()
	tr.join()
	udpSocket.close()

if __name__ == "__main__":
	main()
输出结果：
对方的IP: 192.168.2.125
对方的Port: 8000
<< nihao
>> ('192.168.2.125', 8000):nihao
<< zaijian
>> ('192.168.2.125', 8000):zaijian
<<

练习3：给飞秋发送数据
import socket, time

udpSocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sendData = "1.0:100:李白:192.168.2.155:32:你好"
#飞秋版本号:发送包的序列号:发送人的登录名:发送人的IP地址:命令号（32代表发送数据）:发送的内容
udpSocket.sendto(sendData.encode("gbk"), ("192.168.2.155", 2425))
udpSocket.close()

8. WireSharp 抓包工具:拦截查看网络数据包的内容

（1）安装：默认安装
选择：WireSharp_Legcy

（2）使用：
	打开Wiresharp Legacy， 点击Interface List， 弹出一个选框，轻点一下，可以看到：网络连接和IP地址；
	选择上面有IP地址的那个网络连接，然后点击start
	可以看见抓取到数据包的动态过程

（3）
No.:是抓取到的第几个数据包
Time：是从抓包开始起，到现在的时间；
Source：源IP，即发送方的IP地址
Destination:目标的IP地址，接收方的IP地址
Protocol：使用的协议
Length：数据包的长度，单位：字节
Info:Wiresharp对数据包的简单理解（简单描述）

（4）
每一行都是一次抓包的具体信息；

单击其中一个数据包，发现下面的内容会发生变化；
那是数据包的具体内容。

数据包的具体信息：（以16进制保存）
Frame n: 第n帧数据包
Ethernet II:网络接口层，主要是mac地址（即硬件地址）
Internet Protocol Version 4：网络层IPV4协议，主要是IP地址
User Datagram Protocol:传输层UDP，主要是端口号
Data:应用层

数据包抓取的信息是16进制，但是在网络上真正传输的是最右边的ASSIC码格式。

9. TFTP服务器实现下载图片

运行tftpd32应用程序就相当于开启一个TFTP网络下载服务器，
选择的路径就是服务器的根目录，我们就可以从这个目录中下载文件，
这个目录实际上就相当于共享文件夹

（1）架构
c/s: client server 客户端 服务器 例如：QQ
b/s: browser server 浏览器 服务器 例如：网页访问的服务器

（2）TFTP协议：

C--->S : 操作码1/2(RD/WR) + 文件名 +  0  +  模式  +  0 
	   2字节			  n字节	  1字节  n字节  1字节

C<---S : 操作码3 + 块编号 + 数据
	   2字节     2字节   512字节

块编号：发送过来的数据中都有一个序号，便于回馈时，知道哪个包被收到

ERROR：当没有文件，返回错误信息：
		 操作码5 + 错误码 + 错误信息 + 1
		 
C---->S：应答 ACK 
	    操作码4 + 块编号
		2字节	  2字节

（3）字节序：字节的存放序列：包括小端字节序和大端字节序

0x1234	2字节（其中0x12为高八位，0x34为低八位）
0x12 0x34 或者 0x34 0x12

像我们的PC机，使用的小端：0x34 0x12（内存低地址-->高地址）（小端存储：低地址存低位。例：PC机）（”string”）
像网络上的服务器，一般用大端：0x12 0x34（内存低地址-->高地址）（大端存储：低地址存高位。例：网络传递时）（”!string”）

因为网络上一般为大端存储，所以网络规定，不论你的pc机是大端还是小端，在网络上一律用大端发送。

0x1234 高位低位，1是高位 4是低位

（4）编码过程：

创建udpSocket
udpSocket.send() #	"1rabbit0octet0"

octet：按字节模式发送

import struct
#pack是把字符拼接成字节流，unpack是把字节流解析成tuple
struct.pack("!H10sb5sb",1,"rabbit.jpg",0,"octet",0)	
#!是大端；H占2个字节位置,用1去占；
#10S，代表10个字符，用"rabbit.jpg"，代替10个字节
#b:用0代替，5s用"octet"代替，b：代表整数。

#Python3中，因为s代表字节，所以要把上面修改成 b"rabbit.jpg"
struct.pack("!H10sb5sb",1,b"rabbit.jpg",0,b"octet",0)	

解包： 
data, addr = udpSocket.recvfrom(1024)
cmd_tuple = struct.unpack("!HH", data[0:4]) 
cmd_tuple[0] == 3
cmd_tuple[1] == 块编号

（5）退出的条件
if len(data) < 516:
	print("数据下载完成！")
	break
	
（6）tftp服务的端口是：69

TFTP下载器的实现：
（1）老师的版本：
import socket, struct

udpSocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sendData = struct.pack("!H10sb5sb",1,b"rabbit.jpg",0,b"octet",0)
udpSocket.sendto(sendData, ("192.168.2.5", 69))
f = open("rabbit.jpg", "bw")

while True:
	data, addr = udpSocket.recvfrom(1024)
	cmd_tuple = struct.unpack("!HH", data[0:4])
	if cmd_tuple[0] == 3:
		f.write(data[4:])
		print("第%d次下载！" %cmd_tuple[1])
		ack = struct.pack("!HH",cmd_tuple[0]+1,cmd_tuple[1])
		udpSocket.sendto(ack, addr)
		if len(data) < 516:
			print("数据下载完成！")
			break
f.close()
udpSocket.close()

（2）自己的版本：
import socket, struct

udpSocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
new = open("rabbit-2.jpg", "bw")

#python2用法
#sendData = struct.pack("!H10sb5sb",1,"rabbit.jpg",0,"octet",0)

#python3用法
sendData = struct.pack("!H10sb5sb", 1, b"rabbit.jpg", 0, b"octet", 0)

udpSocket.sendto(sendData, ("192.168.2.155", 69))

while True:
	data, addr = udpSocket.recvfrom(1024)
	ip, port = addr
	if data[1] == 3:
		ack = struct.pack("!H2b",4,data[2],data[3])
		udpSocket.sendto(ack, ("192.168.2.155", port))
		if len(data) < 516:
			print("数据下载完成!")
			break
		else:
			new.write(data[4:])

new.close()
udpSocket.close()

10.UDP的广播

广播是UDP特有的，TCP没有
广播地址："192.168.2.255"

单播：点对点的传输
多播：一对多
广播：一对所有

udpSocket = socket.socket()
#udpSocket.sendto(data,("192.168.2.255",8080))
#广播的前提：对socket进行设置
#参数1：被设置的选项的级别，对socket进行设置，所以SOL_SOCKET
#参数2：配置选项的名字
#参数3：配置选项的值。非0整数：表示允许（一般写1）；0：禁止
udpSocket.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
udpSocket.sendto(data,('<broadcast>',8080))
udpSocket.close()

练习1：发送广播
import socket

def main():
	udpSocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
	udpSocket.bind(("", 8000))
	sendAddr = ("<broadcast>", 8080) # <broadcast>为广播地址
	udpSocket.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)

	for i in range(3):
		udpSocket.sendto("hello".encode("gbk"), sendAddr)

if __name__ == "__main__":
	main()

练习2：接收广播
import socket

def main():
	udpSocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
	udpSocket.bind(("", 8080))
	udpSocket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)

	while True:
		data, addr = udpSocket.recvfrom(1024)
		print("<%s>: %s" %(addr, data.decode("gbk")))

if __name__ == "__main__":
	main()

知识点补充：
In [18]: a = 500

In [19]: b = 500

In [20]: a is b
Out[20]: False

In [21]: a == b
Out[21]: True

注：is比较的是id，==比较的是值

>>> import struct
>>> s = struct.pack("HH",1,2)
>>> print(s)
b'\x01\x00\x02\x00'
>>> s = struct.pack("!HH",1,2)
>>> print(s)
b'\x00\x01\x00\x02'
>>>

注：字符串前带!是大端存储，不带是小端存储















Linux网络编程-TCP
（1）TCP与UDP的区别：

UDP：recvfrom() sendto(data,addr)
	数据传输不稳定，容易丢包，容易造成数据不完整
	传输速度快，效率高
	面向不连接
TCP：
	数据传输稳定，不丢包，数据完整
	传输速度慢，效率低
	面向连接
	有三次握手协议，四次挥手协议
	
（2）UDP的模型：

服务器			  客户端
socket()		  	  socket()
bind()			  

sendto(data,addr)   sendto()
recvfrom(1024)		  recvfrom()

close()			  close()

（3）TCP的模型

服务器					客户端
socket()		 		    socket()
bind()			 		bind()
listen(5)#监听
accept() #接收连接        connect()

recv(1024)		 		send()
send()			 		recv()	

close()			        close()

#连接服务器的IP地址和端口
cli_socket.connect(("192.168.2.5",8080))

练习1：写服务器和网络调试助手通信
（1）老师的版本：
	#coding=utf-8
import socket

def main():
	ser_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	#按ctrl c之后端口号还占用,避免端口号被占用。
	ser_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
	#服务器必须绑定IP地址和端口号
	ser_socket.bind(('',8000))
	ser_socket.listen(5)#监听
	#元组:一个新的socket,主要是和客户端进行收/发数据
	#返回值：包含：一个新的socket，一个IP地址和端口号的元组
	new_socket, new_addr = ser_socket.accept() #接收连接
	#recv返回值是数据，不包含IP地址和端口号
	data = new_socket.recv(1024)
	print('<%s>: %s' %(new_addr, data))
	#send:直接写发送的数据，不用在写IP地址和端口号
	new_socket.send('你好'.encode('gbk'))

	#先关闭新的socket
	new_socket.close()
	ser_socket.close()

if __name__ == '__main__':
	main()

（2）自己的版本：（写服务器和虚拟机自身通信）
import socket

def main():
	ser_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM) 
	#这个套接字相当于总服务台，用于连接

	ser_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
	ser_socket.bind(("", 8000))
	ser_socket.listen(5)
	
	new_socket, new_addr = ser_socket.accept()
	#相当于客服
	#元组:一个新的socket,主要用于与客户端收/发数据
	
	data = new_socket.recv(1024)
	print("<%s>: %s" %(new_addr, data.decode("gbk")))
	new_socket.send("你好".encode("gbk"))

	new_socket.close()
	ser_socket.close()

if __name__ == "__main__":
	main()

练习2：写客户端和网络调试助手通信
（1）老师的版本：
import socket

def main():
	cli_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	cli_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
	cli_socket.connect(("192.168.2.5", 8080))
	cli_socket.send("helo".encode("gbk"))
	data = cli_socket.recv(1024)
	print("<ser>: %s" %data.decode("gbk"))
	cli_socket.close()
	
if __name__ == "__main__":
	main()

（2）自己的版本：（写客户端和虚拟机自身通信）
	#coding=utf-8
import socket

def main():
	cli_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM) 
	cli_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
	#对于客户端,绑定不绑定地址都可以
	#对于服务器端,一定要绑定地址
	send_addr = ("", 8000)
	cli_socket.connect(send_addr)

	cli_socket.send("我是客户端".encode("gbk"))
	data = cli_socket.recv(1024)
	print("<%s>: %s" %(send_addr, data.decode("gbk")))

	cli_socket.close()

if __name__ == "__main__":
	main()

知识点补充：
（1）


这段程序在两台电脑通信的时候加；启动的是一台电脑上的两个程序的时候加。

（2）
一个英文字母，一个数字，一个符号各占一个字节；
一个汉字占两个字节。

练习3：客户端与服务器通信，都可以recv和send，利用多线程实现无限收/发。（并发服务器、并发客户端）
（1）
并发服务器：（老师的版本）
import socket, sys
from threading import Thread

def recv(new_socket, new_addr):
	while True:
		data = new_socket.recv(1024)
		if len(data) > 0:
			print("\r<%s>: %s" %(new_addr, data.decode("gbk")))
			print("<ser>: ", end="")
			sys.stdout.flush()
		else:
			print("\r客户端已退出")
			break
	new_socket.close()


def main():
	ser_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	ser_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
	ser_socket.bind(("192.168.2.125", 8000))
	ser_socket.listen(5)
	new_socket, new_addr = ser_socket.accept()
	t = Thread(target=recv, args=(new_socket, new_addr))
	t.start()
	try:
		while True:
			data = input("<ser>: ")
			new_socket.send(data.encode("gbk"))
	finally:
		ser_socket.close()

if __name__ == "__main__":
	main()

并发客户端：（老师的版本）
import socket, sys
from threading import Thread

def recv(cli_socket):
	while True:
		data = cli_socket.recv(1024)
		print("\r<ser>: %s" %data.decode("gbk"))
		print("<cli>: ", end="")
		sys.stdout.flush()

def main():
	cli_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	cli_socket.connect(("192.168.2.125", 8000))
	t = Thread(target=recv, args=(cli_socket,))
	t.start()

	try:
		while True:
			data = input("<cli>: ")
			cli_socket.send(data.encode("gbk"))
	finally:
		cli_socket.close()

if __name__ == "__main__":
	main()

（2）
并发服务器：（自己的版本）
import socket, sys
from threading import Thread

ser_socket = 0
new_socket = 0
new_addr = ("",0)

def send():
	global new_socket
	while True:
		sendData = input("<< ")
		new_socket.send(sendData.encode("gbk"))

def recv():
	global new_socket
	while True:
		data = new_socket.recv(1024)
		if len(data) > 0:
			print("\r>> cli: %s" %data.decode("gbk"))
			print("<< ",end = "")
			sys.stdout.flush()
		else:
			print("客户端已退出")
			break
	new_socket.close()

def main():
	global ser_socket
	global new_socket
	global new_addr

	ser_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM) 
	#这个套接字相当于总服务台

	ser_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
	ser_socket.bind(("", 8009))
	ser_socket.listen(5)
	
	new_socket, new_addr = ser_socket.accept()
	#相当于客服
	#元组:一个新的socket,主要用于和客户端收/发数据
	new_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
	
	ts = Thread(target = send)
	tr = Thread(target = recv)
	ts.start()
	tr.start()
	ts.join()
	tr.join()
	
	new_socket.close()
	ser_socket.close()

if __name__ == "__main__":
	main()

并发客户端：（自己的版本）
import socket, sys
from threading import Thread

cli_socket = 0
send_addr = ("", 8009)

def send():
	while True:
		global cli_socket
		global send_addr
		sendData = input("<< ")
		cli_socket.send(sendData.encode("gbk"))

def recv():
	while True:
		global cli_socket
		data = cli_socket.recv(1024)
		print("\r>> ser: %s" %data.decode("gbk"))
		print("<< ", end = "")
		sys.stdout.flush()

def main():
	global cli_socket
	global send_addr
	cli_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM) 
	cli_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
	#对于客户端,绑定不绑定地址都可以
	#对于服务器端,一定要绑定地址
	cli_socket.connect(send_addr)

	t1 = Thread(target = send)
	t2 = Thread(target = recv)
	t1.start()
	t2.start()
	t1.join()
	t2.join()
	cli_socket.close()

if __name__ == "__main__":
	main()

知识点补充：
（1）send()、recv()、accept()、connect()都是阻塞的。
（2）凡是两端通信的，一般都需要对数据进行编码或解码。
（3）listen(5)#监听 括号内的数字代表同一时刻，能处理多少个客户端。


































Linux网络编程-服务器与客户端
1.
三次握手协议：发生在connect---accept
标志位：
ACK：表示一个应答，ACK=1，代表ack有效。
SYN：表示一个请求包，发起一个新的连接，SYN=1， 表示seq有效
FIN：释放一个连接

seq序号：标记TCP源端口向目的端口发送的字节流，32位
ack序号：用来标记应答，32位

		  SYN=1，seq=J
c -----------------------------> s
	ACK=1,ack=J+1, SYN=1, seq=K
c <----------------------------- s
		ACK=1,ack=K+1
c -----------------------------> s

cli_socket.close()或者new_socket.close()

四次挥手：
		FIN=1,seq=M
c -----------------------------> s
		ACK=1,ack=M+1
c <----------------------------- s
		FIN=1,seq=N
c <----------------------------- s
		ACK=1,seq=N+1
c -----------------------------> s

练习1：单进程服务器（非并发服务器）
import socket
# 缺点:在同一时刻只能有一个客户端传送数据
# 非并发服务器
def main():
	ser_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	ser_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
	ser_socket.bind(("192.168.2.125", 8000))
	ser_socket.listen(5)
	while True:
		new_socket, new_addr = ser_socket.accept()
		try:
			while True:
				data = new_socket.recv(1024)
				if len(data) > 0:
					print("<%s>: %s" %(new_addr, data.decode("gbk")))
				else:
					print("客户端%s退出" %str(new_addr))
					break
		finally:
			new_socket.close()
	ser_socket.close()

if __name__ == "__main__":
	main()

练习2：多进程服务器（并发服务器，同一时刻可以接收多个客户端，采用多进程）
import socket
from multiprocessing import Process

def deal_client(new_socket, new_addr):
	try:
		while True:
			data = new_socket.recv(1024)
			if len(data) > 0:
				print("<%s>: %s" %(new_addr, data.decode("gbk")))
			else:
				print("客户端%s退出" %str(new_addr))
				break
	finally: 
		new_socket.close()

def main():
	ser_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	ser_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
	ser_socket.bind(("192.168.2.125", 8000))
	ser_socket.listen(5)
	try:
		while True:
			new_socket, new_addr = ser_socket.accept()
			p = Process(target = deal_client, args = (new_socket, new_addr))
			p.start()
			# 在主进程和子进程都有一份new_socket，删除主进程中的，不影响子进程的
			new_socket.close()
	finally:
		ser_socket.close()

if __name__ == "__main__":
	main()

练习3：多线程服务器
import socket
from threading import Thread

def deal_client(new_socket, new_addr):
	try:
		while True:
			data = new_socket.recv(1024)
			if len(data) > 0:
				print("<%s>: %s" %(new_addr, data.decode("gbk")))
			else:
				print("客户端%s退出" %str(new_addr))
				break
	finally: 
		new_socket.close()

def main():
	ser_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	ser_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
	ser_socket.bind(("192.168.2.125", 8000))
	ser_socket.listen(5)
	try:
		while True:
			new_socket, new_addr = ser_socket.accept()
			p = Thread(target = deal_client, args = (new_socket, new_addr))
			p.start()
	finally:
		ser_socket.close()

if __name__ == "__main__":
	main()

练习4：单进程并发服务器（并发服务器，非阻塞模式）
import socket

def main():
	ser_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	ser_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
	ser_socket.setblocking(False)
	ser_socket.bind(("", 8000))
	ser_socket.listen(5)
	client_addr_list = []
	while True:
		try:
			new_socket, new_addr = ser_socket.accept()
		except:
			pass
		else:
			client_addr_list.append((new_socket, new_addr))
			new_socket.setblocking(False)
		for cli_socket, cli_addr in client_addr_list:
			try:
				data = new_socket.recv(1024)
			except:
				pass
			else:
				if len(data) > 0:
					print("<%s>: %s" %(new_addr, data.decode("gbk")))
				else:
					print("客户端%s已下线" %str(new_addr))
					cli_socket.close()
					client_addr_list.remove((cli_socket, cli_addr))
	ser_socket.close()

if __name__ == "__main__":
	main()

练习5：并发服务器_select版本

知识点：
select:查询列表里的所有套接字。

import select

select.select(参数1， 参数2， 参数3)
参数1：检查列表里的所有的套接字能不能收数据
参数2：检查列表里的所有的套接字能不能发数据
参数3：检查列表里的所有的套接字是否产生异常

返回值：由3个列表组成的一个元组。

例：
import socket, select

def main():
	ser_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	ser_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
	ser_socket.bind(("", 8000))
	ser_socket.listen(5)
	inputs_list = [ser_socket]
	addr_dict = {}
	
	while True:
		readable, writeable, exception = select.select(inputs_list, [], [])
		# 采用的轮询
		
		for sock in readable:
			if sock == ser_socket:
				new_socket, new_addr = ser_socket.accept()
# 如果不用字典把地址元组保存，输出时，输出的不一定总是第一次发过来的地址元组
				inputs_list.append(new_socket)
				addr_dict[new_socket] = new_addr
			else:
				data = sock.recv(1024)
				if len(data) > 0:
					print("<%s>: %s" %(addr_dict[sock], data.decode("gbk")))
				else:
					print("客户端%s已退出！" %str(addr_dict[sock]))
					sock.close()
					inputs_list.remove(sock)
	ser_socket.close()

if __name__ == "__main__":
	main()

知识点：
（1）select服务器：
采用的轮询的模式，占用内存。
select服务器，在32位机器上，只能连接1024个客户端。
			  在64位机器上，只能连接2048个客户端。
			  
（2）poll服务器: 可以无限连接，采用的轮询。
（3）epoll服务器：可以无限连接，采用的是事件监听。
（4）try --- finally 不管产不产生异常，都要执行finally语句的代码。
（5）轮询法的概念是，由CPU定时发出询问，依序询问每一个周边设备是否需要其服务，有即给予服务，服务结束后再问下一个周边，接着不断周而复始。

练习6：epoll服务器
import socket, select

def main():
	ser_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	ser_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
	ser_socket.bind(("", 8000))
	ser_socket.listen(5)
	socket_dict = {}
	addr_dict = {}
	# 创建一个epoll对象
	# EPOLLIN: 收数据
	# EPOLLOUT: 发数据
	# EPOLLET: 立刻把事件进行返回
	epoll = select.epoll()
	epoll.register(ser_socket.fileno(), select.EPOLLIN | select.EPOLLET)

	while True:
		# 获得当前所有的监听套接字的状态,比如:能不能收数据
		# 采用的事件机制
		# epoll_list是列表,每个元素是一个元组,(fd, event),即(文件描述符, 事件)
		epoll_list = epoll.poll()
		# 此时哪个套接字可以接收数据，这个列表才会有谁
		
		for fd, event in epoll_list:
			if fd == ser_socket.fileno():
				new_socket, new_addr = ser_socket.accept()
				socket_dict[new_socket.fileno()] = new_socket
				addr_dict[new_socket.fileno()] = new_addr
				epoll.register(new_socket.fileno(), select.EPOLLIN | select.EPOLLET)
			else:
				data = socket_dict[fd].recv(1024)
				if len(data) > 0:
					print("<%s>: %s" %(addr_dict[fd], data.decode("gbk")))
				else:
					print("客户端%s已退出" %str(addr_dict[fd]))
					epoll.unregister(fd)
					socket_dict[fd].close()

if __name__ == "__main__":
	main()

知识点补充：
epoll.poll()的返回值是元组列表[(fd, event)，…]所以说他是所有监听的套接字满足条件的返回列表，至于套接字可以干嘛，根据event是EPOLLIN,还是EPOLLOUT,我们可以使用fd对应的套接字进行recv或send,因为练习程序中都是EPOLLIN，所以不用验证event是谁









































Linux网络编程-正则表达式
正则表达式：描述一种规则的表达式。

（1）模块：re
import re
ret = re.match(正则表达式，要匹配的字符串) --- 谁匹配
返回值：若匹配：匹配成功的对象Match Object
		若不匹配：None
ret.group() 匹配成功对象的匹配部分 --- 哪里匹配

（2）安装Python 3.6.4
配置环境变量：
PATH末尾加上：E:\far sight\Python 3.6.4(32-bit);E:\far sight\Python 3.6.4(32-bit)\Scripts;

>>> import re
>>> pattern = "hello"
>>> s = "hello"
>>> re.match(pattern, s)
<_sre.SRE_Match object; span=(0, 5), match='hello'>
>>> ret = re.match(pattern,s)
>>> ret.group()
'hello'
>>> s = "hello world"
>>> re.match(pattern,s)
<_sre.SRE_Match object; span=(0, 5), match='hello'>
>>> s = "world hello"
>>> re.match(pattern,s)
>>> s.startswith(pattern)
False
>>> s = "hello world"
>>> s.startswith(pattern)
True

（3）通用规则：
最基本的7个：
. 匹配任意一个字符，除了\n

>>> re.match(".","hello")
<_sre.SRE_Match object; span=(0, 1), match='h'>
>>> ret = re.match(".","hello")
>>> print(ret)
<_sre.SRE_Match object; span=(0, 1), match='h'>
>>> print(ret.group())
h
>>> ret = re.match("......","hello")

\d 匹配任意一个数字 0-9
\D 匹配任意一个非数字 

>>> re.match("\d", "123")
<_sre.SRE_Match object; span=(0, 1), match='1'>
>>> re.match("\D", "123")

\s 匹配任意一个空白符，\n,\t,\r,空格
# 一个\t为一个tab的意思
\S 匹配任意一个非空白符

>>> re.match("\s", " ")
<_sre.SRE_Match object; span=(0, 1), match=' '>
>>> re.match("\s","		")
<_sre.SRE_Match object; span=(0, 1), match='\t'>
>>> 
>>> re.match("\s", "\r")
<_sre.SRE_Match object; span=(0, 1), match='\r'>
>>> re.match("\s", "\n")
<_sre.SRE_Match object; span=(0, 1), match='\n'>
>>> re.match("\s", "\t")
<_sre.SRE_Match object; span=(0, 1), match='\t'>
>>> re.match("\S", "	")

\w  匹配单词字符  a-z，A-Z，0-9，_下划线
\W  匹配非单词字符

>>> re.match("\w", "ab123")
<_sre.SRE_Match object; span=(0, 1), match='a'>
>>> re.match("\w\w\w", "ab123")
<_sre.SRE_Match object; span=(0, 3), match='ab1'>
>>> re.match("\w", "\na")
>>> re.match("\W", "\na")
<_sre.SRE_Match object; span=(0, 1), match='\n'>

>>> re.match("1\d\d\d\d\d\d\d\d\d\d","13678901299")
<_sre.SRE_Match object; span=(0, 11), match='13678901299'>

补充：[] 表示一段范围
>>> re.match("1[34578]\d\d\d\d\d\d\d\d\d","12678901299") #[]中间不间断，不用分隔
	  ^ 在[]内部， 表示取反
	注意：^在[]中使用时，只能在[]内部的最前方使用，表示对整个范围取反，如果放在范围中间，不起作用。
	
>>> re.match("1[34578]\d\d\d\d\d\d\d\d\d","12678901299")
>>> re.match("1[^34578]\d\d\d\d\d\d\d\d\d","12678901299")
<_sre.SRE_Match object; span=(0, 11), match='12678901299'>
>>> re.match("1[3^4578]\d\d\d\d\d\d\d\d\d","12678901299")
>>> re.match("1[345^78]\d\d\d\d\d\d\d\d\d","12678901299")
>>> re.match("1[^3^4^5^7^8]\d\d\d\d\d\d\d\d\d","12678901299")
<_sre.SRE_Match object; span=(0, 11), match='12678901299'>
>>> re.match("1[^3^4578]\d\d\d\d\d\d\d\d\d","12678901299")
<_sre.SRE_Match object; span=(0, 11), match='12678901299'>	
>>> re.match("[0-5]","235")
<_sre.SRE_Match object; span=(0, 1), match='2'>
>>> re.match("[0-5]","635")

\d  == [0-9] 
\D  == [^0-9]
\w 	== [a-zA-Z0-9_]
\W  == [^a-zA-Z0-9_]
**********************************

*： 匹配前一个字符，出现0次，无数次，多少次都可以

>>> re.match("\d*", "12")
<_sre.SRE_Match object; span=(0, 2), match='12'>
>>> re.match("1*", "12")
<_sre.SRE_Match object; span=(0, 1), match='1'>
>>> re.match("2*", "12") #"12" == ""+"12" *如果出现次数为0，代表""
<_sre.SRE_Match object; span=(0, 0), match=''>

+ : 匹配前一个字符出现1次或者无限次，至少一次
>>> re.match("\d+","123")
<_sre.SRE_Match object; span=(0, 3), match='123'>
>>> re.match("1+","123")
<_sre.SRE_Match object; span=(0, 1), match='1'>
>>> re.match("2+","223")
<_sre.SRE_Match object; span=(0, 2), match='22'>

?: 匹配前一个字符出现一次或者0次，要么一次，要么没有

>>> re.match("\d?[a-z]","ab12")
<_sre.SRE_Match object; span=(0, 1), match='a'>
>>> re.match("\d+[a-z]","ab12")

{m}匹配前一个字符出现m次
{m,}匹配前一个字符至少出现m次
{m,n} 匹配前一个字符出现m次到n次之间


*******************************
边界匹配：
^ 匹配字符串的开头，必须以什么开头
$ 匹配字符串的结尾，必须以什么结尾
\b 匹配一个单词的边界，头或尾
\B 匹配非单词的边界

例子1：
>>> re.match("1[34578]\d{8}\d$","13567899876000000")
>>> re.match("1[34578]\d{8}\d$","13567899876")
<_sre.SRE_Match object; span=(0, 11), match='13567899876'>
>>> re.match("1[34578]\d{9}$","13567899876")
<_sre.SRE_Match object; span=(0, 11), match='13567899876'>
>>> re.match("1[34578]\d{8}\d$","1356789987a")

例子2：
>>> s = "hello"
>>> re.match("^hello",s)
<_sre.SRE_Match object; span=(0, 5), match='hello'>
>>> re.match("^h",s)
<_sre.SRE_Match object; span=(0, 1), match='h'>

>>> re.match("\w+$","abcd")	     
<_sre.SRE_Match object; span=(0, 4), match='abcd'>
>>> re.match("\w+$","abcd 1234")
	     
>>> re.match("\w+4$","abcd 1234")
>>> re.match("\w+4$","abcd1234")
<_sre.SRE_Match object; span=(0, 8), match='abcd1234'>

>>> re.match("\w+d$","abcd")	     
<_sre.SRE_Match object; span=(0, 4), match='abcd'>
>>> re.match("\w+m$","abcd")

>>> re.match(r"\w+\s\bat\b","m at ch")
<_sre.SRE_Match object; span=(0, 4), match='m at'>
>>> re.match("\w+\s\\bat\\b","m at ch")
<_sre.SRE_Match object; span=(0, 4), match='m at'>

>>> re.match(r"\w+\s\bat\b \bch\b","m at ch")
<_sre.SRE_Match object; span=(0, 7), match='m at ch'>
>>> re.match(r"\w+\s\bat\b ch\b","m at ch")
<_sre.SRE_Match object; span=(0, 7), match='m at ch'>
>>> re.match(r"\w+\s\bat\b ch","m at ch")
<_sre.SRE_Match object; span=(0, 7), match='m at ch'>

>>> re.match(r"\w+\B","mat ch")
<_sre.SRE_Match object; span=(0, 2), match='ma'>
>>> re.match(r"\w+\b","mat ch")	  
<_sre.SRE_Match object; span=(0, 3), match='mat'>


1).补充字符串：

输出：hello "lili"
>>> print("hello "lili"")
SyntaxError: invalid syntax

>>> print("hello \"lili\"")
# 避免歧义，使用转义字符，让"字符不是字符串的结尾，而是一个独立的"字符
hello "lili"
>>> print(r"hello \"lili\"")
hello \"lili\"
>>> print("hello 'lili'")
hello 'lili'

>>> print("\r\t")

>>> print("\\r\\t") #当转义字符很多时，要用特别多的\\
\r\t

为了防止字符转义，可以使用原始字符串，在字符串前加r或R;原始字符串不会把\当成特殊字符，不会转义
注：原始字符串的结尾不能输入反斜线\,除非对反斜线进行转义\\

>>> print(r"\r\t")
\r\t
>>> print(r"\r\t\")
SyntaxError: EOL while scanning string literal
>>> print(r"\r\t\\")
\r\t\\

 '''this is very long string.
"hello world"'''

#一个大的字符串跨多行用'''或"""

2).转义字符的用法：

>>> s = "\nabc"
>>> print(s)

abc
>>>

如果是："C:\network\test.py"

>>> s = "C:\network\test.py"	  
>>> print(s)
C:
etwork	est.py
>>> s = r"C:\network\test.py"
>>> print(s)
C:\network\test.py

3).python中，匹配字符串中"\\n"的理解
>>> s = "\\nabc"

>>> re.match("\\n\w",s)
	  
>>> re.match("\\n\w",s) #没有匹配成功，因为，Python把字符串s中的"\\n",理解成：每个\都代表一个转义字符
						#那么就是"\"+"\"+"n",三个字符。
>>>  re.match("\\\\n\w",s)#那么匹配对象里有一个"\",我就用2个"\\",进行匹配
	     
<_sre.SRE_Match object; span=(0, 3), match='\\na'>
>>>

但是这样\\\\太多了，所有我们一般要用原始字符串，r"\\nabc"，字符串是什么样就是什么样。

>>> re.match(r"\\n\w",s)
<_sre.SRE_Match object; span=(0, 3), match='\\na'>

******************************
匹配分组：

| 匹配左右任意一个表达式

>>> re.match("1|2|a","2d")	  
<_sre.SRE_Match object; span=(0, 1), match='2'>

练习1：
写一个正则表达式，匹配0-100的整数

r"\d$|[1-9]\d$|100$"
r"[1-9]\d?$|0$|100$"
r"[1-9]?\d?$|100$" 

(ab) 将括号中字符作为一个分组

路径：C:\network\test.py
网页：<html></html>

<h1>标题</h1>

>>> s = "<h1>标题</h1>"	  
>>> re.match(r"<h1>(.+)</h1>",s)	  
<_sre.SRE_Match object; span=(0, 11), match='<h1>标题</h1>'>
>>> ret = re.match(r"<h1>(.+)</h1>",s)	  
>>> ret.group()	  
'<h1>标题</h1>'
>>> ret.group(1)	  
'标题'

>>> ret = re.match(r"(<h1>)(.+)(</h1>)",s)	  
>>> ret.group(1)	  
'<h1>'
>>> ret.group(2)	  
'标题'
>>> ret.group(3)	  
'</h1>'
>>> ret.group(0)	  
'<h1>标题</h1>'

\num：调用分组num对应括号的内容

>>> re.match(r"<(.+)>(.+)<(/\1)>",s)	  
<_sre.SRE_Match object; span=(0, 11), match='<h1>标题</h1>'>
>>> ret = re.match(r"<(.+)>(.+)<(/\1)>",s)
>>> ret.group()	  
'<h1>标题</h1>'
>>> ret.group(0)	  
'<h1>标题</h1>'
>>> ret.group(1)	  
'h1'

>>> s = "<html><title>百度</title><h1>欢迎</h1></html>"	  
>>> re.match(r"<(.+)><(.+)>(.+)<(/\2)><(.+)>(.+)</\5><(/\1)>",s)
<_sre.SRE_Match object; span=(0, 41), match='<html><title>百度</title><h1>欢迎</h1></html>'>
>>> ret = re.match(r"<(.+)><(.+)>(.+)<(/\2)><(.+)>(.+)</\5><(/\1)>",s)	  
>>> ret.group(4)	  
'/title'

(?P<name>) 给分组起个别名
(?P=name) 调用分组别名为name的字符串


>>> s = "<h1>标题</h1>"	  
>>> re.match(r"<(?P<key1>.+)>(.+)</(?P=key1)>",s) #用法	  
<_sre.SRE_Match object; span=(0, 11), match='<h1>标题</h1>'>
>>> re.match(r"<((?P<key1>).+)>(.+)</(?P=key1)>",s)
>>>

4).re模块的其他函数

match()

search(): 搜索字符串，不必从开头匹配，只找到匹配的第一个子字符串

>>> s = "<h1>content</h1><h1>content</h1>"	  
>>> re.search(r"content",s)	  
<_sre.SRE_Match object; span=(4, 11), match='content'>
>>> ret = re.search(r"content",s)	  
>>> print(ret)	  
<_sre.SRE_Match object; span=(4, 11), match='content'>
>>> ret.group()
'content'
>>> print(ret.group())	  
Content
>>> s = "<h1>content</h1><h1>content</h1>"
>>> re.search("content",s)
<_sre.SRE_Match object; span=(4, 11), match='content'>

findall(): 查找所有的符合规则的字符串。把找到的结果放到一个列表里

>>> re.findall(r"content",s)
['content', 'content']
>>> re.findall("content",s)
['content', 'content']

**********
sub(正则表达式,replace,string) 字符替换

>>> re.sub("\d+","50","a=100, b=0")	  
'a=50, b=50'

>>> def replace(args):  # args是匹配的对象
	r = int(args.group()) + 50  # args是匹配到的内容
	return str(r)	  
>>> re.sub("\d+",replace,"a=100, b=0")	  
'a=150, b=50'

**********
split() 分隔

>>> re.split(":|,|-","name:ada,113:sdd-45")
	  
['name', 'ada', '113', 'sdd', '45']

5).re模块：贪婪和非贪婪模式

贪婪模式：从左到右尽可能多的匹配，在满足整个匹配规则的基础上
非贪婪模式：从左到右尽可能少的匹配

>>> s = "<html><h1>con</h1></html>"	  
>>> re.match(r"<.+>",s) #.+是任意字符都可以，从前html>到最后</html>都能满足，但是为了符合整体规则。最后的>给规则"<.+>"中的">",.+直到最后的</html
<_sre.SRE_Match object; span=(0, 25), match='<html><h1>con</h1></html>'>
>>> re.sub(r"<.+>","",s)	  
''

>>> s = "this is a number 192.168.2.5"	  
>>> re.match(r"(.+)(\d+\.\d+\.\d+\.\d+)",s)	  
<_sre.SRE_Match object; span=(0, 28), match='this is a number 192.168.2.5'>
>>> ret = re.match(r"(.+)(\d+\.\d+\.\d+\.\d+)",s)	  
>>> ret.group(1)	  
'this is a number 19'
>>> ret.group(2)
'2.168.2.5'

>>> ret = re.match(r"(.+?)(\d+\.\d+\.\d+\.\d+)",s) # 用？来终止贪婪模式，终止后，看？后面，由？后面决定到哪里匹配终止。
>>> ret.group(1）# ？前面变为非贪婪，后面还是贪婪模式	  
'this is a number '
>>> ret.group(2)	  
'192.168.2.5'


































Linux网络编程-Web服务器
1. HTTP协议讲解：
HTML: 超文本文件 --- 主要用在网页上，在基本的文本文件上添加了自己的格式和协议。
HTTP：超文本传输协议 --- 主要用在网页传输上，传输HTML的数据。

（1）HTTP的格式：
GET / HTTP/1.1
Host: www.baidu.com
Connection: keep-alive
User-Agent: Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36
Upgrade-Insecure-Requests: 1
Accept:text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8
Accept-Encoding: gzip, deflate, br
Accept-Language: zh-CN,zh;q=0.9
Cookie:BAIDUID=C722946F91D81BF14F07ED9F32EE9592:FG=1; BIDUPSID=C722946F91D81BF14F07ED9F32EE9592;
PSTM=1516689180; BD_UPN=12314353

数据报文：字节流-----请求头 + 请求体
				    响应头 + 响应体				

请求头：Headers
GET / HTTP/1.1 # 起始行
#GET: 请求方式
#/: 路径，获取资源的路径 /index.html == /
#HTTP/1.1 HTTP 协议的版本

HTTP的请求方式：
GET：获取数据，让服务器把数据返回到浏览器
POST：修改数据，让服务器修改本身的数据。例如：修改密码
PUT：保存数据，让服务器把数据保存到服务器上。例如：注册
DELETE：删除保存的数据
HEAD：返回报文头

响应头：Headers

HTTP/1.1 200 OK #起始行 
Bdpagetype: 1
Bdqid: 0xfd7e9692000008b7
Bduserid: 0
Cache-Control: private
Connection: Keep-Alive
Content-Encoding: gzip
Content-Type: text/html; charset=utf-8
Cxy_all: baidu+52d816c2f2ae6f0d8d3ca1d50977c1e5
Date: Thu, 01 Mar 2018 02:15:31 GMT
Expires: Thu, 01 Mar 2018 02:14:34 GMT
Server: BWS/1.1
Set-Cookie: BDSVRTM=0; path=/
Set-Cookie: BD_HOME=0; path=/
Set-Cookie: H_PS_PSSID=1450_25549_21105_22074; path=/; domain=.baidu.com
Strict-Transport-Security: max-age=172800
Vary: Accept-Encoding
X-Powered-By: HPHP
X-Ua-Compatible: IE=Edge,chrome=1
Transfer-Encoding: chunked

2xx: 200 OK------成功返回，响应成功
3xx: 资源不在服务器上，在其他地方，需要跳转下
4xx: 404 Not Found 用户请求错误，网页找不到
5xx: 502 Web... 服务器出现错误

（2）格式解析：
客户端---服务器
send()--- data = recv()

数据报文的格式：

起始行：GET / HTTP/1.1\r\n
请求头：......\r\n
"\r\n"
请求体：......\r\n


2.Web服务器编码流程（框架）
"""
静态web服务器的编码流程
"""
import socket
from multiprocessing import Process

def deal_client(cli_socket, cli_addr):
    # 3.接收数据
    #while True: 不能写
    recv_data = cli_socket.recv(1024)
    # 4.对recv_data解析 recv_data: 起始行+请求头+"\r\n"+请求体
    # 起始行：GET / HTTP/1.1
    # 5.提取recv_data的请求方式 --- spiltlines()
    # 6.提取recv_data的路径：/ 或者 /index.html --- 正则表达式
    # 7.如果没有这个文件
    try:
        file = open()
    except IOError:
        # 8.回 404 Not Found ,数据都在响应报文
        """
            HTTP/1.1 404 Not Found\r\n
            Server: My Server\r\n
            \r\n
            File is not Found     
        """
    else:
        # 9.获得file的数据，file_data = read
        """
            HTTP/1.1 200 OK\r\n
            Server: My Server\r\n
            \r\n
            file_data     
        """
    cli_socket.close()

def main():
    # 1.创建socket
    ser_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    ser_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    ser_socket.bind(("", 8000))
    ser_socket.listen(100)
    # 2.创建多进程服务器
    while True:
        new_socket, new_addr = ser_socket.accept()
        p = Process(target=deal_client, args=(new_socket,new_addr))
        p.start()
        new_socket.close()

if __name__ == "__main__":
main()

3. 静态的web服务器
要求：多进程的形式recv()
	  print()
	  不管接收数据是什么，都返回个"Hello World"
	  让浏览器显示出来
	  
	  补充：
	  new_socket, new_addr = accept()
	  
	  print("%s客户端已经上线" %str(new_addr))
	  print("%s:%s客户端已经上线" %new_addr)

"""
静态Web服务器，返回hello world
"""
#coding=utf-8
import  socket
from multiprocessing import Process


def deal_client(cli_socket, cli_addr):

    recv_data = cli_socket.recv(1024)
    print("%s" %recv_data.decode("utf-8"))
    # HTTP/1.1

    #response = "HTTP/1.1 200 OK\r\nServer: My Server\r\n\r\nHello World"
    response_start_line = "HTTP/1.1 200 OK\r\n"
    response_headers = "Server: My Server\r\n"
    response_body = "Hello World"
    response = response_start_line + response_headers + "\r\n" + response_body
    print("%s" %response)
    cli_socket.send(response.encode("utf-8"))
    cli_socket.close()

def main():
    ser_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    ser_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    ser_socket.bind(("", 8000))
    ser_socket.listen(100)

    while True:
        new_socket, new_addr = ser_socket.accept()
        print("%s:%s客户端已连接" %new_addr)
        cli = Process(target=deal_client, args=(new_socket, new_addr))
        cli.start()
        new_socket.close()

if __name__ == "__main__":
main()

4. 静态web服务器
要求：192.168.2.5:8000 回车------- ./html/index.html
	  192.168.2.5:8000/index.html ----- ./html/index.html
	  192.168.2.5:8000/python.html ---- File is not found
	  
	  recv_data = recv()
	  file_name 
	  try:
		open()
	  
	  实现这个功能,用正则表达式找到请求的路径
	  GET /index.html HTTP/1.1

（1）老师的版本：
import socket, re
from multiprocessing import Process

HTML_ROOT_DIR = "./html"

def deal_client(cli_socket, cli_addr):
    recv_data = cli_socket.recv(1024)
    print("%s" %recv_data.decode("utf-8"))
    # 数据报文都是以字节码的传输的，不是字符串
    # recv_data 请求数据报文，splitlines，字符串按行提取，返回列表
    request_lines = recv_data.splitlines()
    # 获取请求起始行
    request_start_line = request_lines[0]
    # 从起始行找到获取的资源文件 / 或者 /index.html
    # GET /index.html HTTP/1.1
    # re.match("\w+\s(/\w+\.\w+)", s)
    # re.match("\w+\s(/[^\s]*)", s)
    # 别忘记上面这个是对象，字符串用group()函数获得
    # request_start_line 必须解码再用
    file_name = re.match("\w+\s(/[^\s]*)", request_start_line.decode("utf-8")).group(1)
    # file_name == "/" 打开首页，
    # 一般把常量放在左边，右边放变量
    if "/" == file_name:
        file_name = "/index.html"
    try:
        file = open(HTML_ROOT_DIR + file_name, "rb")
    except IOError:
        # 构建错误信息数据报文
        response_start_line = "HTTP/1.1 404 Not Found\r\n"
        respone_headers = "Server: Static_Server\r\n"
        response_body = "File is not found!"
    else:
        # 文件的数据也是字节流
        file_data = file.read(1024)
        file.close()
        # 构造成功信息数据报文
        response_start_line = "HTTP/1.1 200 OK\r\n"
        respone_headers = "Server: Static_Server\r\n"
        # file_data 必须编码改变编码格式
        response_body = file_data.decode("utf-8")
    finally:
        response = response_start_line + respone_headers + "\r\n" + response_body
        print("%s" %response)
    cli_socket.send(response.encode("utf-8"))
    cli_socket.close()

def main():
    ser_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    ser_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    ser_socket.bind(("", 8000))
    ser_socket.listen(100)

    while True:
        new_socket, new_addr = ser_socket.accept()
        print("%s:%s用户已经连接上了" %new_addr)
        cli = Process(target=deal_client, args=(new_socket, new_addr))
        cli.start()
        new_socket.close()

if __name__ == "__main__":
main()

（2）自己的版本：
"""
静态web服务器的编码流程
"""

import socket, re
from multiprocessing import Process

def deal_client(cli_socket, cli_addr):
    # 3.接收数据
    # while True: 不能写
    recv_data = cli_socket.recv(1024)
    print("%s" %recv_data.decode("utf-8"))
    # 4.对recv_data解析 recv_data:起始行+请求头+"\r\n"+请求体
    # 起始行: GET / HTTP/1.1
    # 5.提取recv_data的请求方式 --- splitlines()
    # 6.提取recv_data的路径：/ 或者 /index.html --- 正则表达式
    # 7.如果没有这个文件
    try:
        lines = recv_data.splitlines()
        print(lines)
        #print(lines[0].decode("utf-8"))
        first_line = lines[0].decode("utf-8")
        print(first_line)
        if first_line.startswith("GET"):
            file_addr = re.match("GET (.+) HTTP/1.1",first_line)
            if file_addr.group(1) in ["/index.html","/"]:
                file_name = "./html/index.html"
            else:
                file_name = "." + file_addr.group(1)
            print(file_name)
            file = open(file_name,"rb")
            file_data = file.read()
            print(file_data)

    except IOError:
        # 8.回复404 Not Found,数据都在响应报文中
        """
            HTTP/1.1 404 Not Found\r\n
            Server: My Server\r\n
            \r\n
            File is not Found
        """
        # response = "HTTP/1.1 404 Not Found\r\nServer: My Server\r\n\r\nFile is not Found"
        response_start_line = "HTTP/1.1 404 Not Found\r\n"
        response_headers = "Server: My Server\r\n"
        response_body = "File is not Found"
        cli_socket.send((response_start_line+response_headers+"\r\n"+response_body).encode("utf-8"))
    else:
        # 9.获得file的数据,file_data = read
        """
            HTTP/1.1 200 OK\r\n
            Server: My Server\r\n
            \r\n
            file_data	
        """
        #cli_socket.recv(1024)
        response = "HTTP/1.1 200 OK\r\nServer: My Server\r\n\r\n " + str(file_data.decode("utf-8"))
        cli_socket.send(response.encode("utf-8"))
    cli_socket.close()

def main():
    # 1.创建socket
    ser_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    ser_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    ser_socket.bind(("", 8000))
    ser_socket.listen(100)
    # 2.创建多进程服务器
    while True:
        new_socket, new_addr = ser_socket.accept()
        print("%s:%s客户端已连接" %new_addr)
        p = Process(target=deal_client, args=(new_socket, new_addr))
        p.start()
        new_socket.close()

if __name__ == "__main__":
main()

（3）index.html文件：
<html>
<head>
    <meta charset="utf-8">
    <title>华清远见</title>
</head>
<body>
<h1>欢迎来到华清远见</h1>
<p>以后内容更精彩</p>
</body>
</html>

5.面向对象的静态web服务器：
import socket, re
from multiprocessing import Process

WEB_ROOT_DIR = "./html"

class HTTPServer(object):
    def __init__(self):
        self.ser_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.ser_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)

    def start(self):
        self.ser_socket.listen(100)
        while True:
            new_socket, new_addr = self.ser_socket.accept()
            print("%s:%s客户端已连接" % new_addr)
            cli = Process(target=self.deal_client, args=(new_socket,))
            cli.start()
            new_socket.close()

    def deal_client(self,cli_socket):
        recv_data = cli_socket.recv(1024)
        print(recv_data.decode("utf-8"))
        # GET /index.html HTTP/1.1\r\n......\r\n
        request_lines = recv_data.splitlines()
        file_name = re.match(r"\w+\s(/[^\s]*)", request_lines[0].decode("utf-8")).group(1)
        if "/" == file_name:
            file_name = "/index.html"
        try:
            file = open(WEB_ROOT_DIR + file_name, "rb")
        except IOError:
            response_start_line = "HTTP/1.1 404 Not Found\r\n"
            response_headers = "Server: My Server\r\n"
            response_body = "<h1>file not found</h1>"
        else:
            file_data = file.read(1024)
            response_start_line = "HTTP/1.1 200 OK\r\n"
            response_headers = "Server: My Server\r\n"
            response_body = file_data.decode("utf-8")
        finally:
            response = response_start_line + response_headers + "\r\n" + response_body
            print(response)
        cli_socket.send(response.encode("utf-8"))
        cli_socket.close()

    def bind(self, port):
        self.ser_socket.bind(("", port))

def main():
    http_server = HTTPServer()
    http_server.bind(8000)
    http_server.start()

if __name__ == "__main__":
main()

6.动态web服务器：
**********
a.py
“””
WSGI接口：web服务器通过统一接口调用Python程序或者应用程序或者基于框架的程序
“””

# env: 服务器解析后的请求字典，由服务器传入参数
# GET /a.py HTTP/1.1\r\n……\r\n…
#env = {
#	“Method”:”GET”,
#	“PATH_INFO”:”/a.py”
#}

# 服务器定义: start_response
# def start_response(status,headers):

# 响应头
# Bdpagetype: 1
# Bdqid: 0xfd7e9692000008b7
# Bduserid: 0

# 最简单的WSGI接口: application()
def application(env, start_response):
	# env.get(“Method”)
	# path = env.get(“PATH_INFO”)
	status = “200 OK”
	headers = [(‘Bdpagetype’,’1’),(‘Bduserid’,’0’)]
	# 调用服务器的函数: start_response
	start_response(status, headers)
	# return 响应体
	return “<h1>hello a.py</h1>”

**********
b.py:
def application(env, start_response):
    # env.get("Method")
    # path = env.get("PATH_INFO")
    status = "200 OK"
    headers = [('Bdpagetype','1'),('Bduserid','0')]
    # 调用服务器的函数：start_response
    start_response(status, headers)
    # return 响应体
return "<h1>hello b.py</h1>"

**********
04_dynamic_web_server.py

import socket, re, sys
from multiprocessing import Process

WEB_ROOT_DIR = "./html"
WSGI_ROOT_DIR = "./python"

class HTTPServer(object):
    def __init__(self):
        self.response_headers = ""
        self.ser_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.ser_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)

    def start(self):
        self.ser_socket.listen(100)
        while True:
            new_socket, new_addr = self.ser_socket.accept()
            print("%s:%s客户端已连接" % new_addr)
            cli = Process(target=self.deal_client, args=(new_socket,))
            cli.start()
            new_socket.close()

    def deal_client(self,cli_socket):
        recv_data = cli_socket.recv(1024)
        print(recv_data.decode("utf-8"))
        # GET /index.html HTTP/1.1\r\n......\r\n
        # GET /a.py HTTP/1.1\r\n......\r\n
        request_lines = recv_data.splitlines()
        file_name = re.match(r"\w+\s(/[^\s]*)", request_lines[0].decode("utf-8")).group(1)
        print("file_name = %s" %file_name)
        if file_name.endswith(".py"):
            # file_name = /a.py
            # import --- sys.path
            env ={
                "Method": "GET",
                "PATH_INFO": "/a.py"
            }
            try:
                m = __import__(file_name[1:-3])
            except:
                response_start_line = "HTTP/1.1 404 Not Found\r\n"
                response_headers = "Server: My Server\r\n"
                response_body = "<h1>xxx.py not found</h1>"
                response = response_start_line+response_headers+"\r\n"+response_body
            else:
                response_body = m.application(env, self.start_response)
                response = self.response_start_line + self.response_headers + "\r\n" + response_body

        else:
            if "/" == file_name:
                file_name = "/index.html"
            try:
                file = open(WEB_ROOT_DIR + file_name, "rb")
            except IOError:
                response_start_line = "HTTP/1.1 404 Not Found\r\n"
                response_headers = "Server: My Server\r\n"
                response_body = "<h1>file not found</h1>"
            else:
                file_data = file.read(1024)
                response_start_line = "HTTP/1.1 200 OK\r\n"
                response_headers = "Server: My Server\r\n"
                response_body = file_data.decode("utf-8")
            finally:
                response = response_start_line + response_headers + "\r\n" + response_body
                print(response)
        cli_socket.send(response.encode("utf-8"))
        cli_socket.close()

    def start_response(self,status, headers):
        self.response_start_line = "HTTP/1.1" + status+"\r\n"

        # headers = [("",""),("",""),("","")]
        for header in headers:
            self.response_headers += "%s:%s\r\n" %header

    def bind(self, port):
        self.ser_socket.bind(("", port))

def main():
    sys.path.insert(1, WSGI_ROOT_DIR)
    http_server = HTTPServer()
    http_server.bind(8000)
    http_server.start()


if __name__ == "__main__":
main()
```
