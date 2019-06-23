#coding=utf-8
import json
from configs.config_error import config_error
from dal.dal_admin import Dal_Admin
from handlers.admin.adminBaseHandler import AmminBaseHandler

class AdminOutLoginHandlder(AmminBaseHandler):
    def post(self):
        post_data = {}
        for key in self.request.arguments:
            post_data[key] = self.get_arguments(key)[0]
        Aid = self.getData("Aid")
        token = self.getData("token")
        response = self.IsSubadmin(post_data)
        if response==None:
            Dal_Admin().loginOut(Aid)
            response = {
                'errorcode': config_error['success'],
            }
        respon_json = json.dumps(response)
        self.write(respon_json)