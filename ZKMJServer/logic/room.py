#-*-coding:utf-8-*-
import traceback
from random import random

from configs.config_default import configs_default
from configs.config_game import config_game
from configs.config_error import config_error
from dal.dal_record import Dal_Record
from logic.mainTimerMamager import MainTimerManager
from logic.stCHI import stCHI
from logic.stGang import stGang
from logic.stGangAI import stGangAI
from logic.stPAI import stPAI
from logic.gamer import Gamer
from logic.CMJManager import CMJManage
from logic.stPeng import stPeng
from model.record import Record
from protobuf import msg_pb2
from tools.utils import Utils
from dal.dal_user import Dal_User
import uuid
## 定义一个房间基类
class Room:
    m_Index = 10000;
    m_IndexAI = -1;
    def __init__(self):##初始化
        return

    def __del__(self):##
        return

    #创建房间
    def initRoom(self,message,conn,parent):
        self.m_parent = parent
        self.m_owner = message.nUserID  # 房主id
        self.m_ownerCache = [] #房主的轮次队列
        self.m_creater=message.nUserID #创建者
        Room.m_Index = (Room.m_Index + 1)
        if Room.m_Index >= 100000:Room.m_Index = 10000
        self.m_id = (str)(Room.m_Index)  ##(str)(uuid.uuid1())  # 生成房间id
        self.m_cmjManager = CMJManage(message.gamePlay)
        self.m_geter = message.nUserID  # 默认当前活跃玩家是房主
        self.m_puter = None
        self.m_gamerCache = dict()  ##玩家集合，id:gamer
        self.m_putMsgCache = []  ##出牌处理的消息队列
        self.m_boss = message.nUserID
        self.m_state = config_game['roomState']['ready']  # 0 未开始，1已经开始,2已结束
        self.m_timerMgr= MainTimerManager()  ##超时处理队列
        self.m_cardID = str(message.sCardType)#房卡配置ID
        self.m_cardCount = 0 #房卡圈数计数，完成之后销毁房间
        self.m_bHuang = False
        self.m_gamePlay = message.gamePlay
        self.m_bNeedAI =self.IsHappyRoom()
        self.m_lastPutPai = stPAI()
        self.m_maxPlayerNum = message.nPlayers
        if self.m_maxPlayerNum < 2: self.m_maxPlayerNum = config_game['maxGamer']
        self.onCreate( message.nUserID, conn)

        #代理创建房间

    def initDeleRoom(self,message,parent):
        self.m_parent = parent
        self.m_owner = None  # 房主id
        self.m_ownerCache = []  # 房主的轮次队列
        self.m_creater=message.nUserID #房间的创建者
        Room.m_Index = (Room.m_Index + 1)
        if Room.m_Index >= 100000:Room.m_Index = 10000
        self.m_id = (str)(Room.m_Index)  ##(str)(uuid.uuid1())  # 生成房间id
        self.m_cmjManager = CMJManage()
        self.m_geter = None  # 默认当前活跃玩家是房主
        self.m_puter = None
        self.m_gamerCache = dict()  ##玩家集合，id:gamer
        self.m_putMsgCache = []  ##出牌处理的消息队列
        self.m_boss = None
        self.m_state = config_game['roomState']['ready']  # 0 未开始，1已经开始,2已结束
        self.m_timerMgr= MainTimerManager()  ##超时处理队列
        self.m_cardID = str(message.sCardType)#房卡配置ID
        self.m_cardCount = 0 #房卡圈数计数，完成之后销毁房间
        self.m_bHuang = False
        self.m_gamePlay = message.gamePlay
        self.m_bNeedAI =self.IsHappyRoom()
        self.m_lastPutPai = stPAI()
        self.m_maxPlayerNum = message.nPlayers
        if self.m_maxPlayerNum < 2: self.m_maxPlayerNum = config_game['maxGamer']

        msg = msg_pb2.Msg()
        msg.type = msg_pb2.EnumMsg.Value('createdeleroomresponse')
        msg.response.createRoomResponse.nErrorCode = config_error['success']
        msg.response.createRoomResponse.sRoomID = self.m_id
        msg.response.createRoomResponse.sCardType = self.m_cardID
        msg.response.createRoomResponse.nPlayers = self.m_maxPlayerNum
        msg.response.createRoomResponse.gamePlay.nType = self.m_gamePlay.nType

        for k, v in enumerate(self.m_gamePlay.optionals):
            msg.response.createRoomResponse.gamePlay.optionals.append(v)

        return msg

    def isFull(self):#判定房间是否已满
        return (len(self.m_gamerCache) >= self.m_maxPlayerNum)

    def sendConnMessage(self,conn,msg):##向玩家发送消息
        data = msg.SerializeToString()
        if conn != None:
            conn.write_message(data,True)

    def sendMessage(self,id,msg):##向玩家发送消息
        data = msg.SerializeToString()
        gamer = self.m_gamerCache.get(id)
        if gamer == None:
            return
        if gamer.conn != None:
            gamer.conn.write_message(data,True)
        #self.HandleAI(gamer, msg)



    def sendOtherMessage(self,id,msg):##向玩家发送消息
        data = msg.SerializeToString()
        for k,v in self.m_gamerCache.iteritems():
            if k != id:
               if v.conn != None:
                  v.conn.write_message(data,True)

    def sendAllMessage(self,msg):##向玩家发送消息
        data = msg.SerializeToString()
        for k,v in self.m_gamerCache.iteritems():
               if v.conn != None:
                  v.conn.write_message(data,True)
                  #self.HandleAI(v, msg)


