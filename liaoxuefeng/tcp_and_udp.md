# 网络编程

## tcp编程

```
kaiqigu@bogon:~/dododo|⇒  cat tcp_server.py 
# coding: utf-8

"""
服务器
"""

import socket
import threading
import time


def tcplink(sock, addr):
	print('Accept new connection from %s:%s...' % addr)
	sock.send(b'Welcome!')
	while True:
		data = sock.recv(1024)
		time.sleep(1)
		if not data or data.decode('utf-8') == 'exit':
			break
		sock.send(('Hello, %s!' % data.decode('utf-8')).encode('utf-8'))
	sock.close()
	print('Connection from %s:%s closed.' % addr)


while True:
	s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	#端口重用
	s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
	s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEPORT, 1)
	s.bind(('127.0.0.1', 9999))
	s.listen(5)
	# 接受一个新连接:
	sock, addr = s.accept()
	# 创建新线程来处理TCP连接:
	t = threading.Thread(target=tcplink, args=(sock, addr))
	t.start()
```

```
kaiqigu@bogon:~/dododo|⇒  cat tcp_client.py 
# coding:utf-8


"""
客户端
"""

import socket

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# 建立连接:
s.connect(('127.0.0.1', 9999))
# 接收欢迎消息:
print(s.recv(1024).decode('utf-8'))
for data in [b'Michael', b'Tracy', b'Sarah']:
    # 发送数据:
    s.send(data)
    print(s.recv(1024).decode('utf-8'))
s.send(b'exit')
s.close()
```

## udp编程

```
kaiqigu@bogon:~/dododo|⇒  cat udp_server.py 
# coding:utf-8

import socket

"""
服务器
"""

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.bind(('127.0.0.1', 9999))

print('Bind UDP on 9999...')
while True:
	data, addr = s.recvfrom(1024)
	print('Received from %s:%s' % addr)
	s.sendto(b'Hello, %s!' % data, addr)
kaiqigu@bogon:~/dododo|⇒  cat udp_client.py 
```

```
# coding:utf-8

import socket

"""
客户端
"""

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
for data in [b'Michael', b'Tracy', b'Sarah']:
	s.sendto(data, ('127.0.0.1', 9999))
	print(s.recv(1024).decode('utf-8'))
s.close()
```