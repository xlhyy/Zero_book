# 软链接


- 创建软连接

```
ln -s 目标地址 软链接地址(例:/usr/bin/tools)
例:
sudo ln -s /home/kaiqigu/下载/TIM-x86_64.AppImage /usr/bin/tim
sudo ln -s /Users/kaiqigu/my_tools/tools.sh /usr/local/bin/qwe
```


- 删除软连接

```
rm -rf 软链接地址
```


- 修改软连接

```
ln -snf 新目标地址 软链接地址
```