##网络协议相关

    def onCreate(self,id,conn):  ##玩家创建房间,id
            msg = msg_pb2.Msg()
            msg.type = msg_pb2.EnumMsg.Value('createroomresponse')
            msg.response.createRoomResponse.nErrorCode = config_error['success']

            if self.IsUserInRoom(id):
               msg.response.createRoomResponse.nErrorCode = config_error['alreadyinroom']
               self.sendConnMessage(conn,msg)
               return

            newGamer = Gamer(id,conn,self.genPos())
            newGamer.boss = True
            self.m_gamerCache[id] = newGamer

            msg.response.createRoomResponse.sRoomID = self.m_id
            msg.response.createRoomResponse.sCardType = self.m_cardID
            msg.response.createRoomResponse.nPlayers = self.m_maxPlayerNum
            msg.response.createRoomResponse.gamePlay.nType = self.m_gamePlay.nType
            for k, v in enumerate(self.m_gamePlay.optionals):
                msg.response.createRoomResponse.gamePlay.optionals.append(v)
            self.sendMessage(id,msg)

            newGamer.initGamePlay(self.m_gamePlay)

            Dal_User().setRoom(id,self.m_id)

            self.AddReadyTimer(id)
            self.AddAITimer()


    def onDestory(self):  ##房间销毁前的处理
        self.cancelTimeOutAll()
        for k,v in self.m_gamerCache.iteritems():
           Dal_User().setRoom(k,'')
        self.m_parent.destory_room(self.m_id)


    def onJoin(self,id,conn,bAI=False):##玩家加入房间,id
                # 网络协议,响应
                msg = msg_pb2.Msg()
                msg.type = msg_pb2.EnumMsg.Value('joinroomresponse')
                if self.IsUserInRoom(id):
                   msg.response.joinRoomResponse.nErrorCode = config_error['alreadyinroom']
                   self.sendConnMessage(conn,msg)
                   return

                newGamer = self.m_gamerCache.get(id)
                if newGamer == None:
                    if self.isFull():
                        msg.response.joinRoomResponse.nErrorCode = config_error['roomfull']
                        self.sendConnMessage(conn,msg)
                        return
                    # if id != self.m_owner and self.IsHappyRoom()==False:#非房主加入需要房主在线才行
                        # boss = self.m_gamerCache.get(self.m_boss)
                        # if boss and boss.conn == None:
                        #     msg.response.joinRoomResponse.nErrorCode = config_error['bossleft']
                        #     self.sendConnMessage(conn, msg)
                        #     return

                    newGamer = Gamer(id,conn,self.genPos(),bAI)
                    if bAI:
                        self.AddAIReadyTimer(id)
                    self.m_gamerCache[id] = newGamer
                    self.m_ownerCache.append(id)
                    if (self.m_owner == None):  # 如果房间没有房主，就生成一个房主
                        self.setNewOwner()
                    newGamer.initGamePlay(self.m_gamePlay)
                    Dal_User().setRoom(id,self.m_id)


                msg.response.joinRoomResponse.nErrorCode = config_error['success']
                msg.response.joinRoomResponse.joinRoom.sID = self.m_id
                msg.response.joinRoomResponse.joinRoom.nState = self.m_state
                msg.response.joinRoomResponse.joinRoom.gamePlay.nType = self.m_gamePlay.nType
                msg.response.joinRoomResponse.joinRoom.nCardCount = self.m_cardCount
                msg.response.joinRoomResponse.joinRoom.sCardType = self.m_cardID
                msg.response.joinRoomResponse.joinRoom.nPlayers = self.m_maxPlayerNum
                msg.response.joinRoomResponse.joinRoom.nOwnerID = self.m_owner
                for k,v in enumerate(self.m_gamePlay.optionals):
                    msg.response.joinRoomResponse.joinRoom.gamePlay.optionals.append(v)

                for k,v in self.m_gamerCache.iteritems():
                     user = Dal_User().getUser(k)
                     gamer = msg.response.joinRoomResponse.joinRoom.Gamers.add()
                     gamer.sRoomID = self.m_id
                     gamer.nGID = k
                     if user:
                         gamer.sName = user.nick
                         gamer.sHeadImage = user.headimg
                         gamer.nGender = user.gender
                         gamer.location.sAddress = user.location.sAddress
                         gamer.location.bIsLocation = user.location.bIsLocation
                         gamer.location.sLat = user.location.sLat
                         gamer.location.sLng = user.location.sLng
                     else:
                         gamer.sName = ''
                         gamer.sHeadImage = ''
                         gamer.nAIRandInfo = v.m_nAIRandInfo
                         gamer.nAIRandHead = v.m_nAIRandHead
                     gamer.bBoss = (k == self.m_boss)
                     gamer.bOwner = (k == self.m_owner)
                     gamer.nPos = v.pos
                     gamer.state = v.state
                     gamer.paipool.nID = k
                     gamer.totalScore = v.m_TotalScore
                     gamer.gameState = v.m_nGameState
                     gamer.bOnline = (v.conn != None)
                     gamer.bAI = v.m_bAI
                     if v.m_bAI:gamer.bOnline = True
                     for type, pool in enumerate(v.cmj.m_MyPAIVec):
                         paipool = gamer.paipool.pool.add()
                         paipool.nType = type
                         for i, value in enumerate(pool):
                             paipool.nValue.append(value)
                     for type, pool in enumerate(v.cmj.m_ChiPAIVec):
                         paipool = gamer.paipool.chiPool.add()
                         paipool.nType = type
                         for i, value in enumerate(pool):
                             paipool.nValue.append(value)
                     for type, pool in enumerate(v.cmj.m_PengPAIVec):
                         paipool = gamer.paipool.pengPool.add()
                         paipool.nType = type
                         for i, value in enumerate(pool):
                             paipool.nValue.append(value)
                     for type, pool in enumerate(v.cmj.m_MGangPAIVec):
                         paipool = gamer.paipool.mGangPool.add()
                         paipool.nType = type
                         for i, value in enumerate(pool):
                             paipool.nValue.append(value)
                     for type, pool in enumerate(v.cmj.m_AGangPAIVec):
                         paipool = gamer.paipool.aGangPool.add()
                         paipool.nType = type
                         for i, value in enumerate(pool):
                             paipool.nValue.append(value)
                     for type, paiObj in enumerate(v.cmj.m_PutPAIVec):
                         paipool = gamer.paipool.putPool.add()
                         paipool.nType = paiObj.m_Type
                         paipool.nValue.append(paiObj.m_Value)

                self.sendMessage(id,msg)

                #网络协议,通知其他人加入了新人
                if self.m_state == config_game['roomState']['ready']:#没有开始牌局的状态下
                    msg = msg_pb2.Msg()
                    msg.type = msg_pb2.EnumMsg.Value('joinroomnotify')
                    user = Dal_User().getUser(newGamer.id)
                    msg.notify.joinRoomNotify.joinGamer.sRoomID = self.m_id
                    msg.notify.joinRoomNotify.joinGamer.nGID = newGamer.id
                    if user:
                        msg.notify.joinRoomNotify.joinGamer.sName = user.nick
                        msg.notify.joinRoomNotify.joinGamer.sHeadImage = user.headimg
                        msg.notify.joinRoomNotify.joinGamer.nGender = user.gender
                        msg.notify.joinRoomNotify.joinGamer.location.sAddress = user.location.sAddress
                        msg.notify.joinRoomNotify.joinGamer.location.bIsLocation = user.location.bIsLocation
                        msg.notify.joinRoomNotify.joinGamer.location.sLat = user.location.sLat
                        msg.notify.joinRoomNotify.joinGamer.location.sLng = user.location.sLng
                    else:
                        msg.notify.joinRoomNotify.joinGamer.sName = ''
                        msg.notify.joinRoomNotify.joinGamer.sHeadImage = ''
                        msg.notify.joinRoomNotify.joinGamer.nAIRandInfo = newGamer.m_nAIRandInfo
                        msg.notify.joinRoomNotify.joinGamer.nAIRandHead = newGamer.m_nAIRandHead
                    msg.notify.joinRoomNotify.joinGamer.bBoss = newGamer.boss
                    msg.notify.joinRoomNotify.joinGamer.bOwner = (newGamer.id == self.m_owner)
                    msg.notify.joinRoomNotify.joinGamer.nPos = newGamer.pos
                    msg.notify.joinRoomNotify.joinGamer.state = newGamer.state
                    msg.notify.joinRoomNotify.joinGamer.gameState = newGamer.m_nGameState
                    msg.notify.joinRoomNotify.joinGamer.totalScore = newGamer.m_TotalScore
                    self.sendOtherMessage(id,msg)

                    self.AddAITimer()
                    self.AddReadyTimer(id)
                    self.gameStart()



    def onLeave(self, id,bKick=False):  ##玩家离开房间,id
            #网络协议
            msg = msg_pb2.Msg()
            msg.type = msg_pb2.EnumMsg.Value('leaveroomresponse')
            msg.response.leaveRoomResponse.nErrorCode = config_error['success']
            msg.response.leaveRoomResponse.bKick = bKick
            if self.IsUserInRoom(id) == False:
               msg.response.leaveRoomResponse.nErrorCode = config_error['notinroom']
               self.sendMessage(id, msg)
               return

            if self.m_state != config_game['roomState']['ready'] and \
                self.m_state !=config_game['roomState']['ending']:#只有房间处于准备状态可以离开
                msg.response.leaveRoomResponse.nErrorCode = config_error['roomstateerror']
                self.sendMessage(id, msg)
                return False

            self.sendMessage(id, msg)
            self.m_gamerCache.pop(id)
            Dal_User().setRoom(id,'')
            if(self.m_owner==id):#如果退出房间的人是房主，则将房主转让
                self.setNewOwner()
            msg = msg_pb2.Msg()
            msg.type = msg_pb2.EnumMsg.Value('leaveroomnotify')
            msg.notify.leaveRoomNotify.nUserID = id
            msg.notify.leaveRoomNotify.sRoomID = self.m_id
            msg.notify.leaveRoomNotify.bKick = bKick
            self.sendOtherMessage(id, msg)
            self.AddAITimer()
            self.beExit(id)

    def onConnect(self, id, conn):  ##玩家掉线重连,复用玩家加入房间协议
        self.sendConnectMessage(id, conn)
    def sendConnectMessage(self, id,conn):  ##玩家掉线重连,复用玩家加入房间协议
            disconnGamer = self.m_gamerCache.get(id)
            disconnGamer.conn = conn
            disconnGamer.m_bAI = False
            msg = msg_pb2.Msg()
            msg.type = msg_pb2.EnumMsg.Value('joinroomresponse')
            msg.response.joinRoomResponse.nErrorCode = 0
            msg.response.joinRoomResponse.joinRoom.sID = self.m_id
            msg.response.joinRoomResponse.joinRoom.nState = self.m_state
            msg.response.joinRoomResponse.joinRoom.gamePlay.nType = self.m_gamePlay.nType
            msg.response.joinRoomResponse.joinRoom.nCardCount = self.m_cardCount
            msg.response.joinRoomResponse.joinRoom.sCardType = self.m_cardID
            msg.response.joinRoomResponse.joinRoom.nPlayers = self.m_maxPlayerNum
            msg.response.joinRoomResponse.joinRoom.nOwnerID = self.m_owner
            for k, v in enumerate(self.m_gamePlay.optionals):
                msg.response.joinRoomResponse.joinRoom.gamePlay.optionals.append(v)

            for k, v in self.m_gamerCache.iteritems():
                user = Dal_User().getUser(k)
                gamer = msg.response.joinRoomResponse.joinRoom.Gamers.add()
                gamer.sRoomID = self.m_id
                gamer.nGID = k
                if user:
                    gamer.sName = user.nick
                    gamer.sHeadImage = user.headimg
                    gamer.nGender = user.gender
                    gamer.location.sAddress = user.location.sAddress
                    gamer.location.bIsLocation = user.location.bIsLocation
                    gamer.location.sLat = user.location.sLat
                    gamer.location.sLng = user.location.sLng
                else:
                    gamer.sName = ''
                    gamer.sHeadImage = ''
                    gamer.nAIRandInfo = v.m_nAIRandInfo
                    gamer.nAIRandHead = v.m_nAIRandHead
                gamer.bBoss = (k == self.m_boss)
                gamer.bOwner = (k == self.m_owner)
                gamer.nPos = v.pos
                gamer.state = v.state
                gamer.paipool.nID = k
                gamer.totalScore = v.m_TotalScore
                gamer.gameState = v.m_nGameState
                gamer.bOnline = (v.conn != None)
                gamer.bAI = v.m_bAI
                if v.m_bAI:gamer.bOnline = True
                for type, pool in enumerate(v.cmj.m_MyPAIVec):
                    paipool = gamer.paipool.pool.add()
                    paipool.nType = type
                    for i, value in enumerate(pool):
                        paipool.nValue.append(value.m_Value)
                for i, value in enumerate(v.cmj.m_BaoPAIVec):
                    newPool = gamer.paipool.pool[value.m_Type]
                    newPool.nValue.append(value.m_Value)
                for type, paiObj in enumerate(v.cmj.m_PutPAIVec):
                    paipool = gamer.paipool.putPool.add()
                    paipool.nType = paiObj.m_Type
                    paipool.nValue.append(paiObj.m_Value)
                for index, paiObj in enumerate(v.cmj.m_OrderPaiVec):
                    orderpai = gamer.paipool.orderPai.add()
                    if isinstance(paiObj,stPAI):
                        orderpai.pai.nType = paiObj.m_Type
                        orderpai.pai.nValue = paiObj.m_Value
                    elif isinstance(paiObj,stCHI):
                        orderpai.chipai.nType = paiObj.m_Type
                        orderpai.chipai.nValue1 = paiObj.m_Value1
                        orderpai.chipai.nValue2 = paiObj.m_Value2
                        orderpai.chipai.nValue3 = paiObj.m_Value3
                    if isinstance(paiObj,stPeng):
                        orderpai.pengpai.nType = paiObj.m_Type
                        orderpai.pengpai.nValue = paiObj.m_Value
                    if isinstance(paiObj, stGang):
                        orderpai.gangpai.nType = paiObj.m_Type
                        orderpai.gangpai.nValue = paiObj.m_Value
                        orderpai.gangpai.nGangState = paiObj.m_nState

            self.sendMessage(id, msg)

            for k, v in self.m_gamerCache.iteritems():
                if v.lastMsg != None:  # 断线后有can牌消息重新发送
                    if  k != id:continue
                    self.sendMessage(id,v.lastMsg)

            # 网络协议,通知其他人加入了新人

            msg = msg_pb2.Msg()
            msg.type = msg_pb2.EnumMsg.Value('connectnotify')
            msg.notify.connectNotify.nUserID = id
            msg.notify.connectNotify.sRoomID = self.m_id
            self.sendOtherMessage(id, msg)
            self.resumeTimeOutAll()


    def onDisConnect(self, id):  ##玩家掉线,id，不删除信息，仅仅把conn置空
            #self.pauseTimeOutAll()

            gamer = self.m_gamerCache.get(id)
            gamer.conn = None
            if self.IsHappyRoom():  # 只有欢乐场掉线变托管
                gamer.m_bAI = True

            # if self.m_owner==id: #如果房主掉线转让房主
            #     self.m_owner=None

            #网络协议
            msg = msg_pb2.Msg()
            msg.type = msg_pb2.EnumMsg.Value('disconnectnotify')
            msg.notify.disConnectNotify.nUserID = id
            msg.notify.disConnectNotify.sRoomID = self.m_id
            self.sendOtherMessage(id, msg)

    def onDissRoom(self, id):  #必须是房主才能解散房间
            #网络协议
            msg = msg_pb2.Msg()
            msg.type = msg_pb2.EnumMsg.Value('dissroomresponse')
            msg.response.dissRoomResponse.nErrorCode = config_error['success']
            gamer = self.m_gamerCache.get(id)
            if id != self.m_owner:
                msg.response.dissRoomResponse.nErrorCode = config_error['notroomowner']
                self.sendMessage(id, msg)
                return False

            if self.IsUserInRoom(id) == False:
               msg.response.dissRoomResponse.nErrorCode = config_error['notinroom']
               self.sendMessage(id, msg)
               return False
            self.sendMessage(id, msg)

            msg = msg_pb2.Msg()
            msg.type = msg_pb2.EnumMsg.Value('dissroomgamenotify')
            msg.notify.dissRoomNotify.nUserID = id
            msg.notify.dissRoomNotify.sRoomID = self.m_id
            self.sendOtherMessage(id, msg)

            self.onDestory()
            return True

    def onKick(self, id):  ##游戏中踢出玩家，托管
        msg = msg_pb2.Msg()
        msg.type = msg_pb2.EnumMsg.Value('leaveroomresponse')
        msg.response.leaveRoomResponse.nErrorCode = config_error['success']
        msg.response.leaveRoomResponse.bKick = True
        if self.IsUserInRoom(id) == False:
            msg.response.leaveRoomResponse.nErrorCode = config_error['notinroom']
            self.sendMessage(id, msg)
            return

        self.sendMessage(id, msg)

        gamer = self.m_gamerCache.get(id)
        gamer.conn = None
        gamer.m_bAI = True

        msg = msg_pb2.Msg()
        msg.type = msg_pb2.EnumMsg.Value('leaveroomnotify')
        msg.notify.leaveRoomNotify.nUserID = id
        msg.notify.leaveRoomNotify.sRoomID = self.m_id
        msg.notify.leaveRoomNotify.bKick = True
        self.sendOtherMessage(id, msg)

