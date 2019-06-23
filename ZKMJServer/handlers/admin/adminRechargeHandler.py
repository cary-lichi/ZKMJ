#coding:utf-8

import json
import tornado.web
import time
import os
import math
import datetime

from handlers.admin.adminBaseHandler import AmminBaseHandler
from configs.config_default import configs_default
from dal.dal_delegate import Dal_Delegate
from dal.dal_recharge import Dal_Recharge
from model.recharge import Recharge
from model.user import User
from dal.dal_user import Dal_User
from dal.dal_admin import Dal_Admin
from tools.utils import Utils
from handlers.BaseHandler import BaseHandler
from configs.config_error import config_error
#后台充值
class AdminRechargeHandler(AmminBaseHandler):
    def post(self):
        Aid = self.getData("Aid")
        post_data = {}
        for key in self.request.arguments:
            post_data[key] = self.get_arguments(key)[0]

        #判断是否有超级管理员权限
        response = self.IsSuperadmin(post_data)
        if response != None:
            respon_json = json.dumps(response)
            self.write(respon_json)
            return

        uid = int(post_data['uid'])
        money = int(post_data['money'])
        gold = int(post_data['gold'])


        user = Dal_User().getUser(uid)
        if user == None:
            respon = {
                'errorcode': config_error['userinvaid']
            }
        else:
            respon = {
                'errorcode': config_error['success']
            }
            user.money = user.money + money
            user.gold = user.gold + gold
            # 更新用户信息
            update_data = {'money': user.money,'gold': user.gold}
            Dal_User().uqdateUser(user.id, **update_data)

            # 充值
            re = Recharge(id=None, time=Utils().dbTimeCreate(), money=money,
                          uid=uid, good='admin', count=1, fromc=2)
            Dal_Recharge().addRecharge(re)
            #     更新操作
            operate = configs_default['adminOperate']['recharge']
            Dal_Admin().addOperate(Aid, operate)

        respon_json = json.dumps(respon)
        self.write(respon_json)
