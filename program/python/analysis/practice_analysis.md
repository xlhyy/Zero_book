### 数据分析练习题


- numpy基础知识
```
示例代码
# _*_ coding: utf-8 _*_
# @time     : 2018/5/7 9:25
# @Author   : liying
# @FileName : numpy_test.py.py
# @Software : PyCharm

import numpy as np

#创建ndarray
a = np.array([1, 2, 3, 4, 5, 6])
if 0:
    b = np.array([[1, 2, 3], [4, 5, 6]])
    print(type(a)) #<class 'numpy.ndarray'>
    print(type(b)) #<class 'numpy.ndarray'>
    print(a) #[1 2 3 4 5 6]
    print(b)
    # [[1 2 3]
    #  [4 5 6]]

    #ndarray属性
    #1 ndim是数组的维数
    print('a.ndim: %d' %a.ndim) #a.ndim: 1
    print('b.ndim: %d' %b.ndim) #b.ndim: 2

    #2 shape是(有几行,有几列)
    print(a.shape) #(6,)
    print(b.shape) #(2, 3)

    #3 itemsize是数组中每个元素的字节单位长度
    # x = np.array([[1, 2, 3], [4, 5, 6]])
    # print(type(x[0][0])) #<class 'numpy.int32'>
    # print(x.itemsize) #4
    x = np.array([[1, 2, 3], [4, 5, 6]], dtype = np.int8)
    print(x.itemsize) #1
    x = np.array([1, 2, 3], dtype = np.int8)
    print(x.itemsize) #1
    # int8（一个字节）
    # float32（四个字节）

    print('='*30)
    #ndarray函数
    a = np.empty(shape=(3,4), dtype=np.int) #ndarray的元素是随机数
    print(a)
    # [[       198      27506    9728512  265945088]
    #  [1836213584 1769173865 1917152879 -630034574]
    #  [1918990088 1735289198 1996806771 -630295967]]

    b = np.zeros(shape=(3,4)) #生成都是0的ndarray,shape指定行列,缺省元素类型为np.float64
    print(b)
    # [[ 0.  0.  0.  0.]
    #  [ 0.  0.  0.  0.]
    #  [ 0.  0.  0.  0.]]

    print(type(b[0][0])) #<class 'numpy.float64'>
    c = np.zeros(5) #没有指定shape,默认产生一维数组
    print(c)
    # [ 0.  0.  0.  0.  0.]

    d = np.ones(shape=(3,4), dtype=np.int) #没有指定shape,默认产生一维数组
    print(d)
    # [[1 1 1 1]
    #  [1 1 1 1]
    #  [1 1 1 1]]

    # print(np.zeros_like(a)) #生成一个元素都为0的shape与a相同的矩阵
    # [[0 0 0 0]
    #  [0 0 0 0]
    #  [0 0 0 0]]

    # print(np.ones_like(a))
    # [[1 1 1 1]
    #  [1 1 1 1]
    #  [1 1 1 1]]

    # e = np.eye(3, 4, dtype=np.int) #产生(3,4)矩阵,主对角线为1
    # [[1 0 0 0]
     # [0 1 0 0]
     # [0 0 1 0]]

    # e = np.eye(3) #产生(3,3)矩阵
    # print(type(e[0][0])) #元素类型为<class 'numpy.float64'>
    # [[ 1.  0.  0.]
    #  [ 0.  1.  0.]
    #  [ 0.  0.  1.]]

    # e = np.eye(3, k=-1) #k默认值为0
    # print(e)
    # [[ 0.  0.  0.]
    #  [ 1.  0.  0.]
    #  [ 0.  1.  0.]]

    # e = np.eye(3, k=1)
    # print(e)
    # [[ 0.  1.  0.]
    #  [ 0.  0.  1.]
    #  [ 0.  0.  0.]]

    e = np.eye(3, dtype=np.int)
    print(type(e[0][0])) #元素类型为<class 'numpy.int32'>
    # [[1 0 0]
    #  [0 1 0]
    #  [0 0 1]]

    print(np.identity(6)) #生成6行6列的矩阵,对角线元素为1,其余元素为0

    print(np.linspace(1,6)) #在[1,6]之间的50个元素(默认长度为50)组成一维数组,步长是均匀的,且第一个元素为1,最后一个元素为6
    # [ 1.          1.10204082  1.20408163  1.30612245  1.40816327  1.51020408
    #   1.6122449   1.71428571  1.81632653  1.91836735  2.02040816  2.12244898
    #   2.2244898   2.32653061  2.42857143  2.53061224  2.63265306  2.73469388
    #   2.83673469  2.93877551  3.04081633  3.14285714  3.24489796  3.34693878
    #   3.44897959  3.55102041  3.65306122  3.75510204  3.85714286  3.95918367
    #   4.06122449  4.16326531  4.26530612  4.36734694  4.46938776  4.57142857
    #   4.67346939  4.7755102   4.87755102  4.97959184  5.08163265  5.18367347
    #   5.28571429  5.3877551   5.48979592  5.59183673  5.69387755  5.79591837
    #   5.89795918  6.        ]

    print(np.linspace(1, 6, 6)) #设定长度为6
    # [ 1.  2.  3.  4.  5.  6.]
    # print(np.linspace(1, 6, 6, endpoint=False)) #范围为[1,6)
    # [ 1.          1.83333333  2.66666667  3.5         4.33333333  5.16666667]
    # print(np.linspace(0, 10, 3, endpoint=False))
    # [ 0.          3.33333333  6.66666667]
    print(np.linspace(0, 10, 3, retstep=True, endpoint=False)) #retstep用来查看步长,默认值为False
    # (array([ 0.        ,  3.33333333,  6.66666667]), 3.3333333333333335)

    print(np.arange(1,6)) #在[1,6)之间产生步长为1的全部元素组成的数组
    # [1 2 3 4 5]
    print(np.arange(6)) #在[0,6)之间产生步长为1的全部元素组成的数组
    print(np.arange(0,6)) #在[0,6)之间产生步长为1的全部元素组成的数组
    # [0 1 2 3 4 5]
    print(np.arange(0,6,2)) ##在[0,6)之间产生步长为2的全部元素组成的数组
    # [0 2 4]

    print(np.arange(6).reshape(3,2))
    # [[0 1]
    #  [2 3]
    #  [4 5]]

    #切片
    print(np.arange(12))
    # [ 0  1  2  3  4  5  6  7  8  9 10 11]
    print(np.arange(12)[1:])
    # [ 1  2  3  4  5  6  7  8  9 10 11]
    print(np.arange(12)[:-1])
    # [ 0  1  2  3  4  5  6  7  8  9 10]
    print(np.arange(12).reshape(3,4))
    # [[ 0  1  2  3]
    #  [ 4  5  6  7]
    #  [ 8  9 10 11]]
    print(np.arange(12).reshape(3,4)[1:,:])
    # [[ 4  5  6  7]
    #  [ 8  9 10 11]]
    print(np.arange(12).reshape(3,4)[1:,1:3])
    # [[ 5  6]
    #  [ 9 10]]

print('='*30)
# import os
# print(os.getcwd()) #打印文件路径 E:\far sight\PyCharmProjects\Scrapy\notes
# 1.txt文件
# student.txt
# A 85 61 78
# B 88 66 87
# C 90 69 88
# D 89 70 77
# E 78 78 90
# a = np.loadtxt('student.txt') #如果第0列是字符串,无法转成浮点数,会报错
# a = np.loadtxt('student.txt',usecols=(1,2,3)) #使用第1,2,3列(因为第0列是名字,无法转成浮点数,会报错)
# [[ 85.  61.  78.]
#  [ 88.  66.  87.]
#  [ 90.  69.  88.]
#  [ 89.  70.  77.]
#  [ 78.  78.  90.]]
# a = np.loadtxt('student.txt',usecols=(1,2,3),skiprows=1) #usecols:使用元组中的列,skiprows:忽略的行数
# [[ 88.  66.  87.]
#  [ 90.  69.  88.]
#  [ 89.  70.  77.]
#  [ 78.  78.  90.]]
# print(a)
# print(np.max(a)) #90.0
#axis=0按列方向,axis=1按行方向
# print(np.amax(a,axis=0)) #[ 90.  78.  90.]
# print(np.amin(a,axis=0)) #[ 78.  66.  77.]
# print(np.mean(a,axis=0)) #[ 86.25  70.75  85.5 ] 求平均值
# np.savetxt('stu.txt',a,fmt='%f',delimiter = ',') #缺省分隔符是空格

# 2.csv文件
# a = np.loadtxt('student.csv', usecols=(2), delimiter=',')  # usecols使用元组中的列
# a = np.loadtxt('student.csv', usecols=(1, 2, 3), delimiter=',')  # usecols使用元组中的列,csv文件一定要指定分隔符,一般为逗号
# a = np.loadtxt('student.csv', usecols=(1, 2, 3), delimiter=',', skiprows=1)  # usecols使用元组中的列,skiprows为忽略的行数
# print(a)
# print(np.max(a))
# print(np.amax(a, axis=0))
# print(np.amin(a, axis=0))
# print(np.mean(a, axis=0))
# np.savetxt('stu.csv', a, fmt='%f', delimiter=',')  # 缺省分隔符是空格

# 在最后一行添加平均分
a = np.loadtxt('student.txt', usecols=(1, 2, 3))
b = np.mean(a, axis=0)
print(np.vstack((a, b)))
# [[ 85.   61.   78. ]
#  [ 88.   66.   87. ]
#  [ 90.   69.   88. ]
#  [ 89.   70.   77. ]
#  [ 78.   78.   90. ]
#  [ 86.   68.8  84. ]]
```

		   
- matplotlib基础知识
```
示例代码1(一次函数 正余弦函数)
# _*_ coding: utf-8 _*_
# @time     : 2018/5/7 15:26
# @Author   : liying
# @FileName : matplotlib_test.py
# @Software : PyCharm

import numpy as np
import matplotlib.pyplot as plt

#===================================
if 0:
    fig = plt.figure(1) #创建画布,编号为1
    x = np.arange(6)
    y = x + 1
    plt.savefig('plot.png') #保存成图片
    plt.show() #显示

#===================================
if 0:
    fig = plt.figure(1)
    x = np.arange(0,np.pi*2,0.1) #步长为0.1
    print(x)
    y1 = np.sin(x)
    y2 = np.cos(x)
    plt.plot(x,y1) #绘图
    plt.plot(x,y2)
    plt.show() #显示

#===================================
if 0:
    plt.rcParams['font.sans-serif'] = ['SimHei'] #用来正常显示中文标签
    plt.rcParams['axes.unicode_minus'] = False #用来正常显示负号(因为加了"正常显示中文标签"语句后,负号会显示异常)
    fig = plt.figure(1)
    x = np.arange(0,np.pi*2,0.1) #步长为0.1
    y1 = np.sin(x)
    y2 = np.cos(x)
    plt.title('Sin()/Cos()')
    # plt.title('正弦曲线/余弦曲线')
    plt.xlabel('X Value')
    plt.ylabel('Y Value')
    plt.xlim(0,2*np.pi) #限制x轴显示的坐标范围
    plt.xticks(np.linspace(0,2*np.pi,5),['0','π/2','π','3π/2','2π']) #重新设置刻度显示(未改变原值,只是显示变了)
    plt.plot(x,y1) #绘图
    # plt.plot(x,y1,color='blue') #设置颜色
    # plt.plot(x,y1,color='#000000') #设置颜色
    # linestyle的取值有4种
    # plt.plot(x,y1,linestyle='-') #实线
    # plt.plot(x,y1,linestyle='--') #--组成的线
    # plt.plot(x,y1,linestyle='-.') #-.组成的线
    # plt.plot(x,y1,linestyle=':') #.组成的线
    # marker的取值有很多种
    # plt.plot(x,y1,marker='o')
    # plt.plot(x,y1,marker='>')
    # ...
    plt.plot(x,y2)
    plt.legend(['sin','cos']) #还可以添加loc和ncol参数
    # loc(设置图例显示的位置)
    # 'best'         : 0, (only implemented for axes legends)(自适应方式)
    # 'upper right'  : 1,
    # 'upper left'   : 2,
    # 'lower left'   : 3,
    # 'lower right'  : 4,
    # 'right'        : 5,
    # 'center left'  : 6,
    # 'center right' : 7,
    # 'lower center' : 8,
    # 'upper center' : 9,
    # 'center'       : 10,
    # ncol(设置列的数量，使显示扁平化，当要表示的线段特别多的时候会有用)
    plt.show() #显示
运行结果



loc=1:									ncol=2:
```

