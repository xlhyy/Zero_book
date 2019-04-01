# 多线程


## 什么是多线程?

```
1) 如果在一个进程中同时运行了多个线程，用来完成不同的工作，则称之为"多线程"。
2) 多个线程交替占用CPU资源，而非真正的并行执行。

注: 多线程的好处
1) 充分利用CPU的资源
2) 简化编程模型
3) 带来良好的用户体验

Java提供了java.lang.Thread类支持多线程编程。
```


## 主线程

```
main()方法即为主线程入口。
产生其他子线程的线程。
必须最后完成执行，因为它执行各种关闭动作。

例:
public static void main(String[] args){
	Thread t = Thread.currentThread();		//获得主线程对象
	System.out.println("当前线程是:"+t.getName());
	t.setName("MyJavaThread");			//设置线程名
	System.out.println("当前线程名是:"+t.getName());//获取线程名
}
```


## 线程的创建和启动
```
1) 在Java中创建线程的两种方式:
继承java.lang.Thread类
实现java.lang.Runnable接口

2) 使用线程的步骤:
定义线程 --> 创建线程对象 --> 启动线程 --> 终止线程
```

## 继承Thread类创建线程

```
1) 定义MyThread类继承Thread类。
2) 重写run()方法，编写线程执行体。
3) 创建线程对象，调用start()方法启动线程。
```

```
例1:
public class MyThread extends Thread{  //继承Thread类
	//重写run()方法
	public void run(){
		for(int i=1; i<100; i++){
			System.out.println(Thread.currentThread().getName()+":"+i);
		}
	}
}

public static void main(String[] args){
	MyThread thread = new MyThread();
	thread.start();  //启动线程
}
```

```
例2:
MyThread t1 = new MyThread();
MyThread t2 = new MyThread();
t1.start();
t2.start();

注:
多个线程交替执行，不是真正的"并行"。
线程每次执行时长由分配的CPU时间片长度决定。
```


## 实现Runnable接口创建线程

```
1) 定义MyRunnable类实现Runnable接口。
2) 实现run()方法，编写线程执行体。
3) 创建线程对象，调用start()方法启动线程。
```

```
例:
public class MyRunnable implements Runnable{  //实现Runnable接口
	//实现run()方法
	public void run(){
		for(int i=0; i<100; i++){
			System.out.println(Thread.currentThread().getName()+":"+i);
		}
	}
}

public static void main(String[] args){
	MyRunnable myRunnable = new MyRunnable();
	Thread myThread = new Thread(myRunnable);
	thread.start();  //启动线程
}
```


## 比较两种创建线程的方式

```
1) 继承Thread类
编写简单，可直接操作线程。
适用于单继承。

2) 实现Runnable接口
避免单继承局限性。
便于共享资源。

注:
1) 推荐使用实现Runnable接口方式创建线程。
2) 线程对象调用start()方法和调用run()方法的区别？
    通过调用Thread类的 start()方法来启动一个线程，这时此线程处于就绪（可运行）状态，并没有运行，一旦得到cpu时间片，就开始执行run()方法，这里方法 run()称为线程体，它包含了要执行的这个线程的内容，Run方法运行结束，此线程随即终止。
```


## 线程调度

```
线程调度指按照特定机制为多个线程分配CPU的使用权。

	方法	 			说明
setPriority(int newPriority)	更改线程的优先级
static void sleep(long millis)	在指定的毫秒数内让当前正在执行的线程休眠
void join()			等待该线程终止
static void yield()		暂停当前正在执行的线程对象，并执行其他线程
void setName(String name)	设置线程名
boolean isAlive()		测试线程是否处于活动状态
```

## 线程优先级

```
1) 线程优先级由1-10表示，1最低，默认优先级为5。
2) 优先级高的线程获得CPU资源的概率较大。
```

```
例:
t1.setPriority(Thread.MAX_PRIORITY);  //将线程对象设置为最高优先级
t2.setPriority(Thread.MIN_PRIORITY);  //将线程对象设置为最低优先级
```

## 线程休眠

```
1) 让线程暂时睡眠指定时长，线程进入阻塞状态。
2) 睡眠时间过后线程会再进入可运行状态。
```

```
例:
Thread.sleep(1000);  //线程休眠1秒
```

## 线程的强制运行

