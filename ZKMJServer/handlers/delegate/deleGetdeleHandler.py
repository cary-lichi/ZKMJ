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
from dal.dal_recharge import Dal_Recharge
from model.recharge import Recharge
from handlers.BaseHandler import BaseHandler
from configs.config_error import config_error

class DeleGetdeleHandler(BaseHandler):
    def post(self):
        id = self.getData("id")
        response = {}
        dele = Dal_Delegate().getDelegate(id)

        if dele ==None:
            response={
                'errorcode':config_error['userinvaild']
            }
            respon_json = json.dumps(response)
            self.write(respon_json)
            return
        user = Dal_User().getUser(id)
        if user !=None:
            deleInfo=[{
                'id':dele.id,
                'nick':user.nick,
                'money':user.money,
            }]
            response={
                'errorcode':config_error['success'],
                'deleInfo':deleInfo,
            }
        else:
            response={
                'errorcode': config_error['userinvaild']
            }
        respon_json = json.dumps(response)
        self.write(respon_json)
