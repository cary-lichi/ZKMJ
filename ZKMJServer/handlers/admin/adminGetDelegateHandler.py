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
from model.delegate import Delegate
from dal.dal_user import Dal_User
from dal.dal_delegate import Dal_Delegate
from tools.utils import Utils
from handlers.BaseHandler import BaseHandler
from configs.config_error import config_error

class AdminGetDelegateHandler(AmminBaseHandler):

    def post(self):
        #post_data = json.loads(self.request.body)
        response = None
        result_data = {}
        post_data = {}
        for key in self.request.arguments:
            post_data[key] = self.get_arguments(key)[0]
        page = int(post_data['page'])
        # 验证权限
        state = int(self.getData("state"))
        response = self.IsSuperadmin(post_data)
        if response != None:
            respon_json = json.dumps(response)
            self.write(respon_json)
            return

        #获得所有的代理id存入列表中
        dele_id_list = Dal_Delegate().getAllID()
        if len(dele_id_list) <= 0:
            response = {
                'errorcode': config_error['idlistisnull'],
                'pageCount': 0,
                'userInfo': ""
            }
        else:
            if state == configs_default['userState']['online']:  # 查询在线
                dele_list_id = Dal_Delegate().getLoginCache()
                response = self.GetDeleResultData(post_data, dele_list_id)
            elif state == configs_default['userState']['outline']:  # 查询离线
                dele_list_id = Dal_Delegate().getOutLineCache()
                response = self.GetDeleResultData(post_data, dele_list_id)
            elif state == configs_default['userState']['all']:  #查询所有
                dele_list_id = Dal_Delegate().getallDeleCache()
                response = self.GetDeleResultData(post_data, dele_list_id)
            elif state ==configs_default['userState']['firstDele']: #查询一级代理
                dele_list_id = Dal_Delegate().getfirstDeleCache()
                response = self.GetDeleResultData(post_data, dele_list_id)
            elif state ==configs_default['userState']['secondDele']: #查询二级代理
                dele_list_id = Dal_Delegate().getsecondDeleCache()
                response = self.GetDeleResultData(post_data,dele_list_id)
            elif state ==configs_default['userState']['threeDele']: #查询三级代理
                dele_list_id = Dal_Delegate().getthreeDeleCache()
                response = self.GetDeleResultData(post_data,dele_list_id)


        respon_json = json.dumps(response)
        self.write(respon_json)















