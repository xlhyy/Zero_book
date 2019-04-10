# 数据库开发

## 数据库概念

```
	1.什么是数据库？
		按照数据结构组织、存储和管理数据的仓库。
优势：持久化存储，优化读写，保证数据的有效性。	
	2.数据库的分类
		（1）关系型数据库——二元关系（二维表格）
		（2）非关系型数据库（NoSQL = Not only SQL 不仅仅是SQL）
```

# MySQL

## MySQL简介

```
	1.MySQL数据库简介
		MySQL是开源的，所以你不需要支付额外的费用。
		MySQL使用标准的SQL数据语言形式。
		MySQL支持大型数据库，支持5000万条记录的数据仓库，32位系统表文件最大可支持4TB，64位系统支持最大的表文件为8TB。
	
	2.RDBMS术语——关系型数据库管理系统
		数据库	——DATABASE（DB）
		数据表（表格）——TABLE
		列（字段、属性）——COLUMN
		行（数据、记录）——Data
		主键	—— Primary Key
		外键	—— 外键用于关联两个表
		复合键	—— 复合键（组合键）将多个列作为一个索引键，一般用于复合索引
		约束	—— 约束是表的数据列上的强制规则
		冗余	—— 存储两倍数据，冗余降低了性能，但提高了数据的安全性（数据冗余是指数据之间的重复，也可以说是同一数据存储在不同数据文件中的现象。）
```

## MySQL数据库环境搭建

```
	1.下载
		安装 .NET FrameWork 4.0
		官网下载
	2.安装	
		next安装，需配置端口号(3306)，设置管理员密码(root)
	3.配置
		开机自动启动服务
	4.开启服务
		（1）运行窗口输入services.msc，打开服务窗口
		（2）找到MySQL服务（MySql57），启动服务
	
	5.测试安装是否成功
		打开客户端之后输入密码，输入show databases;

	6.安装并破解可视软件
		解压navicat110_premium_cs_11.0.19.rar
		安装navicat110_premium_cs_x86.exe
		将压缩包中的navicat.exe替换到navicat110_premium_cs_x86.exe的安装路径下，完成破解
```

## 数据库操作

```
	1.显示所有数据库	—— show databases;
	2.创建数据库 —— create database 数据库名;
	3.删除数据库 —— drop database 数据库名;
	4.切换数据库 —— use 数据库名;
```

## 数据库基本数据类型

```
	1.整型 		int
	2.浮点型		float
	3.字符串		varchar(长度)弹性的字符串，不够长度自动用空格来补充
	4.枚举		enum('预设值1'，'预设值2'...)
知识点补充：
对于char varchar 这种固定长度的数据类型，需要在末尾的括号内写长度。例：create table user(id int,name varchar(50),age int);
char(长度),长度写多少，字符串就要写多长。
```

## 表格操作

```
	1.创建表格
		create table 表名( 列名  类型  【字段约束】,... );

	2.查看表结构
		desc 表名;

	3.删除表格
		drop table 表名;
	4.修改表名
		alter table 原表名 rename 新表名;
	5.修改默认字符集
		alter table 表名 default character set 新的字符集;

	6.添加字段
		alter table 表名 add 字段名 类型 【字段约束 after 字段】;

	7.删除字段
		alter table 表名 drop 字段名;
	8.修改字段名 
		alter table 表名 change 原字段名 新字段名  类型;
	9.修改字段属性
		alter table 表名 modify 原字段名 新类型【字段约束...】;
```

## 字段约束

```
	1.主键 			PRIMARY KEY 字段自动为非空
	2.非空 			NOT NULL
	3.自动递增 		AUTO_INCREMENT 字段必须设为主键
	4.默认值 		DEFAULT
	5.无符号			UNSIGNED 正数部分范围扩大一倍
	6.指定某一个字段的字符集 CHARACTER SET 
	7.唯一			UNIQUE
```

## 知识点补充

```
（1）UNIQUE 和 PRIMARY KEY 约束均为列或列集合提供了唯一性的保证。
（2）PRIMARY KEY 拥有自动定义的 UNIQUE 约束。
（3）请注意，每个表可以有多个 UNIQUE 约束，但是每个表只能有一个 PRIMARY KEY 约束。
（4）在一个表格里最多可以创建一个主键；当然创建逐渐的类型有两种，分为单一列作为主键和组合主键，其中组合主键就是两个列或多个列组合为主键，这在SQL数据操作中用的不是很多；主要记住主键的创建规则，唯一且不能为空。
```

## 数据操作

```
	1.添加数据
		INSERT INTO 表名【(字段1，字段2...)】 VALUES(值1，值2......);

由于第一列有自动添加的字段约束，所以当添加下一列数据时可以写为：(当添加第一行数据时也可以这么写)

也可以如下列这种方式添加：


	2.删除数据
		DELETE FROM 表名【WHERE 条件字段 = 值】; # 如果没写条件，则等于清空该表
	3.修改语句
		UPDATE 表名 SET 修改字段 = 修改值 WHERE 条件字段 = 值;

	4.查询语句
		（1）主句
			SELECT 字段名1【as 别名】 【，字段名2...】 FROM 表名;


注：此处的别名，加不加””都可以。
		（2）条件查询
			SELECT 字段 FROM 表名 WHERE 条件字段 = 值 【and/or 条件字段 = 值】;

		（3）模糊查询
			SELECT 字段 FROM 表名 WHERE 条件字段 LIKE 要匹配的值;
			(% 匹配n个字符，_ 匹配1个字符)



		（4）范围查询
			1.between...and… 查询连续的范围（包括边界值）
			SELECT 字段 FROM 表名 WHERE 条件字段 BETWEEN 值1 and 值2;
			2.in 查询不连续的范围
			SELECT 字段 FROM 表名 WHERE 条件字段 IN(值1，值2...);

知识点补充: != 与 <> 作用相同。
		（5）聚合查询
			1.计数		——count()


注:count()语句的括号内可以放列名或者*，但是无论是放列名还是放*都是显示你后面where字句的结果，但是放列名时，如果这个列名下有null那就不会计入总数里，所以还是有点区别的。括号内加条件能出来结果是因为系统把括号里面的东西当做是列名来使用了。

			2.求和	  	——sum()




3.求平均值	——avg()

			4.求最大值	——max()

			5.求最小值	——min()

知识点补充:select count(*) from student; 的作用是统计表中共有多少行数据。


		（6）分组查询
			SELECT 字段，【聚合查询】 FROM 表名 GROUP BY 要分组的字段 【having 条件字段 = 值】;



知识点补充：


		（7）排序
			SELECT 字段 FROM 表名 ORDER BY 要排序的字段 【DESC/ASC】;
			DESC 降序
			ASC或不写 升序

知识点补充：

		（8）受限查找（获取部分行/分页）
			SELECT 字段 FROM 表名 LIMIT 起始值，条数; 
```