```
使当前线程暂停执行，等待其他线程结束后再继续执行本线程。
public final void join()
public final void join(long mills)
public final void join(long mills, int nanos)

注:
mills: 以毫秒为单位的等待时长。
nanos: 要等待的附加纳秒时长。
需处理InterruptedException异常。
```

```
例:
package mypackage;

public class Test01 {
    //1.现在有T1、T2、T3三个线程，你怎样保证T2在T1执行完后执行，T3在T2执行完后执行
    public static void main(String[] args) throws InterruptedException {
        Thread th1 = new Thread01();
        Thread th2 = new Thread02();
        Thread th3 = new Thread03();
        th1.start();
        th1.join();
        System.out.println("Thread01运行结束。。。");
        th2.start();
        th2.join();
        System.out.println("Thread02运行结束。。。");
        th3.start();
        th3.join();
        System.out.println("Thread03运行结束。。。");
        System.out.println("------主函数-------");
    }
}
class Thread01 extends Thread{
    
    public void run() {
        System.out.println("Thread01...running...");
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
class Thread02 extends Thread{
    public void run() {
        System.out.println("Thread02...running...");
        try {
            Thread.sleep(500);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        
    }
}
class Thread03 extends Thread{
    public void run() {
        System.out.println("Thread03...running...");
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        
    }
}

运行结果:
Thread01...running...
Thread01运行结束。。。
Thread02...running...
Thread02运行结束。。。
Thread03...running...
Thread03运行结束。。。
------主函数-------
```

## 线程的礼让

```
1) 暂停当前线程，允许其他具有相同优先级的进程获得运行机会。
2) 该线程处于就绪状态，不转为阻塞状态。
public static void yield()

注: 实际中无法保证yield()达到让步的目的，因为让步的线程可能被线程调度程序再次选中。
```

```
例:
package mypackage;

public class TestYield {
	 public static void main(String[] args) {
	   MyThread3 t1 = new MyThread3("t1");
	   MyThread3 t2 = new MyThread3("t2");
	   t1.start();
	   t2.start();
	 }
}

class MyThread3 extends Thread {
	MyThread3(String s) {
		super(s);
	}
	
	public void run() {
		for(int i = 1;i <=10; i++) {
			System.out.println(getName() + ":"+i);
			if(i == 0){
				yield();
			}
		}
	}
}

运行结果:
t1:1
t1:2
t2:1
t1:3
t2:2
t1:4
t2:3
t1:5
t2:4
t2:5
t2:6
t2:7
t2:8
t2:9
t2:10
t1:6
t1:7
t1:8
t1:9
t1:10
```

## 线程的五个状态

```
1) 创建状态
2) 就绪状态
3) 阻塞状态
4) 运行状态
5) 死亡状态

1) 新建
2) 就绪
3) 阻塞
4) 死亡
```

## join，sleep，yield对比

```
1) join方法:
    假如在A线程中调用了B线程的join方法(B.join();)，这时A线程会在B线程运行完毕后再运行后面的代码。

2) sleep方法:
    线程中调用sleep方法后，本线程停止(进入阻塞状态)，运行权交给其他线程。

3) yield方法:
    线程中调用yield方法后本线程并不停止，运行权由本线程和优先级不低于本线程的线程来抢。(这里要注意并不是优先级低的就一定抢不过优先级高的，优先级高的只是时间片大一些)
```

## 同步方法(解决多线程共享数据引发的问题)(多个线程操作同一共享资源时，将引发数据不安全问题)

```
使用synchronized修饰的方法控制对类成员变量的访问。

语法:
访问修饰符 synchronized 返回类型 方法名(参数列表){ ... }
或者
synchronized 访问修饰符 返回类型 方法名(参数列表){ ... }

sunchronized就是为当前的线程声明一个锁。
```

