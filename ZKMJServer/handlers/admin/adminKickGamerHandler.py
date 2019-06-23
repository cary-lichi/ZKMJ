#coding:utf-8

import json
import tornado.web
import time
import os
import math
import datetime

from configs.config_default import configs_default
from handlers.admin.adminBaseHandler import AmminBaseHandler
from handlers.gameHandler import GameHandler
from model.user import User
from dal.dal_user import Dal_User
from tools.utils import Utils
from handlers.BaseHandler import BaseHandler
from configs.config_error import config_error

class AdminKickGamerHandler(AmminBaseHandler):

    def post(self):
        Aid = self.getData("Aid")
        post_data = {}
        for key in self.request.arguments:
            post_data[key] = self.get_arguments(key)[0]
            response = None
        result_data = {}
        id = int(post_data['id'])
        user = Dal_User().get(id,User)
        response = self.IsSuperadmin(post_data)
        if response != None:
            respon_json = json.dumps(response)
            self.write(respon_json)
            return

        if user == None:
            response = {
                'errorcode': config_error['userinvaid']
            }
        elif  user.room == '':
            response = {
                'errorcode': config_error['notinroom']
            }
        else:
            response = {
                'errorcode': config_error['success'],
            }
            GameHandler.kick_player(user)
            #     更新操作
            operate = configs_default['adminOperate']['kickGamer']
            Dal_Admin().addOperate(Aid, operate)


        respon_json = json.dumps(response)
        self.write(respon_json)
