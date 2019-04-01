# supervisor配置


## /etc/supervisor/supervisord.conf


```
========================================================主配置
[include]
files = /etc/supervisor.d/conf.d/*.conf

[unix_http_server]
file=/tmp/supervisor.sock   ; (the path to the socket file)

[inet_http_server]         ; inet (TCP) server disabled by default
port=127.0.0.1:9001        ; (ip_address:port specifier, *:port for all iface)
username=user              ; (default is no username (open server))
password=123               ; (default is no password (open server))

[supervisord]
logfile=/var/log/supervisord.log ; (main log file;default $CWD/supervisord.log)
logfile_maxbytes=200MB       ; (max main logfile bytes b4 rotation;default 50MB)
logfile_backups=10           ; (num of main logfile rotation backups;default 10)
loglevel=info                ; (log level;default info; others: debug,warn,trace)

pidfile=/tmp/supervisord.pid ; (supervisord pidfile;default supervisord.pid)

nodaemon=false               ; (start in foreground if true;default false)
minfds=1024                  ; (min. avail startup file descriptors;default 1024)
minprocs=200                 ; (min. avail process descriptors;default 200)

[rpcinterface:supervisor]
supervisor.rpcinterface_factory = supervisor.rpcinterface:make_main_rpcinterface

[supervisorctl]
serverurl=unix:///tmp/supervisor.sock ; use a unix:// URL  for a unix socket



========================================================自配置1
[program:genesis_pub_android_admin]
process_name = %(process_num)02d
command = /usr/local/bin/python2.7 -O /data/sites/genesis_backend/run.py
        --port=2501
        --maxmem=1073741824
        --env=cloud_android
        --server_name=master
        --numprocs=2
        --logging=debug

numprocs = 1
numprocs_start = 0
autorestart = true

stdout_logfile=/data/sites/genesis_backend/logs/g_admin_out.log
stdout_logfile_maxbytes=200MB
stdout_logfile_backups=10
stdout_capture_maxbytes=1MB

stderr_logfile=/data/sites/genesis_backend/logs/g_admin_err.log
stderr_logfile_maxbytes=200MB
stderr_logfile_backups=10
stderr_capture_maxbytes=1MB
loglevel=debug



========================================================自配置2
[program:genesis_pub_android_master]
process_name = %(process_num)02d
command = /usr/local/bin/python2.7 -O /data/sites/genesis_backend/run.py
        --port=2500
        --maxmem=1073741824
        --env=cloud_android
        --server_name=1
        --numprocs=4
        --logging=debug

numprocs = 1
numprocs_start = 0
autorestart = true

stdout_logfile=/data/sites/genesis_backend/logs/g_master_out.log
stdout_logfile_maxbytes=200MB
stdout_logfile_backups=10
stdout_capture_maxbytes=1MB

stderr_logfile=/data/sites/genesis_backend/logs/g_master_err.log
stderr_logfile_maxbytes=200MB
stderr_logfile_backups=10
stderr_capture_maxbytes=1MB
loglevel=debug

[program:genesis_pub_android_chat]
process_name = %(process_num)02d
command = /usr/local/bin/python2.7 -O /data/sites/genesis_backend/run_chat_server.py cloud_android 1
numprocs = 1
numprocs_start = 0
autorestart = true

stdout_logfile=/data/sites/genesis_backend/logs/chat_out.log
stdout_logfile_maxbytes=200MB
stdout_logfile_backups=1
stdout_capture_maxbytes=1MB

stderr_logfile=/data/sites/genesis_backend/logs/chat_err.log
stderr_logfile_maxbytes=200MB
stderr_logfile_backups=1
stderr_capture_maxbytes=1MB
loglevel=debug
```
