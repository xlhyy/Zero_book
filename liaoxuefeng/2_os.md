# os


## 操作文件和目录

```
# 查看当前目录的绝对路径:
>>> os.path.abspath('.')
'/Users/michael'

# 在某个目录下创建一个新目录，首先把新目录的完整路径表示出来:
>>> os.path.join('/Users/michael', 'testdir')
'/Users/michael/testdir'

# 然后创建一个目录:
>>> os.mkdir('/Users/michael/testdir')

# 删掉一个目录:
>>> os.rmdir('/Users/michael/testdir')

# 通过os.path.split()函数，可以把一个路径拆分为两部分，后一部分总是最后级别的目录或文件名:
>>> os.path.split('/Users/michael/testdir/file.txt')
('/Users/michael/testdir', 'file.txt')

# os.path.splitext()可以得到文件扩展名:
>>> os.path.splitext('/path/to/file.txt')
('/path/to/file', '.txt')

# 对文件重命名:
>>> os.rename('test.txt', 'test.py')

# 删掉文件:
>>> os.remove('test.py')
```

```
列出当前目录下的所有目录，只需要一行代码：
>>> [x for x in os.listdir('.') if os.path.isdir(x)]
['.lein', '.local', '.m2', '.npm', '.ssh', '.Trash', '.vim', 'Applications', 'Desktop', ...]

要列出当前目录下的所有.py文件，也只需一行代码：
>>> [x for x in os.listdir('.') if os.path.isfile(x) and os.path.splitext(x)[1]=='.py']
['apis.py', 'config.py', 'models.py', 'pymonitor.py', 'test_db.py', 'urls.py', 'wsgiapp.py']
```