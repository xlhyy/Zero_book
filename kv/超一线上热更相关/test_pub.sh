#!/bin/bash

# Main
if [ $# -ne 1 ]; then
     echo "Usage: `basename $0` <tag>"
     exit 1
fi

END_TAG=$1

read -p "update client resource to resource server - ${END_TAG} ?(y to continue, else to quit):" is_continue

if [ "x$is_continue" != "xy" ]; then
    exit 1
fi


WORK_DIR=$(cd "$(dirname "$0")"; pwd)
RES_DIR="${WORK_DIR}/client_versions"
TEMP_DIR="${WORK_DIR}/temp"

mkdir -p $RES_DIR
rm -rf $RES_DIR/*

HOST="192.168.1.9"
USER="admin"

# DEST_DIR="/data/sites/genesis_backend/logs/client_versions"
GIT_REPO_PATH="/data/release/resource/pub/update4pub"

cd $GIT_REPO_PATH
echo "GIT_REPO_PATH:", $GIT_REPO_PATH
# 先删除所有本地的 tag
git tag -l | xargs git tag -d

# 清除所有的 JSON 和 ZIP 包，避免 TAG 删除的情况存在
rm -f $RES_DIR/*.json
#rm -f $RES_DIR/*.zip
rm -f $RES_DIR/*.txt

# 从远端服务器获取最新的内容
git fetch --prune --all --tags

# 判断 END_TAG 是否存在
flag_is_exist=`git tag -l | grep 'r[0-9]*.[0-9]*.[0-9]*$' |grep $END_TAG `

echo "flag_is_exist is ${flag_is_exist}"

if [ "$flag_is_exist" != "$END_TAG" ]; then
    echo ""
    echo "${END_TAG} is not exists! - ${flag_is_exist}"
    echo "Update fail!"
    echo ""
    exit 1
fi

git checkout $END_TAG
# r1
TAG_PREFIX=${END_TAG:0:2}

echo "TAG_PREFIX: " ${TAG_PREFIX}

CON_STR="_"
echo "con_string: " ${CON_STR}

# 获取 TAG 列表
TAG_LIST=`git tag | grep 'r[0-9]*.[0-9]*.[0-9]*$'| sort | grep "^${TAG_PREFIX}"`

for i in $TAG_LIST
do
    echo $i
    echo date

    if [ "x$i" == "x$END_TAG" ]; then
        JSON_CONTENT="{\"different_files\":[],\"current_version\":\"${END_TAG}\",\"sum_size\":0}"
        echo $JSON_CONTENT > $RES_DIR/$i
        continue                  # here, same as break
    fi

    echo $i
    # 发布的tag小于当前循环tag 时直接退出循环
    a=${END_TAG:3:7}
    b=${i:3:7}

    echo $a
    echo $b

    if [[ "$a" < "$b" ]]; then
        echo "continue_for..... "
        break
    fi

    TEMP_ZIP_DIR="${TEMP_DIR}/${i}"

    mkdir -p $TEMP_ZIP_DIR

    FILE_LIST=`git diff --name-only ${i} ${END_TAG} `
    for file in $FILE_LIST
    do
        FULL_RES_FILE=${GIT_REPO_PATH}/${file}
        if [ ! -f ${FULL_RES_FILE} ]; then
            #echo "no file: " $FULL_RES_FILE
            continue
        fi
        short_path=${file#appstore/}
        # echo "\"$short_path\"," >> $RES_DIR/$i

        echo "file:" $file >> $RES_DIR/$i.txt

        parent_dir_name=`dirname $short_path`
        mkdir -p $TEMP_ZIP_DIR/$parent_dir_name
        cp -P $file $TEMP_ZIP_DIR/$parent_dir_name
    done

    cd $TEMP_ZIP_DIR
    rm -rf $RES_DIR/$END_TAG$CON_STR$i.zip
    
    /usr/bin/zip -r $RES_DIR/$END_TAG$CON_STR$i.zip .

    md5_value=`md5sum $RES_DIR/$END_TAG$CON_STR$i.zip |awk '{print $1}'`
    
    DIFFERENT_FILE="${END_TAG}${CON_STR}${i}.zip"
    JSON_CONTENT="{\"different_files\":[\"$DIFFERENT_FILE\"], \"md5\": \"$md5_value\", \"current_version\":\"$END_TAG\",\"sum_size\":0}"
    echo $JSON_CONTENT > $RES_DIR/$i

    cd $GIT_REPO_PATH
    rm -rf $TEMP_ZIP_DIR

done

cd $WORK_DIR
d=`date  +"%F %T"`
echo "Update Resource Done!"
echo $d $0 $END_TAG >> release.log