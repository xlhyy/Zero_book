# 多进程


## fork

```
Unix/Linux操作系统提供了一个fork()系统调用，它非常特殊。普通的函数调用，调用一次，返回一次，但是fork()调用一次，返回两次，因为操作系统自动把当前进程（称为父进程）复制了一份（称为子进程），然后，分别在父进程和子进程内返回。


kaiqigu@bogon:~/dododo|⇒  cat p_fork.py 
# coding=utf-8

import os

print 'process (%s) start ...' % os.getpid()

pid = os.fork()

if pid == 0:  # 子进程
	print 'i am child process (%s) and my parent is %s.' % (os.getpid(), os.getppid())
else:  # 主进程
	print 'i (%s) just created a child process (%s).' % (os.getpid(), pid)


kaiqigu@bogon:~/dododo|⇒  python p_fork.py 
process (10417) start ...
i (10417) just created a child process (10418).
i am child process (10418) and my parent is 10417.
```


## multiprocessing

```
如果你打算编写多进程的服务程序，Unix/Linux无疑是正确的选择。由于Windows没有fork调用，难道在Windows上无法用Python编写多进程的程序？
由于Python是跨平台的，自然也应该提供一个跨平台的多进程支持。multiprocessing模块就是跨平台版本的多进程模块。



kaiqigu@bogon:~/dododo|⇒  cat p_multiprocessing.py 
# coding=utf-8

from multiprocessing import Process
import os

# 子进程要执行的代码
def run_proc(name):
	print 'run child process %s (%s) ... parent process %s' % (name, os.getpid(), os.getppid())

if __name__ == '__main__':
	print 'parent process %s.' % os.getpid()
	p = Process(target=run_proc, args=('test',))
	print 'child process will start.'
	p.start()
	p.join()  # 可以等待子进程结束后再继续往下运行，通常用于进程间的同步。
	print 'child process end.'



kaiqigu@bogon:~/dododo|⇒  python p_multiprocessing.py
parent process 61758.
child process will start.
run child process test (61775) ... parent process 61758
child process end.
```


## pool

```
如果要启动大量的子进程，可以用进程池的方式批量创建子进程。



kaiqigu@bogon:~/dododo|⇒  cat p_pool.py 
# coding=utf-8

from multiprocessing import Pool
import os, time, random

def long_time_task(name):
	print 'run task %s (%s) ...' % (name, os.getpid())
	start = time.time()
	time.sleep(1)
	end = time.time()
	print 'task %s runs %0.2f seconds.' % (name, (end-start))

if __name__ == '__main__':
	print 'parent process %s.' % os.getpid()
	p = Pool(4)
	for i in range(5):
		p.apply_async(long_time_task, args=(i,))
	print 'waiting for all subprocesses done ...'
	p.close()
	p.join()
	print 'all subprocesses done.'
	
	
	
kaiqigu@bogon:~/dododo|⇒  python p_pool.py
parent process 27367.
run task 0 (27390) ...
waiting for all subprocesses done ...
run task 1 (27391) ...
run task 2 (27392) ...
run task 3 (27395) ...
task 0 runs 1.00 seconds.
run task 4 (27390) ...
task 1 runs 1.00 seconds.
task 2 runs 1.00 seconds.
task 3 runs 1.00 seconds.
task 4 runs 1.00 seconds.
all subprocesses done.


对Pool对象调用join()方法会等待所有子进程执行完毕，调用join()之前必须先调用close()，调用close()之后就不能继续添加新的Process了。
```


## Queue(进程间通信)

```
Process之间肯定是需要通信的，操作系统提供了很多机制来实现进程间的通信。Python的multiprocessing模块包装了底层的机制，提供了Queue、Pipes等多种方式来交换数据。


kaiqigu@bogon:~/dododo|⇒  cat p_queue.py 
# coding=utf-8

from multiprocessing import Process, Queue
import os, time, random

# 写数据进程执行的代码
def write(q):
	print 'process to write: %s' % os.getpid()
	for value in ['a', 'b', 'c']:
		print 'put %s to queue ...' % value
		q.put(value)
		time.sleep(1)

# 读数据进程执行的代码
def read(q):
	print 'process to read: %s' % os.getpid()
	while True:
		value = q.get(True)
		print 'get %s from queue.' % value

if __name__ == '__main__':
	# 父进程创建Queue, 并传给各个子进程
	q = Queue()
	pw = Process(target=write, args=(q,))
	pr = Process(target=read, args=(q,))
	# 启动子进程pw，写入:
	pw.start()
	# 启动子进程pr，读取:
	pr.start()
	# 等待pw结束:
	pw.join()
	# pr进程里是死循环，无法等待其结束，只能强行终止:
	pr.terminate()



kaiqigu@bogon:~/dododo|⇒  python p_queue.py
process to write: 45351
put a to queue ...
process to read: 45354
get a from queue.
put b to queue ...
get b from queue.
put c to queue ...
get c from queue.
```


# 多线程


## 创建线程

