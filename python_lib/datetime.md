# datetime


```
部分方法:
    date()
    time()
    combine()
    now()
    today()
    strptime()      用法同time.strptime(...)
    fromtimestamp()
    toordinal()     返回公元公历开始到当前时间的天数。公元1年1月1日为1
    timetuple()

部分属性:
    year
    month
    day
    hour
    minute
    second

补充: datetime.datetime(...)对象转时间戳
In [1]: import datetime

In [2]: d = datetime.datetime.strptime('2018-08-26 11:23:40', '%Y-%m-%d %X')

In [3]: d
Out[3]: datetime.datetime(2018, 8, 26, 11, 23, 40)

In [4]: import time

In [5]: time.mktime(d.timetuple())
Out[5]: 1535253820.0


例:
In [1]: import datetime

In [2]: d = datetime.datetime.now()

In [3]: d
Out[3]: datetime.datetime(2018, 11, 27, 16, 48, 47, 417075)

In [4]: d.date()
Out[4]: datetime.date(2018, 11, 27)

In [5]: d.time()
Out[5]: datetime.time(16, 48, 47, 417075)

In [6]: d.combine(d.date(), d.time())
Out[6]: datetime.datetime(2018, 11, 27, 16, 48, 47, 417075)

In [7]: d.now()
Out[7]: datetime.datetime(2018, 11, 27, 16, 49, 18, 89182)

In [8]: d.strptime('2018-11-23 10:23:40', '%Y-%m-%d %X')
Out[8]: datetime.datetime(2018, 11, 23, 10, 23, 40)

In [9]: import time

In [10]: d.fromtimestamp(time.time())
Out[10]: datetime.datetime(2018, 11, 27, 16, 50, 17, 426908)

In [23]: d
Out[23]: datetime.datetime(2018, 11, 27, 16, 48, 47, 417075)

In [24]: d + datetime.timedelta(10)
Out[24]: datetime.datetime(2018, 12, 7, 16, 48, 47, 417075)

In [41]: datetime.datetime.now().toordinal()
Out[41]: 737025

In [43]: datetime.datetime.now().timetuple()
Out[43]: time.struct_time(tm_year=2018, tm_mon=11, tm_mday=27, tm_hour=17, tm_min=5, tm_sec=45, tm_wday=1, tm_yday=331, tm_isdst=-1)
```
