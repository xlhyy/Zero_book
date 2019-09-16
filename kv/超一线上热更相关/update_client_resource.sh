#!/bin/bash

# Main
if [ $# -ne 1 ]; then
     echo "Usage: `basename $0` <tag>"
     exit 1
fi

END_TAG=$1
INIT_TAG="nr1.9.3 nr2.1.0 nr2.2.0 nr2.7.0"

read -p "update client resource to resource server - ${END_TAG} ?(y to continue, else to quit):" is_continue

if [ "x$is_continue" != "xy" ]; then
    exit 1
fi


WORK_DIR=$(cd "$(dirname "$0")"; pwd)
RES_DIR="${WORK_DIR}/client_resource"
TEMP_DIR="${WORK_DIR}/temp"

HOST="192.168.211.20"
USER="admin"

# DEST_DIR="/data/sites/resource.kaiqigu.com/static/client_resource"
GIT_REPO_PATH="/data/repo/update4vn"

cd $GIT_REPO_PATH

# 先删除所有本地的 tag
/usr/bin/git tag -l | xargs /usr/bin/git tag -d

# 清除所有的 JSON 和 ZIP 包，避免 TAG 删除的情况存在
 rm -f $RES_DIR/*.json
 rm -f $RES_DIR/*.zip
 rm -f $RES_DIR/*.txt

# 从远端服务器获取最新的内容
/usr/bin/git fetch --prune --all --tags

# 判断 END_TAG 是否存在
flag_is_exist=`/usr/bin/git tag -l | grep $END_TAG `

echo "flag_is_exist is ${flag_is_exist}"

if [ "$flag_is_exist" != "$END_TAG" ]; then
    echo ""
    echo "${END_TAG} is not exists! - ${flag_is_exist}"
    echo "Update fail!"
    echo ""
    exit 1
fi

/usr/bin/git checkout $END_TAG

TAG_PREFIX=${END_TAG:0:2}

echo "TAG_PREFIX: " ${TAG_PREFIX}

if [ ${TAG_PREFIX} == "nv" ];then
    TAG_LIST=`/usr/bin/git tag -l | sort | grep "^${TAG_PREFIX}" |tail -30`
else
    # 获取最新的30个 TAG 列表
    TAG_LIST=`/usr/bin/git tag -l | sort | grep "^${TAG_PREFIX}" |tail -30`

    # 该tag用来更新nginx配置中的判断tag，小于这个tag的客户端需要重新下载安装包以后再更新
    # OLDEST_TAG=`echo ${TAG_LIST} | awk '{print $1}'`

    # 添加初始包的tag，保证app商店下载的客户端可以更新到最新版
    TAG_LIST="$INIT_TAG $TAG_LIST"
fi

for i in $TAG_LIST
do
    echo $i

    if [ "x$i" == "x$END_TAG" ]; then
        JSON_CONTENT="{\"status\":0,\"msg\":\"\",\"data\":{\"different_files\":[],\"current_version\":\"${END_TAG}\",\"sum_size\":0},\"user_status\":{}}"
        echo $JSON_CONTENT > $RES_DIR/$i.json
        continue                  # here, same as break
    fi

    DIFFERENT_FILE="${i}.zip"
    JSON_CONTENT="{\"status\":0,\"msg\":\"\",\"data\":{\"different_files\":[\"$DIFFERENT_FILE\"],\"current_version\":\"$END_TAG\",\"sum_size\":0},\"user_status\":{}}"

    echo $JSON_CONTENT > $RES_DIR/$i.json

    echo $i

    TEMP_ZIP_DIR="${TEMP_DIR}/${i}"

    mkdir -p $TEMP_ZIP_DIR

    FILE_LIST=`/usr/bin/git diff --name-only ${i} ${END_TAG}`
    for file in $FILE_LIST
    do
        FULL_RES_FILE=${GIT_REPO_PATH}/${file}
        if [ ! -f ${FULL_RES_FILE} ]; then
            #echo "no file: " $FULL_RES_FILE
            continue
        fi

        echo "file:" $file >> $RES_DIR/$i.txt
        #cp $FULL_RES_FILE $TEMP_ZIP_DIR
        cp -f --parents $file $TEMP_ZIP_DIR
    done

    cd $TEMP_ZIP_DIR
    rm -rf $RES_DIR/$i.zip
    rm -f ./Resources/lua/game_version_config.lua
    /usr/bin/zip -r $RES_DIR/$i.zip .
    cd $GIT_REPO_PATH
    rm -rf $TEMP_ZIP_DIR

done

cp $RES_DIR/* ${WORK_DIR}/client_resource_bak/
# /usr/bin/rsync -a -z --progress $RES_DIR/ $USER@$HOST:$DEST_DIR/

echo "Update Resource Done!"