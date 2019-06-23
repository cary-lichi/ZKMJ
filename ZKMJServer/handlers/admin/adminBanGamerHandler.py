#coding:utf-8

import json
import tornado.web
import time
import os
import math
import datetime

from configs.config_default import configs_default
from handlers.admin.adminBaseHandler import AmminBaseHandler
from model.user import User
from dal.dal_user import Dal_User
from dal.dal_admin import Dal_Admin
from tools.utils import Utils
from handlers.BaseHandler import BaseHandler
from configs.config_error import config_error

class AdminBanGamerHandler(AmminBaseHandler):

    def post(self):
        aid = self.getData("Aid")
        post_data = {}
        for key in self.request.arguments:
            post_data[key] = self.get_arguments(key)[0]

        response = None
        result_data = {}
        response = self.IsSuperadmin(post_data)
        if response != None:
            respon_json = json.dumps(response)
            self.write(respon_json)
            return
        gid = int(post_data['gid'])
        bForbid = int(post_data['forbid'])
        user = Dal_User().get(gid,User)

        if user == None:
            response = {
                'errorcode': config_error['userinvaid'],
            }
        else:
            response = {
                'errorcode': config_error['success'],
            }
            #判断该玩家是否已被封禁
            if bForbid:
                user.gamestate = configs_default['gameState']['forbid']

            else:
                user.gamestate = configs_default['gameState']['normal']

           #更新玩家信息
            update_data = {"gamestate": user.gamestate}
            Dal_User().uqdateUser(gid,**update_data)
        #     更新操作
        operate = configs_default['adminOperate']['banGamer']
        Dal_Admin().addOperate(aid,operate)

        respon_json = json.dumps(response)
        self.write(respon_json)
