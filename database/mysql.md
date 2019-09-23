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
param = ''

try:
    cursor.execute(sql, param)
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
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '123';
或
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '123';
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