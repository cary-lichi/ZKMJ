#-*-coding:utf-8-*-
from logic.zk_room import ZK_Room
from protobuf import msg_pb2
from logic.stPAI import stPAI
from logic.CMJManager import CMJManage
import random
class Hui_Room(ZK_Room):

    def __init__(self):
        ZK_Room.__init__(self)

    def initPai(self):  ##初始化玩家牌
        self.m_cmjManager.InitPai(0)  # 默认黄庄的剩余牌0张
        self.GenBaoPai()#生成宝牌
        # self.m_cmjManager.m_baoPai.m_Type=4
        # self.m_cmjManager.m_baoPai.m_Value = 5
        self.GraspPai()  # 发牌

        # 网络协议,发送宝牌协议
        msg = msg_pb2.Msg()
        msg.type = msg_pb2.EnumMsg.Value('baopaishownotify')
        msg.notify.baopaiShowNotify.nUserID = 1
        msg.notify.baopaiShowNotify.baopai.nType = self.m_cmjManager.m_baoPai.m_Type
        msg.notify.baopaiShowNotify.baopai.nValue = self.m_cmjManager.m_baoPai.m_Value
        self.sendAllMessage(msg)
        # 通知玩家起牌,之前检查暗杠
        self.getPai(self.m_boss)

    def GenBaoPai(self):  ##生成宝牌
        pai = random.sample(self.m_cmjManager.m_MJVec, 1)[0]
        CMJManage.m_baoPai.m_Type = pai.m_Type
        CMJManage.m_baoPai.m_Value = pai.m_Value
        return True

    def checkPut(self,gamerID,type,value):  ##判断出牌后其他几家是否可以胡牌，还是依方位次序
        self.m_putMsgCache = []
        if(type != self.m_cmjManager.m_baoPai.m_Type or value != self.m_cmjManager.m_baoPai.m_Value):
            self.checkPutOther(gamerID,type,value)
        self.sendCheckPutMsg()
    def onConnect(self, id, conn):  ##玩家掉线重连,复用玩家加入房间协议
        self.sendConnectMessage(id, conn)
        # 网络协议,发送宝牌协议
        msg = msg_pb2.Msg()
        msg.type = msg_pb2.EnumMsg.Value('baopaishownotify')
        msg.notify.baopaiShowNotify.nUserID = 1
        msg.notify.baopaiShowNotify.baopai.nType = self.m_cmjManager.m_baoPai.m_Type
        msg.notify.baopaiShowNotify.baopai.nValue = self.m_cmjManager.m_baoPai.m_Value
        self.sendMessage(id,msg)