#########################################################################

    def onHuang(self):  ##黄庄
        self.m_bHuang = True
        self.gameEnd(True)#游戏结束


    def getPai(self,gamerID):  ##玩家摸牌
                 if self.m_state != config_game['roomState']['doing']:
                     return

                 if self.m_cmjManager.IsOver():
                     self.onHuang()
                     return

                 gamer = self.m_gamerCache.get(gamerID)
                 gamer.resetCircle()
                 gamer.m_nGameAction = config_game['gameAction']['geipai']
                 pai = self.genPaiNet(gamer)

                 msg = msg_pb2.Msg()
                 msg.type = msg_pb2.EnumMsg.Value('canpainotify')
                 msg.notify.canPaiNotify.nUserID = gamerID
                 msg.notify.canPaiNotify.bZm = True

                 canGang = False
                 canTing = False
                 canHu = False

                 if gamer.getTing() == False:
                     canGang = self.checkGetGang(gamerID,msg)
                     putTingPais = gamer.cmj.CheckPutTING()
                     canTing =  (len(putTingPais) > 0)
                 else:
                     canHu = gamer.cmj.CheckAllPai(config_game['MJ']['MJPAI_GETPAI'])

                 if canGang :
                     gamer.setCanGang(True)
                     msg.notify.canPaiNotify.canGang = True
                 if canTing:
                     gamer.setCanTing(True)
                     msg.notify.canPaiNotify.canTing = True
                 if canHu:
                    gamer.setCanHu(canHu)
                    msg.notify.canPaiNotify.canHu = True
                    msg.notify.canPaiNotify.lastHuType = self.CheckLastBao(gamer,pai.m_NewPai.m_Type, pai.m_NewPai.m_Value)
                    msg.notify.canPaiNotify.lastPai.nType = pai.m_NewPai.m_Type
                    msg.notify.canPaiNotify.lastPai.nValue = pai.m_NewPai.m_Value
                    gamer.m_huPai.m_Type = pai.m_NewPai.m_Type
                    gamer.m_huPai.m_Value =  pai.m_NewPai.m_Value

                 if canGang or canTing or canHu:
                     gamer.lastMsg = msg
                     self.startTimeOut(gamerID,msg)
                     self.sendMessage(gamerID, msg)
                     self.HandleAI(gamer, msg)
                     return

                 if gamer.getTing() and gamer.m_bAI == False:#已经听牌，不胡也不黄庄
                     #自动帮已经听牌的玩家打牌
                     self.putPai(gamerID)
                     #Utils().logMainDebug('getPai')
                     self.onPutTimeOut(gamerID)
                     return

                  ##上述情况都不存在,通知摸牌的人打牌
                 self.putPai(gamerID)

    def putPai(self,gamerID,nPutState = 0):  ##玩家出牌，检查打哪些牌可以听
            if self.m_state != config_game['roomState']['doing']:
                return
            gamer = self.m_gamerCache.get(gamerID)
            gamer.resetCircle()
            msg = msg_pb2.Msg()
            msg.type = msg_pb2.EnumMsg.Value('doputpainotify')
            msg.notify.doPutPaiNotify.nUserID = gamerID
            msg.notify.doPutPaiNotify.nPutState = nPutState
            if gamer.getTing() and gamer.m_bTinged == False:
                putTingPais = gamer.cmj.CheckPutTING()
                if len(putTingPais) > 0:
                    gamer.m_bTinged = True
                    gamer.setCanTing(True)
                    if(nPutState == config_game["putPaiState"]["normal"]):
                        msg.notify.doPutPaiNotify.nPutState = config_game["putPaiState"]["moting"]
                    for k,v in enumerate(putTingPais):
                        hupai = msg.notify.doPutPaiNotify.huPais.add()
                        hupai.pai.nType = v.m_canTingPai.m_Type
                        hupai.pai.nValue = v.m_canTingPai.m_Value
                        for k1,v1 in enumerate(v.m_canHuList):
                             hupaipool = hupai.pool.add()
                             hupaipool.pai.nType = v1.m_Type
                             hupaipool.pai.nValue = v1.m_Value
                             hupaipool.count = self.GetLeftCanHuPai(gamerID,v1)

            gamer.lastMsg = msg
            self.sendAllMessage(msg)
            self.startTimeOut(gamerID,msg)# 启动打牌超时计数
            self.HandleAI(gamer,msg)


    def onPutPai(self,gamerID,type,value):  ##玩家出牌
        try:
             if self.m_state != config_game['roomState']['doing']:
                 return False#牌局处于非开始状态不能打牌
             if  self.m_puter == gamerID:#不能一次出两张
                 msg = msg_pb2.Msg()
                 msg.type = msg_pb2.EnumMsg.Value('putpairesponse')
                 msg.response.putPaiResponse.nErrorCode = config_error['userrepeated']
                 self.sendMessage(gamerID, msg)
                 return False

             self.cancelTimeOut(gamerID)

             gamer = self.m_gamerCache.get(gamerID)
             if gamer.cmj.GetPaiIndex(type,value) == -1:
                 Utils().logMainDebug("出牌错误，没有这张牌")
                 return False

             gamer.lastMsg = None
             self.m_puter = gamerID
             gamer.m_nGameAction = config_game["gameAction"]["putpai"]
             self.m_lastPutPai.m_Type = type
             self.m_lastPutPai.m_Value = value
             gamer.onDelPai(type,value)#删除当前出的牌
             gamer.cmj.AddPutPai(type, value)
             ##网络协议,出牌响应
             msg = msg_pb2.Msg()
             msg.type = msg_pb2.EnumMsg.Value('putpairesponse')
             msg.response.putPaiResponse.nErrorCode = config_error['success']
             msg.response.putPaiResponse.putPai.nType = type
             msg.response.putPaiResponse.putPai.nValue = value
             self.sendMessage(gamerID, msg)

            ##网络协议,通知其他玩家有人打牌了
             msg = msg_pb2.Msg()
             msg.type = msg_pb2.EnumMsg.Value('putpainotify')
             msg.notify.putPaiNotify.nUserID = gamerID
             msg.notify.putPaiNotify.putPai.nType = type
             msg.notify.putPaiNotify.putPai.nValue = value
             self.sendOtherMessage(gamerID,msg)
             ##检测出牌玩家是否可以听牌
             ##检测其他玩家是否可以胡牌、吃牌、碰牌、杠牌，
             ##吃牌仅仅判断下家
             ##将所有可能情况按优先级做成消息队列，
             # 在玩家响应过牌的时候依次从消息队列中再次通知玩家
             # 在玩家响应处理的时候消息队列取消
           #  Utils().logMainDebug('玩家'+str(gamerID)+'打牌' + Utils().logPaiString(type,value))
             self.checkPut(gamerID,type,value)
             return True
        except Exception, e:
            msg = traceback.format_exc()  # 方式1
            Utils().logMainDebug(msg)

    def onGuoPai(self,gamerID,type):  ##玩家过牌
            if self.m_state != config_game['roomState']['doing']:
                return
            gamer = self.m_gamerCache.get(gamerID)
            if gamer.getCanGuo() == False:return

            gamer.lastMsg = None
            self.cancelTimeOut(gamerID)

            # 过牌响应
            msg = msg_pb2.Msg()
            msg.type = msg_pb2.EnumMsg.Value('guopairesponse')
            msg.response.guoPaiResponse.nErrorCode = config_error['success']
            self.sendMessage(gamerID, msg)

            # 向其他玩家发送过牌通知
            msg = msg_pb2.Msg()
            msg.type = msg_pb2.EnumMsg.Value('guopainotify')
            msg.notify.guoPaiNotify.nUserID = gamerID
            msg.notify.guoPaiNotify.sRoomID = self.m_id
            self.sendOtherMessage(gamerID, msg)

            #self.ClearCircle()
            gamer.resetCircle()
            if type == 1:#自摸胡
                self.putPai(gamerID)
                self.onPutTimeOut(gamerID)
            elif type == 3:  # 自摸杠
                self.putPai(gamerID)
            elif type == 4: # 吃碰杠听胡（别人打）
                self.sendCheckPutMsg()# 继续从消息队列中发送通知


    def sendCheckPutMsg(self):  ##判断出牌后其他几家是否可以胡牌，还是依方位次序
             if self.m_state == config_game['roomState']['ending']:#已经结束
                 return

             if len(self.m_putMsgCache) <= 0:
                 self.ClearCircle()
                 nextGamer = self.getNextGamer(self.m_geter)
                 self.getPai(nextGamer.id)
                 return False

             msg = self.m_putMsgCache.pop(0)
             gamer = self.m_gamerCache.get(msg.notify.canPaiNotify.nUserID)
             gamer.lastMsg = msg
             self.sendAllMessage(msg)

             self.startTimeOut(msg.notify.canPaiNotify.nUserID,msg)
             self.HandleAI(gamer, msg)
             return True

    def checkPut(self,gamerID,type,value):  ##判断出牌后其他几家是否可以胡牌，还是依方位次序
        self.m_putMsgCache = []
        self.checkPutOther(gamerID,type,value)
        self.sendCheckPutMsg()

    def checkPutOther(self,gamerID,type,value):  ##判断出牌后其他几家是否可以杠碰吃牌，还是依方位次序
             msgPoolTemp = dict()
             gamer = self.m_gamerCache.get(gamerID)

             nexter = None
             rangeMax = self.m_maxPlayerNum - 1
             for i in range(rangeMax,0,-1):
                 level = 0
                 if nexter == None:
                    nexter = self.getNextGamer(gamer.id)
                 else:
                    nexter = self.getNextGamer(nexter.id)
                 nexter.cmj.ResetTemp()

                 canHu = False
                 canGang = False
                 canPeng = False
                 canChi = False
                 if nexter.getTing():  # 只有听牌状态才检测胡
                     nexter.cmj.AddPai(type, value)  # 先添加，判断后再删除
                     canHu = nexter.cmj.CheckAllPai(config_game['MJ']['MJPAI_GETPAI'])
                     nexter.setCanHu(canHu)
                     if canHu:
                         gamer.m_bDianPao = True
                         nexter.m_huPai.m_Type = type
                         nexter.m_huPai.m_Value = value
                     nexter.cmj.DelPaiV(type, value)
                 else:
                     canGang = nexter.cmj.CheckGangPai(type, value,config_game['gangState']['ming'])
                     canPeng = nexter.cmj.CheckPengPai(type, value)
                     if i == rangeMax :
                        canChi = nexter.cmj.CheckChiPai(type, value)

                 nexter.setCanChi(canChi)
                 nexter.setCanGang(canGang)
                 nexter.setCanPeng(canPeng)

                 if(canHu==False and canGang==False and canPeng==False and canChi==False):continue

                 if(canHu):
                     level = level + 10000
                 if(canGang):
                     level = level + 1000
                 if(canPeng):
                     level = level + 100
                 if (canChi):
                     level = level + 1
                 level = level + i*10
                 msg = msg_pb2.Msg()
                 msg.type = msg_pb2.EnumMsg.Value('canpainotify')

                 msg.notify.canPaiNotify.nUserID = nexter.id
                 msg.notify.canPaiNotify.lastPai.nType = type
                 msg.notify.canPaiNotify.lastPai.nValue = value
                 msg.notify.canPaiNotify.canHu = canHu
                 msg.notify.canPaiNotify.canGang = canGang
                 msg.notify.canPaiNotify.canPeng = canPeng
                 msg.notify.canPaiNotify.canChi = canChi


                 if  nexter.getTing()==False:#听牌状态下只能胡
                     for k, v in enumerate(nexter.cmj.m_TempGangPAIVec):
                         pai = msg.notify.canPaiNotify.canGangPool.add()
                         pai.nType = v.m_Type
                         pai.nValue = v.m_Value
                         if canGang:
                             pai.nGangState = config_game['gangState']['ming']
                     for k, v in enumerate(nexter.cmj.m_TempPengPAIVec):
                             pai =  msg.notify.canPaiNotify.canPengPool.add()
                             pai.nType = v.m_Type
                             pai.nValue = v.m_Value
                     if i == 3:
                         for k, v in enumerate(nexter.cmj.m_TempChiPAIVec):
                             chiPai = msg.notify.canPaiNotify.canChiPool.add()
                             chiPai.nType = v.m_Type
                             chiPai.nValue1 = v.m_Value1
                             chiPai.nValue2 = v.m_Value2
                             chiPai.nValue3 = v.m_Value3


                 msgPoolTemp[level] = msg

             sorted(msgPoolTemp.items(),key=lambda d:d[0],reverse=True)
             for k, v in msgPoolTemp.iteritems():
                 self.m_putMsgCache.append(v)


    def onDoPai(self,gamerID,bPut,nPutState=0):  ##处理玩家响应牌，清空消息队列，指定下一个出牌或者起牌者
        self.m_putMsgCache = []
        if bPut:
            ##网络协议,通知人打牌
            self.putPai(gamerID,nPutState)
        else:
            self.getPai(gamerID)

    def onDoHuPai(self,gamerID,pai):  ##玩家胡牌
        #检查玩家是否可胡
                self.m_putMsgCache = []
                self.cancelTimeOut(gamerID)
                gamer = self.m_gamerCache.get(gamerID)
                gamer.lastMsg = None
                if gamer.getCanHu():
                    gamer.setCanHu(False)#取消状态
                    gamer.setHu(True)

                    if self.IsDoHuNeedAddPai(gamer):
                        gamer.cmj.AddPaiReal(gamer.m_huPai.m_Type,gamer.m_huPai.m_Value)

                    msg = msg_pb2.Msg()
                    msg.type = msg_pb2.EnumMsg.Value('dohupairesponse')
                    msg.response.doHuPaiResponse.nErrorCode = 0
                    self.sendMessage(gamerID, msg)

                    msg = msg_pb2.Msg()
                    msg.type = msg_pb2.EnumMsg.Value('dohupainotify')
                    msg.notify.doHuPaiNotify.nUserID = gamerID
                    msg.notify.doHuPaiNotify.sRoomID = self.m_id
                    msg.notify.doHuPaiNotify.pai.nType = pai.nType
                    msg.notify.doHuPaiNotify.pai.nValue = pai.nValue
                    self.sendOtherMessage(gamerID, msg)

                    self.gamerWin(gamerID)
                    self.gameEnd()

    def onDoTingPai(self, gamerID):  ##玩家听牌
                self.cancelTimeOut(gamerID)
                self.m_geter = gamerID
                gamer = self.m_gamerCache.get(gamerID)
                gamer.lastMsg = None
                if gamer.getCanTing():
                    gamer.setCanTing(False)  # 取消状态
                    gamer.setTing(True)

                    msg = msg_pb2.Msg()
                    msg.type = msg_pb2.EnumMsg.Value('dotingpairesponse')
                    msg.response.doTingPaiResponse.nErrorCode = config_error['success']
                    self.sendMessage(gamerID, msg)

                    msg = msg_pb2.Msg()
                    msg.type = msg_pb2.EnumMsg.Value('dotingpainotify')
                    msg.notify.doTingPaiNotify.nUserID = gamerID
                    msg.notify.doTingPaiNotify.sRoomID = self.m_id
                    self.sendOtherMessage(gamerID, msg)

                self.onDoPai(gamerID, True)

    def onDoQiangTingPai(self, gamerID, pai,nChiIndex):  ##玩家抢听牌
        return

    def onDoGangPai(self, gamerID, gangPai):  ##玩家杠牌
                self.cancelTimeOut(gamerID)
                self.m_geter = gamerID
                gamer = self.m_gamerCache.get(gamerID)
                gamer.lastMsg = None
                if gamer.getCanGang():
                    gamer.setCanGang(False)#取消状态

                    stGangPai = stGang()
                    stGangPai.m_Type = gangPai.nType
                    stGangPai.m_Value = gangPai.nValue
                    stGangPai.m_nState = gangPai.nGangState

                    if gangPai.nGangState == config_game['gangState']['an']:
                        gamer.cmj.CheckGangPai( gangPai.nType,gangPai.nValue,gangPai.nGangState)
                        gamer.cmj.DoGangPai(gangPai.nType,gangPai.nValue,gangPai.nGangState)
                        gamer.cmj.AddOrderPai(stGangPai)
                    elif gangPai.nGangState == config_game['gangState']['zmming']:
                        gamer.cmj.DoGangPaiFromPeng(gangPai.nType,gangPai.nValue)
                        gamer.cmj.AddOrderPaiFromPeng(gangPai.nType,gangPai.nValue)
                    else:
                        gamer.cmj.DoGangPai(gangPai.nType,gangPai.nValue,gangPai.nGangState)
                        gamer.cmj.AddOrderPai(stGangPai)

                    self.HandleCPGPutPai(gangPai.nGangState)

                    msg = msg_pb2.Msg()
                    msg.type = msg_pb2.EnumMsg.Value('dogangpairesponse')
                    msg.response.doGangPaiResponse.nErrorCode =  config_error['success']
                    msg.response.doGangPaiResponse.pai.nGangState =  gangPai.nGangState
                    msg.response.doGangPaiResponse.pai.nType = gangPai.nType
                    msg.response.doGangPaiResponse.pai.nValue = gangPai.nValue
                    if gangPai.nGangState != config_game['gangState']['an']:
                        msg.response.doGangPaiResponse.nLastID = self.m_puter
                        msg.response.doGangPaiResponse.lastPai.nType = self.m_lastPutPai.m_Type
                        msg.response.doGangPaiResponse.lastPai.nValue = self.m_lastPutPai.m_Value
                    self.sendMessage(gamerID, msg)

                    msg = msg_pb2.Msg()
                    msg.type = msg_pb2.EnumMsg.Value('dogangpainotify')
                    msg.notify.doGangPaiNotify.nUserID = gamerID
                    msg.notify.doGangPaiNotify.sRoomID = self.m_id
                    msg.notify.doGangPaiNotify.pai.nType = gangPai.nType
                    msg.notify.doGangPaiNotify.pai.nValue = gangPai.nValue
                    msg.notify.doGangPaiNotify.pai.nGangState =  gangPai.nGangState
                    if gangPai.nGangState != config_game['gangState']['an']:
                        msg.notify.doGangPaiNotify.nLastID = self.m_puter
                        msg.notify.doGangPaiNotify.lastPai.nType = self.m_lastPutPai.m_Type
                        msg.notify.doGangPaiNotify.lastPai.nValue = self.m_lastPutPai.m_Value
                    self.sendOtherMessage(gamerID, msg)

                    self.onDoPai(gamerID,False)

    def onDoPengPai(self, gamerID, pai):  ##玩家碰牌
                self.cancelTimeOut(gamerID)
                self.m_geter = gamerID
                gamer = self.m_gamerCache.get(gamerID)
                gamer.lastMsg = None
                if gamer.getCanPeng():
                    gamer.setCanPeng(False)#取消状态
                    gamer.cmj.DoPengPai(pai.nType,pai.nValue)
                    stPengPai = stPeng()
                    stPengPai.m_Type = pai.nType
                    stPengPai.m_Value = pai.nValue
                    gamer.cmj.AddOrderPai(stPengPai)
                    self.HandleCPGPutPai()

                    msg = msg_pb2.Msg()
                    msg.type = msg_pb2.EnumMsg.Value('dopengpairesponse')
                    msg.response.doPengPaiResponse.nErrorCode = 0
                    msg.response.doPengPaiResponse.nLastID = self.m_puter
                    msg.response.doPengPaiResponse.lastPai.nType = self.m_lastPutPai.m_Type
                    msg.response.doPengPaiResponse.lastPai.nValue = self.m_lastPutPai.m_Value
                    self.sendMessage(gamerID, msg)

                    msg = msg_pb2.Msg()
                    msg.type = msg_pb2.EnumMsg.Value('dopengpainotify')
                    msg.notify.doPengPaiNotify.nUserID = gamerID
                    msg.notify.doPengPaiNotify.sRoomID = self.m_id
                    msg.notify.doPengPaiNotify.pai.nType = pai.nType
                    msg.notify.doPengPaiNotify.pai.nValue = pai.nValue
                    msg.notify.doPengPaiNotify.nLastID = self.m_puter
                    msg.notify.doPengPaiNotify.lastPai.nType = self.m_lastPutPai.m_Type
                    msg.notify.doPengPaiNotify.lastPai.nValue = self.m_lastPutPai.m_Value
                    self.sendOtherMessage(gamerID, msg)

                    self.onDoPai(gamerID,True)

    def onDoChiPai(self, gamerID, pai,index):  ##玩家吃牌
                self.cancelTimeOut(gamerID)
                self.m_geter = gamerID
                gamer = self.m_gamerCache.get(gamerID)
                gamer.lastMsg = None
                if gamer.getCanChi():
                    gamer.setCanChi(False)#取消状态
                    chiPai = gamer.cmj.GetChiPai(index)
                    gamer.cmj.DoChiPai(index,pai.nType,pai.nValue)
                    gamer.cmj.AddOrderPai(chiPai)
                    self.HandleCPGPutPai()

                    msg = msg_pb2.Msg()
                    msg.type = msg_pb2.EnumMsg.Value('dochipairesponse')
                    msg.response.doChiPaiResponse.nErrorCode = 0
                    msg.response.doChiPaiResponse.nLastID = self.m_puter
                    msg.response.doChiPaiResponse.lastPai.nType = self.m_lastPutPai.m_Type
                    msg.response.doChiPaiResponse.lastPai.nValue = self.m_lastPutPai.m_Value
                    msg.response.doChiPaiResponse.nChiIndex = index
                    msg.response.doChiPaiResponse.pai.nType = chiPai.m_Type
                    msg.response.doChiPaiResponse.pai.nValue1 = chiPai.m_Value1
                    msg.response.doChiPaiResponse.pai.nValue2 = chiPai.m_Value2
                    msg.response.doChiPaiResponse.pai.nValue3 = chiPai.m_Value3
                    self.sendMessage(gamerID, msg)

                    msg = msg_pb2.Msg()
                    msg.type = msg_pb2.EnumMsg.Value('dochipainotify')
                    msg.notify.doChiPaiNotify.nUserID = gamerID
                    msg.notify.doChiPaiNotify.sRoomID = self.m_id
                    msg.notify.doChiPaiNotify.pai.nType = chiPai.m_Type
                    msg.notify.doChiPaiNotify.pai.nValue1 = chiPai.m_Value1
                    msg.notify.doChiPaiNotify.pai.nValue2 = chiPai.m_Value2
                    msg.notify.doChiPaiNotify.pai.nValue3 = chiPai.m_Value3
                    msg.notify.doChiPaiNotify.nLastID = self.m_puter
                    msg.notify.doChiPaiNotify.lastPai.nType = self.m_lastPutPai.m_Type
                    msg.notify.doChiPaiNotify.lastPai.nValue = self.m_lastPutPai.m_Value
                    self.sendOtherMessage(gamerID, msg)

                    self.onDoPai(gamerID,True)

