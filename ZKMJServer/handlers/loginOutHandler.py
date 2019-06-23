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

class LoginOutHandler(BaseHandler):
    def post(self):
        msgReq = msg_pb2.Msg()
        msgReq.ParseFromString(self.request.body)

        msgResp = msg_pb2.Msg()
        msgResp.type = msg_pb2.EnumMsg.Value('loginoutresponse')

        request = msgReq.request.loginOutRequest
        response = msgResp.response.loginOutResponse
        user = Dal_User().getUser(request.nUserID)
        if user == None:
              response.nErrorCode = config_error['userinvaild']
        else:
              response.nErrorCode = config_error['success']
              Dal_User().delLoginer(user.id)

        data = msgResp.SerializeToString()
        self.write(data)


