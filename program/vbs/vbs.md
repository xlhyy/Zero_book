# vbs语言


### 1. 错误处理：(两个语句一个对象)
```
1) on error resume next (如果后面的程序出现“运行时错误”，会继续运行，不中断)
2) on error goto 0 (如果后面的程序出现“运行时错误”，会显示“出错信息”并停止程序的执行)
3) err (
err对象属性：
description:设置或返回一个描述错误的字符串；
number:     (缺省属性)设置或返回制定一个错误的值；
source:     设置或返回产生错误的对象的名称。

err对象方法:
clear:      清除当前所有的err对象设置；
Raise:      产生一个运行期错误。
)
```


### 2. Dim语句
```
作用:声明变量并分配存储空间
语法:Dim varname [As type]
例子:Dim a As Integer
```


### 3. Do...Loop语句
```
语法:
1)
Do [While condition]
[statements]
Loop

2)
Do
[statements]
Loop [While condition]

3)
Do [Until condition]
[statements]
Loop

4)
Do
[statements]
Loop [Until condition]
```


### 4. For...Next语句
```

作用:以指定次数来重复执行一组语句
语法:
For counter = start To end [Step step]
[statements]
[Exit For]
[statements]
Next [counter]
```


### 5. If...Then...Else语句
```
If condition Then
[statements]
Elseif condition-n then
[elseifstatements-n]
Else
[elsestatements]
End If
```


### 6. Select Case语句
```
Select Case testexpression
Case expressionist-n
[statements-n]
Case Else
[elsestatements]
End Select
```


### 7. Set语句
```
赋值语句
```


### 8. Rem语句
```
注释，同'
```


### 9. inputbox语句
```

inputbox(msg, "title", "啦啦啦")
第一个参数为显示语句，最大长度为1024；
第二个参数为框体名称；
第三个参数为输入内容；
```


### 10. msgbox语句
```

把两个不同的内容一起输出时用“+”连接
语法:MsgBox(prompt [,button] [,title] [,helpfile,content])
1) prompt:
作为消息显示在对话框中的字符串表达式。最大长度约为1024个字符，
如果prompt中包含多行，则可在各行之间用回车符(Chr(13))或换行符(Chr(10))或回车换行符的组合(Chr(13)&Chr(10))分隔各行。

2) buttons:
表示指定显示按钮的数目和类型，使用的图标样式。如果省略，则buttons的默认值为0
0 = vbOKOnly - 只显示确定按钮。
1 = vbOKCancel - 显示确定和取消按钮。
2 = vbAbortRetryIgnore - 显示放弃、重试和忽略按钮。
3 = vbYesNoCancel - 显示是、否和取消按钮。
4 = vbYesNo - 显示是和否按钮。
5 = vbRetryCancel - 显示重试和取消按钮。
16 = vbCritical - 显示临界信息图标。
32 = vbQuestion - 显示警告查询图标。
48 = vbExclamation - 显示警告消息图标。
64 = vbInformation - 显示信息消息图标。
0 = vbDefaultButton1 - 第一个按钮为默认按钮。
256 = vbDefaultButton2 - 第二个按钮为默认按钮。
512 = vbDefaultButton3 - 第三个按钮为默认按钮。
768 = vbDefaultButton4 - 第四个按钮为默认按钮。
0 = vbApplicationModal - 应用程序模式：用户必须响应消息框才能继续在当前应用程序中工作。
4096 = vbSystemModal - 系统模式：在用户响应消息框前，所有应用程序都被挂起。

3) title:
显示在对话框标题栏中的字符串表达式。如果省略title，则将应用程序的名称显示在标题栏中

4) helpfile
字符串表达式，用于标识为对话框提供上下文相关帮助的帮助文件。如果已提供helpfile，则必须提供context。在16位系统平台上不可用。

5) context
数值表达式，用于标识由帮助文件的作者指定给某个帮助主题的上下文编号。如果已提供context，则必须提供helpfile。在16位系统平台上不可用。
```


### 11. 创建对象
```
dim ws = wscript.createobject("wscript.shell")
ws.run "cmd.exe /c shutdown -a",0,true
第2个参数为0:后台运行，应用窗口不可见。
第2个参数为1:应用窗口可见。
```