#聊天
    def onChat(self,gamerID,chatConcent):
        msg = msg_pb2.Msg()
        msg.type = msg_pb2.EnumMsg.Value('chatresponse')
        msg.response.chatResponse.nErrorCode = 0
        self.sendMessage(gamerID, msg)

        msg = msg_pb2.Msg()
        msg.type = msg_pb2.EnumMsg.Value('chatnotify')
        msg.notify.chatNotify.nUserID = gamerID
        msg.notify.chatNotify.sRoomID = self.m_id
        msg.notify.chatNotify.sContent = chatConcent
        self.sendOtherMessage(gamerID, msg)
##房间逻辑

    def onGameReady(self,uid):  ##
        gamer = self.m_gamerCache.get(uid)
        if gamer:
            self.DelReadyTimer(uid)
            msg = msg_pb2.Msg()
            msg.type = msg_pb2.EnumMsg.Value('readygameresponse')
            if gamer.m_nGameState == config_game['gamerState']['ready'] :
                msg.response.readyGameResponse.nErrorCode =  config_error['readyed']
                self.sendMessage(uid, msg)
                return

            gamer.m_nGameState = config_game['gamerState']['ready']
            gamer.lastMsg = None

            msg.response.readyGameResponse.nErrorCode = config_error['success']
            self.sendMessage(uid, msg)

            msg = msg_pb2.Msg()
            msg.type = msg_pb2.EnumMsg.Value('readygamenotify')
            msg.notify.readyGameNotify.nUserID = uid
            msg.notify.readyGameNotify.sRoomID = self.m_id
            self.sendOtherMessage(uid, msg)

            self.gameStart()
            return False


    def gameReset(self):  ##重置
        for k,v in self.m_gamerCache.iteritems():
            v.reset()
        self.m_geter = self.m_boss  # 默认房当前活跃玩家是庄
        self.m_puter = None   # 默认当前出牌玩家是庄
        self.m_putMsgCache = []  ##出牌处理的消息队列
        self.m_state = config_game['roomState']['ready']  # 0 未开始，1已经开始,2已结束
        self.cancelTimeOutAll()
        self.m_putMsgCache = []
        self.m_bHuang = False


    def gameStart(self):  ##开始游戏
        if self.canGameStart() == False:
            return
        print "game start!"
        self.gameReset()

        #一旦游戏开始，就先消耗房卡
        owner = Dal_User().getUser(self.m_creater)
        cardConfig = configs_default['goods'][self.m_cardID]
        owner.gold = owner.gold - cardConfig['gold']
        owner.money = owner.money - cardConfig['money']
        kwargs = {"gold": owner.gold, "money": owner.money}
        Dal_User().uqdateUser(owner.id, **kwargs)
        msg = msg_pb2.Msg()
        msg.type = msg_pb2.EnumMsg.Value('assetupdatenotify')
        msg.notify.assetUpdateNotify.nUserID = owner.id
        msg.notify.assetUpdateNotify.nGold = owner.gold
        msg.notify.assetUpdateNotify.nMoney = owner.money
        self.sendMessage(owner.id,msg)

        bossG = self.m_gamerCache.get(self.m_boss)
        bossG.boss = True

        self.m_state = config_game['roomState']['doing']
        msg = msg_pb2.Msg()
        msg.type = msg_pb2.EnumMsg.Value('startgamenotify')
        msg.notify.startGameNotify.sRoomID = self.m_id
        msg.notify.startGameNotify.nBossID = self.m_boss
        self.sendAllMessage(msg)
        self.initPai()

    def gamerWin(self,gID):  ##赢家
        gamer = self.m_gamerCache.get(gID)
        gamer.setCanHu(False)  # 取消状态
        gamer.setHu(True)

    def gameEnd(self,bHuang = False):  ##结束游戏
            self.m_state = config_game['roomState']['ending']

            self.calcScore()#结算

            msg = msg_pb2.Msg()
            msg.type = msg_pb2.EnumMsg.Value('gameendnotify')
            msg.notify.gameEndNotify.bHuang = bHuang
            msg.notify.gameEndNotify.bOver = self.IsGameOver()
            # if isinstance(self.m_cmjManager,CMJDongBeiManage):
            #     msg.notify.gameEndNotify.bao.nType = CMJDongBeiManage.m_baoPai.m_Type
            #     msg.notify.gameEndNotify.bao.nValue = CMJDongBeiManage.m_baoPai.m_Value

            recordStr = ''
            for k, v in self.m_gamerCache.iteritems():
                v.lastMsg = msg
                v.calcOverData()
                v.m_nGameState = config_game['gamerState']['ending']
                gamerInfo = msg.notify.gameEndNotify.infoList.add()
                gamerInfo.gamerPai.nID = k

                for type, pool in enumerate(v.cmj.m_MyPAIVec):
                    newPool = gamerInfo.gamerPai.pool.add()
                    newPool.nType = type
                    for i, value in enumerate(pool):
                        newPool.nValue.append(value.m_Value)
                for i, value in enumerate(v.cmj.m_BaoPAIVec):
                    newPool = gamerInfo.gamerPai.pool[value.m_Type]
                    newPool.nValue.append(value.m_Value)
                for type, pool in enumerate(v.cmj.m_ChiPAIVec):
                    newPool = gamerInfo.gamerPai.chiPool.add()
                    newPool.nType = type
                    for i, value in enumerate(pool):
                        newPool.nValue.append(value)

                for type, pool in enumerate(v.cmj.m_PengPAIVec):
                    newPool = gamerInfo.gamerPai.pengPool.add()
                    newPool.nType = type
                    for i, value in enumerate(pool):
                        newPool.nValue.append(value)

                for type, pool in enumerate(v.cmj.m_MGangPAIVec):
                    newPool = gamerInfo.gamerPai.mGangPool.add()
                    newPool.nType = type
                    for i, value in enumerate(pool):
                        newPool.nValue.append(value)

                for type, pool in enumerate(v.cmj.m_AGangPAIVec):
                    newPool = gamerInfo.gamerPai.aGangPool.add()
                    newPool.nType = type
                    for i, value in enumerate(pool):
                        newPool.nValue.append(value)

                for index, paiObj in enumerate(v.cmj.m_OrderPaiVec):
                    orderpai = gamerInfo.gamerPai.orderPai.add()
                    if isinstance(paiObj, stPAI):
                        orderpai.pai.nType = paiObj.m_Type
                        orderpai.pai.nValue = paiObj.m_Value
                    elif isinstance(paiObj, stCHI):
                        orderpai.chipai.nType = paiObj.m_Type
                        orderpai.chipai.nValue1 = paiObj.m_Value1
                        orderpai.chipai.nValue2 = paiObj.m_Value2
                        orderpai.chipai.nValue3 = paiObj.m_Value3
                    if isinstance(paiObj, stPeng):
                        orderpai.pengpai.nType = paiObj.m_Type
                        orderpai.pengpai.nValue = paiObj.m_Value
                    if isinstance(paiObj, stGang):
                        orderpai.gangpai.nType = paiObj.m_Type
                        orderpai.gangpai.nValue = paiObj.m_Value
                        orderpai.gangpai.nGangState = paiObj.m_nState

                gamerInfo.nGameCoin = v.m_score
                gamerInfo.bHu = v.getHu()
                if gamerInfo.bHu:
                    gamerInfo.hupai.nType = v.m_huPai.m_Type
                    gamerInfo.hupai.nValue = v.m_huPai.m_Value
                gamerInfo.bTing = v.getTing()
                gamerInfo.bBoss  = v.boss
                for k1,v1 in enumerate(v.m_showState):
                    gamerInfo.nHuOPList.append(v1)

                #总结算数据
                gamerInfo.huCount = v.m_nHuCount
                gamerInfo.moBaoCount = v.m_nMoBaoCount
                gamerInfo.ziMoCount = v.m_nZiMoCount
                gamerInfo.gangCount = v.m_nGangCount
                gamerInfo.dianPaoCount = v.m_nDianPaoCount
                gamerInfo.danJuBestCount = v.m_nDanJuBestCount
                gamerInfo.totalScore = v.m_TotalScore

                #更新战绩
                recordStr = recordStr + str(k)+":"+str(v.m_nHuCount)+","+str(v.m_TotalScore)+";"
                if self.IsHappyRoom():#欢乐场分数兑换金币
                        user = Dal_User().getUser(k)
                        if user:
                            user.gold =  user.gold +  v.m_TotalScore*config_game['happyExchange']
                            if user.gold < 0: user.gold = 0
                            kwargs = {"gold": user.gold}
                            Dal_User().uqdateUser(user.id, **kwargs)

                            msgAsset = msg_pb2.Msg()
                            msgAsset.type = msg_pb2.EnumMsg.Value('assetupdatenotify')
                            msgAsset.notify.assetUpdateNotify.nUserID = user.id  # 庄家最先摸牌
                            msgAsset.notify.assetUpdateNotify.nGold = user.gold
                            msgAsset.notify.assetUpdateNotify.nMoney = user.money
                            self.sendMessage(user.id,msgAsset)



                if v.isAI():
                    self.onGameReady(k)
                else:
                    self.AddReadyTimer(k)
                    v.m_bAI = False


            self.sendAllMessage(msg)
            self.genNextBoss()  # 生成新的庄家

            if msg.notify.gameEndNotify.bOver == True or self.IsHappyRoom():
                # 生成战报记录，更新record表
                recordStr = recordStr[0:(len(recordStr)-1)]
                record = Record(id=None, time=Utils().dbTimeCreate(), gameplay="",
                                gamers=recordStr)
                Dal_Record().addRecord(record)


            if msg.notify.gameEndNotify.bOver == True:
                self.onDestory()


    def genPos(self):  ##生成方位
        for i in range(0,self.m_maxPlayerNum) :
             bGened = False
             p = config_game['position'][i]
             for k,v in self.m_gamerCache.iteritems():
                   if v.pos == p:
                       bGened = True
                       break
             if bGened == False:
                 return  p


    def getNextGamer(self,id):  ##获得下一个位置玩家
        curPos =  self.m_gamerCache[id].pos
        nextPos = ((curPos+1) % self.m_maxPlayerNum)
        for k,v in self.m_gamerCache.iteritems():
            if v.pos == nextPos:
                return v
        return None
    def setNewOwner(self):  ##生成下一个房主
        if self.m_gamerCache == {}:#如果没有人就不设置房主
            self.m_owner=None
            return
        self.m_owner = self.m_ownerCache.pop(0)
        self.m_boss = self.m_owner
        if self.m_gamerCache.get(self.m_owner)==None:
            self.setNewOwner()
        else:
            #通知所有人，房主转让了
            msg = msg_pb2.Msg()
            msg.type = msg_pb2.EnumMsg.Value('ownerchangenotify')
            msg.notify.ownerChangeNotify.nOwnerID = self.m_owner
            self.sendAllMessage(msg)

    def genNextBoss(self):  ##生成下一个庄家
        curBoss = self.m_gamerCache.get(self.m_boss)
        if curBoss.getHu() or self.m_bHuang:return

        newBossPos = curBoss.pos + 1
        newBossPos = (newBossPos % self.m_maxPlayerNum)
        for k,v in self.m_gamerCache.iteritems():
            if v.pos == newBossPos:
                self.m_boss = k
                v.boss = True


