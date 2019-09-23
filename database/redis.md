# redis


## redis可视化

```
https://blog.csdn.net/leisure_life/article/details/78460632
sudo snap install redis-desktop-manager
```


## 缓存更新的套路

```
先更新数据库，再删除缓存。
(原因: 试想，两个并发操作，一个是更新操作，另一个是查询操作，更新操作删除缓存后，查询操作没有命中缓存，先把老数据读出来后放到缓存中，然后更新操作更新了数据库。于是，在缓存中的数据还是老的数据，导致缓存中的数据是脏的，而且还一直这样脏下去了。)
```


## 清空数据库

```
r.flushall()
```

## keys相关

```
del key [key ...]
****dump key (导出key的值)
exists key [key ...]
expire key seconds
expireat key timestamp
pexpire key milliseconds
pexpireat key milliseconds-timestamp

keys pattern
****migrate host key destination-db timeout
move key db
****object
persist key (移除key过期时间)

pttl key (获取key的有效毫秒数)
randomkey (返回一个随机的key)
rename key newkey
renamenx key newkey (重命名一个key，新的key必须是不存在的key)
****restore
****sort
ttl key (获取key的有效时间)
type key (获取key的存储类型)
****wait
****scan
```

```
In [38]: r.ttl('sk1')

In [39]: r.type('sk1')
Out[39]: 'set'

In [40]: r.rename('sk1','sk3')
Out[40]: True

In [41]: r.randomkey()
Out[41]: 'sk2'

In [42]: r.pttl('sk1')

In [43]: r.persist('sk1')
Out[43]: False

In [44]: r.move('sk2',1)
Out[44]: True

In [45]: r.keys()
Out[45]: ['sk3']

In [47]: r.delete('sk1')
Out[47]: 0

In [49]: r.smembers('sk1')
Out[49]: set()

In [50]: r.exists('sk1')
Out[50]: False

In [51]: r.sadd('sk1',1)
Out[51]: 1

In [52]: r.exists('sk1')
Out[52]: True

In [53]: r.expire('sk1',4)
Out[53]: True

In [54]: r.exists('sk1')
Out[54]: True

In [55]: r.exists('sk1')
Out[55]: False
```


## list

```
blpop key [key ...] timeout
brpop key [key ...] timeout
brpoplpush source destination (弹出一个列表的值，将它推到另一个列表，并返回它或阻塞)
rpoplpush source destination (弹出一个列表的值，将它推到另一个列表,并返回它或无返回)
lindex key index
linsert key before/after value	(r.linsert('list1','before','3',0)  在列表中值为'3'的元素前插入元素0)
llen key
lpop key
lpush key value [value ...]
lpushx key value (当队列存在时，从队列左边入队一个元素)
lrange key start stop
lrem key count value	(r.lrem('list1','a',5) 此时count值为5)
"""
COUNT的值可以是以下几种：
1) count > 0 : 从表头开始向表尾搜索，移除与 VALUE 相等的元素，数量为 COUNT 。
2) count < 0 : 从表尾开始向表头搜索，移除与 VALUE 相等的元素，数量为 COUNT 的绝对值。
3) count = 0 : 移除表中所有与 VALUE 相等的值。
"""
lset key index value (相当于修改指定key中index位置的value)
ltrim key start stop (修剪到指定范围内的清单)
rpop key
rpush key value [value ...]
rpushx key value (当队列存在时，从队列右边入队一个元素)

In [167]: r.flushall()
Out[167]: True

In [168]: r.lpush('lk1',1)
Out[168]: 1L

In [169]: r.lpush('lk1',2)
Out[169]: 2L

In [170]: r.lpush('lk1',3)
Out[170]: 3L

In [171]: r.llen('lk1')
Out[171]: 3

In [172]: r.lpush('lk2',4)
Out[172]: 1L

In [173]: r.lpush('lk2',5)
Out[173]: 2L

In [174]: r.lindex('lk1',2)
Out[174]: '1'

In [175]: r.lpop('lk2')
Out[175]: '5'

In [176]: r.lpop('lk2')
Out[176]: '4'

In [177]: r.lpop('lk2')

In [178]: r.lrange('lk1',0,-1)
Out[178]: ['3', '2', '1']

In [179]: r.lpushx('lk1',4)
Out[179]: 4

In [180]: r.lrange('lk1',0,-1)
Out[180]: ['4', '3', '2', '1']

In [181]: r.lrem('lk1',2,1)
Out[181]: 1L

In [182]: r.lrange('lk1',0,-1)
Out[182]: ['4', '3', '1']

In [183]: r.lset('lk1',0,5)
Out[183]: True

In [184]: r.lrange('lk1',0,-1)
Out[184]: ['5', '3', '1']

In [185]: r.ltrim('lk1',0,1)
Out[185]: True

In [186]: r.lrange('lk1',0,-1)
Out[186]: ['5', '3']

In [187]: r.rpush('lk1',2)
Out[187]: 3L

In [188]: r.lrange('lk1',0,-1)
Out[188]: ['5', '3', '2']

In [189]: r.rpushx('lk1',1)
Out[189]: 4

In [190]: r.lrange('lk1',0,-1)
Out[190]: ['5', '3', '2', '1']

In [191]: r.rpop('lk1')
Out[191]: '1'

In [192]: r.rpop('lk1')
Out[192]: '2'
```