```
示例代码2(散点图)
import numpy as np
import matplotlib.pyplot as plt

plt.rcParams['font.sans-serif'] = ['SimHei']
plt.rcParams['axes.unicode_minus'] = False
plt.title('散点图')
plt.xlabel('X Axis')
plt.ylabel('Y Axis')
x = np.random.randn(1024) #产生1024个正态分布数据(标准值为0,方差为1)
y = np.random.randn(1024)
color = ['r','y','k','g','m']
# plt.scatter(x,y,color=color,s=50,marker='>')
plt.scatter(x,y,s=50,alpha=.5,edgecolors='white') #s为面积,默认是20;alpha是透明度;edgecolors是边缘颜色
plt.show()
运行结果
```

```
知识点补充
字体倾斜: 
示例代码3(多子图)
import numpy as np
import matplotlib.pyplot as plt

#===================================
#多子图
x = np.linspace(0, 2*np.pi, 100)
y0 = np.sin(x)
y1 = np.cos(x)
plt.subplot(211) #两行两列第一个
plt.plot(x, y0)
plt.subplot(212) #两行两列第二个
plt.plot(x, y1)
plt.show()
运行结果
```

```
示例代码4(面向对象)
import numpy as np
import matplotlib.pyplot as plt

#===================================
#面向对象
fig = plt.figure(1)
ax = fig.add_subplot(111) #一行一列第一个
ax.set_title('Sin()')
ax.set_xlabel('X Axis')
ax.set_xlabel('Y Axis')
ax.set_xlim(-1,2*np.pi)
ax.set_xticks(np.linspace(0,2*np.pi,5))
ax.set_xticklabels(['0','π/2','π','3π/2','2π'])
x = np.linspace(0,2*np.pi)
y = np.sin(x)
ax.plot(x,y,'go--')
plt.show()
运行结果
```

