============================================
1. 什么是文件
文件可认为是相关记录或放在一起的数据的集合。
JAVA API: java.io.File类


﻿============================================
2. File类
1) File file = new File(String pathname);

2) File类的常用方法
	方法名称			说明
boolean exists( )		判断文件或目录是否存在
boolean isFile( )		判断是否是文件	
boolean isDirectory( )		判断是否是目录
String getPath( )		返回此对象表示的文件的相对路径名
String getAbsolutePath( )	返回此对象表示的文件的绝对路径名
String getName( )		返回此对象表示的文件或目录的名称
boolean delete( )		删除此对象指定的文件或目录
boolean createNewFile( )	创建名称的空文件,不创建文件夹
long length()			返回文件的长度,单位为字节 , 如果文件不存在,则返回 0L


﻿============================================
3. 流
流是指一连串流动的字符，是以先进先出方式发送信息的通道。
通过流来读写文件。

1) Java流的分类:
----------------------
按流向区分:
	输入流: OutputStream和Writer作为基类
	输入流: InputStream和Reader作为基类
(输入输出流是相对于计算机内存来说的。)

----------------------
按处理数据单元划分:
	字节流:
		字节输入流InputStream基类
		字节输出流OutputStream基类
	字符流:
		字符输入流Reader基类
		字符输出流Writer基类
(字节流是8位通用字节流；字符流是16位Unicode字符流。)


﻿============================================
4. 文件的读写
1) 文本文件的读写:
	用FileInputStream和FileOutputStream读写文本文件。
	用BufferedReader和BufferedWriter读写文本文件。
2) 二进制文件的读写:
	使用DataInputStream和DataOutputStream读写二进制文件。

/******************1.使用字节流读写文件******************/
----------------------------------------------------
使用FileInputStream读文本文件:

实现步骤:
import java.io.IOException;
import java.io.FileInputStream;

FileInputStream fis = new FileInputStream("c:\\test.txt");

fis.available();
fis.read();

fis.close();

小结:
InputStream类常用方法:
int read()
int read(byte[] b)
int read(byte[] b,int off,int len)
void close()
int available()

子类FileInputStream常用的构造方法:
FileInputStream(File file)
FileInputStream(String name)

----------------------------------------------------
使用FileOutputStream写文本文件:

实现步骤:
import java.io.IOException;
import java.io.FileOutputStream;

FileOutputStream fos = new FileOutputStream("c:\\test.txt");

String str = "好好学习";
byte[] words = str.getBytes();
fos.write(words);

fos.close();

小结:
OutputStream类常用方法:
void write(int c)
void write(byte[] buf)
void write(byte[] b, int off, int len)
void close()

子类FileOutputStream常用的构造方法:
FileOutputStream(File file)
FileOutputStream(String name)
FileOutputStream(String name, boolean append)

注:
    前两种构造方法在向文件写数据时将覆盖文件中原有的内容。
    创建FileOutputStream实例时，如果相应的文件并不存在，则会自动创建一个空的文件。

例: 复制文本文件
FileInputStream fis = new FileInputStream("D:\\我的青春谁做主.txt");
FileOutputStream fos = new FileOutputStream("C:\\myFile\\myPrime.txt", true);

byte[] words = new char[1024];

while((fis.read())!=-1){
	fis.read(words);
	fos.write(words, 0, words.length);
} 


/******************使用字符流读写文件******************/
例:
格式模板保存在文本文件pet.template中，内容如下:
您好！
我的名字是{name}，我是一只{type}。
我的主人是{master}。

    其中{name},{type},{master}是需要替换的内容，现在要求按照模板格式保存宠物数据到文本文件，即把{name},{type},{master}替换为具体的宠物信息，该如何实现呢。

可以把该问题分解为:
如何从文件中读取模板？			---使用Reader接口实现
如何替换模板中的内容为当前宠物信息？	---使用String的replace()方法实现
如何将文本保存到文件？			---使用Writer接口实现

注: 使用字符流读写文本更合适。

----------------------------------------------------
使用FileReader读取文件:
例:
import java.io.Reader;
import java.io.FileReader;
import java.io.IOException;

Reader fr = null;
StringBuffer sbf = null;

