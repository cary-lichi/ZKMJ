#coding:utf-8
from __future__ import division
import json
import tornado.web
import time
import os
import math
import datetime
import hashlib

from configs.config_default import configs_default
from handlers.admin.adminBaseHandler import AmminBaseHandler
from model.user import User
from dal.dal_user import Dal_User
from tools.utils import Utils
from dal.dal_admin import Dal_Admin
from dal.dal_delegate import Dal_Delegate
from handlers.BaseHandler import BaseHandler
from configs.config_error import config_error

class AdminGetUserHandler(AmminBaseHandler):
    def post(self):
        post_data = {}
        for key in self.request.arguments:
            post_data[key] = self.get_arguments(key)[0]
        state = int(post_data["state"])
        user_list_id = dict()
        respon = None
        respon = self.IsSubadmin(post_data)
        if respon == None:
            if state == configs_default['userState']['online']:  # 查询在线
                user_list_id = Dal_User().getLoginCache()
                respon = self.GetResultData(post_data, user_list_id)
            elif state == configs_default['userState']['outline']:  # 查询离线
                user_list_id = Dal_User().getOutLineCache()
                respon = self.GetResultData(post_data, user_list_id)
            elif state == configs_default['userState']['all']:  # 查询所有
                user_list_id = Dal_Delegate().getonlyPalyerCache()
                respon = self.GetResultData(post_data, user_list_id)
        respon_json = json.dumps(respon)
        self.write(respon_json)















