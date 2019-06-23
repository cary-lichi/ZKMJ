#-*-coding:utf-8-*-
'''
逻辑玩家类
'''

## 商水房间
from logic.zk_room import ZK_Room
class ShangShui_Room(ZK_Room):
    def __init__(self):
        ZK_Room.__init__(self)