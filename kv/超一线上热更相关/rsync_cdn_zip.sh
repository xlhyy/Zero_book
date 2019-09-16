#!/bin/bash

WORK_DIR=$(cd "$(dirname "$0")"; pwd)

/usr/bin/rsync -vzrtopg --progress --password-file=${WORK_DIR}/cdn_file --exclude='*.json' --exclude='*.txt'  /data/up_res/client_resource/  CJYX_BACKUP@203.113.172.117::CJYX_RES/static/client_resource/