#coding:utf-8

import json
import tornado.web
import time
from datetime import datetime
import os

from configs.config_default import configs_default
from model.suggest import Suggest
from dal.dal_record import Dal_Record
from dal.dal_user import Dal_User
from configs.config_error import config_error
from configs.config_game import config_game
from tools.utils import Utils
from handlers.BaseHandler import BaseHandler
from protobuf import msg_pb2

class RankAwardHandler(BaseHandler):
    def post(self):
        msgReq = msg_pb2.Msg()
        msgReq.ParseFromString(self.request.body)

        msgResp = msg_pb2.Msg()
        msgResp.type = msg_pb2.EnumMsg.Value('rankawardresponse')
        user = Dal_User().getUser(msgReq.request.rankAwardRequest.nUserID)
        if user == None:
            msgResp.response.rankAwardResponse.nErrorCode = config_error['userinvaild']
        elif Dal_User().getRankedFlag(user.id,msgReq.request.rankAwardRequest.nRankType):
            msgResp.response.rankAwardResponse.nErrorCode = config_error['rankawarderror']
        else:
            msgResp.response.rankAwardResponse.nErrorCode = config_error['success']
            #这里取排名
            rankOrder = Dal_Record().getRankOrder(user.id, msgReq.request.rankAwardRequest.nRankType)
            rankAwardConfig = Dal_Record().getRankAward(rankOrder, msgReq.request.rankAwardRequest.nRankType)
            if rankAwardConfig == None:
                msgResp.response.rankAwardResponse.nErrorCode = config_error['rankawarderror']
            else:
                if rankAwardConfig['aType'] == configs_default['goodType']['money']:
                    user.money = user.money + rankAwardConfig['award']
                elif rankAwardConfig['aType'] == configs_default['goodType']['gold']:
                    user.gold = user.gold + rankAwardConfig['award']

                msgResp.response.rankAwardResponse.newAssets.nUserID = user.id
                msgResp.response.rankAwardResponse.newAssets.nGold = user.gold
                msgResp.response.rankAwardResponse.newAssets.nMoney = user.money
                kwargs = {"gold": user.gold, "money": user.money}
                Dal_User().uqdateUser(user.id, **kwargs)

                Dal_User().updateRankFlag(user.id,msgReq.request.rankAwardRequest.nRankType)

        dataR = msgResp.SerializeToString()
        self.write(dataR)

