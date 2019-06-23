#coding:utf-8

import json
import tornado.web
import time
import os
from model.user import User
from dal.dal_user import Dal_User
from dal.dal_boardcast import Dal_BoardCast
from configs.config_error import config_error
from configs.config_game import config_game
from tools.utils import Utils
from handlers.BaseHandler import BaseHandler
from protobuf import msg_pb2

class AuthHandler(BaseHandler):
    def post(self):
        msgReq = msg_pb2.Msg()
        msgReq.ParseFromString(self.request.body)

        msgResp = msg_pb2.Msg()
        msgResp.type = msg_pb2.EnumMsg.Value('authresponse')
        user = Dal_User().getUser(msgReq.request.authRequest.nUserID)
        if user == None:
            msgResp.response.authResponse.nErrorCode = config_error['userinvaild']
        else:
            msgResp.response.authResponse.nErrorCode = config_error['success']
            sPhone = msgReq.request.authRequest.sPhone
            sVCode =  msgReq.request.authRequest.sVCode
            sRealName =  msgReq.request.authRequest.sRealName
            sSFZ =  msgReq.request.authRequest.sSFZ

            if sVCode != user.vcode:
                msgResp.response.authResponse.nErrorCode = config_error['autherror']
            else:
                assetlist = Utils().decodeMutilFormat(user.assets, ';', ':')
                for k, v in config_game['authAward'].iteritems():
                    if assetlist.has_key(k):
                        assetlist[k] = assetlist[k] + v
                    else:
                        assetlist[k] = v
                user.assets = Utils().encodeMutilFormat(assetlist, ';', ':')
                msgResp.response.authResponse.newasset = user.assets

                kwargs = {"phone": sPhone,"realname": sRealName,"sfz": sSFZ,"assets": user.assets}
                Dal_User().uqdateUser(user.id, **kwargs)
                Utils().sendTelMsg(sVCode,sPhone)

        dataR = msgResp.SerializeToString()
        self.write(dataR)