```
示例代码5(matplotlib.dates	datetime)
import matplotlib.dates as mdates
import datetime

newsTime= ['Sun, 21 Apr 2017 05:15:05 GMT', 'Sun, 22 Apr 2017 05:15:05 GMT', 'Sun, 23 Apr 2017 05:15:05 GMT']
GMT_FORMAT = '%a, %d %b %Y %H:%M:%S GMT'
newsTime = [datetime.datetime.strptime(i,GMT_FORMAT) for i in newsTime]
for i in newsTime:
    print(i)
    # 2017-04-21 05:15:05
    # 2017-04-22 05:15:05
    # 2017-04-23 05:15:05
# 知识点:
#   newsTime = datetime.datetime.strptime(newsTime,GMT_FORMAT)
#   只要GMT_FORMAT匹配原来的日期格式即可
x = newsTime
y = range(len(x))
for i in y:
    print(i)
    # 0
    # 1
    # 2

#配置横坐标
plt.gca().xaxis.set_major_formatter(mdates.DateFormatter('%Y/%m/%d')) #定义x轴时间标签格式 例:2017/04/23
# plt.gca().xaxis.set_major_locator(mdates.YearLocator()) #按Year定义时间刻度
# plt.gca().xaxis.set_major_locator(mdates.MonthLocator()) #按Month定义时间刻度
plt.gca().xaxis.set_major_locator(mdates.DayLocator()) #按Day定义时间刻度

plt.plot(x, y)
plt.gcf().autofmt_xdate() #自动旋转日期标记
plt.show()
运行结果
（1）若不配置横坐标


（2）添加“定义x轴时间标签”语句

（3）添加“定义时间刻度”语句
按年：

按月：

按日：
```

