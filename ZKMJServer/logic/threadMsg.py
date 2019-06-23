#-*-coding:utf-8-*-

#线程消息类
import time
from datetime import datetime
from apscheduler.schedulers.tornado  import TornadoScheduler
from tools.singleton import Singleton

class ThreadMsg:
    thread_msg_id = {
        'game_time_tick':1,#倒计时消息
        'game_add_ai': 2,#添加机器人消息
        'game_ai_put': 3,#机器人打牌消息
        'game_ai_can': 4,  # 机器人CAN牌消息
        'game_ready': 5  # 机器人CAN牌消息
    }
    def __init__(self):##
       self.id = ''
       self.msg = {}