## zset

```
zadd key score value
zcard key
zcount key min max (-inf +inf) (返回分数范围内的成员数量)
zincrby key score value (score为想要增加的分数，可为正负)	(r.zincrby('zadd1','as',6))
****zinterstore
****zlexcount key min max (- +) (返回成员之间的成员数量)
zrange key start stop [withscores]
****zrangebylex key min max [limit offset count] (- +) (返回指定成员区间内的成员，按字典正序排列，分数必须相同)
****zrevrangebylex key max min [limit offset count] (+ -)
zrangebyscore key min max [withscores] [limit offset count] ('-inf','+inf') (min max 为score的范围值)
zrank key member (返回在排序集合成员的索引) (member为value值)
zrem key member [member ...]
****zremrangebylex key min max (- +) (删除名称按字典由低到高排序成员之间所有成员)
****zremrangebyrank key start stop
zremrangebyscore key min max (-inf +inf)
****zrevrange key start stop [withscores] (除了成员按分数值递减的次序排列这一点外，ZREVRANGE命令的其他方面和ZRANGE命令一样)
zrevrangebyscore key max min (+inf -inf)
zrevrank key value (返回排名) (第一名为0，依次类推)	(r.zrevrank('zadd1','qwe'))
zscore key member	(r.zscore('zadd1','zxc'))
****zunionstore
****zscan

In [89]: r.flushall()
Out[89]: True

In [90]: r.zadd('zk1','value1',98)
Out[90]: 1

In [91]: r.zadd('zk1','value2',80)
Out[91]: 1

In [92]: r.zadd('zk1','value3',76)
Out[92]: 1

In [94]: r.zrangebyscore('zk1', 60, 88)
Out[94]: ['value3', 'value2']

In [95]: r.zrange('zk1',0,-1,withscores=True)
Out[95]: [('value3', 76.0), ('value2', 80.0), ('value1', 98.0)]

In [96]: r.zcard('zk1')
Out[96]: 3

In [97]: r.zcount('zk1',60,80)
Out[97]: 2L

In [98]: int(r.zcount('zk1',60,80))
Out[98]: 2

In [99]: r.zincrby('zk1','value3',1)
Out[99]: 77.0

In [100]: r.zrank('zk1','value3')
Out[100]: 0

In [102]: r.zrank('zk1','value1')
Out[102]: 2

In [103]: r.zrank('zk1','value2')
Out[103]: 1

In [104]: r.zrem('zk1','value1')
Out[104]: 1

In [105]: r.zcard('zk1')
Out[105]: 2

In [106]: r.zremrangebyscore('zk1',70,79)
Out[106]: 1

In [107]: r.zcard('zk1')
Out[107]: 1

In [108]: r.zadd('zk1','value4',12)
Out[108]: 1

In [109]: r.zrevrange('zk1',0,-1,withscores=True)
Out[109]: [('value2', 80.0), ('value4', 12.0)]

In [114]: r.zrevrank('zk1','value3')

In [115]: r.zrevrank('zk1','value2')
Out[115]: 0

In [116]: r.zscore('zk1','value2')
Out[116]: 80.0
```


## string

