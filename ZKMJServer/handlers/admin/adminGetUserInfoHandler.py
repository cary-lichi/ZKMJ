from adminBaseHandler import AmminBaseHandler
from dal.dal_user import Dal_User
from dal.dal_delegate import Dal_Delegate
from tools.utils import Utils
from dal.dal_recharge import Dal_Recharge
class AdminGetUserInfoHandler(AdminBaseHandler):
    def post(self):
        uid = self.getData('uid')
        response = dict()
        userInfo = {}
        rchargeRecord ={}
        user = Dal_User().getUser(uid)
        delegate = Dal_Delegate().getDelegate(uid)
        rchargeR = Dal_Recharge().getRecharge(uid)
        if user !=None:
            rchargeRecord = {
                'time': rchargeR.time,
                'money':rchargeR.money,
            }

            userInfo = {
                'nick':user.nick,
                'id':user.name,
                'account':user.account,
                'lever':delegate.lever,
                'gender':user.gender,
                'logintime':Utils().dateTime3String(user.logintime),
                'money':user.money,
                'resMasonry':user.money,
                'rchargeRecord':rchargeRecord
            }