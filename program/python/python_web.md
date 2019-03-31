### python全栈开发


```
day2
练习1：在Ubuntu下，使用python3，实现一个静态Web服务器
import http.server
import socketserver

PORT = 8000
Handler = http.server.SimpleHTTPRequestHandler #静态Web服务器的请求处理类

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print("serving at port", PORT)
httpd.serve_forever()

练习2：在Ubuntu下，使用python3，搭建一个CGI服务器，实现一个生成随机数的程序
import http.server
import socketserver

PORT = 8000
Handler = http.server.CGIHTTPRequestHandler #可以执行CGI的动态Web服务器的请求处理类

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print("serving at port", PORT)
httpd.serve_forever()

注：
（1）CGIHTTPRequestHandler类中，cgi_directories属性指定了CGI脚本文件所在的路径，默认为"/cgi-bin"
（2）把CGI的脚本文件，放在./cgi-bin路径下
（3）cgi-bin与练习2中的py文件在同一路径下

练习3：使用Django框架实现一个简单的程序
urls.py
from django.contrib import admin
from django.urls import path
from django.conf.urls import url

from . import views

urlpatterns = [
    path(r'admin/', admin.site.urls),#admin
    path('hello/', views.hello),#hello
    url(r'^hello/[0-9]{4}/$', views.hello),#hello/xxxx
]

#url()使用正则表达式语法进行匹配
#path()使用字符串进行匹配

views.py
from django.http.response import HttpResponse

def hello(request):
    print("Hello Django")
    return HttpResponse("<p>Hello World</p>")

练习4：使用Django框架实现一个生成随机数的程序
urls.py
from django.contrib import admin

from django.urls import path
from django.conf.urls import url

from . import views

urlpatterns = [
    path(r'admin/', admin.site.urls), 
    path('hello/', views.hello), 
    url(r'^hello/[0-9]{4}/$', views.hello), 
]

views.py
from django.http.response import HttpResponse
from random import randint

def hello(request):
    print("Hello Django")
    text = '''<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <title>华清远见</title>
</head>
<body>
    <h1>Hello World!</h1>
    <p>华清远见 Python CGI 随机数测试。</p>
    随机数：%d
</body>
</html>
'''
    return HttpResponse(text % (randint(100000, 1000000)))

day3(Django)

练习1：创建模板：实现一个生成随机数的程序
urls.py
from django.urls import path
from django.conf.urls import url
from . import views

urlpatterns = [
    path('hello.html',views.hello_html),
]

views.py
from django.http.response import HttpResponse
from random import randint
from django.shortcuts import render

def hello_html(request):
    rand = randint(100000, 1000000)
    return render(request,"hello.html",{"rand":rand})

hello.html
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <title>华清远见</title>
</head>
<body>
    <h1>Hello World!</h1>
    <p>华清远见 Python CGI 随机数测试。</p>
    随机数：{{ rand }}
</body>
</html>

练习2：创建模板：用div制造一个边长200px的正方形，每次刷新页面时，随机填充不同颜色，并显示颜色值，不使用JS
urls.py
from django.urls import path
from django.conf.urls import url
from . import views

urlpatterns = [
    path('color.html',views.color_box),
]

views.py
from random import randint
from django.shortcuts import render

def color_box(request):
    color = randint(0x000000, 0xffffff)
    return render(request,"color.html",{"color":"%06X"%(color)})
    #加0后，当不足6位时用0补全

color.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
    <div style="width: 200px;height: 200px;background:#{{ color }}"></div>
    颜色值:#{{ color }}
</body>
</html>

练习3：调用静态文件：写一个静态页面，使用AJAX，实现一个简单的时钟，每秒从服务端读取当前时间，并显示在网页上
setting.py
import os
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

STATIC_URL = '/static/'
STATICFILES_DIRS = [
    os.path.join(BASE_DIR,'static_files'),
]

urls.py
from django.urls import path
from django.conf.urls import url
from . import views

urlpatterns = [
    path('nowtime',views.nowtime),
]

views.py
from django.http.response import HttpResponse
from django.shortcuts import render
import time

def nowtime(request):
    temp = time.strftime("%Y-%m-%d %X", time.localtime())
    return HttpResponse(temp)

clock.html (static_files文件夹下)
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>时钟秒表</title>
    <script src="/static/js/jquery-3.0.0.js"></script>
    <script src="/static/js/auto_change.js"></script>
</head >
<body onload='$("#time").load("/nowtime");'>
    <h1>当前时间:</h1>
    <div id="time"></div>
</body>
</html>

auto_change.js
function play(){
    $("#time").load("/nowtime");
}
setInterval(play,1000);
知识点补充
Html文件中使用{% static "css/style.css" %}这种写法时，需要在文件中导入静态文件：{% load staticfiles %}
练习4：创建模板：使用AJAX，实现一个简单的时钟，每秒从服务端读取当前时间，并显示在网页上
urls.py
from django.urls import path
from django.conf.urls import url
from . import views

urlpatterns = [
    path('nowtime',views.nowtime),
    path('clock', views.clock),
]

views.py
from django.http.response import HttpResponse
from django.shortcuts import render
import time

def nowtime(request):
    temp = time.strftime("%Y-%m-%d %X", time.localtime())
    return HttpResponse(temp)

def clock(request):
    temp = time.strftime("%Y-%m-%d %X", time.localtime())
    return render(request,"clock.html",{"time":temp})

clock.html (templates文件夹下)
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>时钟秒表</title>
    <script src="/static/js/jquery-3.0.0.js"></script>
    <script src="/static/js/auto_change.js"></script>
</head >
<body>
    <h1>当前时间:</h1>
    <div id="time">{{ time }}</div>
</body>
</html>

auto_change.js
function play(){
    $("#time").load("/nowtime");
}
setInterval(play,1000);

练习5：变量标签的使用：学生信息表
urls.py
from django.urls import path
from django.conf.urls import url

urlpatterns = [
    path('student',views.student),
]

views.py
from django.shortcuts import render

def student(request):
    info = {
        'name':'小明',
        # 'sex':'男',
        'grade':'六年一班',
        'no':'1234567'
    }
    return render(request,"student.html",{"a":info})

student.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>学生信息</title>
</head>
<body>
    <ul>
        <li>姓名:{{ a.name }}</li>
        <li>性别:{{ a.sex|default:"保密" }}</li>
        <li>班级:{{ a.grade }}</li>
        <li>学号:{{ a.no }}</li>
    </ul>
</body>
</html>

练习6：逻辑标签的使用：学生信息表
urls.py
from django.urls import path
from django.conf.urls import url
from . import views

urlpatterns = [
    path('student',views.student),
]

views.py
from django.shortcuts import render

def student(request):
    infos = [
        {
            'name':'小明',
            # 'sex':'男',
            'grade':'六年一班',
            'no':'1234567'
        },
        {
            'name': '小明',
            # 'sex':'男',
            'grade': '六年一班',
            'no': '1234567'
        },
        {
            'name': '小明',
            # 'sex':'男',
            'grade': '六年一班',
            'no': '1234567'
        }
    ]
    return render(request,"student.html",{"infos":infos})

students.py
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>学生信息</title>
</head>
<body>
    {% if infos %}
        {% for a in infos %}
        <ul>
            <li>姓名:{{ a.name }}</li>
            <li>性别:{{ a.sex|default:"保密" }}</li>
            <li>班级:{{ a.grade }}</li>
            <li>学号:{{ a.no }}</li>
        </ul>
        <hr/>
        {% endfor %}
    {% else %}
        <h2>学生数据为空</h2>
    {% endif %}
</body>
</html>

知识点补充
STATIC_URL = '/static/'
#如果这个名字改了，
#采用<img src="/static/img/signImg1.jpg" />这种写法的将会报错
#而采用{% load staticfiles %}  <img src="{% static "img/headerSecondLineLogo.jpg" %}" />这种写法的将不会受影响
STATICFILES_DIRS = [
    os.path.join(BASE_DIR,'static_files'),
]
day4(Django)
练习1：创建模型
(1)startapp test_model







(2)设置数据库


(3)创建模型
在文件models.py下创建模型



知识点补充：添加外键
designer = models.ForeignKey(GoodFactory,on_delete=None,default='0')
此条语句的作用为
(4)在数据库中创建表



通知Django所有的模型的变化/通知Django指定的模型有变化


（往migrations路径下，自动添加处理数据库的python代码）

根据模型创建或更新所有表的结构/根据模型创建或更新指定表的结构






(5)其他文件的书写(包含数据库数据的读取)

from django.shortcuts import render
from shopping_car.models import GoodsInfo #导入数据表模型

def shopping_car(request):
    infos = GoodsInfo.objects.all() #读取数据表中的所有数据：select * from table
    # infos = GoodsInfo.objects.filter(id=1)
    return render(request,'shoppingCar.html',{'obj':infos})

# Create your views here.


from django.urls import path
from django.conf.urls import url
from shopping_car.views import shopping_car
from . import views

urlpatterns = [
    path('shoppingdb',shopping_car),
]
day5(Django)
练习1：访问外键所在的表单
shoppingCar.html部分代码

<div class="bodyGoodsTitle">
   {{ i.firstLineInfo }}<br />
   {{ i.secondLineInfo }}<br />
	{{ i.designer.name }}
</div>
练习2：输入的单数据，获取后显示(包含GET请求的应用)
shoppingCar.html部分代码

<div class="bodyAccountBox">
   <input type="checkbox" />
   <div class="bodyAccountAllChoose">全选</div>
   <ul>
      <li>删除</li>
      <li>清除失效宝贝</li>
      <li>移入收藏夹</li>
      <li>分享</li>
   </ul>
   <div class="bodyAccountYXSP">已选商品0件</div>
                <div class="bodyGoodAdd"><a href={% static "good_add.html"%}>添加商品</a></div>
                <div class="bodyAccountHJ">合计 (不含运费):</div>
   <div class="bodyAccountMoney"><b>0.00</b></div>
   <div class="bodyAccountButton">结算</div>
</div>
static_files\good_add.html

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>请输入商品信息</title>
</head>
<body>
    <form method="get" action="/good_add">
        <label>第一行信息:</label>
        <input type="text" name="firstLineInfo"><br>
        <label>第二行信息:</label>
        <input type="text" name="secondLineInfo"><br>
        <label>商品单价:</label>
        <input type="text" name="unitPrice"><br>
        <input type="submit" name="submit" value="提交">
    </form>
</body>
</html>
shopping_car\views.py

from django.http import HttpResponse

def good_add(request):#（1）html文件中的使用<form method="get" action="good_add">可以进行数据的提交
    print("数据的请求方法",request.method)
    print("提交的GET数据",request.GET.__str__())
    #（2）通过request.GET.xxx可以获取表单数据
    # return HttpResponse("商品名:"+request.GET["text"])
    return HttpResponse("商品名:"+request.GET.get("text"))
    #知识点补充：当采用request.GET.get(key,default)方法时，即使request.GET[key]中的key不存在,也不会报错，因为赋值了default
urls.py
from django.urls import path
from shopping_car.views import shopping_car, good_add

urlpatterns = [
    path('shoppingdb',shopping_car),
    path('good_add',good_add)
]
练习3：输入表单数据，获取后写入到数据库(包含数据库数据的写入)，实现购物车“添加商品”功能
shoppingCar.html部分代码

<div class="bodyAccountBox">
   <input type="checkbox" />
   <div class="bodyAccountAllChoose">全选</div>
   <ul>
      <li>删除</li>
      <li>清除失效宝贝</li>
      <li>移入收藏夹</li>
      <li>分享</li>
   </ul>
   <div class="bodyAccountYXSP">已选商品0件</div>
                <div class="bodyGoodAdd"><a href={% static "good_add.html"%}>添加商品</a></div>
                <div class="bodyAccountHJ">合计 (不含运费):</div>
   <div class="bodyAccountMoney"><b>0.00</b></div>
   <div class="bodyAccountButton">结算</div>
</div>
static_files\good_add.html

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>请输入商品信息</title>
</head>
<body>
    <form method="get" action="/good_add">
        <label>第一行信息:</label>
        <input type="text" name="firstLineInfo"><br>
        <label>第二行信息:</label>
        <input type="text" name="secondLineInfo"><br>
        <label>商品单价:</label>
        <input type="text" name="unitPrice"><br>
        <input type="submit" name="submit" value="提交">
    </form>
</body>
</html>
shopping_car\views.py

from django.http import HttpResponse, HttpResponseRedirect

def good_add(request):
    if request.method == "GET":#(1)获取数据
        #(2)创建模型对象,并进行属性赋值
        obj = GoodsInfo(
            firstLineInfo=request.GET.get("firstLineInfo"),
            secondLineInfo=request.GET.get("secondLineInfo"),
            unitPrice=request.GET.get("unitPrice"), #获取的是value值

            designer_id=1
        )
        obj.save()#(3)保存到数据库
        # return HttpResponse("数据提交成功")
        return HttpResponseRedirect("/shoppingdb")#此函数的作用是跳转到指定网址页
知识点补充
(1)unitPrice=request.GET.get("unitPrice"), #获取的是<input type="text" name="unitPrice"><br>里的value值
(2)

同理：select中获取到的是{{ item.id }}，{{ item.name }}只是显示的内容。
urls.py
from django.urls import path
from shopping_car.views import shopping_car, good_add

urlpatterns = [
    path('shoppingdb',shopping_car),
    path('good_add',good_add)
]
练习4：Form类的使用
templates\good_add.html

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>请输入商品信息</title>
</head>
<body>
    <form method="get" action="/good_add">
        {{ form }}
{#        <label>第一行信息:</label>#}
{#        <input type="text" name="firstLineInfo"><br>#}
{#        <label>第二行信息:</label>#}
{#        <input type="text" name="secondLineInfo"><br>#}
{#        <label>商品单价:</label>#}
{#        <input type="text" name="unitPrice"><br>#}
        <input type="submit" name="submit" value="提交">
    </form>
</body>
</html>
shopping_car\views.py

from django import forms
from django.shortcuts import render

class MyForm(forms.Form):
    text = forms.CharField(label="商品描述")
    color = forms.CharField(label="颜色")

def good_add_html(response):#生成添加商品的动态网页
    form = MyForm().as_ul()
    return render(response,"good_add.html",{"form":form})
知识点补充

可以使用不同的形式创建form表单
urls.py
from django.contrib import admin

from django.urls import path
from django.conf.urls import url
from shopping_car.views import good_add_html
from . import views

urlpatterns = [
    path('good_add_html',good_add_html),
]
练习5：ModelForm类的使用
templates\good_add.html

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>请输入商品信息</title>
</head>
<body>
    <form method="get" action="/good_add">
        {{ form }}
{#        <label>第一行信息:</label>#}
{#        <input type="text" name="firstLineInfo"><br>#}
{#        <label>第二行信息:</label>#}
{#        <input type="text" name="secondLineInfo"><br>#}
{#        <label>商品单价:</label>#}
{#        <input type="text" name="unitPrice"><br>#}
        <input type="submit" name="submit" value="提交">
    </form>
</body>
</html>
shopping_car\views.py
from django import forms
from django.shortcuts import render
from shopping_car.models import GoodsInfo

#根据模型生成表单
class GoodAddForm(forms.ModelForm):
    class Meta:
        model = GoodsInfo
        fields = ["firstLineInfo","secondLineInfo","unitPrice","designer"]#生成的表单<input>项
        labels = {
            "firstLineInfo":"第一行信息",
            "secondLineInfo":"第二行信息",
            "unitPrice":"单价",
            "designer":"生产商",
        }

def good_add_html(response):#生成添加商品的动态网页
    form = GoodAddForm()
    return render(response,"good_add.html",{"form":form})
知识点补充
不加labels

加labels

使下拉框中显示对象所对应的name的方式：

默认调用.__str__()方法，得到的结果是一个对象；
可以通过重写.__str__()方法，return self.name，从而得到对象相对应的name；
urls.py
from django.urls import path
from shopping_car.views import shopping_car, good_add

urlpatterns = [
    path('shoppingdb',shopping_car),
    path('good_add',good_add)
]
day6(Django)
练习1：电子词典

settings.py
STATIC_URL = '/static/'
STATICFILES_DIRS = [
    os.path.join(BASE_DIR,'static_files'),
]

urls.py
urlpatterns = [
    path('admin/', admin.site.urls),
    path('', views.index),
    path('trans',views.trans),
]

models.py
from django.db import models

class DictionaryDict(models.Model):
    # id = models.IntegerField()
    words = models.TextField(blank=True, null=True)
    comment = models.TextField(blank=True, null=True)
    sample = models.TextField(blank=True, null=True)

# Create your models here.

dictionary/views.py
from django.db.models import QuerySet
from django.shortcuts import render
from dictionary.models import DictionaryDict

def index(request):
    return render(request,"dict.html",{"text":"Waiting for input"})

def trans(request):
    if request.method == "GET":
        content=request.GET.get("content")
        # infos = DictionaryDict.objects.filter(words__iexact=content)
        # 实现模糊查询
        # __exact 代表 精确查找
        # __iexact 代表 like("hello")
        # __contains 代表 like("%hello%")
        infos = DictionaryDict.objects.filter(words__iexact=content)
        # infos = DictionaryDict.objects.get(words__iexact=content)
        #filter返回的是列表
        #get返回的是一个对象
        if infos:
            infos[0].comment = infos[0].comment.replace("&lt;br&gt;","<br>")
            infos[0].sample = infos[0].sample.replace("/r/n","<br>")
            return render(request,"dict.html",{"obj":infos,"text":"输出结果："})
        else:
            return render(request,"dict.html",{"text":"Not found the word"})

# Create your views here.

static_files/style.css
{% load staticfiles %}
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" href="{% static "css/style.css" %}" />
    <script type="text/javascript" src="{% static "js/script.js" %}"></script>
</head>
<body>
    <div class="imgBox">
        <img class="imgFrame" src="{% static "img/dict_logo.jpg" %}" />
    </div>

    <div class="inputBox">
        <form method="get" action="/trans">
            <input class="inputFrame" type="text" name="content" placeholder="&nbsp;Please enter a word"/>
            <input class="buttonFrame" type="submit" name="submit" value="Translate">
        </form>
    </div>


    <div class="outputBox">
        <b>{{ text }}</b><br><br>
        {% for i in obj %}
{#        这种形式在使用filter时使用#}
        <b>单词：</b>{{ i.words|safe }}<br><br>
        <b>解释：</b>{{ i.comment|safe }}<br><br>
        <b>示例：</b>{{ i.sample|safe }}
{#      解决输入 例如：<br> 时，Django框架自动转义问题：告诉Django，标签的内容是安全的，不需要进行HTML转义，直接进行文字替换#}
        {% endfor %}
    </div>
</body>
</html>

templates/dict.html
{% load staticfiles %}
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" href="{% static "css/style.css" %}" />
    <script type="text/javascript" src="{% static "js/script.js" %}"></script>
</head>
<body>
    <div class="imgBox">
        <img class="imgFrame" src="{% static "img/dict_logo.jpg" %}" />
    </div>

    <div class="inputBox">
        <form method="get" action="/trans">
            <input class="inputFrame" type="text" name="content" placeholder="&nbsp;Please enter a word"/>
            <input class="buttonFrame" type="submit" name="submit" value="Translate">
        </form>
    </div>


    <div class="outputBox">
        <b>{{ text }}</b><br><br>
        {% for i in obj %}
{#        这种形式在使用filter时使用#}
        <b>单词：</b>{{ i.words|safe }}<br><br>
        <b>解释：</b>{{ i.comment|safe }}<br><br>
        <b>示例：</b>{{ i.sample|safe }}
{#      解决输入 例如：<br> 时，Django框架自动转义问题：告诉Django，标签的内容是安全的，不需要进行HTML转义，直接进行文字替换#}
        {% endfor %}
    </div>
</body>
</html>


dictionary_dictionarydict


练习2：上传文件

settings.py
STATIC_URL = '/static/'
STATICFILES_DIRS=(
    (os.path.join(BASE_DIR, "staticfiles")),
)

urls.py
from django.contrib import admin
from . import views
from django.urls import path

urlpatterns = [
    path('admin/', admin.site.urls),
    path('upload', views.upload),
]

views.py
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render
from upload_picture.settings import BASE_DIR
import os

def upload(request):
    if request.method == "POST":
        if request.FILES.get("myfile") is None:
            return HttpResponse("请选择文件")
        else:
            myfile = request.FILES["myfile"] #获取文件对象
            print ("文件名："+myfile.name)
            print ("文件大小："+str(myfile.size))

            part_list = myfile.chunks()
            #把上传的文件，保存到staticfiles文件夹中
            file = open(os.path.join(BASE_DIR, "staticfiles/" + myfile.name), "w+b")
            for part in part_list:
                file.write(part)
            file.close()

            return HttpResponseRedirect("/static/"+myfile.name)
    else:
        return render(request, "upload_file.html")

templates/upload_file.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>上传文件</title>
</head>
<body>
    <form method="post" action="upload" enctype="multipart/form-data">
        {% csrf_token %}
        <label>上传文件</label>
        <input type="file" name="myfile">
        <input type="submit" name="upload">
    </form>
</body>
</html>

输出结果



day7

练习1：购物车项目添加商品页面中添加图片上传功能
要求：在购物车项目中的添加商品页面中，增加商品图片上传功能，图片保存到静态文件的img路径中
urls.py
from django.urls import path
from shoping_cart.views import shopping_cart

urlpatterns = [
    path('', shopping_cart),
]
shoping_cart/views.py
from django.http import HttpResponseRedirect, HttpResponse
from django.shortcuts import render
from shoping_cart.forms import GoodAddForm
from shoping_cart.models import GoodsInfo, GoodFactory

def shopping_cart(reqeust):
    infos = GoodsInfo.objects.all() #读取数据表中的所有数据：select * from table
    #infos就是一个字典列表
    #infos = GoodsInfo.objects.filter(id=1)  #select * from table where id = 1
    return render(reqeust, "index.html", {"items": infos})

def good_add(request):  #后台操作数据的接口
    if request.method == "POST":
        if request.FILES.get("img") is None:
            return HttpResponse("请上传图片")
        else:
            file = request.FILES.get("img") #获取文件对象
            part_list = file.chunks()   #读取文件信息

            ###把图片数据保存到本地文件
            local_file = open("static_files/img/"+file.name, "w+b")
            for part in part_list:
                local_file.write(part)
            local_file.close()

        #创建模型对象
        item = GoodsInfo(
            img=file.name,
            goodid="1",
            text=request.POST.get("text"),
            color=request.POST.get("color"),
            size=request.POST.get("size"),
            unit_price=request.POST.get("unit_price"),
            count=request.POST.get("count"),
            total=10,
            designer_id=request.POST.get("designer"),
        )
        item.save() #保存到数据库
        return HttpResponseRedirect("/")
    else:
        form = GoodAddForm()
        return render(request, "good_edit.html",
                      {"items": GoodFactory.objects.all(),
                       "form": form,
                       "title": "商品添加页",
                       "action":"/good_add",
                       "require":"required",
                       })
models.py
from django.db import models

class GoodFactory(models.Model):
    name = models.CharField(default="未定义", max_length=30)
    address = models.CharField(max_length=30)
    tel  = models.CharField(max_length=20)

    def __str__(self):
        return self.name

class GoodsInfo(models.Model):
    designer = models.ForeignKey(GoodFactory, on_delete=None, default="0")
    img   = models.CharField(max_length=30)
    goodid = models.IntegerField()
    text  = models.CharField(max_length=100)
    color = models.CharField(max_length=30)
    size  = models.CharField(max_length=20)
    unit_price = models.IntegerField()
    count = models.IntegerField()
    total = models.IntegerField()

GoodsInfo.designer.__str__()
shoping_cart/forms.py
from django import forms
from shoping_cart.models import GoodsInfo

class MyForm(forms.Form):
    text = forms.CharField(label="商品描述")
    color = forms.CharField(label="颜色")

#根据模型生成表单 model fields labels的名字是固定的
class GoodAddForm(forms.ModelForm):
    class Meta:
        model=GoodsInfo
        fields=["text","color","size","count","unit_price","designer"]  #生成的表单<input>项
        labels={
            "text":"商品描述",
            "color":"颜色",
            "size":"尺寸",
            "count":"数量",
            "unit_price":"单价",
            "designer":"生产商",
        }
templates/good_edit.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>{{ title }}</title>
</head>
<body>
<div>
    <form method="post" action="{{ action }}" enctype="multipart/form-data">
        <input type="hidden" name="id" value="{{ id }}">
        {% csrf_token %}
        <table>{{ form }}
            <tr>
                <th><label for="id_img">商品图片:</label></th>
                <td><input type="file" name="img" {{ require }} id="id_img" /></td>
            </tr>
        </table>
        <input type="submit" name="submit" value="提交">
    </form>
</div>
</body>
</html>
templates/index.html部分代码
<a href="/good_add">添加商品</a>
练习2：购物车中添加删除商品和修改商品功能
urls.py
from django.conf.urls import url
from django.contrib import admin
from django.urls import path
from shoping_cart.views import shopping_cart, good_add, good_del, good_update
from . import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', shopping_cart),
    path('good_add', good_add),
    path('good_del', good_del),
    path('good_update', good_update)
]
shoping_cart/views.py
from django.http import HttpResponseRedirect, HttpResponse
from django.shortcuts import render
from shoping_cart.forms import GoodAddForm
from shoping_cart.models import GoodsInfo, GoodFactory

def shopping_cart(reqeust):
    infos = GoodsInfo.objects.all() #读取数据表中的所有数据：select * from table
    #infos就是一个字典列表
    #infos = GoodsInfo.objects.filter(id=1)  #select * from table where id = 1
    return render(reqeust, "index.html", {"items": infos})

def good_add(request):  #后台操作数据的接口
    if request.method == "POST":
        if request.FILES.get("img") is None:
            return HttpResponse("请上传图片")
        else:
            file = request.FILES.get("img") #获取文件对象
            part_list = file.chunks()   #读取文件信息

            ###把图片数据保存到本地文件
            local_file = open("static_files/img/"+file.name, "w+b")
            for part in part_list:
                local_file.write(part)
            local_file.close()

        #创建模型对象
        item = GoodsInfo(
            img=file.name,
            goodid="1",
            text=request.POST.get("text"),
            color=request.POST.get("color"),
            size=request.POST.get("size"),
            unit_price=request.POST.get("unit_price"),
            count=request.POST.get("count"),
            total=10,
            designer_id=request.POST.get("designer"),
        )
        item.save() #保存到数据库
        return HttpResponseRedirect("/")
    else:
        form = GoodAddForm()
        return render(request, "good_edit.html",
                      {"items": GoodFactory.objects.all(),
                       "form": form,
                       "title": "商品添加页",
                       "action":"/good_add",
                       "require":"required",
                       })

def good_del(request):
    if request.method == "GET" and request.GET.get("id"):
        goodid=request.GET.get("id")
        item = GoodsInfo.objects.get(id=goodid) #从数据库获取商品对象
        item.delete()   #从数据删除对象
        return HttpResponseRedirect("/")
    else:
        return HttpResponse("非法请求")

def good_update(request):
    if request.method == "POST":
        goodid = request.POST.get("id")
        if goodid is None:
            return HttpResponse("没有ID字段")
        item = GoodsInfo.objects.get(id=goodid) #获取对象

        if request.FILES.get("img") is not None: #判断是否上传图片
            file = request.FILES.get("img") #获取文件对象
            part_list = file.chunks()   #读取文件信息
            ###把图片数据保存到本地文件
            local_file = open("static_files/img/"+file.name, "w+b")
            for part in part_list:
                local_file.write(part)
            local_file.close()
            item.img=file.name

        item.goodid="1"
        item.text=request.POST.get("text")
        item.color=request.POST.get("color")
        item.size=request.POST.get("size")
        item.unit_price=request.POST.get("unit_price")
        item.count=request.POST.get("count")
        item.total=10
        item.designer_id=request.POST.get("designer")

        item.save() #保存到数据库
        return HttpResponseRedirect("/")
    else:
        if request.GET.get("id") is None:
            return HttpResponse("非法请求")
        goodid = request.GET.get("id")
        item = GoodsInfo.objects.get(id=goodid)  # 从数据库获取商品对象
        form = GoodAddForm(instance=item)   #把表单数据进行初始化，初始化为item的值
        return render(request, "good_edit.html",
                      {"form": form,
                       "title": "商品修改页",
                       "action":"/good_update",
                       "id":goodid,
                       })
models.py
from django.db import models

class GoodFactory(models.Model):
    name = models.CharField(default="未定义", max_length=30)
    address = models.CharField(max_length=30)
    tel  = models.CharField(max_length=20)

    def __str__(self):
        return self.name

class GoodsInfo(models.Model):
    designer = models.ForeignKey(GoodFactory, on_delete=None, default="0")
    img   = models.CharField(max_length=30)
    goodid = models.IntegerField()
    text  = models.CharField(max_length=100)
    color = models.CharField(max_length=30)
    size  = models.CharField(max_length=20)
    unit_price = models.IntegerField()
    count = models.IntegerField()
    total = models.IntegerField()

GoodsInfo.designer.__str__()
shoping_cart/forms.py
from django import forms
from shoping_cart.models import GoodsInfo

class MyForm(forms.Form):
    text = forms.CharField(label="商品描述")
    color = forms.CharField(label="颜色")

#根据模型生成表单
class GoodAddForm(forms.ModelForm):
    class Meta:
        model=GoodsInfo
        fields=["text","color","size","count","unit_price","designer"]  #生成的表单<input>项
        labels={
            "text":"商品描述",
            "color":"颜色",
            "size":"尺寸",
            "count":"数量",
            "unit_price":"单价",
            "designer":"生产商",
        }
templates/good_edit.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>{{ title }}</title>
</head>
<body>
<div>
    <form method="post" action="{{ action }}" enctype="multipart/form-data">
        <input type="hidden" name="id" value="{{ id }}">
        {% csrf_token %}
        <table>{{ form }}
            <tr>
                <th><label for="id_img">商品图片:</label></th>
                <td><input type="file" name="img" {{ require }} id="id_img" /></td>
            </tr>
        </table>
        <input type="submit" name="submit" value="提交">
    </form>
</div>
</body>
</html>
templates/index.html部分代码
添加商品部分
<div class="computeTotal">
   <input type="checkbox" id="allselect"/>全选
   <a href="/good_add">添加商品</a><a>删除选中的商品</a><a>移到我的关注</a>
   <div class="cmpButtonBox">结算</div>
   <div class="selectProduct">
         已选择<span id="computeNum">1</span>件商品 总价：￥<span id="computPrice">0.0</span>
   </div>
</div>
删除商品和更改商品部分
<div class="itemcolumn t-operation">
   <a href="/good_del?id={{ item.id }}">删除</a><br />
                <a href="/good_update?id={{ item.id }}">修改</a><br />
   <a>移到我的关注</a><br />
   <a>加到我的关注</a><br />
</div>
知识点补充1：Django中存取Cookies
读取Cookies
访问HttpRequest.COOKIES对象
该对象是个字典结构，每个元素的值都是字符串
设置Cookies
常用语法：HttpResponse.set_cookie (key, value)
删除Cookies
常用语法：HttpResponse.delete_cookie ( key )
知识点补充2：Django的Session框架
1 概述
（1）Session框架的出现，是为了解决Cookie的限制与安全漏洞（因为Cookie本身可以携带数据）
（2）可以用Session 框架来存取每个访问者任意数据， 这些数据在服务器端存储，用Cookie保存用来识别访问者身份的验证标签
2 打开Session功能
注：如果项目是用 startproject 来创建的，配置文件中都已经安装了相关配置

（1）配置中间件(MiddleWare)
编辑 MIDDLEWARE_CLASSES 配置，确保 MIDDLEWARE_CLASSES 中包含'django.contrib.sessions.middleware.SessionMiddleware'

（2）配置模型(APP)
确认 INSTALLED_APPS 中有 'django.contrib.sessions'

3 Session的使用
SessionMiddleware 激活后，每个传给视图(view)函数的第一个参数HttpRequest 对象都有一个 session 属性，这是一个字典型的对象
在Session中保存、读取数据
（1）Session是一个字典
（2）request.session['key'] = value
（3）request.session.get("key", default)

例：

知识点补充
（1）views.py中每个函数的参数request中都有session属性，并且是相同的
（2）如果打开两个浏览器，分别请求同一个网址，那么两次请求所获得的session是不一样的
day8
用户与认证
1 Django 认证/授权 系统会包含以下部分
（1）用户 : 在网站注册的人
（2）权限 : 用于标识用户是否可以执行某种操作的二进制(yes/no)标志
（3）组 :一种可以将标记和权限应用于多个用户的常用方法
（4）Messages : 向用户显示队列式的系统消息的常用方法
2 打开认证支持
（1）将 'django.contrib.auth' 放在你的 INSTALLED_APPS 设置中，然后运行 manage.py syncdb以创建对应的数据库表。
（2）确认 SessionMiddleware 后面的 MIDDLEWARE_CLASSES 设置中包含'django.contrib.auth.middleware.AuthenticationMiddleware' SessionMiddleware
（3）使用request.user对象（使用request.user对象的属性和方法）
知识点补充
request.user的属性
（1）username	必需的，不能多于30个字符。 仅用字母数字式字符（字母、数字和下划线）。
（2）first_name	可选; 少于等于30字符。
（3）last_name	可选; 少于等于30字符。
（4）email	可选。 邮件地址。
（5）password	必需的。 密码的哈希值（Django不储存原始密码）。 See the Passwords section for more about this value.
（6）is_staff	布尔值。 用户是否拥有网站的管理权限。
（7）is_active	布尔值. 设置该账户是否可以登录。 把该标志位置为False而不是直接删除账户。
（8）is_superuser	布尔值 标识用户是否拥有所有权限，无需显式地权限分配定义。
（9）last_login	用户上次登录的时间日期。 它被默认设置为当前的日期/时间。
（10）date_joined	账号被创建的日期时间 当账号被创建时，它被默认设置为当前的日期/时间。
request.user的方法
（1）is_authenticated()	对于真实的User对象，总是返回True 。这是一个分辨用户是否已被鉴证的方法。 它并不意味着任何权限，也不检查用户是否仍是活动的。 它仅说明此用户已被成功鉴证。
（2）get_full_name()	返回first_name 加上last_name ，中间插入一个空格。
（3）set_password(passwd)	设定用户密码为指定字符串（自动处理成哈希串）。 实际上没有保存User对象。
（4）check_password(passwd)	如果指定的字符串与用户密码匹配则返回True。 比较时会使用密码哈希表。
（5）get_group_permissions()	返回一个用户通过其所属组获得的权限字符串列表。
（6）get_all_permissions()	返回一个用户通过其所属组以及自身权限所获得的权限字符串列表。
（7）has_perm(perm)	如果用户有指定的权限，则返回True ，此时perm 的格式是"package.codename" 。如果用户已不活动，此方法总是返回False 。
（8）has_perms(perm_list)	如果用户拥有全部 的指定权限，则返回True 。 如果用户是不活动的，这个方法总是返回False 。
（9）has_module_perms(app_label)	如果用户拥有给定的app_label 中的任何权限，则返回True 。如果用户已不活动，这个方法总是返回False 。
（10）get_and_delete_messages()	返回一个用户队列中的Message 对象列表，并从队列中将这些消息删除。
（11）email_user(subj, msg)	向用户发送一封电子邮件。 这封电子邮件是从DEFAULT_FROM_EMAIL 设置的地址发送的。 你还可以传送一个第三参数：from_email ，以覆盖电邮中的发送地址。
练习1：用户注册(两种方法)
1 使用UserCreationForm类创建用户(部分代码)
shoping_cart/view.py部分代码
from django.http import HttpResponse
from django.shortcuts import render
from django.contrib.auth.forms import UserCreationForm

def user_register(request):
    if request.method == "POST":
        #user = User()
        form = UserCreationForm(request.POST)
        if form.is_valid(): #验证表单数据
            form.save()     #保存用户数据
            return HttpResponse("用户创建成功")
        return HttpResponse("用户信息输入有误")
    else:
        return render(request, "user_create.html",{"form":UserCreationForm})
templates/user_create.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>{{ title }}</title>
</head>
<body>
<div>
    <form method="post" action="{{ action }}" enctype="multipart/form-data">
        <input type="hidden" name="id" value="{{ id }}">
        {% csrf_token %}
        <table>{{ form }}
        </table>
        <input type="submit" name="submit" value="提交">
    </form>
</div>
</body>
</html>
urls.py(略)
2 使用User.objects.create_user方法创建用户(部分代码)
shoping_cart/view.py部分代码
from django.contrib.auth.models import User
from django.http import HttpResponse
from django.shortcuts import render
from shoping_cart.forms import UserAddForm 

def user_register2(request):
    if request.method == "POST":
        form = UserAddForm(data=request.POST)
        if form.is_valid(): #验证POST数据是否完全符合表单所用的字段
            User.objects.create_user(username=request.POST["username"], password=request.POST["password"])
            return HttpResponse("用户名："+request.POST["username"]+"<br>密码："+request.POST["password"])
        return HttpResponse("用户信息输入有误")
    else:
        return render(request, "user_create.html",{"form":UserAddForm})
shoping_cart/forms.py
from django import forms

class UserAddForm(forms.Form):
    username = forms.CharField(label="用户名")
    password = forms.CharField(label="密码", widget=forms.PasswordInput)
    usertype = forms.ChoiceField(label="用户类型", choices=(('A', "商家"),('B', "买家")))
templates/user_create.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>{{ title }}</title>
</head>
<body>
<div>
    <form method="post" action="{{ action }}" enctype="multipart/form-data">
        <input type="hidden" name="id" value="{{ id }}">
        {% csrf_token %}
        <table>{{ form }}
        </table>
        <input type="submit" name="submit" value="提交">
    </form>
</div>
</body>
</html>
urls.py(略)
练习2：用户登录与注销
shoping_cart/view.py部分代码
from django.contrib import auth
from django.http import HttpResponseRedirect, HttpResponse
from django.shortcuts import render
from shoping_cart.forms import UserLoginForm

def user_login(request):
    if request.method == "POST":
        form = UserLoginForm(data=request.POST)
        if form.is_valid():
            user = auth.authenticate(username=request.POST["username"], password=request.POST["password"])
            if user: #用户验证成功
                auth.login(request, user=user)
                return HttpResponseRedirect("/")
            else:
                return HttpResponse("用户名或密码错误")
        pass
    else:
        return render(request, "user_login.html", {"form":UserLoginForm})

def user_logout(request):
    auth.logout(request)
    return HttpResponseRedirect("/")
shoping_cart/forms.py
from django import forms

class UserLoginForm(forms.Form):
    username = forms.CharField(label="用户名")
    password = forms.CharField(label="密码")
user_login.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>用户登录</title>
</head>
<body>
<div>
    <form method="post" action="{{ action }}">
        {% csrf_token %}
        <table>{{ form }}
        </table>
        <input type="submit" name="submit" value="提交">
    </form>
</div>
</body>
</html>
urls.py(略)
练习3：全部商品/我的商品/添加到购物车/查看购物车(部分代码)
shoping_cart/view.py部分代码
import datetime
from django.http import HttpResponseRedirect, HttpResponse
from django.shortcuts import render
from shoping_cart.models import GoodsInfo, ShoppingCart

def all_goods(request):
    infos = GoodsInfo.objects.all() #读取数据表中的所有数据：select * from table
    #infos就是一个字典列表
    response = render(request, "index.html", {"user": request.user, "items": infos})
    return response

def my_goods(request):
    if request.user.is_authenticated is not True:  # 未登录的用户
        return HttpResponse("请先登录")
    else:
        infos = GoodsInfo.objects.filter(user=request.user)
    return render(request, "mygoods.html", {"user": request.user, "items": infos})

def add_to_cart(request):
    if request.user.is_authenticated is not True:
        return HttpResponse("请先登录")

    goodid = request.GET.get("goodid")
    if goodid is None:
        return HttpResponse("缺少必要参数")

    good = GoodsInfo.objects.get(id=goodid)
    if good is None:
        return HttpResponse("未发现该商品")
    try:
        shopping_item = ShoppingCart.objects.get(good_id=goodid)
        item = shopping_item
        item.count += 1
    except:
        item = ShoppingCart(user=request.user, good=good,
                        count=1, time=datetime.datetime.today(),
                        goodprice=good.unit_price,
                        total=1
                        )
    item.save()
    return HttpResponse("添加成功")

def mycart(request):
    if request.user.is_authenticated is not True:
        return HttpResponse("请先登录")

    items = ShoppingCart.objects.filter(user=request.user)
    return render(request, "mycart.html", {"user":request.user,"items":items})
templates/index.html部分代码
<div id="contentBox">
          {% if items %}
          {% for item in items %}
   <div class="item">
      <div class="itemcolumn t-checkbox">
                  <img src="/static/img/{{ item.img }}" height="80" width="80"/>
              </div>
      <div class="itemcolumn t-product">
         <span><a>{{ item.text }}</a> </span>
         <img src="{% static "img/seven.png" %}" title="支持七天无理由退换货"/>
      </div>
      <div class="itemcolumn t-size">
         <p title="颜色：{{ item.color }}">颜色：{{ item.color }}</p>
         <p title="尺码：{{ item.size }}">尺码：{{ item.size }}</p>
                  <p title="制造商：{{ item.designer.name }}">生产商：{{ item.designer.name }}</p>
      </div>
      <div class="itemcolumn t-price">
         ￥<span id="perPrice{{ item.id }}">{{ item.unit_price }}</span>
      </div>
      <div class="itemcolumn t-num">
         <div id="subNum{{ item.id }}" class="numOperation">-</div>
         <input type="text" id="num{{ item.id }}" class="num" value="{{ item.count }}"/>
         <div id="addNum{{ item.id }}" class="numOperation">+</div>
      </div>
      <div class="itemcolumn t-money">
         <span id="totalPrice{{ item.id }}">{{ item.total }}</span>
      </div>
      <div class="itemcolumn t-operation">
         <a>移到我的关注</a><br />
         <a>加到我的关注</a><br />
                  <a href="/add_to_cart?goodid={{ item.id }}">添加到购物车</a><br />
      </div>
   </div>
          {% endfor %}
          {% endif %}
</div>

<div class="computeTotal">
          <a>添加到我的关注</a>|<a href="/mycart">查看购物车</a>
</div>
templates/mygoods.html部分代码
<div id="contentBox">
          {% if items %}
          {% for item in items %}
   <div class="item">
      <div class="itemcolumn t-checkbox"><input type="checkbox" id="shop001_item{{ item.id }}" class="shop001"/>
                  <img src="/static/img/{{ item.img }}" height="80" width="80"/>
              </div>
      <div class="itemcolumn t-product">
         <span><a>{{ item.text }}</a> </span>
         <img src="{% static "img/seven.png" %}" title="支持七天无理由退换货"/>
      </div>
      <div class="itemcolumn t-size">
         <p title="颜色：{{ item.color }}">颜色：{{ item.color }}</p>
         <p title="尺码：{{ item.size }}">尺码：{{ item.size }}</p>
                  <p title="制造商：{{ item.designer.name }}">生产商：{{ item.designer.name }}</p>
      </div>
      <div class="itemcolumn t-price">
         ￥<span id="perPrice{{ item.id }}">{{ item.unit_price }}</span>
      </div>
      <div class="itemcolumn t-num">
         <div id="subNum{{ item.id }}" class="numOperation">-</div>
         <input type="text" id="num{{ item.id }}" class="num" value="{{ item.count }}"/>
         <div id="addNum{{ item.id }}" class="numOperation">+</div>
      </div>
      <div class="itemcolumn t-money">
         <span id="totalPrice{{ item.id }}">{{ item.total }}</span>
      </div>
      <div class="itemcolumn t-operation">
         <a href="/good_del?id={{ item.id }}">删除</a><br />
                  <a href="/good_update?id={{ item.id }}">修改</a><br />
         <a>移到我的关注</a><br />
         <a>加到我的关注</a><br />
      </div>
   </div>
          {% endfor %}
          {% endif %}
</div>

<div class="computeTotal">
   <input type="checkbox" id="allselect"/>全选
   <a href="/good_add"">添加商品</a><a>删除选中的商品</a>
</div>
templates/mycart.html部分代码
<div class="contentTitle">
   <div id="sendAddr">
      <span>配送至：</span>
      <span id="address">沈阳沈河区<img src="{% static "img/header_arrow_down.png" %}" /> </span>
   </div>
</div>
<div class="productTitle">
   <div class="column t-checkbox"><input type="checkbox" id="selectAll"/>&nbsp;&nbsp;全选</div>
   <div class="column t-product">商品</div>
   <div class="column t-size"></div>
   <div class="column t-price">单价</div>
   <div class="column t-num">数量</div>
   <div class="column t-money">小计</div>
   <div class="column t-operation">操作</div>
</div>
<div id="contentBox">

          {% if items %}
          {% for item in items %}
   <div class="item">
      <div class="itemcolumn t-checkbox"><input type="checkbox" id="shop001_item{{ item.good.id }}" class="shop001"/>
                  <img src="/static/img/{{ item.good.img }}" height="80" width="80"/>
              </div>
      <div class="itemcolumn t-product">
         <span><a>{{ item.good.text }}</a> </span>
         <img src="{% static "img/seven.png" %}" title="支持七天无理由退换货"/>
      </div>
      <div class="itemcolumn t-size">
         <p title="颜色：{{ item.good.color }}">颜色：{{ item.good.color }}</p>
         <p title="尺码：{{ item.good.size }}">尺码：{{ item.good.size }}</p>
                  <p title="制造商：{{ item.good.designer.name }}">生产商：{{ item.good.designer.name }}</p>
      </div>
      <div class="itemcolumn t-price">
         ￥<span id="perPrice{{ item.good.id }}">{{ item.good.unit_price }}</span>
      </div>
      <div class="itemcolumn t-num">
         <div id="subNum{{ item.good.id }}" class="numOperation">-</div>
         <input type="text" id="num{{ item.good.id }}" class="num" value="{{ item.count }}"/>
         <div id="addNum{{ item.good.id }}" class="numOperation">+</div>
      </div>
      <div class="itemcolumn t-money">
         <span id="totalPrice{{ item.good.id }}">{{ item.total }}</span>
      </div>
      <div class="itemcolumn t-operation">
         <a>移到我的关注</a><br />
         <a>加到我的关注</a><br />
      </div>
   </div>
          {% endfor %}
          {% endif %}
</div>
models.py
from django.contrib.auth.models import User
from django.db import models

class GoodsInfo(models.Model):
    user = models.ForeignKey(User, on_delete=None, default="0")
    designer = models.ForeignKey(GoodFactory, on_delete=None, default="0")
    img   = models.CharField(max_length=30)
    goodid = models.IntegerField()
    text  = models.CharField(max_length=100)
    color = models.CharField(max_length=30)
    size  = models.CharField(max_length=20)
    unit_price = models.IntegerField()
    count = models.IntegerField()
    total = models.IntegerField()

class ShoppingCart(models.Model):
    user = models.ForeignKey(User, on_delete=None, default="0")
    good = models.ForeignKey(GoodsInfo, on_delete=None, default="0")
    goodprice = models.IntegerField()
    count = models.IntegerField()
    time = models.DateTimeField()
    total = models.IntegerField()
urls.py(略)
知识点补充：大项目的urls.py
from django.conf.urls import url
from django.contrib import admin
from django.urls import path
from shoping_cart.views import all_goods, good_add, good_del, good_update, test_session, user_register, \
    user_register2, user_login, user_logout, my_goods, add_to_cart, mycart
from . import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', all_goods),
    path('mygoods', my_goods),
    path('good_add', good_add),
    path('good_del', good_del),
    path('good_update', good_update),
    path('test_session',test_session),
    path('user_register', user_register),
    path('user_register2', user_register2),
    path('login', user_login),
    path('logout', user_logout),
    path('add_to_cart', add_to_cart),
    path('mycart', mycart)
]
day9
知识点1：多表链接(models.ManyToManyField())

（相当于在两个相关联的表中分别创建了一个外键）
结果如下：


知识点2：WebSocket
1 概述
（1）WebSocket是HTML5开始提供的一种在单个 TCP 连接上进行全双工通讯的协议。
（2）WebSocket主要原理就是在浏览器与服务器之间建立一个TCP长连接，可以在保持连接的过程中，互相收发数据，提高了数据传输的实时性
（3）在WebSocket API中，浏览器和服务器只需要做一个握手的动作，然后，浏览器和服务器之间就形成了一条快速通道。两者之间就直接可以数据互相传送。
（4）浏览器通过 JavaScript 向服务器发出建立 WebSocket 连接的请求，连接建立以后，客户端和服务器端就可以通过 TCP 连接直接交换数据。
（5）当你获取 Web Socket 连接后，你可以通过 send() 方法来向服务器发送数据，并通过 onmessage 事件来接收服务器返回的数据。
2 创建WebSocket对象
var Socket = new WebSocket(url, [protocol] );
注：
url的格式："ws://服务器:端口号"
创建对象的过程，就是建立连接的过程
3 WebSocket 属性
（1）Socket.readyState
只读属性 readyState 表示连接状态，可以是以下值：
0 - 表示连接尚未建立。
1 - 表示连接已建立，可以进行通信。
2 - 表示连接正在进行关闭。
3 - 表示连接已经关闭或者连接不能打开。

（2）Socket.bufferedAmount
只读属性 bufferedAmount 已被 send() 放入正在队列中等待传输，但是还没有发出的 UTF-8 文本字节数。
4 WebSocket 事件处理
（1）Socket.onopen	连接建立成功时（握手成功以后）触发
（2）Socket.onmessage	客户端接收服务端数据时触发
（3）Socket.onerror	通信发生错误时触发
（4）Socket.onclose	连接关闭时触发
5 WebSocket 方法
（1）send()	使用连接发送数据
（2）close()	关闭连接
知识点3：tornado框架
1 概述
（1）Tornado是一个基于Python，使用异步非阻塞网络IO原理实现的Web应用框架
（2）Tornado是一个Package
（3）擅长于TCP长连接以及WebSocket
（4）Tornado的工作模式采用事件回调机制（例如：连接事件、数据接收事件、连接断开事件等）
2 tornado与django的区别
（1）Django
主要功能是用来建立网站
框架功能比较完整，大而全
（2）Tornado
主要功能是用来搭建网络服务
框架比较小，小而精
3 tornado框架的应用
(1)创建动态Web服务(HTTP)
使用tornado.web.RequestHandler实现
自己实现Handler类，并继承RequestHandler类
实现相应的get、post等方法

(2)创建静态Web服务
使用tornado.web.StaticFileHandler实现
直接在创建Application时，在绑定URL时，第二个参数直接使用StaticFileHandler
第三个参数传入一个字典，作为静态文件的配置信息，字典常用字段

(3)创建WebSocket服务
使用tornado.websocket.WebSocketHandler实现
练习1：使用tornado实现一个简单的程序(搭建服务器，当客户端访问时，客户端显示”Hello World”)


import tornado.web
import tornado.ioloop

class MyWebHandler(tornado.web.RequestHandler):
    def get(self, *args, **kwargs): #用来处理get请求
        self.write('Hello World') #用来往客户端回复数据

    def post(self, *args, **kwargs): #用来处理post请求
        pass

if __name__ == "__main__":
    app = tornado.web.Application([ #用来绑定URL与处理程序
        (r'/', MyWebHandler)
    ])

    app.listen(8000) #设置服务的监听端口

    tornado.ioloop.IOLoop.current().start() #启动服务
练习2：tornado中websocket的简单实现效果
from tornado import web, websocket
from tornado import ioloop

class MyWebHandler(web.RequestHandler): #处理HTTP协议的类
    def get(self, *args, **kwargs): #用来处理get请求
        self.write('Hello World') #用来往客户端回复数据

    def post(self, *args, **kwargs): #用来处理post请求
        pass

class MyWebSocketHandler(websocket.WebSocketHandler): #处理WebSocket协议的类
    def open(self):
        print("连接成功")
        pass
    def on_message(self, message):
        print("接收到数据："+message)
        self.write_message("已收到")
        pass
    def on_close(self):
        print("连接已断开")
        pass

if __name__ == "__main__":
    app = web.Application([ #用来绑定URL与处理程序
        (r'/hello', MyWebHandler),
        (r'/websocket', MyWebSocketHandler)
    ])

    app.listen(8000) #设置服务的监听端口
    print("启动服务")
    ioloop.IOLoop.current().start() #启动服务

输出结果：


练习3：输入框与显示框的实现

server.py
from tornado import web, websocket
from tornado import ioloop

class MyWebHandler(web.RequestHandler): #处理HTTP协议的类
    def get(self, *args, **kwargs): #用来处理get请求
        self.write('Hello World') #用来往客户端回复数据

    def post(self, *args, **kwargs): #用来处理post请求
        pass

class MyWebSocketHandler(websocket.WebSocketHandler): #处理WebSocket协议的类
    def open(self):
        print("连接成功")
        pass
    def on_message(self, message):
        print("接收到数据："+message)
        self.write_message(message)
        pass
    def on_close(self):
        print("连接已断开")
        pass

if __name__ == "__main__":
    app = web.Application([ #用来绑定URL与处理程序
        (r'/hello', MyWebHandler), #实现web动态服务
        (r'/websocket', MyWebSocketHandler), #实现websocket服务
        # (r'/(index\.html)', web.StaticFileHandler, {"path":"."}), #实现web静态服务
        (r'/(.*)',web.StaticFileHandler,{"path":".","default_filename":"index.html"}),
    ])

    app.listen(8000) #设置服务的监听端口
    print("启动服务")
    ioloop.IOLoop.current().start() #启动服务
index.html
略

输出结果：


练习4：聊天室项目
server.py
from tornado import web, websocket
from tornado import ioloop
import json, uuid

# class MyWebHandler(web.RequestHandler): #处理HTTP协议的类
#     def get(self, *args, **kwargs): #用来处理get请求
#         self.write('Hello World') #用来往客户端回复数据
#
#     def post(self, *args, **kwargs): #用来处理post请求

users = {}

def sent_to_all(json_obj):
    for key in users.keys():
        users[key].write_message(json.dumps(json_obj))

class MyWebSocketHandler(websocket.WebSocketHandler): #处理WebSocket协议的类
    name = ""
    uuid = ""
    def open(self):
        print("连接成功")

    def on_message(self, message):
        print("接收到数据："+message)
        obj = json.loads(message)
        #json.loads(...)可以json字符串变为字典
        type = obj.get("type")
        if type == "login": #用户登录
            self.name = obj["client"]
            self.uuid = uuid.uuid4() #uuid是用户的唯一标识
            users[self.uuid] = self #把用户信息保存到用户表中，以uuid为键
            #上线提醒
            sent_to_all({
                "type":"login",
                "client":self.name,
                "uuid":self.uuid.__str__(),
            })
            #在线用户
            users_obj = []  #创建用户列表
            for key in users.keys():
                users_obj.append({"uuid": key.__str__(), "name": users[key].name})
            self.write_message(json.dumps({
                "type": "userlist",
                "users": users_obj,
            }))

        elif type == "message":
            to_user = obj.get("to")
            #群发
            if to_user == "all": #给所有用户发消息
                sent_to_all({
                    "type":"message",
                    "from_uuid":self.uuid.__str__(),
                    "from_client":self.name,
                    "content":obj.get("content"),
                })
            #发给指定用户
            else:
                to_user_obj = users.get(uuid.UUID(to_user))
                if to_user_obj:#验证是否存在于用户列表里
                    to_user_obj.write_message(json.dumps({
                            "type": "message",
                            "from_uuid": self.uuid.__str__(),
                            "from_client": self.name,
                            "content": obj.get("content"),
                    }))

    def on_close(self):
        if users.get(self.uuid):  # 判断uuid是否在用户列表中
            users.pop(self.uuid)
        print("连接已断开")


if __name__ == "__main__":
    app = web.Application([ #用来绑定URL与处理程序
        # (r'/hello', MyWebHandler), #实现web动态服务
        (r'/websocket', MyWebSocketHandler), #实现websocket服务
        # (r'/(index\.html)', web.StaticFileHandler, {"path":"."}), #实现web静态服务
        (r'/(.*)',web.StaticFileHandler,{"path":".","default_filename":"index.html"}),
    ])

    app.listen(8000) #设置服务的监听端口
    print("启动服务")
    ioloop.IOLoop.current().start() #启动服务
index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
    <META HTTP-EQUIV="Expires" CONTENT="0">
    <!--禁止缓存-->
    <meta charset="UTF-8">
    <title>Title</title>
    <script type="text/javascript">
        var ws, name="";

        function load() {
            ws = new WebSocket("ws://"+document.domain+":8000/websocket");
            //    document：获取当前域名
            if (ws != undefined){
                name = prompt("请输入用户名：","游客");
                ws.onopen = function (ev) {
                    document.getElementById("ws_stat").innerText="连接成功";
                    ws.send('{"type":"login","client":"'+name+'"}');
                }
                ws.onmessage = function (ev) {
                    console.log("收到服务器数据：" + ev.data);
                    data = "";
                    obj = JSON.parse(ev.data);
                    switch (obj.type){
                        case "login":
                            data = "上线提醒："+obj.client+"已上线!";
                            break;
                        case "message":
                            data = obj.from_client+" 发来数据：\n"+obj.content;
                            break;
                        case "userlist":
                            document.getElementById("user_list").innerHTML = "";
                            for (user in obj.users) {
                                document.getElementById("user_list").innerHTML += "<li>"+obj.users[user].name+"</li>";
                                document.getElementById("user_select").innerHTML += "<option value='"+obj.users[user].uuid+"'>"+obj.users[user].name+"</option>";
                            }
                    }
                    document.getElementById("data_recieved").innerText += data + "\n";
                    document.getElementById("data_recieved").scrollTop=1000000000;
                    // 为了显示滚动条底部//
                    // ws.onmessage=function (ev){...}是回调函数，当收到数据时自动运行
                }
                ws.onclose = function (ev) {
                    // alert("连接已断开!")
                    document.location.reload()
                    // 重新加载页面
                }
            }
        }
        function send() {
            data = document.getElementById("input_text").value;
            ws.send('{"type":"message", "content":"' + data + '", "to":"'+document.getElementById("user_select").value+'"}');
        }
    </script>
</head>
<body onload="load()">
    <div>WebSocket连接状态：<span id="ws_stat">未连接</span></div>
    <div style="display: inline-block">
        <h2>收到的数据</h2>
        <div id="data_recieved" style="background-color: bisque; border: 1px; width: 400px; height: 200px; overflow-y: auto; float: left"></div>
        <div style="height: 200px; width: 100px; background-color: gray; float: left; margin-left: 10px">
            在线用户
            <ul id="user_list"></ul>
        </div>
    </div><br>
    <h2>发送数据</h2>
    <select id="user_select">
        <option value="all">所有人</option>
    </select>
    <textarea id="input_text" style="width: 400px;height: 100px"></textarea>
    <input type="submit" value="发送" onclick="send()">
</body>
</html>

输出结果：

知识点补充：Django框架中通过现有数据库自动创建模型
Django引入外部数据库还是比较方便的，步骤如下 ：

创建一个项目，修改seting文件，在setting里面设置你要连接的数据库类型和连接名

称，地址之类，和创建新项目的时候一致 
运行下面代码可以自动生成models模型文件 
Python manage.py inspectdb 
这样就可以在控制台的命令行中看到数据库的模型文件了

把模型文件导入到app中 
创建一个app 
django-admin.py startapp app 
python manage.py inspectdb > app/models.py 
ok模型文件已经生成好了。下面的工作就和之前一样了
```