```
append key value (追加一个值到key上)
****bitcount key [start end] (统计字符串起始位置的字节数)
****bitfield
****bitop
****bitops
decr key (整数原子减1)
****decrby key decrement (原子减指定的整数)
get key
****getbit key offset
getrange key start end (获取存储在key上的值的一个子字符串)
getset key value (设置一个key的value，并获取设置前的值)
incr key (原子加1操作)
incrby key increment (原子增加一个整数)
incrbyfloat key increment (原子增加一个浮点数)
mget key [key ...]
mset key value [key value ...] ( r.mset(**{'str1':1,'str2':2}) )
"""
In [75]: r.mset({'key2': 'haha', 'key3': 'hehe'})
Out[75]: True
"""
msetnx key value [key value ...] ( r.msetnx(**{'str1':1,'str3':2}) ) (key存在无影响，key不存在添加key及其value)
psetex key milliseconds value (毫秒)
setex key seconds value (秒)
set key value [ex seconds] [px milliseconds] [nx|xx]
****setbit key offset value
setnx key value (设置键值，只有当该键不存在时)
****setrange key offset value
strlen key

In [118]: r.flushall()
Out[118]: True

In [119]: r.set('strk1',1)
Out[119]: True

In [120]: r.setnx('strk1',2)
Out[120]: False

In [121]: r.setnx('strk2',2)
Out[121]: True

In [122]: r.strlen('strk1')
Out[122]: 1

In [124]: r.set('strk3',3)
Out[124]: True

In [125]: r.get('strk3')
Out[125]: '3'

In [127]: r.setex('strk3',5,4)
Out[127]: True

In [128]: r.get('strk3')
Out[128]: '5'

In [129]: r.get('strk3')

In [130]: r.incr('strk2')
Out[130]: 3

In [131]: r.incrby('strk2')
Out[131]: 4

In [132]: r.incrbyfloat('strk2')
Out[132]: 5.0

In [133]: r.getset('strk2',2)
Out[133]: '5'

In [134]: r.get('strk2')
Out[134]: '2'

In [135]: r.decr('strk2')
Out[135]: 1

In [136]: r.append('strk2',4)
Out[136]: 2L

In [137]: r.get('strk2')
Out[137]: '14'

In [138]: r.getrange('strk2',0,-1)
Out[138]: '14'

In [139]: r.getrange('strk2',0,1)
Out[139]: '14'

In [140]: r.getrange('strk2',0,0)
Out[140]: '1'

In [141]: r.keys()
Out[141]: ['strk2', 'strk1']

In [142]: r.mget('strk2','strk1')
Out[142]: ['14', '1']

In [144]: r.mset({'strk2':12,'strk1':13})
Out[144]: True

In [145]: r.mget('strk2','strk1')
Out[145]: ['12', '13']

In [148]: r.keys()
Out[148]: ['strk2', 'strk1']

In [149]: r.msetnx({'strk2':1,'strk1':2,'strk3':3})
Out[149]: False

In [150]: r.keys()
Out[150]: ['strk2', 'strk1']

In [151]: r.msetnx({'strk3':3})
Out[151]: True

In [152]: r.keys()
Out[152]: ['strk2', 'strk3', 'strk1']
```


## hash

```
hdel key field [field ...]
hexists key field
hget key field
hgetall key
hincrby key field increment
hincrbyfloat key field increment
hkeys key (查看该键所有field)
hlen key
hmget key field [field ...]
***hmset key field value [field value ...]
hset key field value
hsetnx key field value (设置hash的一个字段，只有当这个字段不存在时有效)
hstrlen key field
hvals key (获取hash的所有值)
****hscan key cursor [MATCH pattern] [COUNT count]

In [63]: r.flushall()
Out[63]: True

In [64]: r.hset('hk1','f1',1)
Out[64]: 1L

In [65]: r.hset('hk1','f1',2)
Out[65]: 0L

In [66]: r.hget('hk1','f1')
Out[66]: '2'

In [67]: r.hset('hk1','f1',3)
Out[67]: 0L

In [68]: r.hget('hk1','f1')
Out[68]: '3'

In [69]: r.hget('hk1','f1')
Out[69]: '3'

In [70]: r.hexists('hk1','f1')
Out[70]: True

In [71]: r.hgetall('hk1')
Out[71]: {'f1': '3'}

In [72]: r.hset('hk1','f2',4)
Out[72]: 1L

In [73]: r.hgetall('hk1')
Out[73]: {'f1': '3', 'f2': '4'}

In [74]: r.hkeys('hk1')
Out[74]: ['f1', 'f2']

In [75]: r.hlen('hk1')
Out[75]: 2

In [76]: r.hmget('hk1','f1','f2')
Out[76]: ['3', '4']

In [77]: r.hmget('hk1','f1')
Out[77]: ['3']

In [78]: r.hvals('hk1')
Out[78]: ['3', '4']

In [79]: r.hstrlen('hk1','f1')
Out[79]: 1

In [80]: r.hsetnx('hk1','f3',2)
Out[80]: 1L

In [81]: r.hincrby('hk1','f3')
Out[81]: 3L

In [82]: r.hget('hk1','f3')
Out[82]: '3'

In [83]: r.hincrbyfloat('hk1','f3')
Out[83]: 4.0

In [84]: r.hget('hk1','f3')
Out[84]: '4'

In [85]: r.hdel('hk1','f2')
Out[85]: 1

In [86]: r.hlen('hk1')
Out[86]: 2

In [87]: r.hdel('hk1','f1')
Out[87]: 1

In [88]: r.hlen('hk1')
Out[88]: 1
```


