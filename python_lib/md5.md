# md5

- md5方式加密

```
In [19]: import hashlib

In [20]: m = hashlib.md5()

In [21]: m.update("Nobody inspects")

In [22]: m.update(" the spammsh repetition")

In [23]: m.digest()
Out[23]: '/\xa7\x8e\x8d\x14U\x8cg\xab\x1c\x81YjU\xdd\xec'

In [24]: m.hexdigest()
Out[24]: '2fa78e8d14558c67ab1c81596a55ddec'
```


```
1) 对以上代码的说明：
1.首先从python直接导入hashlib模块
2.调用hashlib里的md5()生成一个md5 hash对象
3.生成hash对象后，就可以用update方法对字符串进行md5加密的更新处理
4.继续调用update方法会在前面加密的基础上更新加密
5.加密后的二进制结果
6.十六进制结果


2) 如果只需对一条字符串进行加密处理，也可以用一条语句的方式：
In [34]: print hashlib.new("md5", "Nobody inspects the spammsh repetition").hexd
    ...: igest()  
2fa78e8d14558c67ab1c81596a55ddec
或------------
In [35]: print hashlib.md5('Nobody inspects the spammsh repetition').hexdigest()
    ...: 
2fa78e8d14558c67ab1c81596a55ddec
```
