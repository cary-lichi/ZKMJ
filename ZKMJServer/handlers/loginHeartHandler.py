#coding:utf-8

import json
import tornado.web
import time
import os

from handlers.gameHandler import GameHandler
from model.user import User
from dal.dal_user import Dal_User
from configs.config_error import config_error
from tools.utils import Utils
from handlers.BaseHandler import BaseHandler
from protobuf import msg_pb2

class LoginHeartHandler(BaseHandler):
    def post(self):
        msgReq = msg_pb2.Msg()
        msgReq.ParseFromString(self.request.body)
        request = msgReq.request.loginHeartRequest

        user = Dal_User().getUser(request.nUserID)
        if user :
            loginuser = Dal_User().getLoginer(request.nUserID)
            msgResp = msg_pb2.Msg()
            msgResp.type = msg_pb2.EnumMsg.Value('loginheartresponse')
            response = msgResp.response.loginHeartResponse
            # if loginuser and user.sToken == request.sToken:
            #     Dal_User().onHeartBeat(user.id)
            #     response.nErrorCode = config_error['success']
            #     response.nHappyNum = GameHandler.get_happy_users()
            # else:
            #     response.nErrorCode = config_error['loginExpires']
            response.nErrorCode = config_error['success']
            response.nHappyNum = GameHandler.get_happy_users()
            data = msgResp.SerializeToString()
            self.write(data)

