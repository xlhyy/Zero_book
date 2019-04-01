# 计算的两种方式


```
#!/bin/bash

var1=10
var2=20
var3=$(expr $var2 / $var1)
var4=$[$var2 / $var1]
echo $var3
echo $var4
```
