### global方法


- settings.py
```
globals()['ENV_NAME'] = 'ly_config'
```


- main.py
```
# encoding: utf-8

import settings

print settings.ENV_NAME
```


- 运行结果
```
⇒  python globals.py 
ly_config
```
