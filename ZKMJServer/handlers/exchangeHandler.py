#coding:utf-8

import json
import tornado.web
import time
import os
from model.user import User
from dal.dal_user import Dal_User
from configs.config_error import config_error
from tools.utils import Utils

from protobuf import login_pb2
from handlers.BaseHandler import BaseHandler
class ExchangeHandler(BaseHandler):
    def post(self):
        request = login_pb2.LoginRequest()
        request.ParseFromString(self.request.body)

        response = login_pb2.LoginResponse()
        user = Dal_User().getLoginUser(request.sName,request.sPassWord)
        if user == None:
              response.nErrorCode = config_error['userinvaild']
        else:
              response.requester.nUserID = user.id
              response.requester.nExp = user.exp
              response.requester.nPower = user.strength
              response.requester.nGold = user.gold
              response.requester.nCrystal = user.jewel
              response.requester.nSoundState = user.soundstate
              response.requester.nSoundQuality = user.soundquality



        self.write(response)


