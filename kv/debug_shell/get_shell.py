# coding: utf-8

import datetime
import time
import sys
import copy

env_config = sys.argv[1]
config_type = sys.argv[2]
path = sys.argv[3]

sys.path.insert(0, path)

import settings
settings.set_evn(env_config, config_type)
from logics.share import debug_sync_change_time
debug_sync_change_time()
import game_config

from logics.user import User
from logics.share import debug_sync_change_time
from logics.association import GuildEmployBoss
debug_sync_change_time()