## ER模型

```
	1.Entry——实体（表） Relationship——关系
	2.关系分三种类型：
		（1）一对一 		1:1 			例子：一夫一妻制
		（2）一对多（多对一）	1:n(n:1)	例子：皇帝的后宫
		（3）多对多 		m:n 		例子：学生选课
	3.ER图
		三要素：实体（矩形）、关系（菱形）、属性（椭圆）

	4.作图步骤
	（1）确定所有的实体集合；
	（2）选择实体集应包含的属性；
	（3）确定实体集之间的联系；
	（4）确定实体集的关键字，用下划线在属性上表明关键字的属性组合；例：s_id
	（5）确定联系的类型，在用线将表示联系的菱形框联系到实体集时，在线旁注明是1或n(多）来表示联系的类型。
```

## 多表查询

```
	1.等值连接查询
		SELECT 要显示的列 FROM 表1 【A（别名）】，表2 【B（别名）】【，表3 别名....】 WHERE A.属性=B.属性【AND 其他连接条件】【AND 其他条件】;
例：




2.内连接(效果等同于等值连接查询)
		获取两个表中字段匹配关系的记录。
		SELECT 要显示的列 FROM 表1 【A（别名）】 【INNER】 JOIN 表2 【B（别名）】 ON A.属性=B.属性;


		注意：三表或以上表格连接时，需要逐个去连接，表1必须是多表的关系表

	3.外连接(如果需要左/右表所有记录，就用左/右连接)
		（1）左连接
		SELECT 要显示的列 FROM 表1 【A（别名）】 LEFT JOIN 表2 【B（别名）】 ON A.属性=B.属性;
		（2）右连接
		SELECT 要显示的列 FROM 表1 【A（别名）】 RIGHT JOIN 表2 【B（别名）】 ON A.属性=B.属性;

	4.子查询(嵌套查询)：将一个查询语句作为另一个查询语句的条件，嵌套SQL语句中
```

## 事务

```
	1.事务是什么？
		MySQL事务主要用于处理操作量大，复杂度高的数据。
	2.事务的特点
	在 MySQL 中只有使用了 Innodb 数据库引擎的数据库或表才支持事务。
	事务处理可以用来维护数据库的完整性，保证成批的 SQL 语句要么全部执行，要么全部不执行。
	事务用来管理 insert,update,delete 语句
	3.四大特性：
		（1）原子性：一个事务（transaction）中的所有操作，要么全部完成，要么全部不完成，不会结束在中间某个环节。事务在执行过程中发生错误，会被回滚（Rollback）到事务开始前的状态，就像这个事务从来没有执行过一样。
		（2）一致性：在事务开始之前和事务结束以后，数据库的完整性没有被破坏。这表示写入的资料必须完全符合所有的预设规则，这包含资料的精确度、串联性以及后续数据库可以自发性地完成预定的工作。
		（3）隔离性：数据库允许多个并发事务同时对其数据进行读写和修改的能力，隔离性可以防止多个事务并发执行时由于交叉执行而导致数据的不一致。事务隔离分为不同级别，包括读未提交（Read uncommitted）、读提交（read committed）、可重复读（repeatable read）和串行化（Serializable）。
		（4）持久性：事务处理结束后，对数据的修改就是永久的，即便系统故障也不会丢失。
		
	4.操作事务
（1）开启事务：BEGIN;或者 START  TRANSACTION;
		（2）提交事务：COMMIT;
		（3）回滚事务（撤销事务）：ROLLBACK;
例：


		（4）SAVEPOINT identifier; SAVEPOINT允许在事物中创建一个保存点，一个事务可以有多个SAVEPOINT；
		（5）RELEASE SAVEPOINT identifier; 删除一个事务的保存点，当没有指定的保存点时，执行该语句会抛出一个异常；
		（6）ROLLBACK TO identifier; 把事务回滚到标记点（保存点）；
		（7）SET TRANSACTION; 用来设置事务的隔离级别。InnoDB存储引擎提供事务的隔离级别有READ UNCOMMITTED、READ COMMITTED、REPEATABLE READ和SERIALIZABLE。
```


## 索引

```
	1.什么是索引？
		比作数据库的目录，索引是对数据库表中一列或多列的值进行排序的一种结构
		优点：提高检索速度
		缺点：增加了数据操作的繁琐度。

	2.针对什么去创建索引？
		1、表的主键、外键必须有索引；（外键用于与另一张表的关联。是能确定另一张表记录的字段，用于保持数据的一致性。比如，A表中的一个字段，是B表的主键，那他就可以是A表的外键。）
		2、数据量超过300的表应该有索引；
		3、经常与其他表进行连接的表，在连接字段上应该建立索引；
		4、经常出现在Where子句中的字段，特别是大表的字段，应该建立索引；
		5、索引应该建在选择性高的字段上；
		6、索引应该建在小字段上，对于大的文本字段甚至超长字段，不要建索引；
		7、频繁进行数据操作的表，不要建立太多的索引；
		8、删除无用的索引，避免对执行计划造成负面影响； 

	3.创建索引
		（1）创建普通索引
			CREATE INDEX 索引名 ON 表名(字段名【(长度)】);

		（2）创建唯一索引（索引名唯一）
			CREATE UNIQUE INDEX 索引名 ON 表名（字段名【(长度)】）;

知识点补充：int类型的字段后面不用加长度，varchar类型的字段后面需要加长度。与创建表时情况相同。
		（3）创建表时添加索引
			在建表语句后加  INDEX 索引名 (字段名【(长度)】)
		（4）使用ALTER语句添加索引
			ALTER TABLE 表名 ADD INDEX 索引名 (字段名【(长度)】) 
	4.删除索引
		DROP INDEX 【索引名】 ON 表名;
```

	
## 练习

```
1.使用事务添加数据
2.查询所有选择Python课程的学生姓名

3.查询所有选择C++ 课程的学生信息与分数


4.计算某学生的总分与平均分数（用id分组比用name好,因为id不可能重复）
知识点补充：

5.将学生按照总分进行排榜

6.查询所有学生的选课情况

7.使用子查询查询数据库课程没有达到平均分的同学情况

8.计算各科成绩总分、平均分以及选课的人数

9.查询全部老师的任课情况
```


