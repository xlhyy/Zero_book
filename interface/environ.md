# 开发环境


## 生成ssh-key

- `查看是否已经存在ssh秘钥`
    - cd ~/.ssh

- `生成秘钥`

```
    ssh-keygen -t rsa -C 'yourmail@example.com'
你需要把邮件地址换成你自己的,然后一路回车,之后会在用户目录生成.ssh目录,其中id_rsa.pub 即公钥,可以告诉别人给你加对应机器的权限。
->添加ssh-key(以便让别人可以连接自己的机器)
- 文本类似于:
    ssh-rsa
AAAAB3NzaC1yc2EAAAADAQABAAABAQCcOfRQSJiSoCz/d2+HUeMJdt6PA+vbjUJXfmoah8FEOVTc+t6HMEsaIqWIy/N/PX0zTHmafPGFyGwjYEA/
bMZ5GtW9+vw867nK3sRT/w6ADL7luxr4dh1V4CjRX8/js2M8L71imiLee9yhGBedcrrgSxjynZoLbHcJbjjBSa0rnUeOh03GhydrDKcZho7waIWW
8u7JGqWYG91tiTbppBqyiAxvXpj5fklKbb/XMGk9zxVWUqSx+8peg1ZnSTFs4v7B5C2lk8BXUVYkcLgQ1xKCAMLDjIdtHBbSXJd8ONwBKtmJYl6G
KqHMg/maBFW5mAwzAFtNQXBmOEJk4TyP8cfj yuwang@yuwang-MS-7817
    将此文本添加到 ~/.ssh/authorized_keys 里面
```


## 安装brew

- `命令`

curl -LsSf http://github.com/mxcl/homebrew/tarball/master | sudo tar xvz -C/usr/local --strip 1

```
注: 
    地址可能有变动,如果下载不成功可以网上搜最新的安装命令.
安装成功后,使用brew doctor检查以下,根据提示解决有问题的地方.
可能遇到以下问题: Error: /usr/local must be writable!
解决方案,需要加个可读权限, 
sudo chown -R `whoami` /usr/local
之后运行brew 会提示你更新,使用 brew update
```


## 安装wget, pip, redis, mysql

```
brew install wget
sudo easy_install pip
brew install redis
brew install mysql
```


## 安装各种项目运行的依赖库

```
sudo pip install tornado
sudo pip install ipython(遇到os系统问题)
sudo pip install redis
sudo pip install openpyxl==1.7.0(指定版本下载)
sudo pip install MySQL-python(需要本地安装mysql)
sudo pip install gevent
sudo pip install M2Crypto (遇到需要swig的版本升级了)
```


## ipython安装问题处理方案

- 新系统sip的机制, 默认下系统启用SIP系统完整性保护机制，无论是对于硬盘还是运行时的进程 限制对系统目录的写操作。 这也是我们安装ipython失败的原因......

http://xiaorui.cc/2016/03/27/%E8%A7%A3%E5%86%B3mac-osx%E4%B8%8Bpip%E5%AE%89%E8%A3%85ipython%E6%9D%83%E9%99%90%E7%9A%84%E9%97%AE%E9%A2%98/


## redis配置及服务启动

- https://www.tuicool.com/articles/J7Jf6ff


## swig的坑解决方案

- sudo env LDFLAGS="-L$(brew --prefix openssl)/lib" \
CFLAGS="-I$(brew --prefix openssl)/include" \
SWIG_FEATURES="-cpperraswarn -includeall -I$(brew --prefix openssl)/include" \

- pip install m2crypto


## 怎么将终端工具的背景颜色设置为透明

- ubuntu

```
终端菜单栏--编辑--配置文件首选项--颜色--更改自己想要的样式
```

- mac

```
终端--偏好设置--描述文件--更改自己想要的样式
```


## 怎么将终端工具设置背景图片

- ubuntu

