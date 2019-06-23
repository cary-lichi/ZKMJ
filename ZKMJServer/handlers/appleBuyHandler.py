#coding:utf-8
import httplib
import json

import math
import tornado.web
import time
import os

from dal.dal_delegate import Dal_Delegate
from dal.dal_recharge import Dal_Recharge
from model.recharge import Recharge
from model.user import User
from dal.dal_user import Dal_User
from configs.config_error import config_error
from configs.config_default import configs_default
from tools.utils import Utils
from handlers.BaseHandler import BaseHandler
from protobuf import buy_pb2
from protobuf import msg_pb2
#苹果内支付回调,这里已经是支付成功，添加用户商品
class AppleBuyHandler(BaseHandler):
    def onAppleBuy(self,uID,gID,nMoney,nCount):
        # 处理回调结果
        user = Dal_User().getUser(uID)
        goodConfig = configs_default['goods'][gID]
        if goodConfig['type'] == configs_default['goodType']['money']:
            user.money = user.money + goodConfig['extra']
            user.totalmoney = user.totalmoney + goodConfig['extra']
            user.totalrmb = user.totalrmb + goodConfig['rmb']

            # 检测代理充值奖励
            delegater = Dal_Delegate().getDelegate(user.id)
            dLv = str(delegater.slevel)
            parentDelegater = Dal_Delegate().getDelegate(delegater.parent)
            if parentDelegater:  # 对上级代理做奖励
                parentUser = Dal_User().getUser(parentDelegater.gid)
                awardPercent = configs_default['delegate']['payAwards'][dLv]
                awardPay = math.ceil(goodConfig['extra'] * awardPercent)
                parentUser.money = parentUser.money + awardPay
                parentDelegater.awards = parentDelegater.awards + awardPay

                # 给上级代理奖励的钻石
                kwargs = {"money": parentUser.money}
                Dal_User().uqdateUser(parentUser.id, **kwargs)

                # 上级代理获得的奖励总数
                kwargs = {"awards": parentDelegater.awards}
                Dal_Delegate().uqdateDelegate(parentDelegater.id, **kwargs)

        elif goodConfig['type'] == configs_default['goodType']['gold']:
            user.gold = user.gold + goodConfig['extra']

        kwargs = {"gold": user.gold, "money": user.money, "totalmoney": user.totalmoney, "totalrmb": user.totalrmb}
        Dal_User().uqdateUser(user.id, **kwargs)

        # 充值
        re = Recharge(id=None, time=Utils().dbTimeCreate(), money=nMoney,
                      uid=uID, good=gID, count=nCount,fromc=1)
        Dal_Recharge().addRecharge(re)

    def post(self):
        post_data = {}
        for key in self.request.arguments:
            post_data[key] = self.get_arguments(key)[0]

        user = Dal_User().getUser(post_data['userid'])
        if user == None:
            respon = {'errorcode': config_error['userinvaild']}
        else:
             receipt = {"receipt-data":post_data['apple_receipt']}
             applyServerHost = "buy.itunes.apple.com"
             applyServerUrl = "/verifyReceipt"
             con = None
             respon = {}


             try:
                 headers = {"Content-type": "application/x-www-form-urlencoded",
                            "Accept": "text/plain"}
                 conn = httplib.HTTPSConnection(applyServerHost)
                 conn.request('POST', applyServerUrl, json.dumps(receipt), headers)
                 httpres = conn.getresponse()
                 result = httpres.read()
                 result = json.loads(result)
                 status = result.get('status')
                 if  21007 == status:#沙盒环境
                     applyServerHost = "sandbox.itunes.apple.com"
                     conn = httplib.HTTPSConnection(applyServerHost)
                     conn.request('POST', applyServerUrl, json.dumps(receipt), headers)
                     httpres = conn.getresponse()

                 if '200' != str(httpres.status):
                     respon["errorcode"] = -1
                     respon["errmsg"] = str(httpres.status) + " " + httpres.reason
                 else:
                     respon["errorcode"] = config_error['success']
                     result = httpres.read()
                     result = json.loads(result)
                     status = result.get('status')
                     receipt = result.get('receipt', {})

                     transaction_id = receipt.get('transaction_id', '')
                     purchase_date = receipt.get('original_purchase_date', '')
                     product_id = receipt.get('product_id', '')
                     money = configs_default['goods'][product_id]['rmb']

                 if 0 == result['status']:  # 购买成功
                         respon["errorcode"] = config_error['success']
                         respon["product_id"] = product_id

                         self.onAppleBuy(user.id,product_id,money,1)
                 else:
                         respon["errorcode"] = config_error['applepayerror']

             except Exception, e:
                 import traceback
                 respon["errorcode"] = -2
                 respon["errmsg"] = traceback.format_exc()
             finally:
                 if con:
                     con.close()

        respon_json = json.dumps(respon)
        self.write(respon_json)

