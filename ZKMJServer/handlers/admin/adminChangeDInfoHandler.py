#coding:utf-8

import json
import tornado.web
import time
import os
import math
import datetime
import hashlib

from configs.config_default import configs_default
from dal.dal_delegate import Dal_Delegate
from handlers.admin.adminBaseHandler import AmminBaseHandler
from model.user import User
from dal.dal_user import Dal_User
from tools.utils import Utils
from handlers.BaseHandler import BaseHandler
from configs.config_error import config_error
#改变代理信息
class AdminChangeDInfoHandler(AmminBaseHandler):

    def post(self):
        post_data = {}
        for key in self.request.arguments:
            post_data[key] = self.get_arguments(key)[0]

        did = int(post_data['did'])
        oldlv = int(post_data['oldlv'])
        newlv = int(post_data['newlv'])
        Aid = self.getData("Aid")
        # 如果parent不等于-1，说明是首次代理关系确定，需要设置delegate的slevel属性
        parent = int(post_data['parent'])
        response = {}
        delegater = Dal_Delegate().getDelegate(did)
        response = self.IsSuperadmin(post_data)
        if response != None:
            respon_json = json.dumps(response)
            self.write(respon_json)
            return

        if delegater == None:
            response = {
                'errorcode': config_error['delegateinvaid']
            }
        else:
            # response = {
            #     'errorcode': config_error['success']
            # }

            #检查合法性
            if newlv<1 or newlv>3:
                response[ 'errorcode'] = config_error['dlevelerror']
                respon_json = json.dumps(response)
                self.write(respon_json)
                return
            else:
                delegater.level = newlv
                user = Dal_User().getUser(did)
                #检查是否第一次建立代理关系
                if parent != -1:
                    dParent = Dal_Delegate().getDelegate(parent)
                    #如果有上级代理，则上级代理等级要高于当前代理 数值越低代理等级越高
                    if dParent.level <= delegater.level:
                        # 新增进代理缓存中
                        if delegater.level == configs_default['firstLevel']:
                            Dal_Delegate().addfirstDele(delegater.id)
                        elif delegater.level == configs_default['secondLevel']:
                            Dal_Delegate().addsecondDele(delegater.id)
                        elif delegater.level == configs_default['threeLevel']:
                            Dal_Delegate().addthreeDele(delegater.id)

                        childrens = Utils().decodeIDFormat(dParent.children)
                        childrens.append(delegater.id)
                        dParent.children = Utils().encodeIDFormat(childrens)
                        # 更新上级代理信息
                        update_data = {'children': dParent.children}
                        Dal_Delegate().updateDelegate(dParent.id, **update_data)

                        delegater.parent = parent
                        delegater.parentslevel = dParent.level
                        delegater.slevel = delegater.level

                        # 更新代理信息
                        update_data = {'level': delegater.level, 'parent': delegater.parent,
                                       'parentslevel': delegater.parentslevel,
                                       'slevel': delegater.slevel}
                        Dal_Delegate().updateDelegate(did, **update_data)
                        response  ={
                            'errorcode': config_error['success'],
                            'level':delegater.level,
                            'account':user.account
                        }
                        #     更新操作
                        operate = configs_default['adminOperate']['upgradedele']
                        Dal_Admin().addOperate(Aid, operate)

                    else:
                        response['errorcode'] = config_error['dlevelerror']
                        respon_json = json.dumps(response)
                        self.write(respon_json)
                        return
                else:
                    # 新增进代理缓存中
                    # configs_default['firstLevel']
                    if oldlv >= delegater.level or oldlv ==configs_default['deleLevel']['gamer']:
                        Dal_Delegate().addallDeleCache(delegater.id)
                        if delegater.level == configs_default['deleLevel']['firstLevel']:
                            Dal_Delegate().addfirstDele(delegater.id)
                        elif delegater.level == configs_default['deleLevel']['secondLevel']:
                            Dal_Delegate().addsecondDele(delegater.id)
                        elif delegater.level == configs_default['deleLevel']['threeLevel']:
                            Dal_Delegate().addthreeDele(delegater.id)

                        # 更新代理信息
                        update_data = {'level': delegater.level,
                                       'parentslevel': delegater.parentslevel,
                                       'slevel': delegater.slevel}
                        Dal_Delegate().updateDelegate(did, **update_data)
                        # 新增代理用户名和密码
                        deleUser = Utils().encodeRandomAccount(delegater.id)
                        passWord = hashlib.md5(configs_default['delePassword']['default']).hexdigest()
                        updateDel_data ={
                            'account':deleUser,
                            'password':passWord
                        }
                        Dal_User().uqdateUser(did, **updateDel_data)

                        response = {
                            'errorcode': config_error['success'],
                            'level': delegater.level,
                            'account': user.account
                        }
                        #     更新操作
                        operate = configs_default['adminOperate']['upgradedele']
                        Dal_Admin().addOperate(Aid, operate)
                    else:
                        response = {
                            'errorcode': config_error['dlevelerror'],
                        }

        respon_json = json.dumps(response)
        self.write(respon_json)
