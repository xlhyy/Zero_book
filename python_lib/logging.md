### logging


- 知识点
```
# encoding: utf-8

import logging


# 配置输出日志格式
LOG_FORMAT = "%(asctime)s %(name)s %(levelname)s %(pathname)s %(message)s"

# 配置输出时间的格式
DATE_FORMAT = "%Y-%m-%d %H:%M:%S %a"

logging.basicConfig(
            level = logging.DEBUG,
            format = LOG_FORMAT,
            datefmt = DATE_FORMAT,
            filename = r"./test.log"
        )

if __name__ == '__main__':
    logging.debug("msg_debug")
    logging.info("msg_info")
    logging.warning("msg_warning")
    logging.error("msg_error")
    logging.critical("msg_critical")
```


```
# encoding: utf-8

import logging
import sys
reload(sys)
sys.setdefaultencoding("utf-8")

def log():
    # 创建logger，如果参数为空则返回root looger
    logger = logging.getLogger("nick")

    # 设置logger日志等级
    logger.setLevel(logging.DEBUG)

    # 如果logger.handlers列表为空，则添加；否则，直接去写日志
    if not logger.handlers:
        # 创建handler
        fh = logging.FileHandler("test2.log", encoding="utf-8")
        ch = logging.StreamHandler()

        # 设置输出日志格式
        formatter = logging.Formatter(
                    fmt = "%(asctime)s %(name)s %(filename)s %(message)s",
                    datefmt = "%Y/%m/%d %X"
                )

        # 为handler指定输出格式
        fh.setFormatter(formatter)
        ch.setFormatter(formatter)

        # 为logger添加的日志处理器
        logger.addHandler(fh)
        logger.addHandler(ch)

    return logger

if __name__ == '__main__':
    logger = log()
    print "======================="
    logger.warning("泰拳警告")
    print "======================="
    logger.info("提示")
    print "======================="
    logger.error("错误")
    print "======================="
    logger.debug("查错")
```


- 练习
```
import logging

def write_log(info, file_name):
    logger = logging.getLogger()
    hdlr = logging.FileHandler('/tmp/%s' % file_name)
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    hdlr.setFormatter(formatter)
    logger.addHandler(hdlr)
    logger.setLevel(logging.INFO)
    logger.info(info)
    logger.removeHandler(hdlr)
```


```
注: logger_funcs.py文件中内容是由很多个如下类似的函数组成:
def egg_open_egg(env, args, data):
    return {'reward': data.get('reward')}
函数名为: 'views文件名' + 'views文件中的方法名' (即: 网络请求中的method=egg.open_egg)

import logger_funcs
method = env.get_argument('method')
if method:
    func_name = '_'.join(method.split('.'))     # 解析出函数名
    func = getattr(logger_funcs, func_name, None)
    if callable(func):
        result = func()
        """对数据库进行操作
        """
```


```
# encoding: utf-8

import logging, os

BASE_ROOT = os.path.dirname(os.path.abspath(__file__)) + os.path.sep


class LoggingUtil(object):
    """日志工具类
    """
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')

    def __init__(self, path, file_name):
        self.new_file_path = self.file_path(path)
        self.file_name = os.path.join(self.new_file_path, file_name)
        self.check_path()
        self.logger = logging.getLogger(os.path.join(path, file_name))
        self.fhandler = logging.FileHandler(self.file_name)
        self.fhandler.setLevel(logging.DEBUG)
        self.fhandler.setFormatter(self.formatter)
        self.logger.addHandler(self.fhandler)
        self.logger.setLevel(logging.DEBUG)

    def file_path(self, path):
        """文件的路径
        :return:
        """
        return os.path.join(BASE_ROOT, 'logs', path)

    def check_path(self):
        """检查路径
        :return:
        """
        if not os.path.exists(self.new_file_path):
            os.makedirs(self.new_file_path)

    def add_msg(self, sort, msg, *args, **kwargs):
        """添加信息
        :param sort: 类型
        :param msg: 信息
        :return:
        """
        if isinstance(sort, int):
            name = logging._LevelNames.get(sort)
        else:
            name = sort
        name = name.lower()
        if hasattr(self.logger, name):
            func = getattr(self.logger, name)
            func(msg, *args, **kwargs)
            return True
        else:
            return False

    def info(self, msg, *args, **kwargs):
        self.logger.info(msg, *args, **kwargs)

    def debug(self, msg, *args, **kwargs):
        self.logger.debug(msg, *args, **kwargs)


class LoggingCache(object):
    """日志缓存类
    """
    logging_pool = {}

    @classmethod
    def get_logging_with_filename(cls, path, filename, logging_class=LoggingUtil):
        """
        通过文件名获取logging
        :param path:
        :param filename:
        :return:
        """
        f = os.path.join(path, filename)
        logging_util = cls.logging_pool.get(f)
        if logging_util:
            return logging_util

        logging_util = logging_class(path, filename)

        cls.logging_pool[f] = logging_util

        return logging_util

l1 = LoggingUtil('log', 'l1log')
l2 = LoggingCache()
```
