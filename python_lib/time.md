# time

```
1. 获得时间戳:
    time.time()

2. 获得struct_time:
    time.localtime()

3. 将当前时间戳转化为格式化时间字符串:
    time.strftime('%Y-%m-%d')
    time.strftime('%Y-%m-%d', time.localtime())

4. 将格式化时间字符串转为struct_time:
    time.strptime('2018-08-30 12:20:40', '%Y-%m-%d %X')

5. 将struct_time转为时间戳:
    time.mktime(time.localtime())
```


- 实例

```
In [1]: import time

In [2]: time.time()
Out[2]: 1543305098.498046

In [3]: time.localtime()
Out[3]: time.struct_time(tm_year=2018, tm_mon=11, tm_mday=27, tm_hour=15, tm_min=51, tm_sec=55, tm_wday=1, tm_yday=331, tm_isdst=0)

In [4]: time.strftime('%Y-%m-%d %X')
Out[4]: '2018-11-27 15:52:31'

In [5]: time.strftime('%Y-%m-%d %X', time.localtime())
Out[5]: '2018-11-27 15:52:46'

In [6]: time.strftime('%Y-%m-%d %X', time.localtime())
Out[6]: '2018-11-27 15:52:57'

In [7]: time.strftime('%Y-%m-%d %X')
Out[7]: '2018-11-27 15:52:59'

In [8]: time.strptime('2018-08-30 12:20:40', '%Y-%m-%d %X')
Out[8]: time.struct_time(tm_year=2018, tm_mon=8, tm_mday=30, tm_hour=12, tm_min=20, tm_sec=40, tm_wday=3, tm_yday=242, tm_isdst=-1)

In [9]: time.mktime(time.localtime())
Out[9]: 1543305275.0
```


- 利用localtime()转换为时间数组,然后格式化为需要的格式,如

```
timeStamp = 1381419600
timeArray = time.localtime(timeStamp)
otherStyleTime = time.strftime("%Y-%m-%d %H:%M:%S", timeArray)
```
