# curl


- 基本用法

```
命令:	curl www.baidu.com
返回值:	html信息
```


- 保存访问的网页

```
curl www.baidu.com >> baidu.html
```


- 模仿浏览器

```
curl -A "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.0)" www.baidu.com      
```


- 下载文件

```
1) 利用curl下载文件
curl -o test.jpg http://a.hiphotos.baidu.com/image/pic/item/b999a9014c086e062550d0020f087bf40bd1cbfb.jpg
或
curl -O http://a.hiphotos.baidu.com/image/pic/item/b999a9014c086e062550d0020f087bf40bd1cbfb.jpg

2) 循环下载
curl -O http://www.linux.com/dodo[1-5].JPG

3) 下载重命名
curl -o #1_#2.JPG http://www.linux.com/{hello,bb}/dodo[1-5].JPG
这样在hello/dodo1.JPG的文件下载下来就会变成hello_dodo1.JPG

4) 分块下载
有时候下载的东西会比较大，这个时候我们可以分段下载。使用内置option：-r
curl -r 0-100 -o dodo1_part1.JPG http://www.linux.com/dodo1.JPG
curl -r 100-200 -o dodo1_part2.JPG http://www.linux.com/dodo1.JPG
curl -r 200- -o dodo1_part3.JPG http://www.linux.com/dodo1.JPG
cat dodo1_part* > dodo1.JPG

5) 通过ftp下载文件
curl可以通过ftp下载文件，curl提供两种从ftp中下载的语法
curl -O -u 用户名:密码 ftp://www.linux.com/dodo1.JPG
curl -O ftp://用户名:密码@www.linux.com/dodo1.JPG

6) 显示下载进度条
curl -# -O http://www.linux.com/dodo1.JPG

7) 不会显示下载进度信息
curl -s -O http://www.linux.com/dodo1.JPG
```


- 断点续传

```
在windows中，我们可以使用迅雷这样的软件进行断点续传。curl可以通过内置option:-C同样可以达到相同的效果，如果在下载dodo1.JPG的过程中突然掉线了，可以使用以下的方式续传
curl -C -O http://www.linux.com/dodo1.JPG
```


- 上传文件

```
curl不仅仅可以下载文件，还可以上传文件。通过内置option:-T来实现
curl -T dodo1.JPG -u 用户名:密码 ftp://www.linux.com/img/
```


- 显示抓取错误

```
curl -f http://www.linux.com/error
```
