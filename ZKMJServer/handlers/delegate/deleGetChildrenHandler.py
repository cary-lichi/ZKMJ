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
from dal.dal_recharge import Dal_Recharge
from model.recharge import Recharge
from handlers.BaseHandler import BaseHandler
from configs.config_error import config_error

class DeleGetChildrenHandler(BaseHandler):
    def post(self):
        post_data = {}
        for key in self.request.arguments:
            post_data[key] = self.get_arguments(key)[0]
        respon = {}
        uid = int(post_data['id']) #传过来的是userid此处从微信登录时返回过来的uid对应user表中的字段，还是delegate表中的字段？？
        deler = Dal_Delegate().getDelegate(uid)
        result_data = {}
        if deler == None:
            respon={
                errorcode:config_error['delegateinvaid']
            }

        else:

            childList = Utils().decodeIDFormat(deler.children)
            childLen = len(childList)
            for index,k in enumerate(childList):
                k = int(k)
                result_data[index] = {}
                # 根据代理id得到每一个代理
                delegater = Dal_Delegate().getDelegate(k)
                # 获取下级代理的充值记录
                recharge = Dal_Recharge().getallRecharge(long(k))
                # recharge = Dal_Recharge().getValueByAttr('uid',k)
                if delegater == None:
                    continue
                user = Dal_User().getUser(k)
                # result_data[index]['allrecharge'] = recharge
                result_data[index]['did'] = k
                result_data[index]['dgid'] = user.name
                result_data[index]['headimg']=user.headimg
                result_data[index]['nick'] = user.nick
                result_data[index]['gender'] = user.gender
                result_data[index]['logintime'] = Utils().dateTime2String(delegater.logintime)
                result_data[index]['online'] = (Dal_User().getLoginer(k) != None)
                result_data[index]['money'] = user.money
                result_data[index]['totalmoney'] = user.totalmoney
                result_data[index]['rmb'] = user.totalrmb
                result_data[index]['awards'] = delegater.awards
                result_data[index]['shareawards'] = delegater.shareaward
                result_data[index]['newawards'] = delegater.newaward
                result_data[index]['levelawards'] = delegater.levelaward
                result_data[index]['actawards'] = delegater.actaward
                result_data[index]['dlevel'] = delegater.level
                result_data[index]['equipid'] = 0
                result_data[index]['parent'] = delegater.parent
            respon = {
                'errorcode': config_error['success'],
                'deleInfo':result_data,
                'childLen':childLen
            }
        respon_json = json.dumps(respon)
        self.write(respon_json)




