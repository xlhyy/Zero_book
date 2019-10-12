# 函数

- 定义函数

```
#!/bin/bash

function func1()
{
	echo "this is func1"
	echo $1 $2
	return 1
}

function func2()
{
	echo "this is func2"
}


# 1.直接用函数名调用函数
func2
echo $?

echo "-----------------"

# 2.函数传参
func1 1 2
echo $?

echo "-----------------"

# 3.将函数赋值给变量
func=`func1 1 2`
echo ${func}	# 当给func赋值时，执行echo，相当于直接执行函数，以此来调用函数
echo $?
```


```
结果:
this is func2
0
-----------------
this is func1
1 2
1
-----------------
this is func1 1 2
0
```