##卡牌相关

    def genPaiNet(self,gamer):  #随机生成牌
         paiEx= self.m_cmjManager.GetAPai()
         gamer.onAddPai(paiEx.m_NewPai.m_Type,paiEx.m_NewPai.m_Value)
         #网络协议
        # Utils().logMainDebug('玩家' + str(gamer.id) + '真正起牌通知')
         msg = msg_pb2.Msg()
         msg.type = msg_pb2.EnumMsg.Value('getpainotify')
         msg.notify.getPaiNotify.nUserID = gamer.id#庄家最先摸牌
         msg.notify.getPaiNotify.getPai.nType = paiEx.m_NewPai.m_Type
         msg.notify.getPaiNotify.getPai.nValue = paiEx.m_NewPai.m_Value
         msg.notify.getPaiNotify.nLeft = self.m_cmjManager.GetLeftPai()
         self.m_geter = gamer.id
         self.sendAllMessage(msg)

         return paiEx
    def GraspPai(self): #发牌

        self.m_cmjManager.GraspPai(self.m_gamerCache)

        # 网络协议,发送初始化玩家牌协议
        msg = msg_pb2.Msg()
        msg.type = msg_pb2.EnumMsg.Value('initpainotify')
        msg.notify.initPaiNotify.nLeft = self.m_cmjManager.GetLeftPai()
        for k, v in self.m_gamerCache.iteritems():
            gamerPaiPool = msg.notify.initPaiNotify.paiPool.add()
            gamerPaiPool.nID = k
            for type, pool in enumerate(v.cmj.m_MyPAIVec):
                newPool = gamerPaiPool.pool.add()
                newPool.nType = type
                for i, value in enumerate(pool):
                    newPool.nValue.append(value.m_Value)
            for i, value in enumerate(v.cmj.m_BaoPAIVec):
                newPool = gamerPaiPool.pool[value.m_Type]
                newPool.nValue.append(value.m_Value)
        self.sendAllMessage(msg)
    def initPai(self):  ##初始化玩家牌
        self.m_cmjManager.InitPai(0)  # 默认黄庄的剩余牌0张
        self.GraspPai() #发牌
        #通知玩家起牌,之前检查暗杠
        self.getPai(self.m_boss)

    def checkGetGang(self,gamerID,canMsg):  ##检查玩家牌中是否有暗杠
            bGangResult = False
            gamer = self.m_gamerCache.get(gamerID)
            if gamer.getTing() :return  False
            for type, pool in enumerate(gamer.cmj.m_MyPAIVec):
                lastV = -1
                for k,pai in enumerate(pool):
                    value = pai.m_Value
                    if value == lastV:continue
                    lastV = value
                    bGang = gamer.cmj.CheckGangPai(type,value,config_game['gangState']['an'])
                    bGangFormPeng = False
                    if bGang == False:
                       bGangFormPeng =gamer.cmj.CheckGangPaiFromPeng(type,value)
                    if  bGang or bGangFormPeng:
                        bGangResult = True
                        gamer.setCanGang(True)
                        for k, v in enumerate(gamer.cmj.m_TempGangPAIVec):
                              pai = canMsg.notify.canPaiNotify.canGangPool.add()
                              pai.nType = v.m_Type
                              pai.nValue = v.m_Value
                              if bGang:
                                  pai.nGangState =  config_game['gangState']['an']
                              elif bGangFormPeng:
                                  pai.nGangState = config_game['gangState']['zmming']

            return  bGangResult

    # 结算算分
    def calcScore(self):
        return

    # 是否需要解散房间
    def beExit(self,id):
        if (len(self.m_gamerCache) <= 0) or  self.isAllAI():
            self.onDestory()


    # 是否有玩家离线
    def bePause(self):
        for k, v in self.m_gamerCache.iteritems():
            if v.conn == False:
                return True

