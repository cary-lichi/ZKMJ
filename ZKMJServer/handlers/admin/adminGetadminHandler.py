#coding=utf-8
import hashlib
import json

from configs.config_default import configs_default
from configs.config_error import config_error
from dal.dal_admin import Dal_Admin
from handlers.admin.adminBaseHandler import AmminBaseHandler
from model.admin import Admin
from dal.dal_operate import Dal_Operate
from model.operate import Operate


class AdminGetadminHandler(AmminBaseHandler):
    def post(self):
        post_data = {}
        for key in self.request.arguments:
            post_data[key] = self.get_arguments(key)[0]
        response = None
        result_data = {}
        response = self.IsSuperadmin(post_data)
        # 先判断权限
        if response != None:
            respon_json = json.dumps(response)
            self.write(respon_json)
            return
        # 获取所有操作记录
        operate = Dal_Operate().getAllID()
        if len(operate)!=0:
            response = self.GetResultAdmin(post_data,operate)
        else:
            response = {
                'errorcode':config_error['noRecord'] ,
            }
        respon_json = json.dumps(response)
        self.write(respon_json)
        # print ("123")