```
    sudo apt-get install xfce4-terminal
    在应用程序栏顶部搜索xfce4终端并打开
接着在此终端窗口中:编辑--首选项--外观--背景--背景图片
    注: 关于终端字体颜色: 编辑--首选项--颜色--预设--载入预设--Tango(个人喜好)
```

- mac

```
    终端--偏好设置--描述文件--更改自己想要的样式
```


## Ubuntu安装mysql

```
sudo apt-get install mysql-server
apt-get install mysql-client
sudo apt-get install libmysqlclient-dev
安装过程会提示设置密码
使用sudo netstat -tap | grep mysql可以检查是否安装成功
登录数据库: mysql -uroot -p
```


## Python MySQLdb在Linux下安装

- sudo yum install MySQL-python

- 可能遇到问题：

import MySQLdb

```
Traceback (most recent call last):
  File "<stdin>", line 1, in ?
  File "MySQLdb/__init__.py", line 22, in ?
    raise ImportError("this is MySQLdb version %s, but _mysql is version %r" %
ImportError: this is MySQLdb version (1, 2, 3, 'final', 0), but _mysql is version (1, 2, 1, 'final', 1)
原因：之前使用编译的方法进行安装，下的是1.2.3，但是用yum目前最高1.2.1，冲突
解决方法：删除已经编译的文件 rm -rf MySQL-python-1.2.3/
再进行 import MySQLdb，无错误，则表示成功了
```


## pycharm出现卡顿

- help--Find Action--输入VM Options--打开Edit Custom VM Options--改为-Xms1024m -Xmx2048m--重启pycharm


## 配置vim

```
vim ~/.vimrc  编辑配置文件
注: vim主题文件位置
kaiqigu@bogon:/usr/share/vim/vim80/colors|
⇒  ls
README.txt    default.vim   elflord.vim   koehler.vim   pablo.vim     shine.vim     zellner.vim
blue.vim      delek.vim     evening.vim   morning.vim   peachpuff.vim slate.vim
darkblue.vim  desert.vim    industry.vim  murphy.vim    ron.vim       torte.vim
```


## 安装redis

- linux安装redis

```
-获取redis资源:
	wget http://download.redis.io/releases/redis-4.0.8.tar.gz
-解压:
	tar xzvf redis-4.0.8.tar.gz
-安装: 
	cd redis-4.0.8
	make
	cd src
	make install PREFIX=/usr/local/redis
-移动配置文件到安装目录下:
	cd ../
	mkdir /usr/local/redis/etc
	mv redis.conf /usr/local/redis/etc
-配置redis为后台启动:
	vi /usr/local/redis/etc/redis.conf  //将daemonize no 改成daemonize yes
-将redis加入到开机启动:
	vi /etc/rc.local  //在里面添加内容：/usr/local/redis/bin/redis-server /usr/local/redis/etc/redis.conf (意思就是开机调用这段开启redis的命令)
-开启redis:
	/usr/local/redis/bin/redis-server /usr/local/redis/etc/redis.conf
-常用命令:
	启动redis: redis-server /usr/local/redis/etc/redis.conf
	停止redis: pkill redis
	卸载redis: 
		rm -rf /usr/local/redis //删除安装目录
		rm -rf /usr/bin/redis-* //删除所有redis相关命令脚本
		rm -rf /root/download/redis-4.0.4 //删除redis解压文件夹
```

- mac安装redis

```
	使用home-brew一键安装：brew install redis
	启动Redis服务：brew services start redis 或 redis-server /usr/local/etc/redis.conf
	关闭Redis服务：brew services stop redis
	重启Redis服务：brew services restart redis
	打开图形化界面：redis-cli
```


## 安装git

- linux安装git

```
ubuntu: sudo apt-get install git
老一点的debian或ubuntu: sudo apt-get install git-core
其他linux版本: git官网下载--解压--./config--make--sudo make install
```

- mac安装git

