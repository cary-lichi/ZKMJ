#coding:utf-8
from __future__ import division
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

class AdminSearchUserHandler(AmminBaseHandler):
    def post(self):
        # Aid = self.getData("Aid")
        # token = self.getData("token")
        ggid = self.getData("ggid")
        nick = self.getData("nick")
        gid = long(self.getData("gid"))
        post_data = {}
        for key in self.request.arguments:
            post_data[key] = self.get_arguments(key)[0]
        response =None
        response = self.IsSuperadmin(post_data)
        if response ==None:
            list_name = Dal_User().getFuzzyQuery("name", ggid)
            list_nick= Dal_User().getFuzzyNickQuery("nick", nick)
            gid =Dal_User().getFuzzyQuery("id", gid)
            restA = Utils().GetIntersection(list_name,list_nick)
            restA = Utils().GetIntersection(restA,gid)
            if len(restA)!=0:
                 response = self.GetResultData(post_data,restA)
            else:
                response = {
                    'errorcode': config_error['userinvaild'],
                }
        respon_json = json.dumps(response)
        self.write(respon_json)
















