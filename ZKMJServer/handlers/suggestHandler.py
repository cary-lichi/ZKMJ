#coding:utf-8

import json
import tornado.web
import time
from datetime import datetime
import os
from model.suggest import Suggest
from dal.dal_suggest import Dal_Suggest
from dal.dal_user import Dal_User
from configs.config_error import config_error
from configs.config_game import config_game
from tools.utils import Utils
from handlers.BaseHandler import BaseHandler
from protobuf import msg_pb2

class SuggestHandler(BaseHandler):
    def post(self):
        msgReq = msg_pb2.Msg()
        msgReq.ParseFromString(self.request.body)

        msgResp = msg_pb2.Msg()
        msgResp.type = msg_pb2.EnumMsg.Value('suggestresponse')
        user = Dal_User().getUser(msgReq.request.suggestRequest.nUserID)
        if user == None:
            msgResp.response.suggestResponse.nErrorCode = config_error['userinvaild']
        else:
            msgResp.response.suggestResponse.nErrorCode = config_error['success']
            newSugg = Suggest()
            newSugg.phone = msgReq.request.suggestRequest.sPhone
            newSugg.detail =  msgReq.request.suggestRequest.sSuggest
            now = datetime.now()
            now = now.strftime("%Y-%m-%d %H:%M:%S")
            newSugg.time = now
            Dal_Suggest().addSuggest(newSugg)

        dataR = msgResp.SerializeToString()
        self.write(dataR)

