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

class DeleAddChildrenHandler(BaseHandler):
    def post(self):
        response={}
        id =int(self.getData("id"))
        nick = self.getData("nick")
        nid = self.getData("nid")
        user = Dal_User().getUser(nid)
        # 验证他填的用户名是否与id匹配
        if user.nick != nick:
            response = {
                'errorcode': config_error['userinvaild'],
            }
            respon_json = json.dumps(response)
            self.write(respon_json)
            return
        # 验证他的代理权限，只有一级和二级代理能自己添加子代理
        dele = Dal_Delegate().getDelegate(id)
        if configs_default["deleLevel"]["gamer"] < dele.level < configs_default["deleLevel"]["threeLevel"]:
            childrenlist = Utils().decodeIDFormat(dele.children)
            if nid in childrenlist:
                response = {
                    'errorcode': config_error['userrepeated'],
                }
                respon_json = json.dumps(response)
                self.write(respon_json)
                return
            if dele.children=='':
                updateDate = {'children':nid}
            else:
                updateDate = {'children':str(dele.children)+";"+nid}
            Dal_Delegate().updateDelegate(id,**updateDate)
            response = {
                'errorcode': config_error['success'],
            }
        respon_json = json.dumps(response)
        self.write(respon_json)