```
若没有安装homebrew，安装homebrew:  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
-问题:
1)MAC终端操作git时提示Enter passphrase for key '/Users/kaiqigu/.ssh/id_rsa'(ssh登陆时也可能出现同样的问题)
将私钥添加到钥匙串中，按照提示输入私钥密码:
mac下:(问题: 是临时的，下次开机还要再输入...)
ssh-add -K ~/.ssh/id_rsa
linux下:(问题: 是临时的，下次开机还要再输入...)
ssh-add -k ~/.ssh/id_rsa
```


## 连接vpn

- mac连接vpn

```
方式1: 系统偏好设置--网络--+(左下角)--接口选vpn--填服务器地址及账户名称--点鉴定设置添加相应信息--连接
方式2: 安装ShadowsocksX--输入本机用户名及密码进入--+(左下角)--填入相应信息--确定
注意: mac系统连接L2TP的VPN，需要创建下面的文件
1)mac系统，需要创建这个文件sudo vim /etc/ppp/options文件里输入
plugin L2TP.ppp
l2tpnoipsec
2)把高级里 通过VPN连接发送所有流量 点选
```

- windows连接vpn

```
网络--网络和Internet设置--网络和共享中心--设置新的连接或网络--连接到工作区--使用我的Internet连接(VPN)(I)--输入Internet地址(I)--点击桌面右下角的网络图标，选择设置的vpn连接，点击连接--输入用户名和密码--确定
```


## mac安装gitk

```
brew update
brew install git
gitk 
```


## 解决mac下gitk分辨率低的问题

```
开启高分辨率适配步骤如下：
1、重启系统，在黑屏界面的时候按住command + r直至出现进度条，进入系统recovery模式
2、在recovery模式中选择简体中文进入桌面，在最顶层的工具栏中找到“实用工具” -> “终端”，启动命令行终端
3、执行以下命令关闭系统保护
csrutil disable
4、重启正常进入系统，修改系统配置文件（如果没有上面的csrutil disable，是无法修改/System目录内的任何内容的）
sudo vim /System/Library/Frameworks/Tk.framework/Versions/Current/Resources/Wish.app/Contents/Info.plist
======================
然后在这个文件内容中增加以下两行配置：
	<key>NSHighResolutionCapable</key>
        <true/>
增加位置如下图:
	<key>NSHighResolutionCapable</key>
        <true/>
</dict>
</plist>
======================
然后更新Wish.app配置
sudo touch /System/Library/Frameworks/Tk.framework/Versions/Current/Resources/Wish.app
5、再次重启，黑屏时按下command+r直到出现进度条，重新进入recovery模式
6、进入recovery模式桌面后，执行“实用工具”->“终端”启动命令行终端
7、执行命令开启系统文件保护
csrutil enable
8、重启系统，正常进入系统，gitk就OK了
```


## mac安装软件允许任何来源

- https://jingyan.baidu.com/article/6fb756ec538dd0241858fbd5.html


## oh-my-zsh主题

```
1)oh-my-zsh安装:
curl -L http://install.ohmyz.sh | sh
主题(ZSH_THEME)设为pygmalion(ys主题也不错)，可以在~/.zshrc(若无此文件，可以执行sudo pip install zsh)中配置。

2)oh-my-zsh插件
比较好用的是last-working-dir，此插件的作用是下一次打开终端时定位到之前的目录下，是一个很好用的插件。 使用方法同上，不同的是找到plugins=(git)这一行（大概55行左右），改为plugins=(git last-working-dir)，也是重启终端后生效。

3)解决perl: warning: Setting locale failed. perl: warning: Please check that your locale settings:
可能的解决方法:
->在～/.bashrc中添加一句话: export LC_ALL=C
->apt-get install language-pack-zh-hans
```


## 查看python解释器位置

```
In [2]: import sys

In [3]: sys.executable
Out[3]: '/usr/local/opt/python@2/bin/python2.7'
```