## MySQL内置函数
```
	1.字符串函数
		（1）查看字符的ascii码值ascii(str)，str是空串时返回0
			SELECT ascii(str);//显示第一个字符的码值
		（2）查看ascii码值对应的字符	
			SELECT char(num);
		（3）字符串拼接
			SELECT concat(值1，值2...);//值都作为字符串看待
			例：

		（4）字符串长度
			SELECT length(str);
知识点补充：汉字和英文长度不同（不是一定的，由字符集(编码格式)决定）
		（5）截取子字符串
			SELECT substring('要截取的字符串',起始下标，截取长度);//下标从1开始
		（6）去除左右两边字符
			SELECT trim(str);//去除左右两边空格
			SELECT trim(leading/both/trailing 'char' from 'str');
		**********
		（7）返回由n个空格字符组成的一个字符串
space(n)
		（8）替换字符串
replace(str,from_str,to_str)
		（9）大小写转换
select lower('aBcD');
select upper('aBcD');

	2.数学函数
		（1）四舍五入
			SELECT round(值,保留小数位数);
			例：

		（2）x的y次幂
			SELECT pow(x,y);
		**********
（3）求m除以n的余数mod(m,n)，同运算符%
			select mod(10,3);
select 10%3;
		（5）地板floor(n)，表示不大于n的最大整数
			select floor(2.3);
		（6）天花板ceiling(n)，表示不小于n的最大整数
			select ceiling(2.3);
		（7）获取圆周率PI()
			select PI();
		（8）随机数rand()，值为0-1.0的浮点数
			select rand();
（9）还有其它很多三角函数，使用时可以查询文档
		
	3. 日期时间函数
		**********
		（1）当前日期时间now()
select now();
（2）获取子值
year(date)返回date的年份(范围在1000到9999)
month(date)返回date中的月份数值
day(date)返回date中的日期数值
hour(time)返回time的小时数(范围是0到23)
minute(time)返回time的分钟数(范围是0到59)
second(time)返回time的秒数(范围是0到59)
select year('2016-12-21');
select hour('03:12:21');
（3）日期计算，使用+-运算符，数字后面的关键字为year、month、day、hour、minute、second
select '2016-12-21'+interval 1 day;
（4）日期格式化date_format(date,format)，format参数可用的值如下
*  获取年%Y，返回4位的整数
*　获取年%y，返回2位的整数
*　获取月%m，返回2位的整数
*  获取日%d，返回2位的整数
select date_format('2016-12-21','%Y %m %d');
（5）时间格式化time_format(date,format)，format参数可用的值如下
*　获取时%H，值为2位的0-23的整数
*　获取时%h，值为2位的1-12的整数
*　获取分%i，值为2位的0-59的整数
*　获取秒%s，值为2位的0-59的整数
Select time_format('20:12:23', '%H %i %s');
（6）当前日期current_date()
select current_date();
（7）当前时间current_time()
select current_time();
```

## MySQL与Python交互

```
	1.交互
	（1）交互准备
		1.windows安装python，并配置环境变量
		2.在线安装pymysql 
			python -m pip install pymysql
		3.测试pymysql是否安装成功，直接进入脚本，import pymysql没有错误即可
	（2）获取连接
		conn = pymysql.connect(参数)
		参数:
			host:数据库IP地址
			port:mysql数据库端口号（3306）
			db:数据库名
			user:用户名(root)
			password:密码(root)
			charset:编码字符集(gb2312)

	（3）从连接中获取cursor对象
		cs = conn.cursor()

	（4）通过cursor对象来执行SQL语句
		cs.execute(SQL语句)
	
	（5）获取执行语句后的结果集
		cs.fetchone()	//获取首条记录
		cs.fetchall()	//获取全部记录，返回元组

	（6）需要提交事务，并关闭连接
		conn.commit()
		conn.close()
	2.SQL语句参数化
		在使用execute语句时，可将条件参数化，方便未来的查询	
	  	sname = input("")
	  	params =[sname]
	   	cs.execute("select * from students where s_name = %s",params)
	3.操作封装
		封装基础函数，再将其他功能函数按需求进行封装
```

## 练习

```
（1）MySQLHelper.py
import pymysql

# conn = pymysql.connect(host='127.0.0.1' , port= 3306 , db='student_system' , user='root' , password='root',charset = 'gb2312')
#
# cursor = conn.cursor()
# cursor.execute("select * from students where s_name = ?")
# conn.commit()
#
# result = cursor.fetchone()
# # result = cursor.fetchall()
#
# print(type(result))
# print(result)
#
#cursor.close()
# conn.close()

class MySQLHelper():
    def __init__(self,host,port,db,user,password,charset):
        self.host = host
        self.port = port
        self.db = db
        self.user =user
        self.password= password
        self.charset= charset

    def getConn(self):
        self.conn=pymysql.connect(host=self.host,port=self.port,db=self.db,user=self.user,password=self.password,charset=self.charset)
        self.cursor= self.conn.cursor()

    def closeConn(self):
        self.cursor.close()
        self.conn.close()

    def query_one(self):
        result = self.cursor.fetchone()
        return result

    def query_all(self):
        result = self.cursor.fetchall()
        return result

    def executeSQL(self,sql,params):
        self.cursor.execute(sql,params)
        self.conn.commit()

    def select(self, sql, params=()):
        self.executeSQL(sql, params)

    def insert(self, sql, params=()):
        self.executeSQL(sql, params)

    def delete(self, sql, params=()):
        self.executeSQL(sql, params)

    def update(self, sql, params=()):
        self.executeSQL(sql, params)

（2）Main.py
import MySQLHelper,time

def main():
    myhelper = MySQLHelper.MySQLHelper('127.0.0.1',3306,'userdb','root','root','utf8')
    myhelper.getConn()

    print('1.用户注册')
    print('2.用户登录')
    choose = input('<< ')

    if choose == '1':
        register(myhelper)
    elif choose == '2':
        load(myhelper)

    myhelper.closeConn()

def register(myhelper):
    while True:
        username = input('请输入用户名:')
        sql = 'select * from users where username = %s'
        params = [username]
        myhelper.select(sql, params)
        if not myhelper.query_one():
            print('用户名可以使用')
            time.sleep(1)
            break
        else:
            print('用户名已存在，请重新输入')
            time.sleep(1)

    while True:
        password = input('请输入密码:')
        password_again = input('请再次输入密码:')
        if password == password_again:
            sql = 'insert into users(username,password) values(%s,%s)'
            params = [username, password]
            myhelper.insert(sql, params)
            print("注册成功")
            break
        else:
            print('两次密码输入有误，请重新输入')
            time.sleep(1)

def load(myhelper):
    username = input('请输入用户名:')
    password = input('请输入密码:')
    sql = 'select password from users where username = %s'
    params = [username]
    myhelper.select(sql, params)
    password_true = myhelper.query_one()

    if password_true:
        if password == password_true[0]:
            print('登录成功')
        else:
            print('密码错误')
    else:
        print('用户名不存在')

if __name__ == "__main__":
    main()
```


## NoSQL简介

```
	1.优点
		高可扩展性
		分布式计算
		低成本
		架构的灵活性，半结构化数据
		没有复杂的关系
	2.缺点
		没有标准化
		有限的查询功能（到目前为止）
		最终一致是不直观的程序
	3.NoSQL的分类：
		（1）列存储
		（2）文档存储	例：MongoDB
		（3）key-value存储	例：Redis
		（4）图存储
		（5）对象存储
		（6）xml数据库
```

