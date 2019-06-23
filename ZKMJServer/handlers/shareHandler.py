#coding:utf-8

import json
import tornado.web
import time
from datetime import datetime
import os

from configs.config_default import configs_default
from dal.dal_delegate import Dal_Delegate
from dal.dal_mail import Dal_Mail
from model.mail import Mail
from model.suggest import Suggest
from dal.dal_suggest import Dal_Suggest
from dal.dal_user import Dal_User
from configs.config_error import config_error
from configs.config_game import config_game
from tools.utils import Utils
from handlers.BaseHandler import BaseHandler
from protobuf import msg_pb2

class ShareHandler(BaseHandler):
    def post(self):
        msgReq = msg_pb2.Msg()
        msgReq.ParseFromString(self.request.body)

        msgResp = msg_pb2.Msg()
        msgResp.type = msg_pb2.EnumMsg.Value('shareresponse')
        user = Dal_User().getUser(msgReq.request.shareRequest.nUserID)
        if user == None:
            msgResp.response.shareResponse.nErrorCode = config_error['userinvaild']
        elif  user.sharetime and Utils().dbTime2Number(user.sharetime) >= Utils().LastWeekEndTime():
               msgResp.response.shareResponse.nErrorCode = config_error['sharetimeerror']
        else:
            msgResp.response.shareResponse.nErrorCode = config_error['success']

            #分享奖励逻辑
            user.money = user.money + configs_default['shareAward']
            user.sharetime = Utils().dbTimeCreate()
            msgResp.response.shareResponse.newAssets.nUserID = user.id
            msgResp.response.shareResponse.newAssets.nMoney = user.money
            kwargs = { "money": user.money,"sharetime":user.sharetime}
            Dal_User().uqdateUser(user.id, **kwargs)

            delegater = Dal_Delegate().getDelegate(user.id)
            delegater.shareaward = delegater.shareaward + configs_default['shareAward']
            kwargs = { "shareaward": delegater.shareaward}
            Dal_Delegate().updateDelegate(delegater.id, **kwargs)

            #邮件记录
            mail = Mail()
            mail.uid = user.id
            mail.type = configs_default['mail']['type']['shareaward']
            mail.content = str(configs_default['shareAward'])
            mail.time = Utils().dbTimeCreate()
            Dal_Mail().addMail(mail)
            Dal_User().addMails(user.id,mail.id)

        dataR = msgResp.SerializeToString()
        self.write(dataR)

