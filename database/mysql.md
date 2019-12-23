# mysql


## mysql安装

- ubuntu安装mysql

```
sudo apt-get install mysql-server
apt-get install mysql-client
sudo apt-get install libmysqlclient-dev
安装过程中会提示设置密码什么的，注意设置了不要忘了，安装完成之后可以使用如下命令来检查是否安装成功：
sudo netstat -tap | grep mysql
通过上述命令检查之后，如果看到有mysql 的socket处于 listen 状态则表示安装成功。
登陆mysql数据库可以通过如下命令: mysql -uroot -p 
```

- mac安装mysql

```
brew install mysql
brew unlink mysql
brew install mysql-connector-c
sed -i -e 's/libs="$libs -l "/libs="$libs -lmysqlclient -lssl -lcrypto"/g' /usr/local/bin/mysql_config
pip install MySQL-python
brew unlink mysql-connector-c
brew link --overwrite mysql
```

```
(1) 执行mysql报错

ERROR 1045 (28000): Access denied for user 'zhang'@'localhost' (using password: NO) 

1. 解决很简单，执行命令sudo mysql即可 
2. 或者执行命令，mysql -u root 
3. 再解决不了，我就不知道了啊，你可以按照下边的方便，卸载了重装。

关闭运行的mysqld

比较暴力的方式： 
查看mysql是否启动：ps -ef |grep mysql 
 
输入：kill -9 (./mysqld前面第二个数字，这里是627) 然后回车 
输入：ps -ef |grep mysql 就可以继续查看进程在不在： 



(2) 删除mysql

删除前请确认是不是已经关闭运行的mysql，看上面

brew remove mysql
brew cleanup
sudo rm /usr/local/mysql
sudo rm -rf /usr/local/var/mysql
sudo rm -rf /usr/local/mysql*
sudo rm ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
sudo rm -rf /Library/StartupItems/MySQLCOM
sudo rm -rf /Library/PreferencePanes/My*
launchctl unload -w~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
edit /etc/hostconfig and remove the line MYSQLCOM=-YES-
rm -rf ~/Library/PreferencePanes/My*
sudo rm -rf /Library/Receipts/mysql*
sudo rm -rf /Library/Receipts/MySQL*
sudo rm -rf /private/var/db/receipts/*mysql*



(3) 安装

1.执行
brew install mysql

2.最后启动
mysql.server start
```


## 查看mysql服务器版本

```
mysql> select @@version;
+-----------+
| @@version |
+-----------+
| 8.0.17    |
+-----------+
1 row in set (0.00 sec)
```


## mysql数据库操作

- 创建数据库

```
create database python_test_1 charset=utf8;
```

- 使用数据库

```
use python_test_1;
```

- 创建表

```
create table students(
	id int unsigned primary key auto_increment not null,
	name varchar(20) default '',
	age int unsigned default 0,
	gender enum('男','女','保密') default '保密',
	cls_id int unsigned default 0
) charset utf8;
```

```
注: 枚举字段默认值必须在枚举值中，否则会报错。如默认值是'保密'，则enum()的值中必须要有'保密'。
```

- 插入数据

```
insert into students(num,name,age,sex) values(1001,"李白",20,"男");
```

- 查询


```
使用旧版本group by报错解决方案:
报错:ERROR 1055 (42000): Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'work_ad.api_community_pic.id' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by
字面意思理解是sql_model=only_full_group_by限制了，导致在以往MYSQL版本中能正常查询的SQL，在新版本不能用了。


注意: 新版本group by注意事项如下:
在select指定的字段要么就要包含在Group By语句的后面，作为分组的依据；要么就要被包含在聚合函数中。

mysql> select sum(age) from students8 group by sex;
+----------+
| sum(age) |
+----------+
|       49 |
+----------+
1 row in set (0.00 sec)

mysql> select sex from students8 group by sex;
+------+
| sex  |
+------+
| 男   |
+------+
1 row in set (0.00 sec)

mysql> select * from students8;
+----+-----------+------+--------+------+
| id | name      | age  | cls_id | sex  |
+----+-----------+------+--------+------+
|  1 | 李白      |   25 |      2 | 男   |
|  2 | 李清微    |   24 |      1 | 男   |
+----+-----------+------+--------+------+
2 rows in set (0.00 sec)


或将新版限制去除，具体操作网上可查。
```

