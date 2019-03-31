### 脚本用到的一些知识点


```
1.======================================
导包时的搜索路径====================
In [1]: import sys

In [2]: sys.path
Out[2]: 
['',
 '/usr/local/bin',
 '/usr/lib/python2.7',
 '/usr/lib/python2.7/plat-x86_64-linux-gnu',
 '/usr/lib/python2.7/lib-tk',
 '/usr/lib/python2.7/lib-old',
 '/usr/lib/python2.7/lib-dynload',
 '/home/kaiqigu/.local/lib/python2.7/site-packages',
 '/usr/local/lib/python2.7/dist-packages',
 '/usr/lib/python2.7/dist-packages',
 '/usr/lib/python2.7/dist-packages/PILcompat',
 '/usr/lib/python2.7/dist-packages/gtk-2.0',
 '/usr/local/lib/python2.7/dist-packages/IPython/extensions',
 '/home/kaiqigu/.ipython']

    1) sys.path.insert(0, path)，定义搜索路径的优先顺序，序号从0开始，表示最大优先级，sys.path.insert()加入的是临时搜索路径，程序退出后失效。
    2) 使用sys.path.append()方法可以临时添加搜索路径，方便更简洁的import其他包和模块。这种方法导入的路径会在python程序退出后失效。


2.=======================================
获得当前绝对路径=========================
例:
CUR_PATH=$(cd "$(dirname "$0")"; pwd)
ipython -i $CUR_PATH/_shell.py $1

[admin@10-10-6-168 debug_shell]$ ls -a
.  ..  ass  gui  _shell.py  shell.sh
[admin@10-10-6-168 debug_shell]$ ls
ass  gui  _shell.py  shell.sh
[admin@10-10-6-168 debug_shell]$ 

解析:
$(cd `dirname $0`;pwd)
    在命令行状态下单纯执行 $ cd `dirname $0` 是毫无意义的。因为他返回当前路径的"."。
这个命令写在脚本文件里才有作用，他返回这个脚本文件放置的目录，并可以根据这个目录来定位所要运行程序的相对位置（绝对位置除外）。
在/home/admin/test/下新建test.sh内容如下：
    cd `dirname $0`
    echo `pwd`

然后返回到/home/admin/执行
    sh test/test.sh

运行结果:
    /home/admin/test

    这样就可以知道一些和脚本一起部署的文件的位置了，只要知道相对位置就可以根据这个目录来定位，而可以不用关心绝对位置。这样脚本的可移植性就提高了，扔到任何一台服务器，（如果是部署脚本）都可以执行。

3.=====================================
SHELL中的exit 0 和 exit 1有什么区别====
1、如果a.sh只是结束程序，没什么区别
2、如果b.sh调用a.sh脚本，b.sh要根据a.sh执行结果继续任务
exit 0表示成功了
exit 1表示有错误 
(注:返回值可以通过echo $?来获取返回的是0还是1)

4.=====================================
git fetch从远程分支拉取代码============
fetch常结合merge一起用，git fetch + git merge == git pull
一般要用git fetch+git merge，因为git pull会将代码直接合并，造成冲突等无法知道，fetch代码下来要git diff orgin/xx来看一下差异然后再合并。

1.分支概念：
	本地分支	---	本地远程分支	---	远程分支
	master			origin/master		master
	dev2			orgin/dev2		dev2
    如上所示，当前有2个分支master和dev2，当执行git clone的时候会clone下来远程分支到本地远程分支，并且默认本地分支显示master分支，使用git branche可以看到的本地分支只有master，git branch -r可以看到远程2个分支。当使用git checkout dev2 的时候，就会把本地远程分支加入到本地分支中，使用git branch就可以看到本地有2个分支。

网址: https://blog.csdn.net/Mooner_guo/article/details/49674497

5.=====================================
git archive用于打包====================
例:
/usr/bin/git archive --format=tar $tag | tar -xv -C $temp_dir

网址: https://git-scm.com/docs/git-archive

6.=====================================
os.path================================
kaiqigu@kaiqigu-H110-4S:~/PycharmProjects/test_demo|
⇒  vi test.py 

#!/usr/bin/python
#! --*-- coding:utf-8 --*--

import os
import sys

CUR_PATH = os.path.abspath(os.path.dirname(__file__))
ROOT_PATH = os.path.join(CUR_PATH, os.path.pardir, os.path.pardir)
sys.path.insert(0, ROOT_PATH)

print CUR_PATH
print ROOT_PATH

运行结果:
/home/kaiqigu/PycharmProjects/test_demo
/home/kaiqigu/PycharmProjects/test_demo/../..

7.=====================================
if ! test -d ${DIR}
then
        /bin/mkdir -p ${DIR}
fi
```
