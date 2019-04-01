# 网络编程

## IP地址的组成

```
IP地址(32位) = 网络地址 + 主机地址

	前8位范围	8位	8位	8位	8位	
A类	1-126		网络	主机	主机	主机
B类	128-191		网络	网络	主机	主机
C类	192-223		网络	网络	网络	主机
D类	224-239		用于组播通信
E类	240-255		用于科研
```


## java.net包

```
	方法名							说明
-------------------------------------------------------------------------------------------------
static InetAddress getLocalHost()			返回表示本地主机InetAddress对象
-------------------------------------------------------------------------------------------------
static InetAddress getByName(String hostName)		为主机名为hostName的主机返回InetAddress对象
-------------------------------------------------------------------------------------------------
static InetAddress[] getAllByName(String hostName)	为主机名为hostName的所有可能主机返回InetAddress对象组
-------------------------------------------------------------------------------------------------
```


## 基于TCP协议的Socket编程

```
1) 用来实现双向安全连接网络通信。

2) Socket通信模型:
    进行网络通信时，Socket需要借助数据流来完成数据的传递工作。

3) Socket网络变成一般可以分成如下步骤:
建立连接 --> 打开Socket关联的输入输出流 --> 数据流中读写信息 --> 关闭所有的数据流和Socket
例:
Socket socket = new Socket("localhost", 8800);
	|
	v
OutputStream os = socket.getOutputStream();
	|
	v
String info = "用户名: Tom; 用户密码: 123456";
os.write(info.getBytes());
socket.shutdownOutput();
	|
	v
os.close();
socket.close();
```