```
select * from students;
select name,age from students;
select name as '姓名',age from students;
select s.name from students as s;
select students.name from students;
select * from students where not(age>=18 and gender='女');
select * from students where name like '%小%';
select * from students where name like '__'; (查询有2个字的名字)
查询年龄为18或34的姓名:
select * from students where age=18 or age=34;
select * from students where age in (18,34);
查询年龄不在18到34之间的的信息:
select * from students where age not between 18 and 34; (包含两端)
查询年龄在18到34岁之间的男性，按照年龄从小到大到排序:
select * from students where (age between 18 and 34) and gender='男' order by age asc;
查询年龄在18到34岁之间的女性，身高从高到矮排序:
select * from students where (age between 18 and 34) and gender ='女' order by height desc;
查询年龄在18到34岁之间的女性，身高从高到矮排序, 如果身高相同的情况下按照年龄从小到大排序:
select * from students where (age between 18 and 34) and gender = '女' order by height desc,age asc;
查询男性有多少人 count(字段) 要注意如果值有null那么不会进行计算:
select count(*) from students where gender='男';
select max(height) from students where gender ='女';
select min(age) from students;
select sum(age) from students;
计算平均年龄:
select avg(age) from students;
select sum(age)/count(*) from students;
计算所有人的平均年龄，四舍五入保留2位小数:
select round (avg(age),2) from students;
计算每种性别中的人数:
select gender,count(*) from students group by gender;
查询同种性别中的姓名:
select gender,group_concat(name) from students group by gender;
查询平均年龄超过30岁的性别，以及姓名:
select gender ,avg(age) from students group by gender having avg(age) > 30;
查询前5个数据:
select * from students limit 0,5;
每页显示2个，显示第6页的信息, 按照年龄从小到大排序:
select * from students order by age asc limit 6,2;
查询所有对应班级的学生以及班级信息:
select * from students inner join classes on students.cls_id = classes.id;
按班级名字从小到大排序。处于同一个班级的学生，按照学生的id进行从小到大排序
select classes.name,students.* from students inner join classes on students.cls_id = classes.id order by classes.name asc,students.id asc;
```

```
分组用    group by 字段 (having 条件)
连接用    inner join 字段 on 条件,  left join 字段 on 条件,  right join 字段 on 条件
条件用    where
排序用    order by 字段名 desc(降序)/asc(升序)
分页用    limit 显示第几页,每页显示信息几条
```

- 运用查询的运算符

```
and
or
not
>
<
>=
<=
!=
<> #不等于
between and
not between and
in ()
not in ()
like
not like
like '李%'
like '李__'
is null
(asc 升序, desc 降序)
select * from students where(age between 18 and 35) order by age asc;
```

- 字符编码

    - 修改字符编码
    
    ```
    alter database 数据库名 character set utf8;
    alter table <表名> character set utf8;
    alter table <表名> change <字段名> <字段名> <类型> character set utf8;
    alter table user change username username varchar(20) character set utf8 not null;
    alter table photo add photo_owner varchar(30) character set utf8 not null;
    update article set article_author="ly" where article_id=1;
    alter table gbook add gbook_owner varchar(30) not null;
    ```
    - 查看字符编码
    
    ```
    SHOW CREATE DATABASE mofangdata;
    show create TABLE mf_organization_raw;
    ```
    - 报错解决
    
    ```
    # UnicodeDecodeError: 'ascii' codec can't decode byte 0xe5 in position 30: ordinal not in range(128)
    import sys reload(sys)
    sys.setdefaultencoding('utf-8')
    args = request.args.get("name")
    form = request.form.get("name")
    ```

- 从sql文件中导入数据

```
source 路径/文件名.sql
```

- 表中增加新字段

```
alter table students add cls_id int not null;
```

- 更改表中某一个字段的值

```
update students set cls_id=1 where name='李白';
```

- 聚合函数

```
max(age)
min(age)
sum(age)
count(*)
round(avg(age), 2) #保留两位小数
avg(age)
-------------------------------
select sex, count(*) from students group by sex;
```

- limit

```
(limit放在语句最后)
select * from students limit 0,2; #从第0+1条数据开始,读取2条数据
```

- 条件筛选语句

```
group by ... having ...
inner join ... on ...
where ...
-------------------------------
select sex, avg(age) from students group by sex having avg(age)>10;
```

- 连接查询

