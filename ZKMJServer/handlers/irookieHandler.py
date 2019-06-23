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
#领取新手邀请奖励
class IRookieHandler(BaseHandler):
    def post(self):
        msgReq = msg_pb2.Msg()
        msgReq.ParseFromString(self.request.body)

        msgResp = msg_pb2.Msg()
        msgResp.type = msg_pb2.EnumMsg.Value('irookieresponse')
        user = Dal_User().getUser(msgReq.request.irookieRequest.nUserID)
        if user == None:
            msgResp.response.irookieResponse.nErrorCode = config_error['userinvaild']
        else:
            #先检测是否已经领过新手奖励
            if user.parent == 0:
                msgResp.response.irookieResponse.nErrorCode = config_error['notrookie']
            else:
                awards = msgReq.request.irookieRequest.nAwards
                assetlist = Utils().decodeMutilFormat(user.assets, ';', ':')
                for k, v in config_game['rookieIAward'].iteritems():
                    if assetlist.has_key(k):
                        assetlist[k] = assetlist[k] + v*awards
                    else:
                        assetlist[k] = v*awards
                user.assets = Utils().encodeMutilFormat(assetlist, ';', ':')
                msgResp.response.irookieResponse.newAssets = user.assets
                kwargs = { "assets": user.assets}
                Dal_User().uqdateUser(user.id, **kwargs)



        dataR = msgResp.SerializeToString()
        self.write(dataR)

