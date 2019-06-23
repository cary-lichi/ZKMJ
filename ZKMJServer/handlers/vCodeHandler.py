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
from protobuf import msg_pb2

class VCodeHandler(BaseHandler):
    def post(self):
        msgReq = msg_pb2.Msg()
        msgReq.ParseFromString(self.request.body)

        msgResp = msg_pb2.Msg()
        msgResp.type = msg_pb2.EnumMsg.Value('vcoderesponse')
        user = Dal_User().getUser(msgReq.request.vCodeRequest.nUserID)
        if user == None:
            msgResp.response.vCodeResponse.nErrorCode = config_error['userinvaild']
        else:
            msgResp.response.vCodeResponse.nErrorCode = config_error['success']
            sPhone = msgReq.request.vCodeRequest.sPhone
            sVCode = Utils().createPhoneCode()
            msgResp.response.vCodeResponse.sVCode = sVCode
            kwargs = {"vcode": sVCode}
            Dal_User().uqdateUser(user.id, **kwargs)
            Utils().sendTelMsg(sVCode,sPhone)

        dataR = msgResp.SerializeToString()
        self.write(dataR)