```
1) inner join ... on
select students.name,classes.name from students inner join classes on students.cls_id=classes.id;
select s.name,c.name from students as s inner join classes as c on s.cls_id=c.id;
select s.name,s.age,c.name from students as s inner join classes as c on s.cls_id=c.id order by s.age asc;

2) left join ... on #左边的表不管在右边的表中是否找到数据，都显示
select * from students left join classes on students.cls_id=classes.id;

3) right join ... on #右边的表不管在左边的表中是否找到数据，都显示
select * from classes right join students on students.cls_id=classes.id;
```

- 子查询

```
select * from students where age>(select avg(age) from students);
select * from students where cls_id in (select id from classes);
```


## python使用mysql

```
import MySQLdb

db = MySQLdb.connect(host=,port=,user=,passwd=,db=,charset="utf8")
cursor = db.cursor()
sql = """SQL语句"""
param = ['', ...]

try:
    cursor.execute(sql % param)
    db.commit()
except:
    db.rollback()

data = cursor.fetchone()

db.close()

接收返回结果行的函数:
cursor.fetchall()
cursor.fetchone()
cursor.fetchmany(size)
```


## mac下忘记mysql密码

```
Mac下忘记mysql密码: https://baijiahao.baidu.com/s?id=1575944821928606&wfr=spider&for=pc
```


## mac下更改密码

```

mysql连数据库的时候报错:
1251 client does not support authentication protocol requested by server;consider upgrading Mysql client
ERROR 1396 (HY000): Operation ALTER USER failed for 'root'@'localhost'


(1) 先登录mysql
mysql -u root -p
输入密码


(2)
mysql> use mysql;
mysql> select user,host from user;
+------------------+-----------+
| user             | host      |
+------------------+-----------+
| root             | %         |
| admin            | localhost |
| mysql.infoschema | localhost |
| mysql.session    | localhost |
| mysql.sys        | localhost |
| zhangj           | localhost |
+------------------+-----------+
注意我的root，host是'%'


(3) 执行
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';
或
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'root';
```


## 报错

```
ERROR 2002 (HY000): Can't content to local MySQL server through socket '/var mysql 启动不了
解决方法:
ps -A | grep -i mysql kill 列出来的进程
service mysql start

```


## flask框架对mysql数据库操作

```
https://blog.csdn.net/weixin_42750983/article/details/82431257
```


## 遇到的一些问题

```
kaiqigu@bogon:~|⇒  sudo mysql.server restart
Shutting down MySQL
.. SUCCESS! 
Starting MySQL
. ERROR! The server quit without updating PID file (/usr/local/var/mysql/bogon.pid).
kaiqigu@bogon:~|⇒  chmod -R 777 /usr/local/var/mysql/
kaiqigu@bogon:~|⇒  sudo mysql.server restart         
 ERROR! MySQL server PID file could not be found!
Starting MySQL
. SUCCESS! 
```

```
解决MySQL登录ERROR 1045 (28000): Access denied for user 'root'@'localhost' (using passwor)问题

1、首先停掉mysql 数据库 一般是安装在/etc/init,d/mysqld stop 

2、修改mysql的配置文件 /etc/my.cnf   
最后一行添加 skip-grant-tables 表示可以跳过权限去登录

3、重启 mysql 数据库 /etc/init,d/mysqld start

4、使用 mysql -u root -p

‘’回车“

表示没有密码 直接登录

5、修改 mysql 表里面的用户，为其设置密码。

update user set password=PASSWORD("rootadmin") where user='root';（修改root的密码）

6、删除 skip-grant-tables 

7.完成
```

```
kaiqigu@bogon:~|⇒  mysql.server restart
 ERROR! MySQL server PID file could not be found!
Starting MySQL
... ERROR! The server quit without updating PID file (/usr/local/var/mysql/bogon.pid).

kaiqigu@bogon:~|⇒  sudo rm /tmp/mysql.sock.lock

kaiqigu@bogon:~|⇒  mysql.server restart        
 ERROR! MySQL server PID file could not be found!
Starting MySQL
.. SUCCESS! 
```

## ER模型

```
1.Entry——实体（表） Relationship——关系

2.关系分三种类型：
    （1）一对一 		    1:1 			例子：一夫一妻制
    （2）一对多（多对一）	1:n(n:1)	    例子：皇帝的后宫
    （3）多对多 		    m:n 		    例子：学生选课
    
3.ER图
    三要素：实体（矩形）、关系（菱形）、属性（椭圆）

4.作图步骤
（1）确定所有的实体集合；
（2）选择实体集应包含的属性；
（3）确定实体集之间的联系；
（4）确定联系的类型，在用线将表示联系的菱形框联系到实体集时，在线旁注明是1或n或m来表示联系的类型。
```


