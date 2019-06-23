#coding:utf-8

import json
import tornado.web
import time
from datetime import datetime
import os

from configs.config_default import configs_default
from dal.dal_delegate import Dal_Delegate
from dal.dal_mail import Dal_Mail
from model.suggest import Suggest
from dal.dal_suggest import Dal_Suggest
from dal.dal_user import Dal_User
from configs.config_error import config_error
from configs.config_game import config_game
from tools.utils import Utils
from handlers.BaseHandler import BaseHandler
from protobuf import msg_pb2

class MailsHandler(BaseHandler):
    def post(self):
        msgReq = msg_pb2.Msg()
        msgReq.ParseFromString(self.request.body)

        msgResp = msg_pb2.Msg()
        msgResp.type = msg_pb2.EnumMsg.Value('mailresponse')
        user = Dal_User().getUser(msgReq.request.mailRequest.nUserID)
        if user == None:
            msgResp.response.mailResponse.nErrorCode = config_error['userinvaild']
        else:
            msgResp.response.mailResponse.nErrorCode = config_error['success']

            mails = Utils().decodeIDFormat(user.mails)
            for k,v in enumerate(mails):
                mail = Dal_Mail().getMail(int(v))
                if mail == None:continue
                addMail = msgResp.response.mailResponse.mails.add()
                addMail.nID = mail.id
                addMail.nUID = mail.uid
                addMail.nType = mail.type
                addMail.sContent = mail.content
                if isinstance(mail.time,str):
                    addMail.sTime = mail.time
                else:
                    addMail.sTime = Utils().dateTime2String(mail.time)

        dataR = msgResp.SerializeToString()
        self.write(dataR)

