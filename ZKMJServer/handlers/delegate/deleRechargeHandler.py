#coding:utf-8

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
from model.recharge import Recharge
from handlers.BaseHandler import BaseHandler
from configs.config_error import config_error
from dal.dal_recharge import Dal_Recharge
#上级代理为下级代理充值
class DeleRechargeHandler(BaseHandler):
    def post(self):
        post_data = {}
        for key in self.request.arguments:
            post_data[key] = self.get_arguments(key)[0]

        uid = int(post_data['id']) #
        rid = int(post_data['rid']) #要充值的下级代理id
        money = int(post_data['money'])
        user = Dal_User().getUser(uid)
        userChild = Dal_User().getUser(rid)
        result_data = {}
        if user == None or userChild == None :
            result_data['errorcode'] =config_error['delegateinvaid']
        elif user.money < money:
            result_data['errorcode'] =config_error['delepayforothererror']
        else:
            user.money = user.money - money
            userChild.money = userChild.money + money
            # 更新用户信息
            update_data = {'money': user.money}
            Dal_User().uqdateUser(user.id, **update_data)
            update_data = {'money': userChild.money}
            Dal_User().uqdateUser(userChild.id, **update_data)
            time = Utils().dbTimeCreate()

            #新增充值记录
            rechge = Recharge(id=None, time=time, money=money,
                        uid=rid, good=uid, count='1',
                        fromc='3')
            Dal_Recharge().addRecharge(rechge)
            result_data['errorcode'] = config_error['success']
            result_data['money'] = user.money
            result_data['rid'] = userChild.id
            result_data['rmoney'] = userChild.money

        respon_json = json.dumps(result_data)
        self.write(respon_json)