```
练习1：沈阳7日天气折线图
示例代码
# _*_ coding: utf-8 _*_
# @time     : 2018/5/8 9:46
# @Author   : liying
# @FileName : weather.py
# @Software : PyCharm

import urllib.request
from bs4 import BeautifulSoup
import urllib, re
import numpy as np
import matplotlib.pyplot as plt

headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36",
}

req = urllib.request.Request("http://www.weather.com.cn/weather/101070101.shtml", headers=headers) #构造请求
response = urllib.request.urlopen(req) #发送请求
html = response.read() #html是字符串
soup = BeautifulSoup(html,'lxml')
day_info = []
wea_info = []
tem_info1 = []
tem_info2 = []
win_info1 = []
win_info2 = []

obj = soup.find_all(attrs={'class':re.compile(r'^sky skyid')})

for i in obj:
    day_info.append(i.find('h1').string)
    wea_info.append(i.find('p',attrs={'class': 'wea'}).string)
    # tem_info1.append(int(i.find('p',attrs={'class': 'tem'}).find('span').string))
    tem_info2.append(int(str(i.find('p',attrs={'class': 'tem'}).find('i').string).replace('℃','')))
    # win_info1.append(i.find('p',attrs={'class': 'win'}).find('span').attrs['title'])
    # win_info2.append(i.find('p',attrs={'class': 'win'}).find('i').string)

plt.rcParams['font.sans-serif'] = ['SimHei']
plt.rcParams['axes.unicode_minus'] = False
fig = plt.figure(1)
x = np.arange(0,7,1)
y1 = tem_info1
y2 = tem_info2
plt.ylim(-5,40)
plt.title('沈阳最近7天天气情况')
# plt.xlabel('时间')
plt.ylabel('温度值(℃)')
plt.xticks(np.linspace(0,7,8),day_info)
# plt.plot(x,y1) #绘图
plt.plot(x,y2)
temp_x = []
for i in range(len(day_info)):
    plt.plot((x[i],x[i]),(-5,y2[i]),'k--',linewidth=1)
    # plt.annotate(str(wea_info[i])+'\n'+str(tem_info1[i])+'℃',xy=(x[i], y1[i]),xycoords='data',xytext=(-10,10),textcoords='offset points',fontsize=10)
    plt.annotate(str(wea_info[i])+'\n'+str(tem_info2[i])+'℃',xy=(x[i], y2[i]),xycoords='data',xytext=(-10, 10),textcoords='offset points',fontsize=10)
# plt.legend(['最高温度','最低温度'])
plt.legend(['最低温度'])
plt.show() #显示
运行结果
```

