#coding:utf-8
#by lichiYang
#这是一个查询代理的消费（充值记录的接口）

import json
import tornado.web
import time
import os
import math
import datetime

from configs.config_default import configs_default
from model.user import User
import application
from model.delegate import Delegate
from dal.dal_user import Dal_User
from dal.dal_delegate import Dal_Delegate
from tools.utils import Utils
from dal.dal_recharge import Dal_Recharge
from model.recharge import Recharge
from handlers.BaseHandler import BaseHandler
from configs.config_error import config_error

class DeleGetRechatgeInfoHandler(BaseHandler):
    def post(self):
        id = self.getData("id")
        rInfo = []
        response = {}
        #通过id查询他充值的记录
        user = Dal_User().getUser(id)
        rechatge = Dal_Recharge().getValueByAttr('uid',long(id))
        fromcc = Dal_Recharge().getValueByAttr('fromc',3)
        if user==None:
            response={
                'errorcode':config_error['userinvaild']
            }
            respon_json = json.dumps(response)
            self.write(respon_json)
            return
        if len(fromcc)!=0:#遍历充值记录
            for k in fromcc:
#                 通过id去查到记录
                k = int(k)
                rechatges = Dal_Recharge().getRecharge(k)
                if rechatges.good ==id:
                    rInfo.append(rechatges.id)
        r_list = rechatge + rInfo
        if len(r_list)!=0:
            # index =0
            rechatInfos=[]
            for k in r_list:
                rechatgeinfo = Dal_Recharge().getRecharge(k)
                if rechatgeinfo ==None:
                    continue
                infos = {
                    'time':Utils().dateTime2String(rechatgeinfo.time),
                    'money':rechatgeinfo.money,
                    'fromc':rechatgeinfo.fromc,
                    'uid':rechatgeinfo.uid,
                    'good':rechatgeinfo.good,
                    # 'count':int(rechatgeinfo.count),
                }
                rechatInfos.append(infos)
            response={
                'errorcode':config_error['success'],
                'rechatgeinfo':rechatInfos,
            }
        respon_json = json.dumps(response)
        self.write(respon_json)
        return

