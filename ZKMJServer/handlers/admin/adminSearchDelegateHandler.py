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
from dal.dal_delegate import Dal_Delegate
from tools.utils import Utils
from handlers.BaseHandler import BaseHandler
from configs.config_error import config_error
from configs.config_default import configs_default

class AdminSearchDelegateHandler(AmminBaseHandler):
    def post(self):
        # Aid = self.getData("Aid")
        # token = self.getData("token")
        dgid = self.getData("dgid")
        account = self.getData("account")
        nick = self.getData("nick")
        did = self.getData("did")
        state = int(self.getData("state"))
        post_data = {}
        for key in self.request.arguments:
            post_data[key] = self.get_arguments(key)[0]
        response =None
        response = self.IsSuperadmin(post_data)
        if response ==None:
            listState = None
            if state ==configs_default['deleLevel']['firstLevel']:
                listState = Dal_Delegate().getfirstDeleCache()
            elif state ==configs_default['deleLevel']['secondLevel']:
                listState = Dal_Delegate().getsecondDeleCache()
            elif state ==configs_default['deleLevel']['threeLevel']:
                listState = Dal_Delegate().getthreeDeleCache()
            elif state =="":
                listState = Dal_Delegate().getallDeleCache()
            listAccount = Dal_User().getFuzzyQuery("account", account)
            listNick = Dal_User().getFuzzyNickQuery("nick", nick)
            listDgid = Dal_User().getFuzzyQuery("name", dgid)
            listDid = Dal_User().getFuzzyQuery("id", did)

            restA = Utils().GetIntersection(listAccount,listNick)
            restB = Utils().GetIntersection(listDid,listDgid)
            restC = Utils().GetIntersection(restB,restA)
            restD = Utils().GetIntersection(restC,listState)
            if len(restD)!=0:
                response = self.GetDeleResultData(post_data,restD)
            else:
                response = {
                    'errorcode': config_error['userinvaild'],
                }
        respon_json = json.dumps(response)
        self.write(respon_json)