#coding:utf-8

import json

import math
import tornado.web
import time
import os

from configs.config_default import configs_default
from configs.config_error import config_error
from dal.dal_cztime import Dal_CZTime
from dal.dal_delegate import Dal_Delegate
from dal.dal_mail import Dal_Mail
from dal.dal_recharge import Dal_Recharge
from dal.dal_user import Dal_User
from handlers.BaseHandler import BaseHandler
from model.cztime import CZTime
from model.mail import Mail
from model.recharge import Recharge
from xml.etree import ElementTree

import xml.dom.minidom as minidom

from tools.utils import Utils


class PayResultWXHandler(BaseHandler):
    def post(self):
        root = ElementTree.fromstring(self.request.body)
        node_result_code = root.find('result_code')
        node_return_code = root.find('return_code')
        attach = root.find('attach')
        totle_fee = root.find('total_fee')
        time_end = root.find('time_end')

        userData = str(attach.text)
        arrData = userData.split(';')
        UID = arrData[0]
        GID = arrData[1]
        Count = arrData[2]
        Money = arrData[3]

        if node_result_code.text == 'SUCCESS' and node_return_code.text == 'SUCCESS':
            #给支付返回结果
           # returnMsg = "<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[OK]]></return_msg></xml>"#self.createReturnXML()

            self.write("SUCCESS")

            #避免重复通知
            if Dal_CZTime().getCZTime(time_end.text) != None:return

            # 记录支付通知结果时间 避免重复通知
            czT = CZTime(time=time_end.text)
            Dal_CZTime().addCZTime(czT)

            #处理回调结果
            user = Dal_User().getUser(UID)
            goodConfig = configs_default['goods'][GID]
            if goodConfig['type'] == configs_default['goodType']['money']:
                user.money = user.money + goodConfig['extra']
                user.totalmoney = user.totalmoney + goodConfig['extra']
                user.totalrmb = user.totalrmb + goodConfig['rmb']

                # 检测代理充值奖励
                delegater = Dal_Delegate().getDelegate(user.id)
                dLv = str(delegater.slevel)#原始等级
                parentDelegater = Dal_Delegate().getDelegate(delegater.parent)
                if parentDelegater:  # 对上级代理做奖励
                    parentUser = Dal_User().getUser(parentDelegater.id)
                    awardPercent = configs_default['delegate']['payAwards'][dLv]
                    awardPay = math.ceil(goodConfig['extra']*awardPercent)
                    parentUser.money = parentUser.money + awardPay
                    parentDelegater.awards = parentDelegater.awards + awardPay

                    #给上级代理奖励的钻石
                    kwargs = {"money": parentUser.money}
                    Dal_User().uqdateUser(parentUser.id, **kwargs)

                    #上级代理获得的奖励总数
                    kwargs = {"awards": parentDelegater.awards}
                    Dal_Delegate().uqdateDelegate(parentDelegater.id, **kwargs)

                    # 邮件记录
                    mail = Mail()
                    mail.uid = parentDelegater.id
                    mail.type = configs_default['mail']['type']['deleparentaward']
                    mail.content = str(awardPay)
                    mail.time = Utils().dbTimeCreate()
                    Dal_Mail().addMail(mail)
                    Dal_User().addMails(mail.uid, mail.id)

            elif goodConfig['type'] == configs_default['goodType']['gold']:
                user.gold = user.gold + goodConfig['extra']

            kwargs = {"gold": user.gold, "money": user.money, "totalmoney": user.totalmoney, "totalrmb": user.totalrmb}
            Dal_User().uqdateUser(user.id, **kwargs)

            # 充值
            re = Recharge(id=None, time=Utils().dbTimeCreate(), money=Money,
                      uid=UID, good=GID, count=Count,fromc=0)
            Dal_Recharge().addRecharge(re)



    def createReturnXML(self):
        root = ElementTree.Element('xml')
        subCode = ElementTree.SubElement(root,'return_code')

        subCode.text = 'SUCCESS'
        subMsg = ElementTree.SubElement(root,'return_msg')
        subMsg.text = 'OK'
        result = ElementTree.tostring(root)
        return result

