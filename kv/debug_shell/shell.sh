#!/bin/bash

# default enviroment config name
_ENV_CONFIG='stg_pub'

# default root dir
_ROOT_PATH='/Users/kaiqigu/PycharmProjects/Superhero1/backend'

# default config type
_CONFIG_TYPE='1'

echo "This script will create a shell environment for debug"

# Read the environment config
read -p "Please input the enviroment config name: [$_ENV_CONFIG] " ENV_CONFIG
if ! echo $ENV_CONFIG | egrep -q '^[a-z0-9_]+$'; then
    echo "Selecting default: $_ENV_CONFIG"
    ENV_CONFIG=$_ENV_CONFIG
fi

# Read the config type
read -p "Please input the config type: [$_CONFIG_TYPE] " CONFIG_TYPE
if ! echo $CONFIG_TYPE | egrep -q '^master|[0-9]$'; then
    echo "Selecting default: $_CONFIG_TYPE"
    CONFIG_TYPE=$_CONFIG_TYPE
fi

# Read the root dir
read -p "Please input the root dir [$_ROOT_PATH] " ROOT_PATH
if [ ! -d "$ROOT_PATH" ]; then
    echo "Selected default - $_ROOT_PATH"
    ROOT_PATH=$_ROOT_PATH
fi

#echo $ENV_CONFIG $CONFIG_TYPE $ROOT_PATH

CUR_PATH=$(cd "$(dirname "$0")"; pwd)

ipython -i $CUR_PATH/get_shell.py $ENV_CONFIG $CONFIG_TYPE $ROOT_PATH
