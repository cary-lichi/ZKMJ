#coding:utf-8

import json
import tornado.web
import time
from datetime import datetime
import os

from configs.config_default import configs_default
from dal.dal_user import Dal_User
from configs.config_error import config_error
from configs.config_game import config_game
from tools.utils import Utils
from handlers.BaseHandler import BaseHandler
from protobuf import msg_pb2
from handlers.gameHandler import GameHandler
from logic.room import Room

class DeleCreateRoomHandler(BaseHandler):
    def post(self):
        msgReq = msg_pb2.Msg()
        msgReq.ParseFromString(self.request.body)

        message=msgReq.request.createRoomRequest

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

        msgResp=newRoom.initDeleRoom(message, self)

        GameHandler.add_room(newRoom)

        dataR = msgResp.SerializeToString()
        self.write(dataR)
  # 销毁无效房间
    def destory_room(self,rid):
        GameHandler.del_room(rid)