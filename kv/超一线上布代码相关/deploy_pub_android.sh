#!/bin/sh

# main
if [ $# -ne 1 ]; then
    echo "Usage: `basename $0` <version_tag>"
    exit 1
fi

tag=$1

# example r0.00.00.00
reg="^r[0-9]\.[0-9]{1,2}\.[0-9]{1,2}\.[0-9]{1,2}$"

if [ ! `echo $tag | grep -E $reg` ]; then
    echo "version error example r0.0.0.0"
    exit 1
fi

WORK_DIR=$(cd "$(dirname "$0")"; pwd)
GIT_REPO_PATH="/data/repo/backend"
APP_SRV_LIST="${WORK_DIR}/pub_android_srv.txt"

#ROOT_DIR="/home/madajie/release/cmge"
#repo_dir="/home/madajie/s/genesis/backend"
temp_dir="${WORK_DIR}/temp_android/"
#HOST_LIST="${ROOT_DIR}/server_list.txt"

rm -rf $temp_dir/*

echo $tag > $temp_dir/version

cd $GIT_REPO_PATH
/usr/bin/git fetch --all
/usr/bin/git archive --format=tar $tag | tar -xv -C $temp_dir

HOST=(`cat ${APP_SRV_LIST} | grep -v '^#' `)

echo "Deploy to the hosts:"
for i in ${HOST[@]}
do
    echo $i
done

read -p "Are you sure you want to continue (y/n)?" MFLAG
if [ "x${MFLAG}" != "xy" ]; then
    exit 1
fi

# 校验下需要更新多少文件
THOST=${HOST[0]}

/usr/bin/rsync --dry-run -aI --progress --recursive --exclude='upload_xls' --exclude='.git' --exclude='logs' --exclude='test/local_config.py' $temp_dir "admin@$THOST:/data/sites/genesis_backend/"

read -p "Are you sure you want to continue (y/n)?" CFLAG
if [ "x${CFLAG}" != "xy" ]; then
    exit 1
fi

echo 'backend pub deployed'
for host in ${HOST[@]}
do
    echo $host
    /usr/bin/rsync -aI --progress --recursive --exclude='upload_xls' --exclude='.git' --exclude='logs' --exclude='test/local_config.py' $temp_dir "admin@${host}:/data/sites/genesis_backend/"

done

# 另外2台nginx
for host in 10.10.30.240
do                                                                                                                                                                               
    echo $host                                                                                                                                                                   
    /usr/bin/rsync -aI --progress --recursive --exclude='upload_xls' --exclude='.git' --exclude='logs' --exclude='test/local_config.py' $temp_dir "admin@${host}:/data/sites/genesis_backend/"                                                                                                                                                                    
                                                                                                                                                                                 
done

echo $?

cd $WORK_DIR
d=`date  +"%F %T"`
echo $d $0 $tag
echo $d $0 $tag >> release.log