##time sync

    def startTimeOut(self,gID,sMsg):  ##超时处理
        self.m_nTickCount = 0
        args = {'id':gID,'msg':sMsg}
        self.m_timerMgr.addTimer(gID,self.onTimeTick,config_game['timetick'], args)

    def onTimeTick(self,args):  ##同步客户端超时
        self.m_nTickCount = self.m_nTickCount + 1
        deltaTime =  config_game['timeout'] - self.m_nTickCount
        if deltaTime == 0:
            self.onTimeOut(args)
            return
        ##网络协议,通知玩家倒计时
        msg = msg_pb2.Msg()
        msg.type = msg_pb2.EnumMsg.Value('gametimeticknotify')
        msg.notify.gameTimeTickNotify.nUserID = args['id']
        msg.notify.gameTimeTickNotify.nLeft = deltaTime
        self.sendAllMessage(msg)

    def onTimeOut(self,args):  ##操作超时回调，出牌或者响应胡听杠碰吃
        gID = args['id']
        sMsg= args['msg']
        self.cancelTimeOut(gID)
        if self.IsHappyRoom(): # 只有欢乐场超时自动转托管
           self.onDelegate(gID,True)
        if sMsg.type == msg_pb2.EnumMsg.Value('canpainotify'):
            canType = self.GetCanMsgType(sMsg)
            self.onGuoPai(gID, canType)
        else:
            if self.IsHappyRoom() == False: return  # 只有欢乐场超时才自动打牌
            self.onPutTimeOut(gID,sMsg)

    def cancelTimeOut(self, gid):  ##取消超时处理
        self.m_timerMgr.delTimer(gid)
        # ##网络协议,通知玩家倒计时
        msg = msg_pb2.Msg()
        msg.type = msg_pb2.EnumMsg.Value('gametimeticknotify')
        msg.notify.gameTimeTickNotify.nUserID = gid
        msg.notify.gameTimeTickNotify.nLeft = config_game['timeout']
        self.sendAllMessage(msg)

    def pauseTimeOutAll(self):  ##取消所有超时处理
        if self.IsAllGamerOnLine():
            self.m_timerMgr.pauseAllTimer()

    def resumeTimeOutAll(self):  ##取消所有超时处理
        if self.IsAllGamerOnLine():
            self.m_timerMgr.resumeAllTimer()

    def cancelTimeOutAll(self):  ##取消所有超时处理
        self.m_timerMgr.delAllTimer()

    def onPutTimeOut(self,gamerID,msg = None):  ##操作超时回调，出牌
        gamer = self.m_gamerCache.get(gamerID)
        #最后一张
        putPai = gamer.cmj.m_LastRealPAI
        if gamer.cmj.GetPaiIndex(gamer.cmj.m_LastRealPAI.m_Type,gamer.cmj.m_LastRealPAI.m_Value) == -1:
           putPai = gamer.cmj.HandleAIPutPai()
        if msg:
            if msg.type == msg_pb2.EnumMsg.Value('doputpainotify'):  # 出牌
                if msg.notify.doPutPaiNotify.nUserID != gamerID: return
                if len(msg.notify.doPutPaiNotify.huPais._values) > 0:
                    hupai = msg.notify.doPutPaiNotify.huPais._values[0]
                    self.onPutPai(gamerID, hupai.pai.nType, hupai.pai.nValue)
                    return

       # Utils().logMainDebug("onPutTimeOut玩家"+str(gamerID)+'出牌'+Utils().logPaiString( putPai.m_Type, putPai.m_Value))
        self.onPutPai(gamerID, putPai.m_Type, putPai.m_Value)

    def getDianPaos(self):  ##获得点炮者
       for k,v in self.m_gamerCache.iteritems():
           if v.m_bDianPao:return v
       return None

    def getWins(self):  ##获得胜利玩家
       wins = []
       for k,v in self.m_gamerCache.iteritems():
           if v.getHu():wins.append(v)
       return wins

    def canGameStart(self):  ##游戏能否开始
        if len(self.m_gamerCache) != self.m_maxPlayerNum:
            return False

        for k,v in self.m_gamerCache.iteritems():
            if v.m_nGameState != config_game['gamerState']['ready']:
                return False

        for k,v in self.m_gamerCache.iteritems():
            v.m_nGameState = config_game['gamerState']['doing']

        return True

    def GetLeftCanHuPai(self,uid,pai):##获取能胡的牌的剩余牌数
        nLeft = self.m_cmjManager.GetLeftCanHuPai(pai)
        for k,v in self.m_gamerCache.iteritems():
            if k == uid:continue
            nLeft = nLeft + v.cmj.GetLeftCanHuPai(pai)
        return nLeft

    def IsAllGamerOnLine(self):##是否所有玩家在线
        for k,v in self.m_gamerCache.iteritems():
            if v.conn == None and v.m_bAI == False:
                return False

        return True

