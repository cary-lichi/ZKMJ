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
from handlers.BaseHandler import BaseHandler
from configs.config_error import config_error

class DeleLoginHandler(BaseHandler):
    def post(self):
        # post_data = json.loads(self.request.agruments)
        post_data = {}
        for key in self.request.arguments:
            post_data[key] = self.get_arguments(key)[0]

        print (post_data)
        result_data = {}
        uid = post_data['uid'].decode("utf-8") #此处从微信登录时返回过来的uid对应user表中的字段，还是delegate表中的字段？？
        user = Dal_User().getLoginUser(uid,"")
        if user == None:#成为代理必须先进游戏成为用户
            result_data['errorcode'] = config_error['delegateinvaid']
        else:
            delegater = Dal_Delegate().getDelegate(user.id)
            if delegater == None:  # 成为代理必须先进游戏成为用户
                result_data['errorcode'] = config_error['delegateinvaid']
            else:
                respon = {}
                delegater = Dal_Delegate().getDelegate(user.id)
                respon['dgid'] = user.id
                respon['nick'] = user.nick
                respon['gender'] = user.gender
                respon['online'] = True
                respon['logintime'] = Utils().dateTime2String(user.logintime)
                respon['money'] = user.money
                respon['totalmoney'] = 0
                respon['awards'] = delegater.awards
                respon['shareawards'] = delegater.shareaward
                respon['newawards'] = delegater.newaward
                respon['levelawards'] = delegater.levelaward
                respon['actawards'] = delegater.actaward
                respon['dlevel'] = delegater.level
                respon['equipid'] = 0
                respon['gid'] = user.id
                respon['headimg'] = user.headimg
                respon['children'] = delegater.children
                respon['icode'] = delegater.icode
                result_data = {
                    'errorcode': config_error['success'],
                    'delegateInfo': respon
                }

        respon_json = json.dumps(result_data)
        self.write(respon_json)




