#coding:utf-8

import json
import tornado.web
import time
from datetime import datetime
import os

from configs.config_default import configs_default
from model.suggest import Suggest
from dal.dal_suggest import Dal_Suggest
from dal.dal_user import Dal_User
from configs.config_error import config_error
from configs.config_game import config_game
from tools.utils import Utils
from handlers.BaseHandler import BaseHandler
from protobuf import msg_pb2

class WelfareHandler(BaseHandler):
    def post(self):
        msgReq = msg_pb2.Msg()
        msgReq.ParseFromString(self.request.body)

        msgResp = msg_pb2.Msg()
        msgResp.type = msg_pb2.EnumMsg.Value('welfareresponse')
        user = Dal_User().getUser(msgReq.request.welfareRequest.nUserID)
        if user == None:
            msgResp.response.welfareResponse.nErrorCode = config_error['userinvaild']
        elif  user.welfaretime and Utils().dbTime2Number(user.welfaretime) >= Utils().LastDayEndTime():
            msgResp.response.welfareResponse.nErrorCode = config_error['luckytimeerror']
        elif user.gold >=  configs_default['welfare']:
            msgResp.response.welfareResponse.nErrorCode = config_error['welfareerror']
        else:
            msgResp.response.welfareResponse.nErrorCode = config_error['success']

            #发福利逻辑
            user.gold = user.gold + configs_default['welfare']

            user.welfaretime = Utils().dbTimeCreate()
            msgResp.response.welfareResponse.newAssets.nUserID = user.id
            msgResp.response.welfareResponse.newAssets.nGold = user.gold
            kwargs = {"gold": user.gold,"welfaretime":user.welfaretime}
            Dal_User().uqdateUser(user.id, **kwargs)


        dataR = msgResp.SerializeToString()
        self.write(dataR)

