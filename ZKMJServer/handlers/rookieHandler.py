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
#新手验证码，奖励等
class RookieHandler(BaseHandler):
    def post(self):
        msgReq = msg_pb2.Msg()
        msgReq.ParseFromString(self.request.body)

        msgResp = msg_pb2.Msg()
        msgResp.type = msg_pb2.EnumMsg.Value('rookieresponse')
        user = Dal_User().getUser(msgReq.request.rookieRequest.nUserID)
        if user == None:
            msgResp.response.rookieResponse.nErrorCode = config_error['userinvaild']
        else:
            #先检测是否已经领过新手奖励
            if user.parent == 0:
                msgResp.response.rookieResponse.nErrorCode = config_error['notrookie']
            else:
                sICode = msgReq.request.rookieRequest.sICode#邀请码
                nI = (int)(Utils().decodeRandomCode(sICode))#获取邀请者
                inviter = Dal_User().getUser(nI)
                if inviter != None:
                    # 发放新手奖励
                    assetlist = Utils().decodeMutilFormat(user.assets, ';', ':')
                    for k, v in config_game['rookieAward'].iteritems():
                        if assetlist.has_key(k):
                            assetlist[k] = assetlist[k] + v
                        else:
                            assetlist[k] = v
                    user.assets = Utils().encodeMutilFormat(assetlist, ';', ':')
                    kwargs = {"parent": nI, "assets": user.assets}
                    Dal_User().uqdateUser(user.id, **kwargs)

                else:
                    msgResp.response.rookieResponse.nErrorCode = config_error['userinvaild']


        dataR = msgResp.SerializeToString()
        self.write(dataR)

