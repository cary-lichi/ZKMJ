#coding:utf-8

import json
import tornado.web
import time
import os
from model.user import User
from dal.dal_user import Dal_User
from configs.config_error import config_error
from configs.config_game import config_game
from tools.utils import Utils
from handlers.BaseHandler import BaseHandler
from protobuf import buy_pb2
from protobuf import msg_pb2
#显示新手邀请奖励
class IRookieShowHandler(BaseHandler):
    def post(self):
        msgReq = msg_pb2.Msg()
        msgReq.ParseFromString(self.request.body)

        msgResp = msg_pb2.Msg()
        msgResp.type = msg_pb2.EnumMsg.Value('irookieshowresponse')
        user = Dal_User().getUser(msgReq.request.irookieShowRequest.nUserID)
        if user == None:
            msgResp.response.irookieShowResponse.nErrorCode = config_error['userinvaild']
        else:
            msgResp.response.irookieShowResponse.nErrorCode = config_error['success']
            rookies = Dal_User().getValueByAttr('parent',user.id)
            msgResp.response.irookieShowResponse.nAwardCount = len(rookies)
            for k,v in enumerate(rookies):
                record =  msgResp.response.records.add()
                record.nUserID = record.id
                record.nUserNick = record.name
                record.nInviteTime = record.invitetime


        dataR = msgResp.SerializeToString()
        self.write(dataR)

