#coding=utf-8
import json
import tornado.web
import time
import os
import math
import datetime

from dal.dal_recharge import Dal_Recharge
from dal.dal_admin import Dal_Admin
from dal.dal_user import Dal_User
from dal.dal_base import Dal_base
from model.recharge import Recharge
from model.admin import Admin
from model.user import User
from handlers.admin.adminBaseHandler import AmminBaseHandler
from configs.config_error import config_error
from configs.config_default import configs_default

class AdminRechargeInfoHandler(AmminBaseHandler):
    def post(self):
        # orderNum =self.getData("oid")
        # account = self.getData("account")
        # gid = self.getData("identifier")
        # strattime = self.getData("strattime")
        # endtime = self.getData("endtime")
        post_data = {}
        for key in self.request.arguments:
            post_data[key] = self.get_arguments(key)[0]
        response = None
        # 判断是否有三级管理员权限
        response = self.IsSub3admin(post_data)
        if response != None:
            respon_json = json.dumps(response)
            self.write(respon_json)
            return
        #获取所有的充值记录
        recharge = Dal_Recharge().getAllID()
        if len(recharge)!=0:
            response =self.GetResultRecharge(post_data,recharge)
        else:
            response = {
                'errorcode': config_error['noRecord'],
            }
        respon_json = json.dumps(response)
        self.write(respon_json)

