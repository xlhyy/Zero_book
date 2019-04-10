# traceback


```
In [15]: import traceback, datetime

In [16]: try:
    ...:     c = a['b']
    ...: except:
    ...:     traceback_info = repr(traceback.format_exc())
    ...:     tb_info_list = traceback_info.split('\\n')
    ...:     now = str(datetime.datetime.now())
    ...:     
    ...:     

In [17]: for i in tb_info_list:
    ...:     print i
    ...:     
u'Traceback (most recent call last):
  File "<ipython-input-16-86daeee2d292>", line 2, in <module>
    c = a[\'b\']
KeyError: \'b\'
'

In [18]: print now
2018-10-23 09:51:26.463526
```


```
# encoding: utf-8

'''
sys.exc_info
traceback.print_exc()
traceback.format_exc()
traceback.format_exception_only(etypr, value)
'''

import sys
import traceback


try:
    i = [1]
    print i[2]
except:
    exc_type, exc_value, exc_traceback = sys.exc_info()
    print ('%s\n%s\n%s\n') % sys.exc_info()
    print '=============================='

    # 可传文件参数，将打印信息输出到文件。
    traceback.print_exc()
    print '=============================='
    
    print traceback.format_exc()
    print '=============================='
    
    etype, value, tb = sys.exc_info()
    line = traceback.format_exception_only(etype, value)
    print line


'''
输出结果:
<type 'exceptions.IndexError'>
list index out of range
<traceback object at 0x7ff22b331368>

==============================
Traceback (most recent call last):
  File "error_info.py", line 16, in <module>
    print i[2]
IndexError: list index out of range
==============================
Traceback (most recent call last):
  File "error_info.py", line 16, in <module>
    print i[2]
IndexError: list index out of range

==============================
['IndexError: list index out of range\n']
'''
```
