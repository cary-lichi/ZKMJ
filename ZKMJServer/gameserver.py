#-*-coding:utf-8
import tornado.web
import tornado.httpserver
import tornado.options
import tornado.ioloop
import tornado.log
import yaml
import logging
import logging.config

from configs import config_game
from application import webapplication
from tornado.options import define, options
from dal.dal_admin import Dal_Admin
from dal.dal_delegate import Dal_Delegate
from dal.dal_mail import Dal_Mail
from dal.dal_user import Dal_User
from dal.dal_record import Dal_Record
from dal.dal_recharge import Dal_Recharge
from dal.dal_operate import Dal_Operate
from logic.mainTimerMamager import MainTimerManager
from tools.utils import Utils
from logic.gameplay.ACMJ import ACMJ
import time as time
import datetime
import random

#coding=utf-8
define("port", default=8001, help="run on the given port", type=int)

def initLog():
    #logging.config.fileConfig('configs/logging.conf')
    logging.config.dictConfig(yaml.load(open('configs/python_logging.yaml', 'r')))

def onHttpTest(data):
    n = 0

def httpTest():
    Utils().send_post_request("127.0.0.1",8001,'/index',{'test':1},onHttpTest)

def initCache():
    Dal_User().initCache()

    # for k in range(1,300):
    #     rd = Record()
    #     rd.time = Utils().dbTimeCreate()
    #     rd.gameplay=''
    #     k = str(k)
    #     rd.gamers = "301786:"+k+"-"+k+";"+"301787:"+k+"-"+k+";"+"301788:"+k+"-"+k+";"+"301789:"+k+"-"+k
    #     Dal_Record().addRecord(rd)
    Dal_Record().initCache()
    Dal_Delegate().initCache()
    Dal_Mail().initCache()
    Dal_Admin().initCache()
    Dal_Recharge().initCache()
    Dal_Operate().initCache()

def main():
    print (options.help)
    print "Quit the server with CONTROL-C "
    tornado.options.parse_command_line()
    http_server=tornado.httpserver.HTTPServer(webapplication)
    http_server.listen(options.port)
    tornado.ioloop.IOLoop.instance().start()

def test():
    arr = [301, 301, 302, 302, 303, 303, 304, 304, 305, 305, 306, 306, 307, 307]  # 胡
    a = random.sample(arr,1)
    b = random.sample(arr, 1)
    c = random.sample(arr, 1)
    d = random.sample(arr, 1)

    mj=ACMJ()
    listArr = []
    arr = [301, 301, 302, 302, 303, 303, 304, 304, 305, 305, 306, 306, 307, 307] #胡
    listArr.append(arr)
    arr = [301, 301, 302, 302, 303, 304, 305, 306, 307, 307, 308, 308, 309, 309] #不胡
    listArr.append(arr)
    arr = [301, 301, 301, 302, 302, 303, 304, 304, 305, 305, 306, 307, 307, 307] #胡
    listArr.append(arr)
    arr = [301, 301, 301, 302, 303, 304, 305, 306, 307, 308, 308, 309, 309, 309] #胡
    listArr.append(arr)
    arr = [301, 301, 301, 302, 302, 304, 305, 306, 307, 308, 308, 309, 309, 309] #不胡
    listArr.append(arr)
    arr = [301, 301, 301, 302, 302, 304, 305, 306, 307, 308, 308, 309, 309, 309] #不胡
    listArr.append(arr)
    arr = [301, 301, 301, 302, 302, 303, 303, 304, 304, 305, 305, 305, 309, 309] #胡
    listArr.append(arr)
    arr = [301, 301, 301, 302, 302, 304, 305, 306, 307, 308, 308, 309, 309, 309]  # 不胡
    listArr.append(arr)
    arr = [301, 301, 301, 302, 302, 303, 303, 304, 304, 305, 305, 305, 309, 309]  # 胡
    listArr.append(arr)
    arr = [301, 301, 301, 302, 302, 304, 305, 306, 307, 308, 308, 309, 309, 309]  # 不胡
    listArr.append(arr)

    for i in listArr:
        if mj.isHu(i,302):
            print ("胡啦胡啦")
        else:
            print "抱歉你还不能胡哦"
    # do something


if __name__ == "__main__":
    # starttime = datetime.datetime.now()
    # for i in range(1000):
    #     test()
    # endtime = datetime.datetime.now()
    # interval = endtime - starttime
    # print interval
    initLog()
    initCache()
    main()