```
练习2：学生成绩柱状图
示例代码
# _*_ coding: utf-8 _*_
# @time     : 2018/5/8 14:38
# @Author   : liying
# @FileName : student.py
# @Software : PyCharm

import numpy as np
import matplotlib.pyplot as plt

infos1 = np.loadtxt(open('student.csv',encoding='utf-8-sig'),dtype=np.str,delimiter=',')
infos2 = np.loadtxt(open('student.csv',encoding='utf-8-sig'),usecols=(1,2,3),dtype=np.int,delimiter=',')
name = infos1[:,0]
math = infos2[:,0]
chinese = infos2[:,1]
english = infos2[:,2]

plt.rcParams['font.sans-serif'] = ['SimHei']
plt.rcParams['axes.unicode_minus'] = False
plt.figure(figsize=(8,8)) #自定义画布大小为800*800
plt.title('成绩柱状图')
plt.xlabel('学生姓名')
plt.ylabel('分数')

x = np.arange(len(name))
total_width,n = 0.8,3 #有多少个类型,只需更改n即可
width = total_width/n

x = x-width
# plt.bar(x, math,  width=width, label='数学')
# plt.bar(x + width, chinese, width=width, label='语文')
# plt.bar(x + 2 * width, english, width=width, label='英语')
plt.bar(x, math,  width=width)
plt.bar(x + width, chinese, width=width)
plt.bar(x + 2 * width, english, width=width)
plt.legend(['数学','语文','英语'])
plt.ylim(0,100)
plt.xticks(x+width,name)
plt.show()


运行结果
```

