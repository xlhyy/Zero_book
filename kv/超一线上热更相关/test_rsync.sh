#!/bin/sh

work_dir=/data/release/resource/pub

if [ -z $work_dir ];then
    exit 1
fi

temp=$work_dir"/client_versions"
version_path="/data/sites/genesis_backend/logs"

targets=(120.132.57.20 120.132.57.21)

for target in ${targets[*]};
do
    target_path=admin@$target:$version_path;
    echo $target_path;
    rsync -alrI --progress --recursive --exclude='*.zip' $temp $target_path && date && echo "client resource version file $target deployed";
done