# Redis

## Redis简介

```
	1.Redis是一款可基于内存也可持久化的一款数据库，key-value数据库
	2.Redis作者：Salvatore Sanfilippo（塞尔瓦托·圣菲利波）
	3.Redis资助公司：VMware,Pivotal
	4.Redis的优势
		Redis支持数据的持久化，可以将内存中的数据保存在磁盘中，重启的时候可以再次加载进行使用。
		Redis不仅仅支持简单的key-value类型的数据，同时还提供list，set，zset，hash等数据结构的存储。
		Redis支持数据的备份，即master-slave模式的数据备份。
		性能极高,官方benchmark测试在50个并发执行100000个请求测试中,Redis能读的速度是110000次/s,写的速度是81000次/s。
		丰富的数据类型，Redis支持二进制案例的 Strings, Lists, Hashes, Sets 及 Sorted Sets 数据类型操作。
		原子，Redis的所有操作都是原子性的，同时Redis还支持对几个操作全并后的原子性执行。
		丰富的特性，Redis还支持publish/subscribe（订阅）, 通知, key 过期等等特性
	5.Redis的数据类型
		1.string（字符串）：
string类型是二进制安全的。意思是redis的string可以包含任何数据。比如jpg图片或者序列化的对象 。
string类型是Redis最基本的数据类型，一个redis中字符串value最多可以是512M
		2.hash（哈希）：
			hash 是一个键值对集合。
hash是一个string类型的field和value的映射表，hash特别适合用于存储对象。
		3.list（列表）：
Redis 列表是简单的字符串列表，按照插入顺序排序。你可以添加一个元素导列表的头部（左边）或者尾部（右边）。
它的底层实际是个链表
		4.set（集合）：
Redis的Set是string类型的无序集合。它是通过HashTable实现实现的，
		5.zset(sorted set：有序集合)：
Redis zset 和 set 一样也是string类型元素的集合,且不允许重复的成员。不同的是每个元素都会关联一个double类型的分数。
redis正是通过分数来为集合中的成员进行从小到大的排序。zset的成员是唯一的,但分数(score)却可以重复。
```

## Redis的环境安装

```
	1.windows下安装配置redis
		（1）解压redis到指定位置
		（2）redis-server.exe	——	服务端
		     redis-cli.exe	——	客户端
		     redis.windows.conf ——	配置文件	
			port 6379
			slaveof 主从配置
		     dump.rdb		—— 	生成的数据库文件

		（3）配置环境变量
			新建系统变量 ：REDIS_HOME
			path变量后追加：%REDIS_HOME%;
		
		（4）启动服务端
			redis-server.exe (redis.windows.conf)	——	以该文件夹下的配置文档启动数据库（如果没加redis.windows.conf，按照系统变量中的文件路径下的配置文档启动数据库）
			注意：服务窗口不能关闭
		
		（5）启动客户端
			redis-cli.exe	(-h 主机号 -p 端口号)
		
		（6）挂载系统服务
			进入要挂载服务的路径下
			redis-server --service-install redis.windows.conf
		
		（7）启动服务
			redis-server --service-start
		
		（8）终止服务（windows）
			redis-cli shutdown
	
	2.Linux下安装配置redis
		（1）解压并复制
			在usr/local目录下创建文件夹 redis
				sudo mkdir redis
			文件放在桌面,然后进行解压
				tar zxvf redis的压缩包
			复制到刚刚创建好的文件夹下
				sudo mv redis-4.0.6/* /usr/local/redis
		（2）进入目录，执行生成命令
			cd /usr/local/redis
			sudo make
			sudo make test 
			sudo make install
		（3）启动服务端，启动客户端
			启动服务端：redis-server	
			启动客户端：redis-cli
```

## 数据操作

```
		1.string
			（1）设置键值（覆盖原键值对）	——   set key value
			（2）获取值			——   get key
			例：设置、获取键值

			（3）设置键值并设置过期时间	——   setex key seconds value

			注：赋值时不必强调类型，系统会智能识别。
例：赋值aaaa和’hello123’时，都为字符串；赋值111和’123’这种纯数字或者纯数字字符串时，都视为int型（实际上还是字符串），可以进行运算。
			（4）设置多个键值		——   mset key1 value （key2 value...）

			（5）获取多个键值		——   mget key1 key2...

			（6）计算 要求：值是纯数字
				自增1			——   incr key

				自增任意整数		——   incrby key num

				自减1 			——   decr key
				自减任意整数		——   decrby key num
			（7）追加字符串			——   append key str

			（8）获取值长度			——   strlen key


		2.键命令
			（1）检索键			——   keys pattern  	?表示1位 *表示n位，例如：keys *

			（2）判断键是否存在，如果存在返回非0，不存在返回0
							——   exists key1 （key2...）

			（3）查看键对应的value的类型	——   type key

			（4）删除键和对应的值		——   del key1 (key2...)
			（5）清空键值			——   flushall

			（6）设置过期时间，以秒为单位，创建时没有设置过期时间则一直存在，直到使用使用DEL移除
							——   expire key seconds

			（7）查看有效时间		——   ttl key	
			注：>= 0时，代表有效时间还有多久；-2代表不存在；-1代表一直存在；


		3.hash	
			（1）设置单个属性		——   hset key field value
			（2）设置多个属性		——   hmset key field1 value （field2 value...）
			例：设置单个及多个属性

			（3）获取单个属性		——   hget key field
			（4）获取多个属性		——   hmget key field1 (field2...)
			（5）获取所有属性和对应的值	——   hgetall key
			例：获取单个、多个、所有属性和对应的值

			（6）获取所有属性名		——   hkeys key

			（7）获取属性个数		——   hlen key

			（8）获取所有属性值		——   hvals key

			（9）判断属性是否存在		——   hexists key field

			（10）删除属性			——   hdel key field1 (field2...)

			（11）获取值的字符串长度函数		——   hstrlen key field
			注：本机的redis版本过低，无法使用该函数
```


## list（底层为双向链表）

```
（lpush-rpop 先进先出 模拟队列	lputh-lpop 先进后出 模拟栈）
（1）列表的元素类型为string
（2）按照插入顺序排序
（3）在列表的头部或者尾部添加元素

	1.从头部(左边)添加数据
		LPUSH key value1 value2...
	2.从尾部(右边)添加数据
		RPUSH key value1 value2...
	3.获取所有数据
		LRANGE key start stop //-1代表倒数第一个元素
例：

	4.插入数据
		LINSERT key BEFORE/AFTER 元素 value

	5.替换指定下标的元素
		LSET key index value

	6.左弹出第一个元素
		LPOP key 

	7.右弹出第一个元素
		RPOP key
	8.裁剪列表（切片）
		LTRIM key start stop

	9.获取列表元素个数（长度）		
		LLEN key

	10.查看列表某下标的对应元素
		LINDEX key index
```


