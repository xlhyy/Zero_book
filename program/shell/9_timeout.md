# 超时


```
kaiqigu@bogon:~/dododo/test|⇒  cat tt.sh 
#!/bin/bash

read -p "enter something: " something
echo ${something}

if read -t 5 -p "please enter your name: " name
then
    echo "hello ${name}!"
else
    echo "sorry, timeout!"
fi
```


```
kaiqigu@bogon:~/dododo/test|⇒  sh tt.sh 
enter something: 123
123
please enter your name: sorry, timeout!
```


```
kaiqigu@bogon:~/dododo/test|⇒  sh tt.sh
enter something: 123
123
please enter your name: li
hello li!
```

