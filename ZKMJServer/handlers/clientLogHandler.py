#coding:utf-8

import json
import tornado.web
import time
import os
from model.user import User
from dal.dal_user import Dal_User
from configs.config_error import config_error
from tools.utils import Utils
from handlers.BaseHandler import BaseHandler
from protobuf import msg_pb2

class ClientLogHandler(BaseHandler):
    def post(self):
        msgReq = msg_pb2.Msg()
        msgReq.ParseFromString(self.request.body)
        request = msgReq.request.clientLogRequest
        Utils().logMainDebug("玩家"+str(request.nUserID)+"在"+Utils().dbTimeCreate()+"出错: "+ str(request.sContent))



