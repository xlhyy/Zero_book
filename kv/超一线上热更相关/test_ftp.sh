#!/bin/bash
ftp -n<<!
open proxy.wsfdupload.lxdns.com
user cjyxcmge wangsu@123
binary
ls
cd pub
lcd /data/release/resource/pub/client_versions
prompt
mput *.zip
ls
close
bye