## set

```
sadd key member [member ...]  向key添加元素
scard key  查看key中有几个成员
sdiff key [key ...] (获得第一个key中存在，其他key中不存在的元素)
sdiffstore destination key [key ...] (取第一个key中存在，其他key中不存在的元素，放到destination中)
sinter key [key ...]    (交集)
sinterstore destination key [key ...]   (将给定集合之间的交集存储在指定的集合中。如果指定的集合已经存在，则将其覆盖。)
sismember key member
smembers key (获取集合里面的所有元素)
smove source destination member
spop key [count]
srandmember key [count] (从集合里面随机获取一个元素)
srem key member [member ...]
sunion key [key ...] 获得并集
sunionstore destination key [key ...]
****sscan

In [8]: r.flushall()
Out[8]: True

In [9]: r.keys()
Out[9]: []

In [10]: r.sadd('sk1',4)
Out[10]: 1

In [11]: r.sadd('sk1',5)
Out[11]: 1

In [12]: r.smembers('sk1')
Out[12]: {'4', '5'}

In [13]: r.sismember('sk1',5)
Out[13]: True

In [14]: r.sismember('sk1',3)
Out[14]: False

In [15]: r.scard('sk1')
Out[15]: 2

In [17]: r.spop('sk1')
Out[17]: '4'

In [18]: r.spop('sk1')
Out[18]: '5'

In [19]: r.sadd('sk1',1)
Out[19]: 1

In [20]: r.sadd('sk1',2)
Out[20]: 1

In [21]: r.smembers('sk1')
Out[21]: {'1', '2'}

In [22]: r.smove('sk1','sk2',2)
Out[22]: True

In [23]: r.smembers('sk1')
Out[23]: {'1'}

In [24]: r.smembers('sk2')
Out[24]: {'2'}

In [25]: r.sdiff('sk1','sk2')
Out[25]: {'1'}

In [26]: r.smembers('sk1')
Out[26]: {'1'}

In [27]: r.srandmember('sk1',1)
Out[27]: ['1']

In [28]: r.smembers('sk1')
Out[28]: {'1'}

In [29]: r.srem('sk1', 1)
Out[29]: 1

In [30]: r.smembers('sk1')
Out[30]: set()

In [32]: r.sadd('sk1',2)
Out[32]: 1

In [33]: r.sadd('sk1',3)
Out[33]: 1

In [34]: r.smembers('sk1')
Out[34]: {'2', '3'}

In [35]: r.smembers('sk2')
Out[35]: {'2'}

In [36]: r.sinter('sk1','sk2')
Out[36]: {'2'}

In [37]: r.sunion('sk1','sk2')
Out[37]: {'2', '3'}
```


# python连接redis


## python连接数据库

```
In [1]: import redis

In [2]: r = redis.Redis(host='127.0.0.1',port=6379,password='',db=0)

In [3]: r
Out[3]: Redis<ConnectionPool<Connection<host=127.0.0.1,port=6379,db=0>>>
```


## redis简单操作

```
import redis
redis_config = {
    'host': '192.138.16.70',
    'port': 6379,
}
r = redis.Redis(**redis_config)
r.set('li','you are very good!')
print r.get('li')
```


## redis连接池

```
import redis
def get_redis_connect():
    redis_config = {
	'host': '192.168.16.70',
	'port': 6379,
    }
    pool = redis.ConnectionPool(**redis_config)
    r = redis.Redis(connection_pool=pool)
    return r

if __name__ == '__main__':
    r = get_redis_connect()
    r.set('name', 'li')
    print r.get('name')
```


## redis管道

```
#可以一次执行多次redis命令
#应用管道后速度效率大大提升
def withpipe(r):
    pipe = r.pipeline(transaction=True)
    for i in xrange(1,1000):
	key = "tets1" + str(i)
	value = "test1" + str(i)
	pipe.set(key, value)
    pipe.execute()
```

## 项目实例

```
import redis
def make_redis_client(redis_config):
    try:
	if cmp(redis.VERSION, (2,10,1)) >= 0:
	    pool = redis.BlockingConnectionPool(retry_on_timeout=True, **redis_config)
	else:
	    pool = redis.BlockingConnectionPool(**redis_config)
    except:
	pool = redis.BlockingConnectionPool(**redis_config)
    redis_client = redis.Redis(connection_pool=pool)

    return redis_client
```
