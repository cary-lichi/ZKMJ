#-*-coding:utf-8-*-
'''
逻辑玩家类
'''
from configs.config_error import config_error
from configs.config_game import config_game
from protobuf import msg_pb2
from tools.utils import Utils
from logic.room import Room
from logic.zk_room import ZK_Room
from CMJ import CMJ
## 欢乐房间，人齐就开
class Happy_Room(ZK_Room):
    def __init__(self):
        Room.__init__(self)


    # def onDisConnect(self, id):  ##玩家掉线,id，不删除信息，仅仅把conn置空
    #     self.m_state = config_game['roomState']['disable']
    #     DongBei_Room.onDisConnect(self,id)
    #     if self.m_gamerCache.has_key(id):
    #         self.m_gamerCache.pop(id)
    #     self.beExit(id)

    # def onLeave(self, id,bKick=False):  ##玩家离开房间,id
    #     # 网络协议
    #     msg = msg_pb2.Msg()
    #     msg.type = msg_pb2.EnumMsg.Value('leaveroomresponse')
    #     msg.response.leaveRoomResponse.nErrorCode = config_error['success']
    #     msg.response.leaveRoomResponse.bKick = bKick
    #     self.sendMessage(id, msg)
    #     if self.m_gamerCache.has_key(id):
    #         self.m_gamerCache.pop(id)
    #     msg = msg_pb2.Msg()
    #     msg.type = msg_pb2.EnumMsg.Value('leaveroomnotify')
    #     msg.notify.leaveRoomNotify.nUserID = id
    #     msg.notify.leaveRoomNotify.sRoomID = self.m_id
    #     msg.notify.leaveRoomNotify.bKick = bKick
    #     self.sendOtherMessage(id, msg)
    #
    #     self.beExit(id)