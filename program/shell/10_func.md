# 函数

- 定义函数

```
#!/bin/bash

function hello_world()
{
	echo 'hello world func'
	echo "$1" "$2"
	return 1
}

hello()
{
	echo 'hello func'
}

# 直接用函数名调用hello函数
hello
result="$?"
echo "$result"

echo '----------'
# 使用[函数名 函数参数]来传递参数
hello_world 1 2
result="$?"
echo "$result"

echo '----------'
# 使用[FUN=`函数名 函数参数`]来直接调用
FUN=`hello_world 'a' 'b'`
result="$?"
echo "$result"
echo "$FUN" # 当给FUN赋值`函数 参数`时，执行echo "$FUN"，相当于直接执行函数 参数，以此来调用函数

# hello func
# 0
#
# hello world func
# 1 2
# 1
#
# 1
# hello world func
# a b
```
