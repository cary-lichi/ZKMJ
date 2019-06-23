#coding=utf-8
import hashlib
import json

from configs.config_default import configs_default
from configs.config_error import config_error
from dal.dal_admin import Dal_Admin
from handlers.admin.adminBaseHandler import AmminBaseHandler
from model.admin import Admin


class AdminRegSubadminHandler(AmminBaseHandler):
    def post(self):
        Aid = self.getData("Aid")
        post_data = {}
        for key in self.request.arguments:
            post_data[key] = self.get_arguments(key)[0]
        response = None
        result_data = {}
        userName = self.getData('userName')
        passWord = self.getData('passWord')
        level = self.getData('level')
        nick = self.getData('nick')
        type = self.getData('type')

        response = self.IsSuperadmin(post_data)
        if response != None:
            respon_json = json.dumps(response)
            self.write(respon_json)
            return
        if userName !="" and passWord !="":
            passWord = hashlib.md5(passWord).hexdigest()
            suAdmin = Dal_Admin().getValueByAttr('userName', userName)
            if len(suAdmin) == 0:
                add_data = Admin(id=None, userName=userName, passWord=passWord, nickname=nick, admin=level, token=None, type=type)
                newAdmin = Dal_Admin().addAdmin(add_data)
                response = {
                    'errorcode': config_error['success'],
                }
                #     更新操作
                operate = configs_default['adminOperate']['RegSubadmin']
                Dal_Admin().addOperate(Aid, operate)
            else:
                response = {
                    'errorcode': config_error['userrepeated'],
                }
        respon_json = json.dumps(response)
        self.write(respon_json)