#处理游戏结束，房间是否需要销毁
    def IsGameOver(self):
        self.m_cardCount = self.m_cardCount + 1
        configCount = configs_default['goods'][self.m_cardID]['extra']
        return self.m_cardCount >= configCount


    def ClearCircle(self):
       for k,gamer in self.m_gamerCache.iteritems():
           gamer.resetCircle()

#处理吃碰杠时候，对上一个出牌者打出的牌进行删除处理
    def HandleCPGPutPai(self,nGangState=2):
        if nGangState == config_game['gangState']['an']:return
        lastPuter = self.m_gamerCache.get(self.m_puter)
        lastPuter.cmj.DelPutPai()

    def CalcWinScoreInner(self,winner,score):
        winer = self.m_gamerCache.get(winner)
        for k,v in self.m_gamerCache.iteritems():
            if k != winner:
                deltaScore = score
                #if v.boss:deltaScore = deltaScore*2
                winer.m_score = winer.m_score + deltaScore
                v.m_score = v.m_score - deltaScore

    def CalcWinScoreInnerBoss(self,winner):
        winer = self.m_gamerCache.get(winner)
        for k,v in self.m_gamerCache.iteritems():
            if k != winner:
                winer.m_score = winer.m_score + abs(v.m_score)
                v.m_score = v.m_score - abs(v.m_score)

    def ClearSocreInner(self):
        for k, v in self.m_gamerCache.iteritems():
                v.m_score = 0

    def IsUserInRoom(self,id):
        user = Dal_User().getUser(id)
        if user:return user.room !=''
        return False

    def SaveLastPutPai(self,pai):
        for k, v in self.m_gamerCache.iteritems():
                v.saveLastPutPai(pai)

    def CheckLastBao(self,gamer,type,value):
        return config_game['canLastBaoType']['normal']

    def IsDoHuNeedAddPai(self,huer):
        for id,gamer in self.m_gamerCache.iteritems():
            if gamer.m_bDianPao:return True
        return False

    def GetCanMsgType(self,canMsg):
        if canMsg.notify.canPaiNotify.bZm :
            if canMsg.notify.canPaiNotify.canHu:
                return config_game['canType']['zmhu']
            if canMsg.notify.canPaiNotify.canGang:
                return config_game['canType']['zmgang']

        return config_game['canType']['other']


    def AddReadyTimer(self,gID):
        if self.IsHappyRoom():
           self.m_timerMgr.addTimer("ready"+str(gID),self.OnReadyTimeOut,config_game['readyTime'],gID)

    def OnReadyTimeOut(self, gID):
        gamer = self.m_gamerCache.get(gID)
        if gamer.m_nGameState ==  config_game['gamerState']['ready'] or gamer.isAI() or \
            self.IsHappyRoom() == False:return
        self.onLeave(gID,True)


    def DelReadyTimer(self, gID):
        if self.IsHappyRoom():
           self.m_timerMgr.delTimer("ready"+str(gID))