- xlrd基础知识(excel文件读取)
```
示例代码
# _*_ coding: utf-8 _*_
# @time     : 2018/5/9 9:14
# @Author   : liying
# @FileName : matplotlib_excel.py
# @Software : PyCharm

import xlrd

workbook = xlrd.open_workbook(r'E:\far sight\PyCharmProjects\Scrapy\180509\辽宁各市2016GDP.xlsx')
print(workbook.sheet_names()) #返回全部sheet组成的列表
# sheet = workbook.sheet_by_index(0) #通过索引获得excel第0个sheet,索引从0开始
sheet = workbook.sheet_by_name('辽宁') #通过名字获得excel名字是'辽宁'的sheet
print(sheet.name, sheet.nrows, sheet.ncols) #输出当前sheet的名字,包含的行数,列数
rows = sheet.row_values(1) #获取索引为1的行
cols = sheet.col_values(0) #获取所因为0的列
print(rows)
print(cols)
print(sheet.cell(0,1).value) #获取0行1列的cell值
print(sheet.cell(0,1).ctype) #输出为:0 empty,1 string,2 number,3 date,4 boolean,5 error
for r in range(sheet.nrows):
    for l in range(sheet.ncols):
        print(sheet.cell(r, l).value, end="")
print('\n')
print(sheet.cell(sheet.nrows-1,0).value)


运行结果
['辽宁', '吉林', '黑龙江']
辽宁 15 2
['沈阳', 5460.01]
['大连', '沈阳', '鞍山', '营口', '锦州', '盘锦', '抚顺', '本溪', '丹东', '朝阳', '辽阳', '葫芦岛', '铁岭', '阜新', '辽宁2016年各市GDP']
6730.33
2
大连6730.33沈阳5460.01鞍山1440.78营口1189.32锦州1035.06盘锦1007.14抚顺760.27本溪754.46丹东748.45朝阳708.87辽阳654.18葫芦岛645.94铁岭588.04阜新406.21辽宁2016年各市GDP

辽宁2016年各市GDP
xlwt基础知识(excel文件写入)
示例代码
# _*_ coding: utf-8 _*_
# @time     : 2018/5/9 11:06
# @Author   : liying
# @FileName : excel_write.py
# @Software : PyCharm

import xlwt

city = ['大连', '沈阳', '鞍山', '营口', '锦州', '盘锦', '抚顺', '本溪', '丹东', '朝阳', '辽阳', '葫芦岛', '铁岭', '阜新']
gdp = [6730.33, 5460.01, 1440.78, 1189.32, 1035.06, 1007.14, 760.27,754.46, 748.45, 708.87, 654.18, 645.94, 588.04, 406.21]
workbook = xlwt.Workbook()
sheet = workbook.add_sheet('辽宁', cell_overwrite_ok=True)
# cell_overwrite_ok允许重复写同一个cell(cell代表单元格)
# 例:写入两次sheet.write(1, 1, 'GDP')时,不会报错

#第一种方式
title_style = xlwt.XFStyle() #Create Style

alignment = xlwt.Alignment() #Create Alignment
alignment.horz = xlwt.Alignment.HORZ_CENTER #设置水平居中
# May be: HORZ_GENERAL, HORZ_LEFT, HORZ_CENTER, HORZ_RIGHT, HORZ_FILLED, HORZ_JUSTIFIED, HORZ_CENTER_ACROSS_SEL, HORZ_DISTRIBUTED
alignment.vert = xlwt.Alignment.VERT_CENTER #设置垂直居中
# May be: VERT_TOP, VERT_CENTER, VERT_BOTTOM, VERT_JUSTIFIED, VERT_DISTRIBUTED
title_style.alignment = alignment #Add Alignment to Style

font = xlwt.Font() #Create Font
font.bold = True #字体加粗
title_style.font = font #Add Bold Font to Style

pattern = xlwt.Pattern() #Create the Pattern
pattern.pattern = xlwt.Pattern.SOLID_PATTERN #设置填充模式为全部填充
# May be: NO_PATTERN, SOLID_PATTERN
pattern.pattern_fore_colour = 3 ##设置填充颜色
# May be: 8 through 63. 0 = Black, 1 = White, 2 = Red, 3 = Green, 4 = Blue,
# 5 = Yellow, 6 = Magenta, 7 = Cyan, 16 = Maroon, 17 = Dark Green,
# 18 = Dark Blue, 19 = Dark Yellow , almost brown), 20 = Dark Magenta,
# 21 = Teal, 22 = Light Gray, 23 = Dark Gray, the list goes on...
title_style.pattern = pattern #Add Pattern to Style

#第二种方式
# title_style = xlwt.easyxf(
#     'font: bold on, name 微软雅黑;' #加粗 微软雅黑
#     'align: vert centre, horiz centre;' #垂直居中 水平居中
#     'pattern: pattern solid, fore_colour gray25;', #填充模式为全部填充 设置填充颜色
# )
# content_style = xlwt.easyxf(
#     'font: name 宋体;' #宋体
#     'align: vert centre, horiz right;' #垂直居中 水平靠右
#     'pattern: pattern solid, fore_colour blue_gray;', #填充模式为全部填充 设置填充颜色
# )

sheet.write_merge(0, 0, 0, 1,'辽宁省2016年',title_style)
#注意: 0,0,0,1 a(行),b(行),c(列),d(列)
#将第a行,第c列与第b行,第d列合并,写入'辽宁省2016年'
sheet.write(1, 0, '城市', title_style) #在1行0列写入'城市'
sheet.write(1, 1, 'GDP', title_style)

for i in range(2, len(city)+2):
    sheet.write(i, 0, city[i - 2])
    sheet.write(i, 1, gdp[i - 2])
    # sheet.write(i, 0, city[i-2], content_style)
    # sheet.write(i, 1, gdp[i-2], content_style)
workbook.save('辽宁GDP.xls')
运行结果
第一种方式


第二种方式
```

