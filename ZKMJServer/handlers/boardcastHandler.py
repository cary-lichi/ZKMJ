#coding:utf-8

import json
import tornado.web
import time
import os
from model.user import User
from dal.dal_user import Dal_User
from dal.dal_boardcast import Dal_BoardCast
from configs.config_error import config_error
from configs.config_default import configs_default
from tools.utils import Utils
from handlers.BaseHandler import BaseHandler
from protobuf import buy_pb2
from protobuf import msg_pb2

class BoardCastHandler(BaseHandler):
    def post(self):
        msgReq = msg_pb2.Msg()
        msgReq.ParseFromString(self.request.body)

        msgResp = msg_pb2.Msg()
        msgResp.type = msg_pb2.EnumMsg.Value('boardcastresponse')
        user = Dal_User().getUser(msgReq.request.boardcastRequest.nUserID)
        if user == None:
            msgResp.response.boardcastResponse.nErrorCode = config_error['userinvaild']
        else:
            pool = Dal_BoardCast().getAll()
            for k,v in pool.iteritems():
               bc = msgResp.response.boardcastResponse.bPool.add()
               bc.nID = k
               bc.sTitle = v.title
               bc.sDetail = v.detail
               bc.sDate = v.time


        dataR = msgResp.SerializeToString()
        self.write(dataR)

