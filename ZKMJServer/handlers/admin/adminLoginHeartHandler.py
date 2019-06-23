#coding=utf-8
import json

from configs.config_error import config_error
from dal.dal_admin import Dal_Admin
from handlers.admin.adminBaseHandler import AmminBaseHandler


class AdminLoginHeartHandler(AmminBaseHandler):
    def post(self):
        token = self.getData("token")
        Aid = self.getData("Aid")
        response = None
        admin= Dal_Admin().getAdminuser(Aid)
        if admin['token'] == token:
            Dal_Admin().onHeartBeat(Aid)
            response = {
                 'errorcode': config_error['success'],
            }
        else:
            response = {
                'errorcode': config_error['loginExpires'],
            }

        respon_json = json.dumps(response)
        self.write(respon_json)