## set

```
（1）无序集合
（2）元素为string类型
（3）元素具有唯一性，不重复
（无序：不能通过下标进行索引；存入和存储顺序不一定相同）

	1.添加元素
		SADD key value1 value2...
	2.获取所有元素
		SMEMBERS key
例：

	3.获取元素个数
		SCARD key

	4.产生交集
		SINTER key1 key2...

	5.求某集合与其它集合的差集，本集合中除去与其他集合相同的部分
		SDIFF key1 key2...

	6.求合集（产生的合集也是set类型，去掉了重复数据）
		SUNION key1 key2...

	7.判断元素是否在集合中
		SISMEMBER key value
```


## zset（sorted set）

```
（1）sorted set，有序集合
（2）元素为string类型
（3）元素具有唯一性，不重复
（4）每个元素都会关联一个double类型的score，表示权重，通过权重将元素从小到
大排序
（5）元素的score可以相同

	1.添加元素（分数可以重复，元素不能重复，分数可用小数）
		ZADD key score value score value ...
	2.获取元素
		ZRANGE key start stop [withscores]	//正序
		ZREVRANGE key start stop [withscores]	//倒序

	3.返回元素个数
		ZCARD key

	4.返回在分数段中的元素个数(包括min和max)
		ZCOUNT key min max

	5.查看某元素的score值
		ZSCORE key value
```


## 发布订阅

```
	1.什么是发布订阅？
		Redis 发布订阅(pub/sub)是一种消息通信模式：发送者(pub)通过频道发送消息，订阅者(sub)通过频道接收消息。
	2.使用场景
		广播、群聊、博客博主推送博文，订阅者同时接收到博文更新的消息、直播
	3.实现原理
		发送者(pub)通过频道发送消息，订阅者(sub)通过频道接收消息。
	4.操作命令
		（1）订阅一个或多个频道
			subscribe channel channel

		（2）订阅多个匹配频道（需要正则表达式）
			psubscribe channel*
		（3）发布订阅
			publish channel message

		（4）取消订阅（客户端无法模拟取消订阅，因为客户端在订阅之后一直在等待接收消息，没法进行取消订阅操作）
			unsubscribe channel
```

## Redis事务

```
	1.Redis 事务可以一次执行多个命令
	2.事务操作命令
		（1）开启事务
			MULTI
		（2）执行事务
			EXEC

		（3）取消事务（回滚）
			DISCARD

		（4）监视key，如果在事务执行之前这个(或这些) key 被其他命令所改动，那么事务将被打断
			WATCH key key2...

		（5）取消监视
			UNWATCH
```


## Redis安全

```
	1.密码设置
		（1）设置密码
			CONFIG set requirepass 密码
		（2）取消密码
			CONFIG set requirepass “”
		（3）输入密码
			AUTH 密码
		（4）查看redis的密码状况
			CONFIG get requirepass

	2.数据的备份以及恢复（数据的导入与导出）
		（1）数据备份，会在服务端目录下生成dump.rdb文档
			SAVE
		例：模拟数据丢失

		（2）将生成的dump.rdb文档替换回路径，然后重启服务
```


## redis实际应用场景

```
	1.排行榜
		使用原理：使用zset数据类型记录分数和实体，使用zrange通过分数进行排行显示

漏洞：如果实体重名则无法存入到zset中，因为zset数据不能有重复数据
	2.计数
		使用原理：使用string数据类型，值存计数，然后使用incr进行数值自增，实现下载量或浏览次数
	3.消息队列
		使用原理：使用list数据类型与lpush-rpop模拟队列，遇到阻塞状态使用brpop
		解决：生产者消费者模式、订阅和发布模式

知识点补充：
（1）生产者消费者模式：生产者生产数据到缓冲区中，消费者从缓冲区中取数据。
如果缓冲区已经满了，则生产者线程阻塞；
如果缓冲区为空，那么消费者线程阻塞。
```



## 主从配置

```
	1.作用
		（1）主从复制：主数据库将数据备份到从数据库中，保证数据一致性
		（2）读写分离：主数据库可以进行写和读，然后从数据库进行读取，不能擅自更改数据库中的数据
	应用实例：分布式系统
	
	2.原理
		（1）当一个从数据库启动时，会向主数据库发送sync（同步请求）命令，
		（2）主数据库接收到sync命令后会开始在后台保存快照（执行rdb操作），并将保存期间接收到的命令缓存起来
		（3）当快照完成后，redis会将快照文件和所有缓存的命令发送给从数据库。
		（4）从数据库收到后，会载入快照文件并执行收到的缓存的命令。

	3.步骤
		（1）在从机目录下打开配置文件，写slaveof <masterip> <masterport>
		（2）打开从机服务端，自动连接主机
		（3）打开从机客户端，查看数据是否与主机一致
	
	4.哨兵作用——实现自动主从机切换
		（1）监听Master状态（是否正常运行）
		（2）如果Master运行异常，从全部从机中随机选择一个从机作为主机，并将其他从机改变从属目标，并且哨兵的监视对象变为现在的主机。
		（3）如果原主机恢复正常运行，原主机将会变成从机。
	
	5.哨兵配置（自动主从切换）
		（1）主数据库目录中创建一个sentinel.conf配置文档
		（2）配置文档中输入sentinel monitor 主机名 主机IP 主机端口号 投票数
		（3）打开主机服务端，打开从机服务端
		（4）打开一个窗口运行哨兵 redis-server sentinel.conf --sentinel
		（5）关闭主数据库服务端，测试结果
	
	6.注意
		主从配置使用哨兵时，无论数据库是主数据库还是从数据库，都要在目录下配置哨兵文件，并将哨兵监视IP指向自身
```

## python与redis交互

```
		1.pip安装redis模块
		2.导入redis模块
		3.获取连接，redis.StrictRedis()函数
		4.操作数据直接使用redis操作命令对应API
		5.获取出来的值（字节码），需要decode()解码
		6.封装
```

## 实例练习1：用户登陆