## 事务

```
1.事务是什么？
MySQL事务主要用于处理操作量大，复杂度高的数据。


2.事务的特点：
在 MySQL 中只有使用了 Innodb 数据库引擎的数据库或表才支持事务。
事务处理可以用来维护数据库的完整性，保证成批的 SQL 语句要么全部执行，要么全部不执行。
事务用来管理 insert,update,delete 语句。


3.四大特性：
（1）原子性：一个事务（transaction）中的所有操作，要么全部完成，要么全部不完成，不会结束在中间某个环节。事务在执行过程中发生错误，会被回滚（Rollback）到事务开始前的状态，就像这个事务从来没有执行过一样。
（2）一致性：在事务开始之前和事务结束以后，数据库的完整性没有被破坏。这表示写入的资料必须完全符合所有的预设规则，这包含资料的精确度、串联性以及后续数据库可以自发性地完成预定的工作。
（3）隔离性：数据库允许多个并发事务同时对其数据进行读写和修改的能力，隔离性可以防止多个事务并发执行时由于交叉执行而导致数据的不一致。事务隔离分为不同级别，包括读未提交（Read uncommitted）、读提交（read committed）、可重复读（repeatable read）和串行化（Serializable）。
（4）持久性：事务处理结束后，对数据的修改就是永久的，即便系统故障也不会丢失。


4.操作事务:
（1）开启事务：BEGIN;或者 START  TRANSACTION;
（2）提交事务：COMMIT;
（3）回滚事务（撤销事务）：ROLLBACK;
（4）SAVEPOINT identifier; SAVEPOINT允许在事物中创建一个保存点(例: savepoint my_savepoint;)，一个事务可以有多个SAVEPOINT；
（5）RELEASE SAVEPOINT identifier; 删除一个事务的保存点，当没有指定的保存点时，执行该语句会抛出一个异常；
（6）ROLLBACK TO savepoint identifier; 把事务回滚到标记点（保存点）；
（7）SET TRANSACTION; 用来设置事务的隔离级别。InnoDB存储引擎提供事务的隔离级别有READ UNCOMMITTED、READ COMMITTED、REPEATABLE READ和SERIALIZABLE。

例：
mysql> start transaction;
Query OK, 0 rows affected (0.00 sec)

mysql> insert into students(name, age, cls_id) values('haha1', 2, 2);
Query OK, 1 row affected (0.01 sec)

mysql> savepoint my_123;
Query OK, 0 rows affected (0.00 sec)

mysql> insert into students(name, age, cls_id) values('haha2', 2, 2);
Query OK, 1 row affected (0.00 sec)

mysql> rollback to savepoint my_123;
Query OK, 0 rows affected (0.01 sec)

mysql> select * from students;
+----+-------+------+--------+
| id | name  | age  | cls_id |
+----+-------+------+--------+
|  1 | haha1 |    2 |      2 |
+----+-------+------+--------+
3 rows in set (0.00 sec)
```


## 索引

```
https://www.jianshu.com/p/0d6c828d3c70
```


## Ubuntu安装mysql未提示输入密码，安装后修改mysql默认密码

```
mysql默认密码为空
但是使用mysql -uroot -p 命令连接mysql时，报错
ERROR 1045 (28000): Access denied for user 'root'@'localhost' 
此时修改root的默认密码即可

1.进入到etc/mysql 目录下，查看debian.cnf文件
2.找到用户名，密码 ，使用此账号登录mysql
3.修改root用户的的密码
4.修改完密码，需要重启mysql
    /etc/init.d/mysql restart
5.再次登录
    mysql -u root -p 密码
    就ok了
```


## mysql卸载及重装

```
首先删除mysql:
sudo apt-get remove mysql-*

然后清理残留的数据
dpkg -l |grep ^rc|awk '{print $2}' |sudo xargs dpkg -P
它会跳出一个对话框，你选择yes就好了

然后安装mysql
sudo apt-get install mysql-client mysql-server 
安装的时候会提示要设置root密码，如果你没有在卸载的时候去清理残留数据是不会提示你去设置root密码的

检查mysql是不是在运行
sudo service mysql status 
一般安装完成之后都是会自动运行的。

如果没有运行你可以
sudo service mysql start 

查看端口
sudo netstat -tap | grep mysql 
```
