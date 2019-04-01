# find


```
查找文件
find ./ -type f

查找目录
find ./ -type d

查找名字为test的文件或目录
find ./ -name test

查找名字符合正则表达式的文件,注意前面的‘.*’(查找到的文件带有目录)
find ./ -regex .*so.*\.gz

查找目录并列出目录下的文件(为找到的每一个目录单独执行ls命令，没有选项-print时文件列表前一行不会显示目录名称)
find ./ -type d -print -exec ls {} \;

查找目录并列出目录下的文件(为找到的每一个目录单独执行ls命令,执行命令前需要确认)
find ./ -type d -ok ls {} \;

查找目录并列出目录下的文件(将找到的目录添加到ls命令后一次执行，参数过长时会分多次执行)
find ./ -type d -exec ls {} +

查找文件名匹配*.c的文件
find ./ -name \*.c

打印test文件名后，打印test文件的内容
find ./ -name test -print -exec cat {} \;

不打印test文件名，只打印test文件的内容
find ./ -name test -exec cat {} \;

查找文件更新日时在距现在时刻二天以内的文件
find ./ -mtime -2

查找文件更新日时在距现在时刻二天以上的文件
find ./ -mtime +2

查找文件更新日时在距现在时刻一天以上二天以内的文件
find ./ -mtime 2

查找文件更新日时在距现在时刻二分以内的文件
find ./ -mmin -2

查找文件更新日时在距现在时刻二分以上的文件
find ./ -mmin +2

查找文件更新日时在距现在时刻一分以上二分以内的文件
find ./ -mmin 2

查找文件更新时间比文件abc的内容更新时间新的文件
find ./ -newer abc

查找文件访问时间比文件abc的内容更新时间新的文件
find ./ -anewer abc

查找空文件或空目录
find ./ -empty

查找空文件并删除
find ./ -empty -type f -print -delete

查找权限为644的文件或目录(需完全符合)
find ./ -perm 664

查找用户/组权限为读写，其他用户权限为读(其他权限不限)的文件或目录
find ./ -perm -664

查找用户有写权限或者组用户有写权限的文件或目录
find ./ -perm /220
find ./ -perm /u+w,g+w
find ./ -perm /u=w,g=w

查找所有者权限有读权限的目录或文件
find ./ -perm -u=r

查找用户组权限有读权限的目录或文件
find ./ -perm -g=r

查找其它用户权限有读权限的目录或文件
find ./ -perm -o=r

查找所有者为lzj的文件或目录
find ./ -user lzj

查找组名为gname的文件或目录
find ./ -group gname

查找文件的用户ID不存在的文件
find ./ -nouser

查找文件的组ID不存在的文件
find ./ -nogroup

查找有执行权限但没有可读权限的文件
find ./ -executable \! -readable

查找文件size小于10个字节的文件或目录
find ./ -size -10c

查找文件size等于10个字节的文件或目录
find ./ -size 10c

查找文件size大于10个字节的文件或目录
find ./ -size +10c

查找文件size小于10k的文件或目录
find ./ -size -10k

查找文件size小于10M的文件或目录
find ./ -size -10M

查找文件size小于10G的文件或目录
find ./ -size -10G
```
