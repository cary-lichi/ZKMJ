#coding:utf-8

import json
import tornado.web
import time
import os
import math
import datetime
import hashlib
from configs.config_default import configs_default
from model.user import User
import application
from model.delegate import Delegate
from dal.dal_user import Dal_User
from dal.dal_delegate import Dal_Delegate
from tools.utils import Utils
from handlers.BaseHandler import BaseHandler
from configs.config_error import config_error

class DeleChangePasswordHandler(BaseHandler):
    def post(self):
        response={}
        did = int(self.getData("uid"))
        passWord = hashlib.md5(self.getData("passWord")).hexdigest()
        # 查询有无此用户
        userId = Dal_User().getValueByAttr("id", did)
        if len(userId) !=0:
            update_passWord = {'dpassword':passWord}
            Dal_User().uqdateUser(did,**update_passWord)
            response ={
                'errorcode':config_error['success']
            }
        else:
            response = {
                'errorcode': config_error['userinvaild']
            }
        respon_json = json.dumps(response)
        self.write(respon_json)



