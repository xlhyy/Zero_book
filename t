[1mdiff --git a/.idea/Zero_book.iml b/.idea/Zero_book.iml[m
[1mindex d0876a7..6f63a63 100644[m
[1m--- a/.idea/Zero_book.iml[m
[1m+++ b/.idea/Zero_book.iml[m
[36m@@ -5,4 +5,8 @@[m
     <orderEntry type="inheritedJdk" />[m
     <orderEntry type="sourceFolder" forTests="false" />[m
   </component>[m
[32m+[m[32m  <component name="TestRunnerService">[m
[32m+[m[32m    <option name="projectConfiguration" value="Nosetests" />[m
[32m+[m[32m    <option name="PROJECT_TEST_RUNNER" value="Nosetests" />[m
[32m+[m[32m  </component>[m
 </module>[m
\ No newline at end of file[m
[1mdiff --git a/README.md b/README.md[m
[1mindex 3816013..c5afa73 100644[m
[1m--- a/README.md[m
[1m+++ b/README.md[m
[36m@@ -1,2 +1,3 @@[m
 # Zero_book[m
[31m-My way to study.[m
[32m+[m
[32m+[m[32m{% include "./SUMMARY.md" %}[m
[1mdiff --git a/SUMMARY.md b/SUMMARY.md[m
[1mindex 1f7b71b..040ca3c 100644[m
[1m--- a/SUMMARY.md[m
[1m+++ b/SUMMARY.md[m
[36m@@ -1,47 +1,5 @@[m
[31m-## 召唤师接口文档[m
[32m+[m[32m## My way to study.[m
 [m
 * Jenkins[m
 [m
     * [召唤师jenkins项目](interface/jenkins.md)[m
[31m-[m
[31m-* 各种常用游戏逻辑[m
[31m-[m
[31m-    * [常用逻辑](interface/CommonLogic.md)[m
[31m-    * [配置格式](interface/ConfigLogic.md)[m
[31m-[m
[31m-* 接口文档[m
[31m-[m
[31m-    * [登陆流程及相关API](interface/login.md)[m
[31m-    * [用户相关](interface/user.md)[m
[31m-    * [卡牌](interface/cards.md)[m
[31m-    * [装备](interface/equip.md)[m
[31m-    * [抽卡](interface/gacha.md)[m
[31m-    * [世界boss](interface/world_boss.md)[m
[31m-    * [主线剧情](interface/chapter.md)[m
[31m-    * [竞技场](interface/arena.md)[m
[31m-    * [金币副本](interface/gold_map.md)[m
[31m-    * [勇士之塔](interface/tower.md)[m
[31m-    * [好友系统](interface/friend.md)[m
[31m-    * [命运之力](interface/fate_power.md)[m
[31m-    * [邮件系统](interface/mail.md)[m
[31m-    * [聊天系统](interface/chat.md)[m
[31m-    * [装备副本](interface/equip_map.md)[m
[31m-    * [材料副本](interface/item_map.md)[m
[31m-    * [工会](interface/guild.md)[m
[31m-    * [杯赛](interface/placement_match.md)[m
[31m-    * [charge商店](interface/charge_shop.md)[m
[31m-    * [新竞技场](interface/arena_new.md)[m
[31m-    * [头像／头像框](interface/head.md)[m
[31m-    * [战旗](interface/warchess.md)[m
[31m-    * [朋友圈](interface/moments.md)[m
[31m-    * [好感度](interface/favor.md)[m
[31m-    * [道具](interface/item.md)[m
[31m-    * [商店](interface/shop.md)[m
[31m-    * [热门活动](interface/active.md)[m
[31m-    * [地牢](interface/dungeon.md)[m
[31m-    * [饰品](interface/trinket.md)[m
[31m-    * [图鉴](interface/handbook.md)[m
[31m-[m
[31m-* 其它[m
[31m-[m
[31m-    * [异步任务 celery](interface/my_celery.md)[m
[1mdiff --git a/interface/test.md b/interface/test.md[m
[1mindex c46d6cc..5dc1c03 100644[m
[1m--- a/interface/test.md[m
[1m+++ b/interface/test.md[m
[36m@@ -1,320 +1,8 @@[m
[31m-# 热门活动[m
[32m+[m[32m# 测试文档[m
 [m
[31m-### 热门活动入口[m
[31m-http://localhost/summoner/api?method=active.active_show&user_token=h11234567[m
[31m-[m
[31m-- 参数[m
[31m-    - `method`: `active.active_show`[m
[31m-[m
[31m-- 返回值[m
[31m-```[m
[31m-{[m
[31m-    "hot_active": {             # 小红点 0显示红点，1不显示[m
[31m-        "one_recharge": 0,      # 单笔充值小红点[m
[31m-        "add_recharge": 0,      # 累计充值小红点[m
[31m-        "add_consume": 0,       # 累计消费小红点[m
[31m-        "daily_sign": 1,        # 签到小红点[m
[31m-    }[m
[31m-    "show":[m
[31m-    {[m
[31m-        "1": {                  # 活动id[m
[31m-            "active_time": 1,   # 1表示活动开启,0表示活动尚未开启[m
[31m-            "context": {        # 玩家在该活动的首页信息[m
[31m-                ...[m
[31m-            },[m
[31m-        }[m
[31m-        "2": {[m
[31m-            "active_time": 0,[m
[31m-            "context": {},[m
[31m-        },[m
[31m-        "3": {[m
[31m-            "active_time": 0,[m
[31m-            "context": {},[m
[31m-        },[m
[31m-        ...[m
[31m-    }[m
[31m-}[m
[31m-```[m
[31m-[m
[31m-[m
[31m-### 签到活动首页[m
[31m-http://localhost/summoner/api?method=active.active_daily_sign&user_token=h11234567[m
[31m-[m
[31m-- 参数[m
[31m-    - `method`: `active.active_daily_sign`[m
[31m-[m
[31m-- 返回值[m
[31m-```[m
[31m-{[m
[31m-    "show":[m
[31m-    {[m
[31m-        "seven_sign": {             # 每日签到[m
[31m-            "1": {                      # 第一天[m
[31m-                "reward_flag": 1,       # 1代表可领取 2代表已领取[m
[31m-            },[m
[31m-            ...[m
[31m-        }[m
[31m-        "add_sign": {               # 累计签到[m
[31m-            'can_receive': 1,           # 1代表可领取 0代表不可领取[m
[31m-            'add_reward': [],           # 显示的奖励[m
[31m-            'remain_days': 0,           # 差多少天可以领奖[m
[31m-            'sign_days': 7,             # 已签到天数[m
[31m-        },[m
[31m-    }[m
[31m-}[m
[31m-```[m
[31m-[m
[31m-[m
[31m-### 签到活动领取奖励[m
[31m-http://localhost/summoner/api?method=active.receive_sign_reward&user_token=h11234567&active_id=1&type=1[m
[31m-[m
[31m-- 参数[m
[31m-    - `method`: `active.receive_sign_reward`[m
[31m-    - `active_id`: `1`  # 配置id(当为领取七日签到奖励时需要此参数)[m
[31m-    - `type`: `1`   # 1代表七日签到领奖，2代表累计签到领奖[m
[31m-[m
[31m-- 返回值[m
[31m-```[m
[31m-{[m
[31m-    "reward": [],                   # 奖励[m
[31m-    "show":                         # 领奖后首页信息[m
[31m-    {[m
[31m-        "seven_sign": {             # 每日签到[m
[31m-            "1": {                      # 第1天[m
[31m-                "reward_flag": 1,       # 1代表可领取 2代表已领取[m
[31m-            },[m
[31m-            ...[m
[31m-        }[m
[31m-        "add_sign": {               # 累计签到[m
[31m-            'can_receive': 1,           # 1代表可领取 0代表不可领取[m
[31m-            'add_reward': [],           # 显示的奖励[m
[31m-            'remain_days': 0,           # 差多少天可以领奖[m
[31m-            'sign_days': 7,             # 已签到天数[m
[31m-        },[m
[31m-    }[m
[31m-}[m
[31m-```[m
[31m-[m
[31m-[m
[31m-### 单笔/累计充值首页[m
[31m-http://localhost/summoner/api?method=active.recharge_index&user_token=h11234567&ctype=1[m
[31m-[m
[31m-- 参数[m
[31m-    - `method`: `active.recharge_index`[m
[31m-    - `ctype`: `1` # 1表示单笔充值,2表示累计充值[m
[31m-[m
[31m-- 返回值[m
[31m-[m
[31m-```[m
[31m-{[m
[31m-    "show":[m
[31m-    {[m
[31m-        "1": {[m
[31m-            "flag": 0,          # 0表示可以领奖[m
[31m-            "now_num": 0,       # 当前完成次数[m
[31m-            "need_value":0,     # 还需充值的数量(累充时有此字段)[m
[31m-        },[m
[31m-        "2": {[m
[31m-            "flag": 1,          # 1表示任务正在进行中[m
[31m-            "now_num": 0,[m
[31m-            "need_value":500,[m
[31m-        },[m
[31m-        "3": {[m
[31m-            "flag": 2,          # 2表示已经领奖[m
[31m-            "now_num": 0,[m
[31m-            "need_value": 0,[m
[31m-        },[m
[31m-    },[m
[31m-    "remain_time": 0,           # 活动倒计时[m
[31m-}[m
[31m-```[m
[31m-[m
[31m-[m
[31m-### 单笔/累计充值领取奖励[m
[31m-http://localhost/summoner/api?method=active.recharge_award&user_token=h11234567&active_id=1[m
[31m-[m
[31m-- 参数[m
[31m-    - `method`: `active.recharge_award`[m
[31m-    - `active_id`: `1` # 配置表里的id[m
[31m-[m
[31m-- 返回值[m
[31m-[m
[31m-```[m
[31m-{[m
[31m-    "reward": {},               # 通用奖励[m
[31m-    "show":                     # 领取后单笔/累计充值首页数据[m
[31m-    {[m
[31m-        "1": {[m
[31m-            "flag": 0,          # 0表示可以领奖[m
[31m-            "now_num": 0,       # 当前完成次数[m
[31m-            "need_value":0,     # 还需充值的数量(累充时有此字段)[m
[31m-        },[m
[31m-        "2": {[m
[31m-            "flag": 1,          # 1表示任务正在进行中[m
[31m-            "now_num": 0,[m
[31m-            "need_value":500, [m
[31m-        },[m
[31m-        "3": {[m
[31m-            "flag": 2,          # 2表示已经领奖[m
[31m-            "now_num": 0,[m
[31m-            "need_value":0,[m
[31m-        },[m
[31m-    },[m
[31m-    "remain_time": 0,           # 活动倒计时[m
[31m-}[m
[31m-```[m
[31m-[m
[31m-[m
[31m-### 累计消耗首页[m
[31m-http://localhost/summoner/api?method=active.consume_index&user_token=h11234567[m
[31m-[m
[31m-- 参数[m
[31m-    - `method`: `active.consume_index`[m
[31m-[m
[31m-- 返回值[m
[31m-[m
[31m-```[m
[31m-{[m
[31m-    "show":[m
[31m-    {[m
[31m-        "1": {[m
[31m-            "flag": 0,          # 0表示可以领奖[m
[31m-            "now_value":500,    # 当前累计消耗[m
[31m-        },[m
[31m-        "2": {[m
[31m-            "flag": 1,          # 1表示任务正在进行中[m
[31m-            "now_value":0, [m
[31m-        },[m
[31m-        "3": {[m
[31m-            "flag": 2,          # 2表示已经领奖[m
[31m-            "now_value":0,[m
[31m-        },[m
[31m-    },[m
[31m-    "remain_time": 0,           # 活动倒计时[m
[31m-}[m
[31m-```[m
[31m-[m
[31m-[m
[31m-### 累计消耗领取奖励[m
[31m-http://localhost/summoner/api?method=active.consume_award&user_token=h11234567&active_id=1[m
[31m-[m
[31m-- 参数[m
[31m-    - `method`: `active.consume_award`[m
[31m-    - `active_id`: `1` # 配置表里的id[m
[31m-[m
[31m-- 返回值[m
[31m-[m
[31m-```[m
[31m-{[m
[31m-    "reward": {},               # 通用奖励[m
[31m-    "show":                     # 领取后累计消耗首页数据[m
[31m-    {[m
[31m-        "1": {[m
[31m-            "flag": 0,          # 0表示可以领奖[m
[31m-            "now_value":500,    # 当前累计消耗[m
[31m-        },[m
[31m-        "2": {[m
[31m-            "flag": 1,          # 1表示任务正在进行中[m
[31m-            "now_value":0, [m
[31m-        },[m
[31m-        "3": {[m
[31m-            "flag": 2,          # 2表示已经领奖[m
[31m-            "now_value":0,[m
[31m-        },[m
[31m-    },[m
[31m-    "remain_time": 0,           # 活动倒计时[m
[31m-}[m
[31m-```[m
[31m-[m
[31m-[m
[31m-### 限时兑换首页[m
[31m-http://localhost/summoner/api?method=active.omni_index&user_token=h11234567[m
[31m-[m
[31m-- 参数[m
[31m-    - `method`: `active.omni_index`[m
[31m-[m
[31m-- 返回值[m
[31m-[m
[31m-```[m
[31m-{[m
[31m-    "show": [m
[31m-    {[m
[31m-        "1": 3,         # id为1的兑换次数剩余3[m
[31m-        "2": 0,[m
[31m-        "3": 0,[m
[31m-        "4": 0,[m
[31m-    },[m
[31m-    "remain_time": 0,   # 活动倒计时[m
[31m-}[m
[31m-```[m
[31m-[m
[31m-[m
[31m-### 限时兑换领取奖励[m
[31m-http://localhost/summoner/api?method=active.omni_exchange&user_token=h11234567&exchange_id=1&times=1[m
[31m-[m
[31m-- 参数[m
[31m-    - `method`: `active.omni_exchange`[m
[31m-    - `exchange_id`: `1` # 奖励配置id[m
[31m-    - `times`: `1` # 兑换个数[m
[31m-    [m
[31m-[m
[31m-- 返回值[m
[31m-[m
[31m-```[m
[31m-{[m
[31m-    "reward": {},       # 通用奖励[m
[31m-    "show":             # 领取后限时兑换首页数据[m
[31m-    {[m
[31m-        "1": 3,         # id为1的兑换次数剩余3[m
[31m-        "2": 0,[m
[31m-        "3": 0,[m
[31m-        "4": 0,[m
[31m-    },[m
[31m-    "remain_time": 0,   # 活动倒计时[m
[31m-}[m
[31m-```[m
[31m-[m
[31m-[m
[31m-### 特殊钻石(每日充值)兑换首页[m
[31m-http://localhost/summoner/api?method=active.omni_diamond_index&user_token=h11234567[m
[31m-[m
[31m-- 参数[m
[31m-    - `method`: `active.omni_diamond_index`[m
[31m-[m
[31m-- 返回值[m
[31m-[m
[31m-```[m
[31m-{[m
[31m-    "show":[m
[31m-    {[m
[31m-        "1": 3,         # id为1的购买次数剩余3[m
[31m-        "2": 0,[m
[31m-        "3": 0,[m
[31m-    },[m
[31m-    "remain_time": 0,   # 活动倒计时[m
[31m-}[m
[31m-```[m
[31m-[m
[31m-[m
[31m-### 特殊钻石(每日充值)兑换领取奖励[m
[31m-http://localhost/summoner/api?method=active.omni_diamond_exchange&user_token=h11234567&active_id=1&times=1[m
[31m-[m
[31m-- 参数[m
[31m-    - `method`: `active.omni_diamond_exchange`[m
[31m-    - `active_id`: `1` # 配置表里的id[m
[31m-    - `times`: `1` # 兑换个数[m
[31m-[m
[31m-- 返回值[m
[32m+[m[32m### title[m
 [m
[32m+[m[32m- content[m
 ```[m
[31m-{[m
[31m-    "reward": {},       # 通用奖励[m
[31m-    "show":             # 领取后特殊钻石兑换首页数据[m
[31m-    {[m
[31m-        "1": 3,         # id为1的购买次数剩余3[m
[31m-        "2": 0,[m
[31m-        "3": 0,[m
[31m-    },[m
[31m-    "remain_time": 0,   # 活动倒计时[m
[31m-}[m
[32m+[m[32mThis is a test document.[m
 ```[m
