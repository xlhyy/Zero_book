### os.path


- os.path模块主要用于文件的属性获取。
```
1)
In [2]: os.path.abspath('test.log')
Out[2]: '/home/kaiqigu/test.log'

2)
In [6]: os.path.split('/home/kaiqigu/test.log')
Out[6]: ('/home/kaiqigu', 'test.log')

3)
In [8]: os.path.dirname('/home/kaiqigu/test.log')
Out[8]: '/home/kaiqigu'

4)
In [9]: os.path.basename('/home/kaiqigu/test.log')
Out[9]: 'test.log'

5)
In [10]: os.path.commonprefix(['/home/td','/home/td/ff','/home/td/fff'])
Out[10]: '/home/td'

6)
In [11]: os.path.exists('test.log')
Out[11]: True

7)
In [12]: os.path.isabs('/home/kaiqigu/test.log')
Out[12]: True

8)
In [14]: os.path.isfile('test.log')
Out[14]: True

9)
In [17]: os.path.isdir('nginx_templates')
Out[17]: True

10)
In [19]: os.path.join('/home','kaiqigu','test.log')
Out[19]: '/home/kaiqigu/test.log'

11)
os.path.normcase(path)
    在Linux和Mac平台上，该函数会原样返回path，在windows平台上会将路径中所有字符转换为小写，并将所有斜杠转换为饭斜杠。
>>> os.path.normcase('c:/windows\\system32\\')
'c:\\windows\\system32\\'

12)
In [24]: os.path.normpath('/home/kaiqigu/test.log/../nginx_template')
Out[24]: '/home/kaiqigu/nginx_template'

13)
In [29]: os.path.splitext('test.log')
Out[29]: ('test', '.log')

14)
# 返回path的文件的大小(字节)。
In [30]: os.path.getsize('test.log')
Out[30]: 54

15)
# 返回path所指向的文件或者目录的最后存取时间。
n [32]: os.path.getatime('test.log')
Out[32]: 1543282742.9987984

16)
# 返回path所指向的文件或者目录的最后修改时间。
In [33]: os.path.getmtime('test.log')
Out[33]: 1543030201.106775

17)
# 在Linux和Mac平台上，该函数会原样返回path，在windows平台上会将路径中所有字符转换为小写，并将所有斜杠转换为反斜杠。
>>> os.path.normcase('c:/windows\\system32\\')
'c:\\windows\\system32\\'
```