```
例1:
public class HasSelfPrivateNum {
    private int num = 0;
    public void addI(String username) {
        try {
            if (username.equals("a")) {
                num = 100;
                System.out.println("a set over!");
                Thread.sleep(2000);
            } else {
                num = 200;
                System.out.println("b set  over!");
            }
            System.out.println(username + " num=" + num);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
 
    public static void main(String[] args) {
        HasSelfPrivateNum numRef = new HasSelfPrivateNum();
        ThreadA a = new ThreadA(numRef);
        a.start();
        ThreadB b = new ThreadB(numRef);
        b.start();
    }
}
 
class ThreadA extends Thread{
    private HasSelfPrivateNum numRef;
    public ThreadA(HasSelfPrivateNum numRef){
        super();
        this.numRef = numRef;
    }
 
    @Override
    public void run(){
        super.run();
        numRef.addI("a");
    }
}
 
class ThreadB extends Thread{
    private HasSelfPrivateNum numRef;
    public ThreadB(HasSelfPrivateNum numRef){
        super();
        this.numRef = numRef;
    }
 
    @Override
    public void run(){
        super.run();
        numRef.addI("b");
    }
}

运行结果:
a set over!
b set  over!
b num=200
a num=200
```

```
例2:
public class HasSelfPrivateNum {
    private int num = 0;
 
    synchronized public void addI(String username) {
        try {
            if (username.equals("a")) {
                num = 100;
                System.out.println("a set over!");
                Thread.sleep(2000);
            } else {
                num = 200;
                System.out.println("b set  over!");
            }
            System.out.println(username + " num=" + num);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
 
    public static void main(String[] args) {
        HasSelfPrivateNum numRef1 = new HasSelfPrivateNum();
        HasSelfPrivateNum numRef2 = new HasSelfPrivateNum();
        ThreadA a = new ThreadA(numRef1);
        a.start();
        ThreadB b = new ThreadB(numRef2);
        b.start();
    }
}
 
class ThreadA extends Thread{
    private HasSelfPrivateNum numRef;
    public ThreadA(HasSelfPrivateNum numRef){
        super();
        this.numRef = numRef;
    }
 
    @Override
    public void run(){
        super.run();
        numRef.addI("a");
    }
}
 
class ThreadB extends Thread{
    private HasSelfPrivateNum numRef;
    public ThreadB(HasSelfPrivateNum numRef){
        super();
        this.numRef = numRef;
    }
 
    @Override
    public void run(){
        super.run();
        numRef.addI("b");
    }
}

运行结果:
a set over!
b set  over!
b num=200
a num=100
```


## 同步代码块

```
语法:
synchronized(syncObject){
	//需要同步的代码
}

注:
syncObject为需同步的对象，通常为this。
效果与同步方法相同。
```

```
例:
public void run(){
	while(true){
		synchronized(this){  //同步代码块
			//省略修改数据的代码 ...
			//省略显示信息的代码 ...
		}
	}
}
```

```
总结:
多个并发线程访问同一资源的同步代码块时:
1) 同一时刻只能有一个线程进入synchronized(this)同步代码块。
2) 当一个线程访问一个synchronized(this)同步代码块时，其他synchronized(this)同步代码块同样被锁定。
3) 当一个线程访问一个synchronized(this)同步代码块时，其他线程可以访问该资源的非synchronized(this)同步代码。
```

## 线程安全的类型

```
例: 查看ArrayList类的add()方法定义:
public boolean add(E e){
	ensureCapacityInternal(size+1);  //集合扩容，确保能新增数据
	elementData[size++] = e;  //在新增位置存放数据
	return true;
}

注:
1) ArrayList类的add()方法为非同步方法。
2) 当多个线程向同一个ArrayList对象添加数据时，可能出现数据不一致问题。
3) ArrayList为非线程安全的类型。

-----------------------------------------------------------------
		方法是否同步	效率比较	适合场景
-----------------------------------------------------------------
线程安全	是		低		多线程并发共享资源
-----------------------------------------------------------------
非线程安全	否		高		单线程
-----------------------------------------------------------------
(为了达到安全性和效率的平衡，可以根据实际场景来选择合适的类型。)
```

## 常见类型对比

```
1) Hashtable && HashMap
Hashtable
继承关系: 实现了Map接口，Hashtable继承Dictionary类。
**线程安全，效率较低。
键和值都不允许为null。

HashMap
继承关系: 实现了Map接口，HashMap继承AbstractMap类。
**非线程安全，效率较高。
键和值都允许为null。

2) StringBuffer && StringBuilder
前者线程安全，后者非线程安全。
```


## 补充
```
1) Java实现线程同步的两种方式是什么？
https://www.cnblogs.com/wuyangbing/p/synchronized.html

2) Java提供了哪三个方法用于实现线程间通信？
https://www.cnblogs.com/hapjin/p/5492619.html
```
