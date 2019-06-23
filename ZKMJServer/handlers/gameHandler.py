# -*-coding:utf-8-*-
'''
用户点击开始游戏  用户传入的数据是 用户名和歌曲id  返回值是错误码  和的当前的体力值
'''
import json
import traceback

import gc
import tornado.web
import tornado.websocket
import time
import logging

from configs.config_default import configs_default
from configs.config_game import config_game
from configs.config_error import config_error
from dal.dal_user import Dal_User
from logic.happy_room import Happy_Room
from tools.utils import Utils
from logic.room import Room
from logic.zk_room import ZK_Room
from logic.hui_room import Hui_Room
from protobuf import msg_pb2

#基本思想是vip和普通房间都是先在后台创建房间，
# vip房间需要消耗房卡道具，可邀请微信好友加入
#普通房间是当用户开始游戏时，先检查房间队列中有没有空闲的，如果有就直接加入，没有则创建新的普通房间加入
#一旦创建房间，默认进入长链接模式
class GameHandler(tornado.websocket.WebSocketHandler):
    waiters = dict()#用户链接集合
    room_cache = dict()  ##玩家分组集合，房间id=》房间

    def check_origin(self, origin):
        return True

    def get_compression_options(self):
        # Non-None enables compression with default options.
        return {}

    def open(self):
        uID = (int)(self.get_argument('id'))
        if GameHandler.waiters.has_key(uID):
            GameHandler.waiters.pop(uID)
        GameHandler.waiters[uID] = self
        self.on_connect(uID,self)

    def on_close(self):
        uID = (int)(self.get_argument('id'))
        GameHandler.waiters.pop(uID)
        self.on_disconnect(uID)



    @classmethod
    def get_connect(cls, uid):
        return  cls.waiters[uid]

    @classmethod
    def add_room(cls, room):
        cls.room_cache[room.m_id] = room

    @classmethod
    def get_room(cls, id):
        if cls.room_cache.has_key(id):
           return  cls.room_cache.get(id)
        return None

    @classmethod
    def del_room(cls, id):
        if cls.room_cache.has_key(id):
           cls.room_cache.pop(id)
          # gc.collect()

    @classmethod
    def create_room(cls, message):
        return cls.on_create_dele_room(message)

    @classmethod
    def get_free_happy_room(cls):
        for rid,room in cls.room_cache.iteritems():
            if room.isFull() == False and room.IsHappyRoom() and room.IsEnableRoom():return room
        return None

    @classmethod
    def get_happy_users(cls):
        count = 0
        for rid, room in cls.room_cache.iteritems():
            if  room.IsHappyRoom():
                count = count + 4
        return count

    @classmethod
    def kick_player(cls,user):
        userRoom = cls.get_room(user.room)
        if userRoom == None:return
        userRoom.onKick(user.id)

    def on_message(self, message):
        # logging.info("got message %r", message)
        try:
            msgRequest = msg_pb2.Msg()
            msgRequest.ParseFromString(message)
            if msgRequest.type == msg_pb2.EnumMsg.Value('createroomrequest'):
                self.on_create_room(msgRequest.request.createRoomRequest)
            elif msgRequest.type == msg_pb2.EnumMsg.Value('joinroomrequest'):
                self.on_join_room(msgRequest.request.joinRoomRequest)
            elif msgRequest.type == msg_pb2.EnumMsg.Value('leaveroomrequest'):
                self.on_leave_room(msgRequest.request.leaveRoomRequest)
            elif msgRequest.type == msg_pb2.EnumMsg.Value('dissroomrequest'):
                self.on_diss_room(msgRequest.request.dissRoomRequest)
            elif msgRequest.type ==msg_pb2.EnumMsg.Value('putpairequest'):
                self.on_put_pai(msgRequest.request.putPaiRequest)
            elif msgRequest.type == msg_pb2.EnumMsg.Value('dochipairequest'):
                self.on_do_chi_pai(msgRequest.request.doChiPaiRequest)
            elif msgRequest.type == msg_pb2.EnumMsg.Value('dogangpairequest'):
                self.on_do_gang_pai(msgRequest.request.doGangPaiRequest)
            elif msgRequest.type == msg_pb2.EnumMsg.Value('dohupairequest'):
                self.on_do_hu_pai(msgRequest.request.doHuPaiRequest)
            elif msgRequest.type == msg_pb2.EnumMsg.Value('dopengpairequest'):
                self.on_do_peng_pai(msgRequest.request.doPengPaiRequest)
            elif msgRequest.type == msg_pb2.EnumMsg.Value('guopairequest'):
                self.on_guo_pai(msgRequest.request.guoPaiRequest)
            elif msgRequest.type == msg_pb2.EnumMsg.Value('doqiangtingpairequest'):
                self.on_do_qiang_ting_pai(msgRequest.request.doQiangTingPaiRequest)
            elif msgRequest.type == msg_pb2.EnumMsg.Value('dotingpairequest'):
                self.on_do_ting_pai(msgRequest.request.doTingPaiRequest)
            elif msgRequest.type == msg_pb2.EnumMsg.Value('readygamerequest'):
                self.on_ready_game(msgRequest.request.readyGameRequest)
            elif msgRequest.type == msg_pb2.EnumMsg.Value('chatrequest'):
                self.on_chat(msgRequest.request.chatRequest)
            elif msgRequest.type == msg_pb2.EnumMsg.Value('delegaterequest'):
                self.on_delegate(msgRequest.request.delegateRequest)
        except Exception, e:
            msg = traceback.format_exc()  # 方式1
            Utils().logMainDebug(msg)

    # 创建房间
    def on_create_room(self, message):
        uID = message.nUserID
        gP = message.gamePlay
        cardType = message.sCardType

        user = Dal_User().getUser(uID)
        if user.room != '': return

        # 检查资产
        cardConfig = configs_default['goods'][cardType]
        if user.gold < cardConfig['gold'] or user.money < cardConfig['money']:
            msg = msg_pb2.Msg()
            msg.type = msg_pb2.EnumMsg.Value('createroomresponse')
            msg.response.createRoomResponse.nErrorCode = config_error['moneyerror']
            data = msg.SerializeToString()
            self.write_message(data, True)
            return

        newRoom = None
        if gP.nType == config_game['gameplay']['type']['common']:
            newRoom = ZK_Room()
        elif gP.nType == config_game['gameplay']['type']['hunzi']:
            newRoom = Hui_Room()
        elif gP.nType == config_game['gameplay']['type']['happy']:
            self.on_create_happy_room(message)
            return
        else:  # 默认是通用玩法
            newRoom = Room()

        newRoom.initRoom(message, GameHandler.waiters[uID], self)
        GameHandler.add_room(newRoom)

        # 创建代理房间
    def on_create_dele_room(self, message):
        uID = message.nUserID
        gP = message.gamePlay
        cardType = message.sCardType
        user = Dal_User().getUser(uID)
        if user.room != '': return
        # 检查资产
        cardConfig = configs_default['goods'][cardType]
        if user.gold < cardConfig['gold'] or user.money < cardConfig['money']:
            msg = msg_pb2.Msg()
            msg.type = msg_pb2.EnumMsg.Value('createdeleroomresponse')
            msg.response.createRoomResponse.nErrorCode = config_error['moneyerror']
            return msg
        newRoom = None
        if gP.nType == config_game['gameplay']['common']['id']:
            newRoom = Room()
        elif gP.nType == config_game['gameplay']['dongbei']['id']:
            newRoom = DongBei_Room()
        if gP.nType == config_game['gameplay']['haerbin_common']['id'] or \
                gP.nType == config_game['gameplay']['haerbin_jiahu']['id']:
            newRoom = HaErBin_Room()
        elif gP.nType == config_game['gameplay']['mudanjiang_common']['id'] or \
                gP.nType == config_game['gameplay']['mudanjiang_jiahu']['id']:
            newRoom = MuDanJiang_Room()
        else:  # 默认是通用玩法
            newRoom = Room()

        GameHandler.add_room(newRoom)
        return newRoom.initDeleRoom(message, self)

    def on_create_happy_room(self, message):
        uID = message.nUserID
        message.sCardType = '0'
        gP = message.gamePlay
        user = Dal_User().getUser(uID)

        freeRoom = GameHandler.get_free_happy_room()
        if freeRoom == None:
            newRoom = Happy_Room()
            newRoom.initRoom(message, GameHandler.waiters[uID],self)
            GameHandler.add_room(newRoom)
        else:
            freeRoom.onJoin(uID, GameHandler.waiters[uID])


    def on_join_room(self, message):
        uid = message.nUserID
        rid = message.sRoomID
        user = Dal_User().getUser(uid)
        if user.room != '':
            return
        room = self.get_room(rid)
        if room == None:
            # 网络协议,响应
            msg = msg_pb2.Msg()
            msg.type = msg_pb2.EnumMsg.Value('joinroomresponse')
            msg.response.joinRoomResponse.nErrorCode = config_error['roominvalid']
            data = msg.SerializeToString()
            conn = GameHandler.waiters[uid]
            if conn != None:
                conn.write_message(data, True)
            return
        room.onJoin(uid,GameHandler.waiters[uid])


    def on_leave_room(self, message):
        uid = message.nUserID
        rid = message.sRoomID
        room = self.get_room(rid)
        if room != None:
            room.onLeave(uid)#离开房间

    def on_diss_room(self, message):
        uid = message.nUserID
        rid = message.sRoomID
        room = self.get_room(rid)
        if room != None:
           room.onDissRoom(uid)#解散房间

    def on_connect(self, id,conn):
        for k,v in self.room_cache.iteritems():
            if v.m_gamerCache.has_key(id):
                v.onConnect(id,conn)  # 重连处理
                break

    def on_disconnect(self, id):
        # Dal_User().delLoginer(id)#断线之后可以重新登录
        for k,v in self.room_cache.iteritems():
            if v.m_gamerCache.has_key(id):
                v.onDisConnect(id)  # 断线处理
                break

    def on_put_pai(self, message):
        uid = message.nUserID
        rid = message.sRoomID
        room = self.get_room(rid)
        room.onPutPai(uid,message.putPai.nType,message.putPai.nValue)

    def on_guo_pai(self, message):
        uid = message.nUserID
        rid = message.sRoomID
        room = self.get_room(rid)
        room.onGuoPai(uid,message.nType)

    def on_do_chi_pai(self, message):
        uid = message.nUserID
        rid = message.sRoomID
        room = self.get_room(rid)
        room.onDoChiPai(uid,message.pai,message.nChiIndex)

    def on_do_gang_pai(self, message):
        uid = message.nUserID
        rid = message.sRoomID
        room = self.get_room(rid)
        room.onDoGangPai(uid,message.pai)

    def on_do_hu_pai(self, message):
        uid = message.nUserID
        rid = message.sRoomID
        room = self.get_room(rid)
        room.onDoHuPai(uid,message.pai)

    def on_do_ting_pai(self, message):
        uid = message.nUserID
        rid = message.sRoomID
        room = self.get_room(rid)
        room.onDoTingPai(uid)

    def on_do_peng_pai(self, message):
        uid = message.nUserID
        rid = message.sRoomID
        room = self.get_room(rid)
        room.onDoPengPai(uid,message.pai)

    def on_do_qiang_ting_pai(self, message):
        uid = message.nUserID
        rid = message.sRoomID
        chiIndex = message.nChiIndex
        room = self.get_room(rid)
        room.onDoQiangTingPai(uid,message.pai,chiIndex)

    def on_ready_game(self, message):
        uid = message.nUserID
        rid = message.sRoomID
        room = self.get_room(rid)
        if room != None:
           room.onGameReady(uid)

    def on_chat(self, message):
        uid = message.nUserID
        rid = message.sRoomID
        room = self.get_room(rid)
        if room != None:
           room.onChat(uid,message.sContent)

    # 销毁无效房间
    def destory_room(self,rid):
        GameHandler.del_room(rid)

    # 销毁无效房间
    def on_delegate(self, message):
        uid = message.nUserID
        rid = message.sRoomID
        room = self.get_room(rid)
        if room != None:
           room.onDelegate(uid,message.bDo)