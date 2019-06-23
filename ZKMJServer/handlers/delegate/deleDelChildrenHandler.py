#coding:utf-8
# by lichiYang
# 2018-04-24
#这是删除当前代理的下级代理接口
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

class DeleDelChildrenHandler(BaseHandler):
    def post(self):
        id = self.getData("rid")#要删除的代理id
        did = self.getData("id")#当前登录的代理id
        dele = Dal_Delegate().getDelegate(did)
        user = Dal_User().getUser(did)
        if user ==None:
            response = {
                'errorcode': config_error['userinvaild'],
            }
            respon_json = json.dumps(response)
            self.write(respon_json)
            return
        childrenlist = Utils().decodeIDFormat(dele.children)
        if id in childrenlist:
            # 删除元素
            childrenlist.remove(id)
            #更新数据库数据
            childrenlists = Utils().encodeIDFormat(childrenlist)
            updateDate = {'children':childrenlists}
            Dal_Delegate().updateDelegate(did, **updateDate)
            response = {
                'errorcode': config_error['success'],
            }
        else:
            response = {
                'errorcode': config_error['userinvaild'],
            }
        respon_json = json.dumps(response)
        self.write(respon_json)
