#coding:utf-8

import json
import tornado.web
import time
from datetime import datetime
import os

from configs.config_default import configs_default
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

class LuckyHandler(BaseHandler):
    def post(self):
        msgReq = msg_pb2.Msg()
        msgReq.ParseFromString(self.request.body)

        msgResp = msg_pb2.Msg()
        msgResp.type = msg_pb2.EnumMsg.Value('luckyresponse')
        user = Dal_User().getUser(msgReq.request.luckyRequest.nUserID)
        if user == None:
            msgResp.response.luckyResponse.nErrorCode = config_error['userinvaild']
        elif  user.luckytime and Utils().dbTime2Number(user.luckytime) >= Utils().LastDayEndTime():
               msgResp.response.luckyResponse.nErrorCode = config_error['luckytimeerror']
        else:
            msgResp.response.luckyResponse.nErrorCode = config_error['success']

            #抽奖逻辑
            randNum = Utils().random_index(configs_default['luckysRate'])
            msgResp.response.luckyResponse.nLucky = randNum
            luckGood = configs_default['luckys'][randNum]

            if luckGood['type'] == configs_default['goodType']['money']:
                user.money = user.money + luckGood['extra']
            elif luckGood['type'] == configs_default['goodType']['gold']:
                user.gold = user.gold + luckGood['extra']

            user.luckytime = Utils().dbTimeCreate()
            msgResp.response.luckyResponse.newAssets.nUserID = user.id
            msgResp.response.luckyResponse.newAssets.nGold = user.gold
            msgResp.response.luckyResponse.newAssets.nMoney = user.money
            kwargs = {"gold": user.gold, "money": user.money,"luckytime":user.luckytime}
            Dal_User().uqdateUser(user.id, **kwargs)

            # 邮件记录
            mail = Mail()
            mail.uid = user.id
            mail.type = configs_default['mail']['type']['luckyaward']
            mail.content = str(luckGood['type']) + ':'+str(luckGood['extra'])
            mail.time = Utils().dbTimeCreate()
            Dal_Mail().addMail(mail)
            Dal_User().addMails(mail.uid, mail.id)


        dataR = msgResp.SerializeToString()
        self.write(dataR)