```
（1）RedisHelper.py
import redis

class RedisHelper(object):
    def __init__(self, host, port):
        self.host = host
        self.port = port

    def getConn(self):
        self.r = redis.StrictRedis(host=self.host, port=self.port)

    def isExists(self,key):
        return self.r.exists(key)

    def insert(self,key,value):
        self.r.set(key,value)

    def getValue(self,key):
        return self.r.get(key).decode()

（2）Main.py
import RedisHelper

def register(rh):
    username = input("请输入用户名")
    if rh.isExists(username):
        print("账号已存在")
    else:
        while True:
            password=input("请输入密码")
            password_agian =input("请再次输入密码")
            if password == password_agian:
                rh.insert(username,password)
                print("注册成功")
                break
            else:
                print("两次密码输入有误，请重新输入")

def login(rh):
    while True:
        username = input("请输入用户名")
        password = input("请输入密码")
        if rh.isExists(username):
            pwd = rh.getValue(username)
            if pwd == password:
                print("登录成功")
                break
            else:
                print("密码错误")
        else:
            print("用户名不存在")

def main():
    rh = RedisHelper.RedisHelper('127.0.0.1',6379)
    rh.getConn()
    choose = input("1.注册 2.登录")
    if choose == '1':
        register(rh)
    elif choose =='2':
        login(rh)
    else:
        print("选择有误")

if __name__ == '__main__':
main()

实例练习2：简易消息队列
import redis

class Task():
	def __init__(self):
		self.r=redis.StrictRedis(host="localhost",port=6379)
		#这种连接写法比较推荐
		self.queue = 'list'

	def listen_task(self):
		while True:
			task = self.r.brpop(self.queue,60)[1]
			print(task.decode())
		
if __name__ =='__main__':
	Task().listen_task()

注：可以使用cmd窗口开启一个redis-cli，进行数据的添加。

实例练习3：实现发布订阅功能
#!/usr/bin/env python
#-*- coding:utf-8 -*-  
import redis  
  
class RedisHelper(object):  
    def __init__(self): 
	#连接Redis 
        self.__conn = redis.Redis(host='127.0.0.1',port=6379)
		#连接的另一种写法
        self.channel = '98.6' #定义名称  
  
    #def publish(self,msg):#定义发布方法  
    #    self.__conn.publish(self.channel,msg)  
    #    return True  
  
    def subscribe(self):#定义订阅方法  
        pub = self.__conn.pubsub() # 获取订阅权限
# pub是一个subscribe订阅对象
# 例：<redis.client.PubSub object at 0x0264B8B0>
        pub.subscribe(self.channel) # 进入接收订阅的状态
        pub.parse_response() # 解析出来的是subscribe的信息
						  # 例：[b'subscribe', b'98.6', 1]
# 解析后pub没有变，仍然是同一个subscribe订阅对象
		# 例：<redis.client.PubSub object at 0x0264B8B0>
        return pub  

def main():
	rh = RedisHelper()
	#rh.publish("hello")
	sub=rh.subscribe()
	while True:
		print(sub.parse_response()[2].decode()) # 解析出来的是message的信息
										 # 例：[b'message', b'98.6', b'hello']
		#sub仍然仍然是同一个subscribe订阅对象
	
if __name__ =='__main__':
	main()
```

# MongoDB

## MongoDB简介（由C++编写）

```
	1.MongoDB特点：
		（1）模式自由：可以把不同结构的文档存储在同一个数据库里
		（2）面向集合的存储：适合存储JSON风格文件的形式（键值对）
		（3）完整的索引支持：对任何属性可索引
		（4）复制和高可用性：支持服务器之间的数据复制，支持主-从模式及服务器之间的相互复制。复制的主要目的是提供冗余及自动故障转移
		（5）自动分片：将数据分散到水平服务器上进行存储，节省存储空间，提高查询速度。（例：分布式系统）（分片：是指将数据拆分，将其分散到不同的机器上。）
		（6）高效的传统存储方式：支持二进制数据及大型对象（如照片或图片）

	2.MongoDB概念：
		（1）数据库	——	database
		（2）集合（表）	——	collection
		（3）文档（行）	——	document
		（4）域（列）	——	field
		（5）索引	——	index
		（6）主键	——	primary key
```

## MongoDB安装（默认端口号 27017）

```
	1.下载MongoDB
		偶数为稳定版本，奇数为开发版本
	2.next安装MongoDB
	3.配置环境变量
		（1）MONGODB_HOME: mongodb目录下的server\3.2\bin
		（2）path追加：%MONGODB_HOME%;
	4.开启服务端
		新建一个数据库数据存储目录
		mongod --dbpath 存储目录路径
	5.开启客户端
		mongo [服务端IP]
```

## 数据类型

```
	Object ID：文档ID
	String：字符串，最常用，必须是有效的UTF-8
	Boolean：存储一个布尔值，true或false
	Integer：整数可以是32位或64位，这取决于服务器
	Double：存储浮点值
	Arrays：数组或列表，多个值存储到一个键
	Object：用于嵌入式的文档（文档里面存文档），即一个值为一个文档
	Null：存储Null值
	Timestamp：时间戳
	Date：存储当前日期或时间的UNIX时间格式
```

## MongoDB简单操作

```
	1.数据库操作
		（1）创建（切换）数据库，数据库中存在数据才会形成数据库
			use 数据库名
		（2）查看全部数据库
			show dbs

注：创建集合之后，数据库才有实体
		（3）删除已指定的数据库（当前的数据库）
			db.dropDatabase()

		（4）查看当前数据库名称
			Db

		
	2.集合操作
		（1）创建集合
			db.createCollection(集合名[，集合配置])
 
	注：集合名要加引号;
		直接向集合插入数据也可以创建集合；
		（2）删除集合
			db.集合名.drop()

		（3）查看所有集合
			show collections


	3.文档操作
		（1）插入文档
			db.集合名.insert({文档内容})

		（2）删除文档
			db.集合名.remove({查询条件：值}[,{justOne:<boolean>}])

		（3）查询文档
			db.集合名.find({查询条件：值})

		（4）修改文档
			db.集合名.update({查询条件：值},{修改后的文档}[,{multi:<boolean>}]) //multi为true 批量修改

注：修改时，后面要写全，不然会把之前的全部语句改成输入的值。
			$set ：指定某个属性修改
```

```
例1：修改指定属性


例2：修改所有指定属性

		（5）保存文档
			db.集合名.save()	//如果数据存在则修改，如果数据不存在则创建


	4.文档查询
		（1）查询所有
			db.集合名.find()
			db.集合名.find({})
		（2）只返回第一条数据
			db.集合名.findOne({查询条件：值})
		（3）将查询结果格式化
			在查询结果函数后调用.pretty()
例：查询所有、条件查询、只查询符合条件的第一条数据、查询结果格式化

		（3）逻辑运算
			and：
				同一个属性，例如查年龄段
				db.集合名.find({age:{$gt:18,$lt:22}})
				不同属性
				db.集合名.find({age:{$gt:18},sex:'女'})
			or:
				db.集合名.find({$or:[{age:{$gt:18}},{age:{$lt:16}}]})
例：两个属性逻辑或、同一个属性中逻辑或

		（4）比较运算符
			大于：$gt 	大于等于：$gte
			小于：$lt	小于等于：$lte
			不等于：$ne


		（5）范围运算符
			db.集合名.find({age:{$in:[18,20]}})
			$in：查询所有符合[]中的值的文档
			$nin：查询不符合[]中的值的文档

		（6）自定义查询
			db.集合名.find({$where:
			function(参数列表)
				{
					函数体...
				}
			})

		（7）模糊查询
			db.集合名.find({name:{$regex:'x'}})	
			db.集合名.find({name:/x/})		//name带有x的所有文档,^x代表以x开头

		（8）受限查询
			db.集合名.find({查询条件：值}).skip(num).limit(num)
			skip()：跳过多少条
			limit()：查询多少条
例：查询3条、从全部中跳过3条之后输出、从全部中跳过3条之后查询2条

		（9）投影	
			find({查询条件：值},{想显示的列：1})	//1显示 0不显示
			默认情况下 _id是显示状态

		（10）排序
			find().sort({要排序的属性:1})	//1代表正序 -1代表倒序

		（11）统计
			find({查询条件：值}).count()
			count({查询条件：值})

		（12）去重
			distinct(去重字段,{条件})
```