#欢乐城要做特殊处理
    def IsHappyRoom(self):
        return  (self.m_gamePlay.nType == config_game['gameplay']['type']['happy'])
    def IsEnableRoom(self):
        return  (self.m_state != config_game['roomState']['disable'])

# AI处理
    def HandleAI(self,gamer,msg):
        try:
            if gamer.m_bAI == False :return
            if msg.type == msg_pb2.EnumMsg.Value('doputpainotify'):#出牌
                if msg.notify.doPutPaiNotify.nUserID != gamer.id: return
                if len( msg.notify.doPutPaiNotify.huPais._values) >0:
                    hupai = msg.notify.doPutPaiNotify.huPais._values[0]
                    self.AIPut(gamer.id, hupai.pai.nType, hupai.pai.nValue)
                    return

                putPai = gamer.cmj.HandleAIPutPai()
                self.AIPut(gamer.id, putPai.m_Type,putPai.m_Value)
                return
            elif msg.type == msg_pb2.EnumMsg.Value('canpainotify'):#can牌
                if msg.notify.canPaiNotify.nUserID != gamer.id: return
                self.AICan(gamer,msg)
        except Exception, e:
            msg = traceback.format_exc()  # 方式1
            Utils().logMainDebug(msg)

    def AddAITimer(self):
        if self.m_bNeedAI == False:return
        self.m_timerMgr.addTimer("addAI",self.OnAddAI,config_game['addAITime'],'')

    def OnAddAI(self,arg):
        Room.m_IndexAI = (Room.m_IndexAI - 1)
        if Room.m_IndexAI <= -100000: Room.m_IndexAI = -1
        self.onJoin(Room.m_IndexAI,None,True)
        if self.isFull():
            self.m_timerMgr.delTimer("addAI")

    def AIPut(self,gID,nType,nValue):
        maxPutTime =config_game['aiPutTime']
        putTime =Utils().random_range(2, maxPutTime)
        id = "aiPut"+str(gID)
        args = {'id':id,'gid':gID,'type':nType,'value':nValue}
        self.m_timerMgr.addTimer(id, self.OnAIPut, putTime, args)

    def OnAIPut(self,args):
        self.m_timerMgr.delTimer(args['id'])
        #Utils().logMainDebug("OnAIPut玩家"+str(args['gid'])+'出牌'+Utils().logPaiString( args['type'],args['value']))
        self.onPutPai(args['gid'],args['type'],args['value'])

    def AICan(self, gamer,msg):
        maxPutTime = config_game['aiPutTime']
        putTime = Utils().random_range(2, maxPutTime)
        id = "aiCan" + str(gamer.id)
        args = {'id':id,'gamer':gamer,'msg':msg}
        self.m_timerMgr.addTimer(id, self.OnAICan, putTime,args)

    def OnAICan(self,args):
        try:
            self.m_timerMgr.delTimer(args['id'])
            msg = args['msg']
            gamer = args['gamer']
            self.m_timerMgr.delTimer("aiCan" + str(gamer.id))
            if msg.notify.canPaiNotify.canHu:
                self.onDoHuPai(gamer.id, msg.notify.canPaiNotify.lastPai)
            elif msg.notify.canPaiNotify.canTing:
                self.onDoTingPai(gamer.id)
            elif msg.notify.canPaiNotify.canQiangTing:
                if len(msg.notify.canPaiNotify.canPengPool) > 0:
                    self.onDoQiangTingPai(gamer.id, msg.notify.canPaiNotify.lastPai, -1)
                else:
                    self.onDoQiangTingPai(gamer.id, msg.notify.canPaiNotify.lastPai, 0)
            elif msg.notify.canPaiNotify.canGang:
                gangAI = stGangAI()
                gangAI.nType = msg.notify.canPaiNotify.canGangPool[0].nType
                gangAI.nValue =msg.notify.canPaiNotify.canGangPool[0].nValue
                gangAI.nGangState = msg.notify.canPaiNotify.canGangPool[0].nGangState
                self.onDoGangPai(gamer.id, gangAI)
            elif msg.notify.canPaiNotify.canPeng:
                self.onDoPengPai(gamer.id, msg.notify.canPaiNotify.lastPai)
            elif msg.notify.canPaiNotify.canChi:
                self.onDoChiPai(gamer.id, msg.notify.canPaiNotify.lastPai, 0)
        except Exception, e:
            msg = traceback.format_exc()  # 方式1
            Utils().logMainDebug(msg)

    # 是否需要解散房间
    def onDelegate(self,uid,bDelegate):
         gamer = self.m_gamerCache.get(uid)
         gamer.m_bAI = bDelegate
         msg = msg_pb2.Msg()
         msg.type = msg_pb2.EnumMsg.Value('delegateresponse')
         msg.response.delegateResponse.nErrorCode = config_error['success']
         msg.response.delegateResponse.bDo = bDelegate
         self.sendMessage(uid,msg)

         msg = msg_pb2.Msg()
         msg.type = msg_pb2.EnumMsg.Value('delegatenotify')
         msg.notify.delegateNotify.nUserID = uid
         self.sendOtherMessage(uid,msg)

    # 是否需要解散房间
    def isAllAI(self):
        for k,v in self.m_gamerCache.iteritems():
            if v.m_bAI == False:
                return False
        return True

    #机器人准备时间
    def AddAIReadyTimer(self,id):
        self.AIreadyId = id
        self.m_timerMgr.addTimer("AIReady", self.OnAIReady, config_game['aiReadTime'], '')

    def OnAIReady(self, arg):
        uid = self.AIreadyId
        self.onGameReady(uid)
        self.m_timerMgr.delTimer("AIReady")
