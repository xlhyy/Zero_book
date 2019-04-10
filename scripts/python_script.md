# python脚本常用知识点

```
1. 切换工作路径(方便操作该文件夹下的文件)
import sys
import os.path
sys.path.insert(0, '想要切换的绝对路径')

2. 获取命令行参数
import sys
filename = sys.argv[1]

3. 获取文件每一行的数据
比如文件中内容格式为:UID+空格+数据
f = open(filename)
for i in f:
    user_id,num = l.strip().split()

4. 判断文件是否存在，不存在则退出
import os.path
if not os.path.exists(filename):
    exit(1)

5. 将输出到屏幕上的数据保存到一个文件
./文件名.sh > 要输出为的文件名
python 文件名.py > 要输出的文件名
```