## 聚合

```
	1.聚合函数
	2.管道
	3.表达式
```


## 聚合

```
	1.聚合语法
		db.集合名.aggregate([
		{管道1:{表达式}},
		{管道2:{表达式}},
				...
		])

	2.表达式

		（1）$sum		——	求和	$sum:1代表计数功能，和Count功能相同

		（2）$avg		——	求平均值

		（3）$max（min）		——	求最大值（最小值）

		（4）$push		——	将查询后字段中的值加入到一个列表中显示

		（5）$first（last）	——	查询存储位置上的第一条（最后一条）


	3.管道（将前一次的输出作为后一次的输入）
			（文档处理（表达式）完毕后，通过管道进行下一次处理）
		（1）$group —— 分组管道
		{
			$group:{
				_id:"字段",
				counter:{$sum:1}
				}
		}

		
		（2）$match —— 过滤管道
		{
			$match:{
				筛选条件
			}
		}
```

```
例：先过滤再分组


		（3）$project —— 投影管道
		{
			$project:{
				显示的列：1
				隐藏的列：0
			}
		}


		（4）$sort —— 排序管道
		{
			$sort:{
				要排序的列:1升序，-1降序
				
			}
		}
例：先过滤再排序



		（5）$limit、$skip —— 受限管道
		{$skip:行数},{$limit:行数}


		（6）$unwind —— 遍历数组管道
		{$unwind:'$列'}
```


## 索引

```
		1.索引提升查询速度
		2.数据模拟：使用for循环插入100000条数据

		3.性能测试：explain('executionStats')
（此次查询用了多长时间）


注：输出结果中的 ”executionTimeMillis”:76 为76ms
		4.添加普通索引：ensureIndex({要加索引的字段:1})

		5.再次性能测试，发现速度明显提升
		6.添加唯一索引
			ensureIndex({要加索引的字段:1},{'unique':1})

		7.添加联合索引
			ensureIndex({要加索引的字段:1,要加索引的字段:1})

		8.查看所有索引
			getIndexes()

		9.删除所有索引（注：索引_id_不可被删除）
			dropIndexes()

		10.删除指定索引（可以删除多个）
			dropIndex('索引名',...)
```


## 安全性

```
		1.use admin 切换到用户数据库

		2.创建用户
			（1）普通用户：只能管理用户，查看数据库，查看数据库内集合，但不能查看和操作集合中的内容
			db.createUser({user:’用户名',pwd:'密码’,roles:[‘userAdminAnyDatabase’,’dbAdmin
AnyDatabase']})

			（2）超级管理员：万能
			db.createUser({user:'用户名',pwd:'密码',roles:['root']})

		3.以安全性能开启服务端
			mongod [--dbpath d:\data ...]  --auth

		4.客户端登录
			（1）mongo
				use admin
				db.auth('用户名','密码')

			（2）mongo -u 用户名 -p 密码 --authenticationDatabase admin
（admin指的是数据库）


		5.自定义权限分配
			db.createUser({user:'用户名',pwd:'密码',roles:[{role:'权限',db:'数据库名'},{...}]}) 


		6.修改密码
			db.changeUserPassword("用户名", "新密码")  

		7.删除用户

查看当前已经创建的用户的信息：


删除所有用户：
```



## 数据备份和恢复

```
		1.数据备份（导出）
			mongodump -u root -p root --authenticationDatabase admin -h 数据库IP -d 数据库名 -o 目标目录
（1）

（2）只要有root用户，数据备份的时候就要加上root用户登录，不管是用mongo方式，还是用mongod [--dbpath d:\data ...]  --auth方式开启客户端


		2.数据恢复（导入）
			mongorestore -u root -p root --authenticationDatabase admin -h 数据库IP -d  数据库名 --dir 目标路径
```

## 监控

```
		1.mongostat	——	mongodb状态监测工具

		2.mongotop	——	mongodb延时监测工具
```


## 补充

```
	MongoDB数据库大小
		32bit —— 2GB
		64bit —— 无限制
```

```
管道练习题1：

1.求男、女生人数
 db.stu.aggregate([ {$group:{ _id:'$sex',counter:{$sum:1}}} ])

2.求学生总人数、平均年龄
 db.stu.aggregate([ {$group:{ _id:'',counter:{$sum:1},age_avg:{$avg:'$age'} }}])

3.显示所有男生和所有女生
 db.stu.aggregate([ {$group:{_id:'$sex' , name_list:{$push:"$name"}}} ])

4.求男、女生中的最大年龄
 db.stu.aggregate([ {$group:{_id:'$sex' , age_max:{$max:"$age"}}} ])

5.查询年龄大于20岁的学生
 db.stu.aggregate([ {$group:{_id:'$sex' , age_max:{$max:"$age"}}} ])

6.分别统计年龄大于22岁的男、女生人数
 db.stu.aggregate([ {$match:{age:{$gt:20}}}, {$group:{_id:"$sex",counter:{$sum:1}}} ])

7.查询学生的姓名、年龄
 db.stu.aggregate([ {$project:{_id:0,name:1,age:1}}])

8.查询男、女生人数，只输出人数
 db.stu.aggregate([ {$group:{ _id:'$sex',counter:{$sum:1}}},{$project:{_id:0,counter:1}} ])

9.查询学生信息，按年龄排序
 db.stu.aggregate([ {$sort:{age:1}} ])

10.查询男生、女生人数，按人数降序
 db.stu.aggregate([ {$group:{ _id:'$sex',counter:{$sum:1}}},{$sort:{counter:1}}])

11.查询2条学生信息
 db.stu.aggregate([{$limit:2}])

12.查询从第3条开始的学生信息
 db.stu.aggregate([{$skip:2}])

13.统计男生、女生人数，按人数升序，取第二条数据
 db.stu.aggregate([ {$group:{_id:"$sex",counter:{$sum:1}}}, {$sort:{counter:1}}
, {$skip:1}, {$limit:1} ])
```

