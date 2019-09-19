#!/bin/bash

clear
echo
echo -e "\033[;33m            TOOLS LIST"
echo -e "\033[;36m	
    q) Exit
    1) to jumpserver
    2) to Superhero1_backend
    3) to Superhero1_documents
    4) to Superhero1_thailand backend
    5) to Superhero1_server_doc
    6) to Superhero1_stg_test
    7) to Superhero1_start_server
    8) to Sanguo_backend
    9) to Sanguo_documents
    10) to Superhero2_backend
    11) to Superhero2_documents
    12) to Summoners_backend
    13) to Summoners_wiki
    14) to Summoners_svn
    15) to Zero_book
    16) to Bigsaleking_backend
    17) to Bigsaleking_wiki
    18) run_Bigsaleking_server
    19) run_redis_server port=6379
    20) run_redis_server port=6301
	\033[;37m"
read -p "Please enter your choose: " choose
while [ 1 ]
do
case $choose in
	q)
        	clear
		exit
		;;
	1)
			echo [ "HrCPu9HWCuwYx00E" ]
		ssh ying.li@192.168.1.21 -i /Users/kaiqigu/ying.li.pem
		choose="q"
		;;
	2)
		cd /Users/kaiqigu/PycharmProjects/Superhero1/backend/
		zsh
		;;
	3)
		cd /Users/kaiqigu/PycharmProjects/Superhero1_documents/backend_documents/doc/
		zsh
		;; 
	4)
		cd /Users/kaiqigu/PycharmProjects/Superhero1_thailand/backend_thailand
		zsh
		;;
    5)
		cd /Users/kaiqigu/PycharmProjects/Superhero1_server_doc/
		zsh
		;;
    6)
        ssh admin@192.168.1.75
		choose="q"
        ;;
	7)
		ps aux|grep run.py|grep -v grep|awk '{print $2}'|xargs kill -9 && python /Users/kaiqigu/PycharmProjects/Superhero1/backend/run.py --env=test_pub --server_name=master --numprocs=1
		zsh
		;;
	110)
		cd /home/kaiqigu/PycharmProjects/Practice_python
		zsh
		;;
	8)
	    cd /Users/kaiqigu/PycharmProjects/Sanguo/backend/
	    zsh
        ;;
    9)
        cd /Users/kaiqigu/PycharmProjects/Sanguo_documents/sanguowiki/
        zsh
        ;;
    10)
        cd /Users/kaiqigu/PycharmProjects/Superhero2/backend/
        zsh
        ;;
    11)
        cd /Users/kaiqigu/PycharmProjects/Superhero2_documents/wiki/
        zsh
        ;;
	12)
		cd /Users/kaiqigu/PycharmProjects/Summoners/backend/
		zsh
		;;
	13)
		cd /Users/kaiqigu/PycharmProjects/Summoners/summoner_doc/
		zsh
		;;
	14)
		cd /Users/kaiqigu/PycharmProjects/Summoners/summoner_svn/配置表/
		zsh
		;;
	15)
		cd /Users/kaiqigu/PycharmProjects/Zero_book
		zsh
		;;
	16)
		cd /Users/kaiqigu/PycharmProjects/Bigsaleking/backend
		zsh
		;;
	17)
		cd /Users/kaiqigu/PycharmProjects/Bigsaleking/wiki
		zsh
		;;
	18)
		python /Users/kaiqigu/PycharmProjects/Bigsaleking/backend/run.py --server_name=all --numprocs=1 --env=ly --port=8888
		zsh
		;;
	19)
		redis-server
		zsh
		;;
	20)
		redis-server --port 6301
		zsh
		;;
	*)
		echo -e "\033[;31mEnter error!!!\033[;37m"
        read -p "Please enter your choose again: " choose
		;;
esac
done


