### apscheduler


- 知识点
```
常用的若干调度器:
BlockingScheduler:	仅可用在当前你的进程之内，与当前的进程共享计算资源。
BackgroundScheduler:	在后台运行调度，不影响当前的系统计算运行
AsyncIOScheduler:	如果当前系统中使用了async module，则需要使用异步的调度器
GeventScheduler:	如果使用了gevent，则使用该调度器
TornadoScheduler:	如果使用了Tornado，则使用该调度器
TwistedScheduler:	Twister应用的调度器
QtScheduler:		Qt的调度器

----------------------------------------------------------------
1. 新增作业
1) 基于add_job方法来动态添加
例:
sched.add_job(job_function, 'cron', day_of_week='mon-fri', hour='0-9', minute="*", second="*/4")
2) 基于scheduled_job修饰器来动态装饰job的实际函数
例:
@sched.scheduled_job('cron', id='my_job_id', day='last sun')
def some_decorated_task():
    print("I am printed at 00:00:00 on the last Sunday of every month!")

2. 移除作业
1)
job = scheduler.add_job(myfunc, 'interval', minutes=2)
job.remove()
2)
scheduler.add_job(myfun, 'interval', minutes=2, id='my_job_id')
scheduler.remove_job('my_job_id')

3. 暂停作业
apscheduler.job.Job.pause()
apscheduler.schedulers.base.BaseScheduler.pause_job()

4. 恢复作业
apscheduler.job.Job.resume()
apscheduler.schedulers.base.BaseScheduler.resume_job()

5. 获得作业列表
get_jobs()
print_jobs()

6. 修改作业
1) 使用modify()或modify_job()动态修改job的属性信息(注: id属性无法修改)
apscheduler.job.Job.modify(max_instances=6, name='Alternate name')
2) 使用reschedule()或reschedule_job()动态重新设置trigger
apscheduler.job.Job.reschedule_job('my_job_id', trigger='cron', minute='*/5')

7. 关闭调度器
scheduler.shutdown()
scheduler.shutdown(wait=False)
```


- 实例
```
例1:
# coding=utf-8

from apscheduler.schedulers.blocking import BlockingScheduler
from datetime import datetime
import time
import os

def tick():
    print('Tick! The time is: %s' % datetime.now())

if __name__ == '__main__':
    scheduler = BlockingScheduler()
    scheduler.add_job(tick, 'cron', second='*/3', hour='*')
    print('Press Ctrl+{0} to exit'.format('Break' if os.name == 'nt' else 'C'))

    try:
	scheduler.start()
    except(KeyboardInterrupt, SystemExit):
	scheduler.shutdown()
```


```
例2:
# encoding: utf-8

from apscheduler.schedulers.blocking import BlockingScheduler

sched = BlockingScheduler()

@sched.scheduled_job('interval', seconds=3)
def timed_job():
    print('This job is run every three seconds.')
@sched.scheduled_job('cron', day_of_week='mon-fri', hour='0-9', minute='30-59', second='*/3')
def scheduled_job():
    print ('This job is run every weekday.')

print ('before the start function')
sched.start()
```


```
例3:
# coding=utf-8

from apscheduler.schedulers.background import BackgroundScheduler
from apscheduler.schedulers.blocking import BlockingScheduler

import datetime
import time
import logging

def job_function():
    print "Hello World" + " " + str(datetime.datetime.now())

if __name__ == '__main__':
    log = logging.getLogger('apscheduler.executors.default')
    log.setLevel(logging.INFO)  # DEBUG

    fmt = logging.Formatter('%(levelname)s:%(name)s:%(message)s')

    # 将日志输出打印在屏幕上
    h = logging.StreamHandler()
    h.setFormatter(fmt)
    log.addHandler(h)

    # 将日志输出到一个文件中
    fh = logging.FileHandler("test.log", encoding="utf-8")
    fh.setFormatter(fmt)
    log.addHandler(fh)

    print ('start to do it')

    sched = BlockingScheduler()
    sched.add_job(job_function, 'cron', day_of_week='mon-fri', hour='*', minute="*", second="*/4")

    sched.start()
```