```
管道练习题2：

1.按类别统计商品
db.store.aggregate([{$group:{_id:'$type',counter:{$sum:1}}}])

2.求商品平均价
db.store.aggregate([{$group:{_id:'',price_avg:{$avg:'$price'}}}])

3.按类显示所有商品名
db.store.aggregate([{$group:{_id:'$type',names:{$push:'$g_name'}}}])

4.求各类商品中最贵的
db.store.aggregate([{$group:{_id:'$type',names:{$max:'$price'}}}])

5.查询价格大于50的商品
db.store.aggregate([{$match:{price:{$gt:50}}}])

6.查询商品的名字和类别
db.store.aggregate([{$project:{_id:0,g_name:1,type:1}}])

7.查询商品信息，按价格排列
db.store.aggregate([{$sort:{price:1}}])

8.实现商品分页效果
for (i = 0;i<db.store.find().count();i+=5){db.store.aggregate([{$skip:i},{$limit:5}])}
```



## 复制（副本集）

```
	1.复制作用	——	数据备份，故障转移，读写分离
	2.复制原理
		主节点负责处理客户端请求，从节点定期轮询主节点的操作，然后在自己的数据库副本中执行操作，从而保障与主节点的数据一致
	3.设置副本集
		（1）创建文件夹 27017，27018，27019
		（2）分别开启三个mongodb服务端，并设置副本集
			mongod --bind_ip 192.168.2.245 --port 27017 --dbpath d:\mongodb_log\27017 --replSet rs_new

		（3）开启客户端，服务器ip：192.168.2.155，port：27017
mongo --host 192.168.2.245 --port 27017

		（4）副本集初始化
			rs.initiate()

		（5）查看当前副本集配置
			rs.conf()

注：如果出现显示为:OTHER>的情况时，可以使用这条语句将:OTHER>切换为当前身份（:PRIMARY>，:SENCONDARY>）。
		（6）查看副本集状态
			rs.status()

		（7）查看当前机器是主机还是从机

		（7）初始化之后在主节点中添加从节点
			rs.add("ip:port")

添加从节点之后的状态：

		（8）在初始化之前添加节点，然后再初始化
			config = {
				"_id":"副本集名",
				"members":[
					{"_id":0,"host":"ip:port"},
					{"_id":1,"host":"ip:port"}
				]
			}		

			rs.initiate(config)

注：如果已经初始化，则不能用这种方式添加节点，会报错”already  initialized”。
		（9）在主节点中删除节点
			rs.remove("ip:port")

		（10）节点最少1个，最多7个
		（11）从机可以读取数据，但先要输入
			rs.slaveOk()
		（12）主机宕机可直接切换到其中一个从机，实现自动主从切换
```

## python与mongodb交互

```
		1.在线安装pymongo
			pip install pymongo
		2.导入pymongo模块
			import pymongo
		3.连接客户端
			client = pymongo.MongoClient("ip",port)
		4.获取数据库
			db = client.数据库名
		5.获取集合
			test = db.集合名
例：

		6.获取集合内的值
			（1）获取所有值
				for result in test.find():
					print(result)

例：

输出结果：

			（2）按某个条件值查询结果
				test.find({"查询条件":值})
				可以把查询条件整体提出作为参数
			（3）查询一个或多个文档
cur = test.find()
cur.next()
注：cur.next()在同一个程序中是可叠加的  例：print(cur.next())# 此时查询的是第一条
print(cur.next())# 此时查询的是第二条
例：

输出结果：

			（4）查询一个文档
				test.find_one(条件)
注：test.find_one()在同一个程序中不可叠加
例：

输出结果：

			（5）获取文档个数
print stu.count()
例：

输出结果：

		7.插入数据
			test.insert({条件})

知识点补充：插入数据的另一种方法

输出结果：

		8.管道操作
			agg1 = {"$group":{"_id":"$sex","counter":{"$sum":1}}}
			test.aggregate([agg1]) # 参数为管道列表
		9.动态更改数据库
			db = client[数据库名][集合名]

实例练习：登录注册，实现用户的增删改查
（1）mongoHelper.py
import pymongo

class MongoHelper(object):
    def __init__(self, host, port,db_name,col_name):
        self.client = pymongo.MongoClient(host, port)
        self.col = self.client[db_name][col_name]

    def insertDoc(self, doc):
        self.col.insert(doc)

    def selectAllDoc(self, doc):
        return self.col.find(doc)

    def selectOneDoc(self, doc):
        return self.col.find_one(doc)

（2）main.py
import mongoHelper

def main():
    mh_test_stu = mongoHelper.MongoHelper('127.0.0.1', 27017, 'test', 'stu')
    choose = input("1.登录 2.注册 3.注销 4.修改")
    if choose == '1':
        login(mh_test_stu)
    elif choose == '2':
        register(mh_test_stu)
    else:
        print('功能未开通')

def login(mh):
    username = input("请输入用户名")
    password = input("请输入密码")
    query_doc = {'name': username}
    try:
        pwd = mh.selectOneDoc(query_doc)['password']
        if password == str(pwd):
            print("登录成功")
        else:
            print("登录失败")
    except:
        print("登录失败")

def register(mh):
    username = input("请输入用户名")
    count = mh.selectAllDoc({"name":username}).count()
    if count == 0:
        password = input("请输入密码")
        password_again = input("请再次输入密码")
        if password == password_again:
                mh.insertDoc({"name":username,"password":password})
        else:
                print("两次密码输入有误")

if __name__ == '__main__':
    main()
```

## MongoDB关系

```
1.MongoDB 的关系表示多个文档之间在逻辑上的相互联系。
2.文档间可以通过嵌入和引用来建立联系。
（1）嵌入式关系：
例：
"_id":ObjectId("52ffc33cd85242f436000001"),
   "contact": "987654321",
   "dob": "01-01-1991",
   "name": "Tom Benzamin",
   "address": [
      {
         "building": "22 A, Indiana Apt",
         "pincode": 123456,
         "city": "Los Angeles",
         "state": "California"
      },
      {
         "building": "170 A, Acropolis Apt",
         "pincode": 456789,
         "city": "Chicago",
         "state": "Illinois"
      }]
}
		
（2）引用式关系：
例：
{
   "_id":ObjectId("52ffc33cd85242f436000001"),
   "contact": "987654321",
   "dob": "01-01-1991",
   "name": "Tom Benzamin",
   "address_ids": [
      ObjectId("52ffc4a5d85242602e000000"),
      ObjectId("52ffc4a5d85242602e000001")
   ]
}
		
3.MongoDB 中的关系可以是：
1:1 (1对1)
1: N (1对多)
N: 1 (多对1)
M: N (多对多)
```
