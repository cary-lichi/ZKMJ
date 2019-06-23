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

class DeleWxLoginHandler(BaseHandler):
    def post(self):
        post_data = {}
        for key in self.request.arguments:
            post_data[key] = self.get_arguments(key)[0]
        response ={}
        deleInfo ={}
        deleName = self.getData("deleName")
        # passWord = self.getData("passWord")
        passWord = hashlib.md5(self.getData("passWord")).hexdigest()
        # 先去判断此是否存在
        userId = Dal_User().getValueByAttr("account",deleName)
        if len(userId)!=0:
        #     判断是否有权限进入代理后台
            user = Dal_User().getUser(userId[0])
            delegater = Dal_Delegate().getDelegate(userId[0])
            if configs_default["deleLevel"]["gamer"]<delegater.level<=configs_default["deleLevel"]["threeLevel"]:
                # 验证登录账号和密码
                DeleLogin =Dal_User().getLoginDeleAgent(deleName,passWord)
                # if user.account ==deleName and user.password == passWord:
                if DeleLogin !=None:
                    # 更新代理登录时间
                    Dal_Delegate().updateLoginTime(user.id)
                    # 将他加入到在线代理中
                    Dal_Delegate().addLoginer(user.id)
                    deleInfo={
                        'did':user.id,
                        'nick':user.nick,
                        'gender':user.gender,
                        'account':user.account,
                        'online': True,
                        'logintime': Utils().dateTime3String(delegater.logintime),
                        'money':user.money,
                        'headimg': user.headimg,
                        'icode': delegater.icode,
                    #         'totalmoney': 0
                    #         'awards' :delegater.awards
                    #         'shareawards':delegater.shareaward
                    #         'newawards': delegater.newaward
                    #         'levelawards': delegater.levelaward
                    #         'actawards': delegater.actaward
                        'level': delegater.level
                    #         'equipid': 0
                    #         'gid': user.id
                    #         'children': delegater.children
                    }
                    response={
                        'errorcode': config_error['success'],
                        'deleInfo':deleInfo,
                    }
                else:
                    response = {
                        'errorcode': config_error['pwderror'],
                    }
            else:
                response = {
                    'errorcode': config_error['adminRights'],
                }
        else:
            response = {
                'errorcode': config_error['delegateinvaid'],
            }
        respon_json = json.dumps(response)
        self.write(respon_json)