try{
	fr = new FileReader("D:\\myDoc\\简介.txt");
	char ch[] = new char[1024];
	sbf = new StringBuffer();

	int length = fr.read(ch);
	while(length != -1){
		sbf.append(ch);  //追加到字符串
		length = fr.read();
	}
	fr.close();
}

----------------------------------------------------
使用BufferedReader读文本文件:
例:
import java.io.FileReader;
import java.io.BufferedReader;
import java.io.IOException;

Reader fr = new FileReader("C:\\myTest.txt");
BufferedReader br = new BufferedReader(fr);

br.readLine();

br.close();
fr.close();

注:
BufferedReader类：
如何提高字符流读取文本文件的效率？
使用FileReader类是Reader类的子类。

BufferedReader类是Reader类的子类。
BufferedReader类带有缓存区。
按行读取内容的readLine()方法是BufferedReader类特有的方法。

小结:
Reader类常用方法:
int read()
int read(byte[] c)
read(char[] c, int off, int len)
void close()

子类BufferedReader常用的构造方法:
BufferedReader(Reader in)

子类BufferedReader特有的方法:
readLine()

----------------------------------------------------
使用FileWriter写文件
例:
import java.io.Reader;
import java.io.FileWriter;
import java.io.IOException;

try{
	fw = new FileWriter("D:\\myDoc\\简介.txt");
	fw.write("相忘于江湖");
	fw.flush();
}catch(IOException e){
	System.out.println("文件不存在");
}
fw.close();

----------------------------------------------------
使用BufferedWriter写文件
例:
import java.io.FileWriter;
import java.io.BufferedWriter;
import java.io.IOException;

FileWriter fw = new FileWriter("C:\\myTest.txt");
BufferedWriter bw = new BufferedWriter(fw);

bw.write("hello");

bw.flush();
fw.close();

注:
BufferedWriter类:
如何提高字符流写文本文件的效率？
使用FileWriter类与BufferedWriter类。

BufferedWriter类是Writer类的子类。
BufferedWriter类带有缓存区。

小结:
Writer类常用方法:
write(String str)
write(String str, int off, int len)
void close()
void flush()

子类BufferedWriter常用的构造方法:
BufferedReader(Writer out)

例:
读取模板文件C:\pet.templater的内容,按照pet.template的模板格式保存宠物数据到文本文件,即把{name},{type},{master} 替换为具体的宠物信息,将替换后的内容写入到D\myDoc\pet.txt中?

实现思路:
1) 创建字符输入流BufferedReader对象
2) 创建字符输出流BufferedWriter对象
3) 建StringBuffer对象sbf，用来临时存储读取的数据
4) 通过循环实现文件读取，并追加到sbf中
5) 使用replace()方法替换sbf中的内容
6) 将替换后的内容写入到文件中
7) 关闭输入流，输出流

例:
BufferedReader reader = new BufferedReader(fr);
BufferedWriter writer = new BufferedReader(fw);
String line = null;
StringBuffer sbf = new StringBuffer();

while((line = reader.readLine()) != null){
	sbf.append(line);
}

String newString = sbf.toString().replace("{name}","欧欧");
...

writer.write(newString);


/******************读写二进制文件******************/
DataInputStream类:
是FileInputStream的子类
与FileInputStream类结合使用读取二进制文件

DataOutputStream类
是FileOutputStream的子类
与FileOutputStream类结合使用写二进制文件

----------------------------------------------------
使用DataOutputStream读二进制文件
例:
import java.io.FileInputStream;
import java.io.DataInputStream;

FileInputStream fis = new FileInputStream("C:\\HelloWorld.class");
DataInputStream dis = new DataInputStream(fis);

dis.read();

dis.close();

----------------------------------------------------
使用DataOutputStream写二进制文件
例:
import java.io.FileOutputStream;
import java.io.DataOutputStream;

FileOutputStream outFile = new FileOutputStream("C:\\temp.class");
DataOutputStream out = new DataOutputStream(outFile);

out.write(1);

out.close();


﻿============================================
5. 总结
1) File类用于访问文件或目录的属性。
2) 程序和数据源之间通过流联系:
输入流和输出流
字节流和字符流
*** 3) FileInputStream和FileOutputStream以字节流的方式读写文本文件。
*** 4) BufferedReader和BufferedWriter以字符流的方式读写文本文件，而且效率更高。
*** 5) DataInputStream和DataOutputStream可用于读写二进制文件。


