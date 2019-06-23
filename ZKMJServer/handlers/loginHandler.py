#coding:utf-8

import json
import tornado.web
import time
import os

from dal.dal_delegate import Dal_Delegate
from model.user import User
from dal.dal_user import Dal_User
from configs.config_error import config_error
from configs.config_default import configs_default
from tools.utils import Utils
from handlers.BaseHandler import BaseHandler
from protobuf import msg_pb2

class LoginHandler(BaseHandler):
    def post(self):
        msgReq = msg_pb2.Msg()
        msgReq.ParseFromString(self.request.body)

        msgResp = msg_pb2.Msg()
        msgResp.type = msg_pb2.EnumMsg.Value('loginresponse')

        request = msgReq.request.loginRquest
        response = msgResp.response.loginResponse
        user = Dal_User().getLoginUser(request.sName,request.sPassWord)
        if user == None:
              response.nErrorCode = config_error['userinvaild']
        else:
                if user.gamestate == configs_default['gameState']['forbid']:
                    response.nErrorCode = config_error['userforbid']
                elif Dal_User().getLoginer(user.id) and user.room == "":
                    response.nErrorCode = config_error['userlogined']
                else:
                    sToken = Utils().createToken()  # 生成token
                    user.sToken = sToken
                    # //设置位置信息
                    user.location = request.location
                    response.nErrorCode = config_error['success']
                    response.requester.nUserID = user.id
                    response.requester.sToken = sToken
                    if user.name:
                        response.requester.sName = user.name
                    if user.nick:
                        response.requester.sNick = user.nick
                    if user.exp:
                        response.requester.nExp = user.exp
                    if user.gold != None:
                        response.requester.nGold = user.gold
                    if user.money != None:
                        response.requester.nMoney = user.money
                    if user.headimg:
                        response.requester.sHeadimg = user.headimg
                    if user.phone:
                        response.requester.sPhone = user.phone
                    if user.records:
                        response.requester.sRecords = user.records
                    if user.assets:
                        response.requester.sAssets = user.assets
                    if user.room:
                        response.requester.sRoom = user.room
                    if user.gender != None:
                        response.requester.nGender = user.gender
                    if user.luckytime:
                        response.requester.bLuckyToday = (
                        Utils().dbTime2Number(user.luckytime) >= Utils().LastDayEndTime())
                    else:
                        response.requester.bLuckyToday = False
                    if user.welfaretime:
                        response.requester.bWelfareToday = (
                        Utils().dbTime2Number(user.welfaretime) >= Utils().LastDayEndTime())
                    else:
                        response.requester.bWelfareToday = False

                    if user.sharetime:
                        response.requester.bShareAwardWeek = (
                            Utils().dbTime2Number(user.sharetime) >= Utils().LastWeekEndTime())
                    else:
                        response.requester.bShareAwardWeek = False

                    if user.rankaward:
                        rkAwardFlags = user.rankaward.split(';')
                        for flag in rkAwardFlags:
                            response.requester.bRkAwardFlags.append((flag == '1'))

                    # response.requester.nWinCount = user.wincount
                    # response.requester.nTotalCount =  user.totalcount
                    # response.requester.sIP = self.request.remote_ip


                    delegater = Dal_Delegate().getDelegate(user.id)
                    response.requester.sICode = delegater.icode

                    # 登录记录
                    Dal_User().addLoginer(user.id)
                    # //更新登录时间
                    Dal_User().updateLoginTime(user.id)

        data = msgResp.SerializeToString()
        self.write(data)


