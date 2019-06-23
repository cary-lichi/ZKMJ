# -*-coding:utf-8-*-
'''
用户点击开始游戏  用户传入的数据是 用户名和歌曲id  返回值是错误码  和的当前的体力值
'''
import json
import tornado.web
import tornado.websocket
import time
import logging
from configs.config_error import config_error
from dal.dal_user import Dal_User
from tools.utils import Utils
from model.gamer import Gamer
from model.room import Room

from protobuf import msg_pb2
from protobuf import create_room_pb2

#基本思想是vip和普通房间都是先在后台创建房间，
# vip房间需要消耗房卡道具，可邀请微信好友加入
#普通房间是当用户开始游戏时，先检查房间队列中有没有空闲的，如果有就直接加入，没有则创建新的普通房间加入
#一旦创建房间，默认进入长链接模式
class TestHandler(tornado.websocket.WebSocketHandler):
    waiters = dict()#用户链接集合
    room_cache = dict()  ##玩家分组集合，房间id=》房间
    def check_origin(self, origin):
        return True

    def get_compression_options(self):
        # Non-None enables compression with default options.
        return {}

    def open(self):
        uID = (int)(self.get_argument('id'))
        self.waiters.append(uID)

    def on_close(self):
        # GameHandler.testconn = None
        # return
        uID = (int)(self.get_argument('id'))
        self.waiters.pop(uID)

    @classmethod
    def get_connect(cls, uid):
        return  cls.waiters[uid]

    def add_room(self, room):
       self.room_cache[room.id] = room

    def get_room(self, id):
        return  self.room_cache.get(id)

    def del_room(self, id):
         self.room_cache.pop(id)

    def on_message(self, message):
        # logging.info("got message %r", message)
        # msgR = msg_pb2.Msg()
        # msgR.ParseFromString(message)

        # msg = msg_pb2.Msg()
        # msg.type = msg_pb2.EnumMsg.Value('createroomresponse')
        # # msg.response.createRoomResponse.nErrorCode = 0
        # # msg.response.createRoomResponse.nType = 0
        # # msg.response.createRoomResponse.sRoomID = "asda"
        # #
        # # data = msg.SerializeToString()
        # # GameHandler.waiters[12345].write_message(data)
        # msg = test_pb2.testMessage()
        # msg.id = 123456
        #
        # msg1 = test_pb2.testMessage()
        # msg1.id = 123
        #
        # data = msg.SerializeToString()
        # data1 = msg1.SerializeToString()
        # GameHandler.testconn.write_message(data1)
        # # GameHandler.waiters[234].write_message(data)
        # # return
        msgRequest = msg_pb2.Msg()
        msgRequest.ParseFromString(message)
        if msgRequest.type == msg_pb2.EnumMsg.Value('createroomrequest'):
            self.on_create_room(msgRequest.request.createRoomRequest)
        elif msgRequest.type == msg_pb2.EnumMsg.Value('joinroomrequest'):
            self.on_join_room(msgRequest.request.joinRoomRequest)
        elif msgRequest.type == msg_pb2.EnumMsg.Value('leaveroomrequest'):
            self.on_leave_room(msgRequest.request.leaveRoomRequest)
        elif msgRequest.type == msg_pb2.EnumMsg.Value('getpairequest'):
            self.on_get_pai(msgRequest.request.getPaiRequest)
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
        elif msgRequest.type ==msg_pb2.EnumMsg.Value('dotingpairequest'):
            self.on_do_ting_pai(msgRequest.request.doTingPaiRequest)
        elif msgRequest.type == msg_pb2.EnumMsg.Value('guopairequest'):
            self.on_guo_pai(msgRequest.request.doTingPaiRequest)

#创建房间
    def on_create_room(self, message):
        uid = message.nUserID
        newRoom = Room(uid,GameHandler.waiters[uid])
        self.room_cache[newRoom.m_id] = newRoom


    def on_join_room(self, message):
        uid = message.nUserID
        rid = message.sRoomID
        room = self.get_room(rid)
        room.onJoin(uid,GameHandler.waiters[uid])


    def on_leave_room(self, message):
        uid = message.nUserID
        rid = message.nRoomID
        room = self.get_room(rid)
        room.onLeave(uid)

    def on_get_pai(self, message):
        uid = message.nUserID
        rid = message.nRoomID
        room = self.get_room(rid)
        room.onGetPai(uid)

    def on_put_pai(self, message):
        uid = message.nUserID
        rid = message.nRoomID
        room = self.get_room(rid)
        room.onPutPai(uid,message.putPai.nType,message.putPai.nValue)

    def on_guo_pai(self, message):
        uid = message.nUserID
        rid = message.nRoomID
        room = self.get_room(rid)
        room.onGuoPai(uid, message.nType,message.pai)

    def on_do_chi_pai(self, message):
        uid = message.nUserID
        rid = message.nRoomID
        room = self.get_room(rid)
        room.onDoChiPai(uid,message.pai)

    def on_do_gang_pai(self, message):
        uid = message.nUserID
        rid = message.nRoomID
        room = self.get_room(rid)
        room.onDoGangPai(uid,message.pai)

    def on_do_hu_pai(self, message):
        uid = message.nUserID
        rid = message.nRoomID
        room = self.get_room(rid)
        room.onDoHuPai(uid,message.pai)

    def on_do_peng_pai(self, message):
        uid = message.nUserID
        rid = message.nRoomID
        room = self.get_room(rid)
        room.onDoPengPai(uid,message.pai)

    def on_do_ting_pai(self, message):
        uid = message.nUserID
        rid = message.nRoomID
        room = self.get_room(rid)
        room.onDoTingPai(uid,message.pai)



