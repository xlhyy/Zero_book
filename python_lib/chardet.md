# chardet


## 查看字符串编码格式

```
In [1]: s = "asdasd"

In [2]: import chardet

In [3]: chardet.detect(s)
Out[3]: {'confidence': 1.0, 'encoding': 'ascii', 'language': ''}
```