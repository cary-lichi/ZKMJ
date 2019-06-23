#coding:utf-8

import json
import tornado.web
import time
import os
from model.user import User
from dal.dal_user import Dal_User
from configs.config_error import config_error
from configs.config_default import configs_default
from tools.utils import Utils
from handlers.BaseHandler import BaseHandler
from protobuf import buy_pb2
from protobuf import msg_pb2

class BuyHandler(BaseHandler):
    def post(self):
        msgReq = msg_pb2.Msg()
        msgReq.ParseFromString(self.request.body)

        msgResp = msg_pb2.Msg()
        msgResp.type = msg_pb2.EnumMsg.Value('buyresponse')
        user = Dal_User().getUser(msgReq.request.buyRequest.nUserID)
        if user == None:
            msgResp.response.buyResponse.nErrorCode = config_error['userinvaild']
        else:
              msgResp.response.buyResponse.nErrorCode = config_error['success']
              totalG = 0
              totalM = 0
              for i,v in enumerate(msgReq.request.buyRequest.goods):
                   gID = v.nID
                   gConfig = configs_default['goods'][str(gID)]
                   gType = gConfig['type']
                   #这里只能用钻石购买金币
                   if gType != configs_default['goodType']['gold']:continue
                   gMoney = gConfig['money']#需要花费的钻石数量
                   gExtra = gConfig['extra']#能兑换的金币数量
                   totalG = totalG + gExtra
                   totalM = totalM + gMoney


              if user.money < totalM:
                  msgResp.response.buyResponse.nErrorCode = config_error['moneyerror']
              else:
                  user.gold = user.gold  + totalG
                  user.money = user.money  - totalM
                  msgResp.response.buyResponse.newAssets.nUserID = user.id
                  msgResp.response.buyResponse.newAssets.nGold = user.gold
                  msgResp.response.buyResponse.newAssets.nMoney = user.money
                  kwargs = {"gold": user.gold,"money": user.money}
                  Dal_User().uqdateUser(user.id,**kwargs)


        dataR = msgResp.SerializeToString()
        self.write(dataR)

