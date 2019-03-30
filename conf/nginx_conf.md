# nginx配置


### /etc/nginx/nginx.conf


```
=====================================================================120.123.57.20
user  nginx;

worker_processes  8;
worker_rlimit_nofile 65535;

error_log  /data/nginx/logs/error.log warn;
pid        /var/run/nginx.pid;


events {
    #use epoll;
    worker_connections  10240;
}


http {
    ### Basic ####
    sendfile on;

    tcp_nopush on;
    tcp_nodelay off;

    keepalive_timeout 600;

    types_hash_max_size 2048;
    client_max_body_size 64M;
    client_body_buffer_size 1024k;    

    include       /etc/nginx/mime.types;

    default_type  application/octet-stream;

    ### Logging ###
    log_format  main  '$remote_addr - $remote_user [$time_local] $http_host "$request" $request_body '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for" '
                      '$upstream_addr $upstream_response_time $request_time';

    access_log /data/nginx/logs/access.log  main;
    #error_log /data/nginx/logs/error.log warn;

    ### Gzip ###
    gzip  on;
    gzip_disable "msie6";
    gzip_min_length 1k;
    gzip_comp_level 7;
    gzip_http_version 1.1;
    gzip_types text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript application/javascript;

    proxy_buffer_size 4k;
    proxy_buffers 64 32k;
    
   # allow 119.161.137.199;
   # allow 101.254.182.2;
   # deny all;

    # include /etc/nginx/conf.d/*.conf;

    # deal with master python 
    upstream genesis_pub_android_ios_master {
        server 127.0.0.1:2500 max_fails=2 fail_timeout=2s weight=8;
        # 再添加一台 master python 
        server 10.10.14.70:2500 max_fails=2 fail_timeout=2s weight=1;
    }

    upstream genesis_pub_android_admin {
        server 127.0.0.1:2501 max_fails=2 fail_timeout=2s weight=4;
    }

    # 添加后台admin进程
    #upstream genesis_pub_ios_admin.app {
    #    server 10.10.6.168:2501 max_fails=2 fail_timeout=2s weight=9;
    #}

    server {
        listen 80;
        server_name pub.kaiqigu.net localhost 120.132.57.20 10.10.14.8;
        server_name pub.kaiqigu.cn;
        server_name genesis_android.kaiqigu.net;
        server_name genesis_android.kaiqigu.cn;

	if ($arg_channel ~ 'aiyingyong'){return 200 '{"status": "1", "user_status": {}, "_client_cache_update": {}, "all_config_version": "", "msg": "该平台已经停止合作，请选择其他平台登录", "data": {}}';}

        location /favicon.ico {
            empty_gif;
            access_log off;
        }

        location / {
#            root /usr/share/nginx/html;
#            index index.html index.htm;
            return 404;
        }

        # redirect server error pages to the static page /50x.html
        #
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   /usr/share/nginx/html;
        }

        # pub admin
        location /genesisandroidios/admin/ {
            rewrite ^/genesisandroidios/(.*) /$1 break;

            proxy_pass http://genesis_pub_android_admin;
        }

        ### genesisandroidios - android enter ######

        location /genesisandroidios/ {
            rewrite ^/genesisandroidios/(.*) /$1 break;

            proxy_pass http://genesis_pub_android_ios_master;

            proxy_read_timeout 60s;
            proxy_pass_header Server;

            proxy_redirect off;

            proxy_set_header Host $http_host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Scheme $scheme;

            proxy_next_upstream error http_502;
        }

        ### Images and static content ###
        #location /genesisandroidios/lr/ {
        #    root /opt/sites/genesis_pub_kuaiyong_tongbutui_client/;

        #    rewrite ^/genesisandroidios/lr/(.*) /$1 break;

        #    autoindex off;
        #    keepalive_timeout 0;
        #}

        location /genesisandroidios/static/ {
            root /data/sites/genesis_backend/static/; 
            rewrite ^/genesisandroidios/static(.*) $1 break;
            autoindex off;
        }

        location /genesisandroidios/crash/ {
            add_header Content-Type "text/plain;charset=utf-8";

            return 200 "ok";

            access_log  /data/nginx/logs/genesis_crash.log main;
        }

        #location /genesisandroidios/transformer/api/ {
        #    add_header Content-Type "text/plain;charset=utf-8";
        #    return 200 "{\"status\": \"ok\"}";
        #    access_log  /data/logs/nginx/genesis_crash.log main;
        #}


    }


}



=====================================================================120.123.57.21
user  nginx;

worker_processes  6;
worker_rlimit_nofile 655350;

error_log  /data/logs/nginx/error.log warn;
pid        /var/run/nginx.pid;


events {
    use epoll;
    worker_connections  102400;
}


http {
    ### Basic ####
    sendfile on;

    tcp_nopush on;
    tcp_nodelay off;

    keepalive_timeout 600;

    types_hash_max_size 2048;
    client_max_body_size 64M;

    proxy_http_version 1.1;
    proxy_set_header Connection "";

    include       /etc/nginx/mime.types;

    default_type  application/octet-stream;

    ### Logging ###
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" $request_body '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for" '
                      '$upstream_addr $upstream_response_time $request_time';

    access_log  /data/logs/nginx/access.log  main;
    #error_log /data/logs/nginx/error.log warn;

    ### Gzip ###
    gzip  on;
    gzip_disable "msie6";
    gzip_min_length 1k;
    gzip_comp_level 9;
    gzip_http_version 1.1;
    gzip_types text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript application/javascript;

    proxy_buffer_size 4k;
    proxy_buffers 128 32k;

    #allow 119.161.137.199;
    #allow 101.254.182.2;
    #deny all;

    #include /etc/nginx/conf.d/*.conf;


    upstream genesis_pub_1.app {

        server 10.10.53.40:2500 max_fails=2 fail_timeout=2s weight=9;

        #server 10.10.20.171:2500 max_fails=2 fail_timeout=2s weight=9;
    }

    upstream genesis_pub_2.app {

        server 10.10.7.228:2500 max_fails=2 fail_timeout=2s weight=9;
        server 10.10.7.75:2500 max_fails=2 fail_timeout=2s weight=9;
        server 10.10.19.232:2500 max_fails=2 fail_timeout=2s weight=9;
        server 10.10.21.133:2500 max_fails=2 fail_timeout=2s weight=9;
        server 10.10.35.150:2500 max_fails=2 fail_timeout=2s weight=9;

        server 10.10.28.60:2500 max_fails=2 fail_timeout=2s weight=9;
        server 10.10.26.186:2500 max_fails=2 fail_timeout=2s weight=9;
        # server 10.10.27.104:2500 max_fails=2 fail_timeout=2s weight=9;
        # server 10.10.32.31:2500 max_fails=2 fail_timeout=2s weight=9;

        server 10.10.46.207:2500 max_fails=2 fail_timeout=2s weight=9;
        server 10.10.16.212:2500 max_fails=2 fail_timeout=2s weight=9;

        # server 10.10.24.105:2500 max_fails=2 fail_timeout=2s weight=9;
        # server 10.10.38.111:2500 max_fails=2 fail_timeout=2s weight=9;

        server 10.10.53.40:2600 max_fails=2 fail_timeout=2s weight=6;

    }

    #upstream genesis_pub_3.app {

    #    server 10.10.41.109:2500 max_fails=2 fail_timeout=2s weight=9;
    #    server 10.10.50.182:2500 max_fails=2 fail_timeout=2s weight=9;
    #    server 10.10.50.243:2500 max_fails=2 fail_timeout=2s weight=9;
    #    server 10.10.53.24:2500 max_fails=2 fail_timeout=2s weight=9;
    #    server 10.10.58.216:2500 max_fails=2 fail_timeout=2s weight=9;

    #    server 10.10.21.234:2500 max_fails=2 fail_timeout=2s weight=9;
    #    server 10.10.29.71:2500 max_fails=2 fail_timeout=2s weight=9;
    #    server 10.10.31.65:2500 max_fails=2 fail_timeout=2s weight=9;

    #}

    upstream genesis_pub_4.app {

        server 10.10.20.171:2500 max_fails=2 fail_timeout=2s weight=9;

    }


    server {
        listen 80 default backlog=2048;
        #server_name 120.132.57.21 10.10.14.70 localhost;
        server_name ~.*;

	# 灰度关服开关 0:关闭, 1:开启
        set $close_server 0;
        # 白名单ip
        if ($remote_addr ~ "203.86.67.226|124.207.29.34|219.142.26.114") {set $close_server 3$close_server;}  # kaiqigu

        # 合服操作时只停指定的服，匹配规则是如果不属于 g37 g389这三个区服则修改屏蔽条件
        # 不放开则全服都停
	#if ($uri !~ "/g718/|/g752/|/g742/|/g743/|/g746/|/g747/|/g745/|/g728/|/g726/|/g751/|/g750/|/g729/|/g727/|/g741/|/g740/|/g720/|/g721/|/g722/|/g723/|/g724/|/g725/|/g719/|/g749/|/g744/|/g748/|/g739/|/g738/|/g733/|/g732/|/g731/|/g730/|/g737/|/g736/|/g735/|/g734/|/g760/|/g761/|/g754/|/g755/|/g757/|/g756/|/g753/|/g768/|/g769/|/g764/|/g765/|/g766/|/g767/|/g762/|/g763/|/g759/|/g758/|/g775/|/g773/|/g772/|/g771/|/g770/|/g777/|/g776/|/g774/|/g810/|/g830/|/g821/|/g829/|/g828/|/g816/|/g817/|/g814/|/g815/|/g812/|/g813/|/g811/|/g818/|/g823/|/g822/|/g820/|/g827/|/g826/|/g825/|/g824/|/g819/|/g838/|/g839/|/g840/|/g832/|/g833/|/g843/|/g841/|/g842/|/g831/|/g834/|/g835/|/g836/|/g837/|/g844/|/g856/|/g866/|/g850/|/g854/|/g849/|/g848/|/g847/|/g845/|/g846/|/g853/|/g851/|/g852/|/g855/|/g864/|/g860/|/g861/|/g863/|/g865/|/g862/|/g859/|/g857/|/g858/|/g868/|/g869/|/g871/|/g870/|/g872/|/g867/|/g873/|/g879/|/g875/|/g877/|/g876/|/g878/|/g874/|/g881/|/g880/|/g883/|/g882/|/g885/|/g884/|/g886/|/g890/|/g889/|/g888/|/g887/|/g896/|/g894/|/g895/|/g892/|/g891/|/g893/|/g897/|/g902/|/g900/|/g901/|/g898/|/g899/|/g904/|/g905/|/g903/|/g906/|/g907/|/g911/|/g915/|/g909/|/g908/|/g910/|/g913/|/g912/|/g914/|/g916/|/g917/|/g918/|/g919/|/g920/|/g921/|/g922/|/g923/|/g924/|/g925/|/g926/|/g927/|/g928/|/g929/|/g930/|/g931/|/g932/|/g933/|/g934/|/g935/|/g936/|/g937/|/g938/|/g939/|/g940/") {set $close_server 3$close_server;}

        # 主要拦截api与与get_user_server_list接口
        if ($args ~ "get_user_server_list") {set $close_server 2$close_server;}
        if ($uri ~ "api") {set $close_server 2$close_server;}
              
        # 不属于以上白名单ip，也不属于单独停服的区服则直接返回停服提示给前端，返回数据里 的status每个项目可能不同，按实际情况处理即可
        if ($close_server ~ 21)
        {
            return 200 '{"status": 9527, "data": {}, "user_status": {}, "msg": "14:00~18:00合服中", "game_config_version": {}, "all_config_version": ""}';
        }
	if ($arg_platform_channel ~ 'aiyingyong|itools_221|yingyonghui|jinli|itools|PPS|PP|ouwan|android_itools
'){return 200 '{"status": "1", "user_status": {}, "_client_cache_update": {}, "all_config_version": "", "msg": "该平台已经停止合作，请选择其他平台登录", "data": {}}';}

	if ($arg_channel ~ 'aiyingyong|itools_221|yingyonghui|jinli|itools|PPS|PP|ouwan|android_itools
'){return 200 '{"status": "1", "user_status": {}, "_client_cache_update": {}, "all_config_version": "", "msg": "该平台已经停止合作，请选择其他平台登录", "data": {}}';}	

        location /favicon.ico {
            empty_gif;
            access_log off;
        }

        location / {
            root /usr/share/nginx/html;
            index index.html index.htm;
        }

        set $fuck 1;
        if ($args ~ "world_boss.fight"){set $fuck 2$fuck;}
        if ($http_user_agent !~ ^$){set $fuck 3$fuck;}
        if ($fuck ~ "321"){return 503;}

        proxy_read_timeout 300s;
        proxy_pass_header Server;

        proxy_redirect off;

        proxy_set_header Host $http_host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Scheme $scheme;
        proxy_next_upstream error http_502;

        # 合服
        location ~ /combine_server/ {
        # location ~ /g494/|/g503/|/g504/|/g497/|/g517/|/g495/|/g505/|/g506/|/g502/|/g508/|/g509/|/g516/|/g513/|/g512/|/g510/|/g518/|/g507/|/g515/|/g514/|/g511/|/g519/|/g523/|/g525/|/g526/|/g529/|/g522/|/g520/|/g521/|/g524/|/g527/|/g530/|/g528/|/g531/|/g532/|/g539/|/g538/|/g535/|/g534/|/g537/|/g536/|/g533/|/g546/|/g547/|/g548/|/g545/|/g540/|/g541/|/g542/|/g543/|/g544/|/g549/|/g555/|/g553/|/g552/|/g554/|/g551/|/g550/|/g557/|/g556/|/g559/|/g558/|/g560/|/g565/|/g564/|/g562/|/g563/|/g561/|/g566/|/g567/|/g568/|/g569/|/g570/|/g571/|/g572/|/g573/|/g574/|/g575/|/g576/|/g577/|/g578/|/g579/|/g580/|/g581/|/g582/|/g583/|/g584/|/g585/|/g586/|/g587/|/g588/|/g589/|/g590/{
            add_header Content-Type "application/json;charset=utf-8";
            return 200 "{}";
            access_log /data/logs/nginx/combine_server.log main;
        }

        # 老老服 8台服务器
        location ~ /g1[6-9][0-9]/|/g2[0-9][0-9]/|/g30[0-9]/|/g31[0-2]/ {
            rewrite ^/[^\/]*/(.*)/ /$1/ break;
            proxy_pass http://genesis_pub_2.app;
        }

        # 老老服 13台服务器
        location ~ /g[2-9]/|/g[1-9][0-9]/|/g1[0-5][0-9]/ {
            rewrite ^/[^\/]*/(.*)/ /$1/ break;
            proxy_pass http://genesis_pub_2.app;
        }

        # 老服 9台服务器
        location ~ /g31[3-9]/|/g32[0-9]/|/g33[0-9]/|/g34[0-9]/|/g35[0-9]/|/g36[0-9]/|/g37[0-9]/|/g38[0-9]/|/g39[0-9]/|/g40[0-9]/|/g41[0-9]/|/g42[0-9]/|/g43[0-9]/|/g44[0-9]/|/g45[0-9]/|/g46[0-9]/|/g47[0-9]/|/g48[0-9]/|/g49[0-9]/|/g50[0-9]/|/g51[0-9]/|/g52[0-9]/|/g53[0-9]/|/g54[0-9]/|/g55[0-9]/|/g56[0-9]/|/g57[0-9]/|/g58[0-9]/|/g59[0-9]/|/g60[0-9]/|/g61[0-9]/|/g62[0-9]/|/g63[0-9]/|/g64[0-9]/|/g65[0-9]/|/g66[0-2]/|/g66[4-9]/|/g67[0-9]/|/g68[0-9]/|/g69[0-9]/|/g70[0-9]/|/g71[0-9]/|/g72[0-9]/|/g73[0-9]/|/g74[0-9]/|/g75[0-9]/|/g76[0-9]/|/g77[0-9]/|/g78[0-9]/|/g79[0-9]/|/g80[0-9]/|/g81[0-9]/|/g82[0-9]/|/g83[0-9]/|/g84[0-9]/|/g85[0-9]/|/g86[0-9]/|/g87[0-9]/|/g88[0-9]/|/g89[0-9]/|/g90[0-9]/|/g91[0-9]/|/g92[0-9]/|/g93[0-9]/|/g94[0-9]/|/g95[0-9]/ {
            rewrite ^/[^\/]*/(.*)/ /$1/ break;
            proxy_pass http://genesis_pub_2.app;
        }

	# 新服
	location ~ /g53[5-9]/|/g54[0-9]/|/g55[0-3]/|/g55[0-3]/ {
	    rewrite ^/[^\/]*/(.*)/ /$1/ break;
            proxy_pass http://genesis_pub_1.app;
	}

        # 新区
	location ~ /g(\d+)/ {
            rewrite ^/[^\/]*/(.*)/ /$1/ break;
            proxy_pass http://genesis_pub_4.app;
        }

    }


}



==================================================conf.d/default.conf
server {
    listen       80;
    server_name  localhost;

    #charset koi8-r;
    #access_log  /var/log/nginx/log/host.access.log  main;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }

    #error_page  404              /404.html;

    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }

    # proxy the PHP scripts to Apache listening on 127.0.0.1:80
    #
    #location ~ \.php$ {
    #    proxy_pass   http://127.0.0.1;
    #}

    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    #
    #location ~ \.php$ {
    #    root           html;
    #    fastcgi_pass   127.0.0.1:9000;
    #    fastcgi_index  index.php;
    #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
    #    include        fastcgi_params;
    #}

    # deny access to .htaccess files, if Apache's document root
    # concurs with nginx's one
    #
    #location ~ /\.ht {
    #    deny  all;
    #}
}



==================================================conf.d/example_ssl.conf
# HTTPS server
#
#server {
#    listen       443 ssl;
#    server_name  localhost;

#    ssl_certificate      /etc/nginx/cert.pem;
#    ssl_certificate_key  /etc/nginx/cert.key;

#    ssl_session_cache shared:SSL:1m;
#    ssl_session_timeout  5m;

#    ssl_ciphers  HIGH:!aNULL:!MD5;
#    ssl_prefer_server_ciphers   on;

#    location / {
#        root   /usr/share/nginx/html;
#        index  index.html index.htm;
#    }
#}

```