```
知识点补充
xlwt里easyxf能理解的颜色：
```

```
练习3：辽宁省各市GDP饼形图
示例代码
# _*_ coding: utf-8 _*_
# @time     : 2018/5/9 9:58
# @Author   : liying
# @FileName : matplotlib_pie.py
# @Software : PyCharm

import xlrd
import matplotlib.pyplot as plt

workbook = xlrd.open_workbook(r'E:\far sight\PyCharmProjects\Scrapy\180509\辽宁各市2016GDP - 副本.xlsx')
sheet = workbook.sheet_by_name('辽宁')
city = sheet.col_values(0)
gdp = sheet.col_values(1)
print(city)
print(gdp)
explode = [0,0.1,0,0,0,0,0,0,0,0,0,0,0,0] #0.1为突出该部分
plt.figure(figsize=(9, 9))
plt.rcParams['font.sans-serif'] = ['SimHei']
plt.rcParams['axes.unicode_minus'] = False
plt.axes(aspect=1) #当aspect为1是圆形
patches,l_texts,p_texts = plt.pie(gdp, explode=explode, labels=city, shadow=True, startangle=90, labeldistance=1.1, autopct='%3.1f%%',pctdistance=0.8)
# shadow=True 显示图形阴影
# startangle=90 逆时针旋转90度
# labeldistance=1.1 文本位置离圆心1.1倍半径距离,
# autopct='%3.1f%%' 圆里面的文本格式,%3.1f%%表示小数有3位,整数为1位的浮点数
# pctdistance=0.8 圆里面的文本离圆心0.8倍半径距离
# patches 是一个由<matplotlib.patches.Wedge object at 0x03EA2B50>对象组成的列表
# l_texts 是饼图外的文本组成的列表 [Text(-0.898252,0.634935,'大连'), Text(-0.527877,-1.07766,'沈阳'),...]
# p_texts 是饼图内的文本组成的列表 [Text(-0.653274,0.461771,'30.4%'), Text(-0.395908,-0.808243,'24.7%'),...]
print(patches)
print(l_texts)
print(p_texts)
plt.legend(gdp, ncol = 2)
plt.savefig('LN_GDP.jpg')
plt.savefig('LN_GDP.svg')
plt.savefig('LN_GDP.pdf')
plt.show()
运行结果
```