```
kaiqigu@bogon:~/dododo|⇒  cat t_threading.py 
# coding=utf-8

import time, threading

# 新线程执行的代码
def loop():
	print 'thread %s is running ...' % threading.current_thread().name
	n = 0
	while n < 5:
		n = n+1
		print 'thread %s >>> %s' % (threading.current_thread().name, n)
		time.sleep(1)
	print 'thread %s ended.' % threading.current_thread().name


if __name__ == '__main__':
	print 'thread %s is running ...' % threading.current_thread().name
	t = threading.Thread(target=loop, name='LoopThread')
	t.start()
	t.join()
	print 'thread %s ended.' % threading.current_thread().name



kaiqigu@bogon:~/dododo|⇒  python t_threading.py
thread MainThread is running ...
thread LoopThread is running ...
thread LoopThread >>> 1
thread LoopThread >>> 2
thread LoopThread >>> 3
thread LoopThread >>> 4
thread LoopThread >>> 5
thread LoopThread ended.
thread MainThread ended.
```


## Lock

```
多线程和多进程最大的不同在于，多进程中，同一个变量，各自有一份拷贝存在于每个进程中，互不影响，而多线程中，所有变量都由所有线程共享，所以，任何一个变量都可以被任何一个线程修改，因此，线程之间共享数据最大的危险在于多个线程同时改一个变量，把内容给改乱了。
```

### 出现数据乱的情况

```
kaiqigu@bogon:~/dododo|⇒  cat t_lock1.py 
# coding=utf-8

import time, threading

# 假定这是你的银行存款
balance = 0

def change_it(n):
	# 先存后取,结果应该为0
	global balance
	balance = balance + n
	balance = balance - n

def run_thread(n):
	for i in range(100000):
		change_it(n)

t1 = threading.Thread(target=run_thread, args=(5,))
t2 = threading.Thread(target=run_thread, args=(8,))
t1.start()
t2.start()
t1.join()
t2.join()
print balance



kaiqigu@bogon:~/dododo|⇒  python t_lock1.py
47
kaiqigu@bogon:~/dododo|⇒  python t_lock1.py
-8
kaiqigu@bogon:~/dododo|⇒  python t_lock1.py
46
kaiqigu@bogon:~/dododo|⇒  python t_lock1.py
0
kaiqigu@bogon:~/dododo|⇒  python t_lock1.py
13
```


### 数据不乱的情况(加锁)

```
kaiqigu@bogon:~/dododo|⇒  cat t_lock2.py 
# coding=utf-8

import time, threading

# 假定这是你的银行存款:
balance = 0
lock = threading.Lock()

def change_it(n):
    # 先存后取，结果应该为0:
    global balance
    balance = balance + n
    balance = balance - n

def run_thread(n):
    for i in range(100000):
		# 先获取锁
		lock.acquire()
		try:
			# 放心的改
			change_it(n)
		finally:
			# 改完了一定要释放锁
			lock.release()

t1 = threading.Thread(target=run_thread, args=(5,))
t2 = threading.Thread(target=run_thread, args=(8,))
t1.start()
t2.start()
t1.join()
t2.join()
print(balance)



kaiqigu@bogon:~/dododo|⇒  python t_lock2.py 
0
kaiqigu@bogon:~/dododo|⇒  python t_lock2.py
0
kaiqigu@bogon:~/dododo|⇒  python t_lock2.py
0
kaiqigu@bogon:~/dododo|⇒  python t_lock2.py
0
```


### 多核CPU

```
启动与CPU核心数量相同的N个线程，在4核CPU上可以监控到CPU占用率仅有102%，也就是仅使用了一核。

但是用C、C++或Java来改写相同的死循环，直接可以把全部核心跑满，4核就跑到400%，8核就跑到800%，为什么Python不行呢？

因为Python的线程虽然是真正的线程，但解释器执行代码时，有一个GIL锁：Global Interpreter Lock，任何Python线程执行前，必须先获得GIL锁，然后，每执行100条字节码，解释器就自动释放GIL锁，让别的线程有机会执行。这个GIL全局锁实际上把所有线程的执行代码都给上了锁，所以，多线程在Python中只能交替执行，即使100个线程跑在100核CPU上，也只能用到1个核。

GIL是Python解释器设计的历史遗留问题，通常我们用的解释器是官方实现的CPython，要真正利用多核，除非重写一个不带GIL的解释器。

所以，在Python中，可以使用多线程，但不要指望能有效利用多核。如果一定要通过多线程利用多核，那只能通过C扩展来实现，不过这样就失去了Python简单易用的特点。

不过，也不用过于担心，Python虽然不能利用多线程实现多核任务，但可以通过多进程实现多核任务。多个Python进程有各自独立的GIL锁，互不影响。

小结

多线程编程，模型复杂，容易发生冲突，必须用锁加以隔离，同时，又要小心死锁的发生。

Python解释器由于设计时有GIL全局锁，导致了多线程无法利用多核。多线程的并发在Python中就是一个美丽的梦。
```
