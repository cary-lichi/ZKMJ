#coding=utf-8
import json
import tornado.web
import time
import os
import math
import datetime
import hashlib
from configs.config_default import configs_default
from model.admin import Admin
from dal.dal_admin import Dal_Admin
from tools.utils import Utils
from handlers.BaseHandler import BaseHandler
from configs.config_error import config_error

class AdminLoginHandler(BaseHandler):
    def post(self):
        post_data = {}
        for key in self.request.arguments:
            post_data[key] = self.get_arguments(key)[0]

        response=None
        userName = post_data['userName']
        passWord= hashlib.md5(post_data['passWord']).hexdigest()
        admin_id_list = Dal_Admin().getAll()
        if len(admin_id_list) <= 0:
            #用户不存在
            response = {
                'errorcode': config_error['idlistisnull']
            }
        else:
            for k in admin_id_list:
                k = int(k)
                # adminUser = Dal_admin().getAdminuser(k)
                if admin_id_list[k]["userName"]==userName:
                    if (passWord == admin_id_list[k]['passWord']):
                        adminId = admin_id_list[k]["id"]
                        nickName = admin_id_list[k]["nickname"]
                        token = Utils().createToken()
                        Dal_Admin().login(adminId,token)
                        response = {
                            'errorcode': config_error['success'],
                            'Aid': adminId,
                            'token':token,
                            'nickName':nickName,
                        }
                    else:
                        response = {
                            'errorcode': config_error['pwderror'],
                        }
        respon_json = json.dumps(response)
        self.write(respon_json)





