# 超时


```
#!/bin/bash

if read -t 5 -p "Please enter your name: " name
then
	echo "Hello $name, welcome to my script"
else
	echo
	echo "Sorry, too slow! "
fi

<<COMMENT
⇒  ./12-超时.sh
Please enter your name: li
Hello li, welcome to my script

⇒  ./12-超时.sh 
Please enter your name: li
Sorry, too slow! 
COMMENT
```
