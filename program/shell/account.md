# 创建多个用户账号


```
#!/bin/bash

# read会自动读取.csv文本文件的下一行内容
# users.csv文件的格式如下: userid,user name
# 必须作为root用户才能运行这个脚本，因为useradd命令需要root权限
# 账户信息/etc/passwd

input="users.csv"
while IFS=',' read -r userid name
do
	echo "adding $userid"
	useradd -c "$name" -m $userid
done < "$input"
```
