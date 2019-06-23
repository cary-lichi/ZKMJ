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

class RegisterHandler(BaseHandler):
    def post(self):
        msgReq = msg_pb2.Msg()
        msgReq.ParseFromString(self.request.body)
        request = msgReq.request.registerRequest

        msgResp = msg_pb2.Msg()
        msgResp.type = msg_pb2.EnumMsg.Value('registerresponse')
        response = msgResp.response.registerResponse
        user = Dal_User().getValueByAttr('name',request.sName)
        if len(user) != 0:
              response.nErrorCode = config_error['userinvaild']
        else:
            um = User(id=None, name=request.sName, password=request.sPassWord,
                      nick=None, exp=None, gold=None,
                      money=None, headimg=None, phone=None,
                      records=None, assets=None, room=None,
                      parent = None,parentaward = None,invitetime=None)
            Dal_User().addUser(um)
            response.nErrorCode = config_error['success']
            response.nUserID = um.id


        data = msgResp.SerializeToString()
        self.write(data)


