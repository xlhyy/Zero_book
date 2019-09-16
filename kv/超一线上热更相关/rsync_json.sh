#!/bin/bash

WORK_DIR=$(cd "$(dirname "$0")"; pwd)

/usr/bin/rsync -az --progress  --exclude='*.zip' --exclude='*.txt'  /data/up_res/client_resource/  admin@192.168.211.20:/data/sites/backend_vietnam/logs/client_versions/