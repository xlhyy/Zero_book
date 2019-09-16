#!/bin/bash

HOSTS=`cat pub_android_srv.txt | grep -v '^#'`

cmd=$1

for host in $HOSTS
do
    echo $host
    if [ "x$cmd" == "xrestart" ];then
        sleep 1
    fi
    ssh admin@$host /usr/local/bin/supervisorctl -u user -p 123 $cmd all
done