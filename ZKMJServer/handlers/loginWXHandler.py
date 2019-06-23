#coding:utf-8

import json
import tornado.web
import time
import os

from configs.config_default import configs_default
from dal.dal_delegate import Dal_Delegate
from dal.dal_mail import Dal_Mail
from model.delegate import Delegate
from model.mail import Mail
from model.user import User
from dal.dal_user import Dal_User
from configs.config_error import config_error
from tools.utils import Utils
from handlers.BaseHandler import BaseHandler
from protobuf import msg_pb2

class LoginWXHandler(BaseHandler):
    def post(self):
        msgReq = msg_pb2.Msg()
        msgReq.ParseFromString(self.request.body)

        msgResp = msg_pb2.Msg()
        msgResp.type = msg_pb2.EnumMsg.Value('loginresponse')

        request = msgReq.request.loginWXRequest
        response = msgResp.response.loginResponse
        icode =  request.iCode
        user = Dal_User().getLoginUser(request.sOpenID,"")
        if user == None:
             response.nErrorCode = config_error['success']
             user = User(id=None, name=request.sOpenID, password="",
                                  nick=request.sNick, exp=0, gold=0,
                                  money=0, headimg=request.sHeadImage, phone='',
                                  records='', assets='', room='',
                                  rookie = 0,invitetime=None,
                                  luckytime=None,welfaretime=None,
                                  gender=request.nGender,rankaward="0;0;0;0",
                                  logintime=Utils().dbTimeCreate(),
                                  gamestate = configs_default['gameState']['normal'],
                                  totalmoney=0,totalrmb=0,sharetime=None,
                                  wincount =0,totalcount=0,mails='',actawards='')

             Dal_User().addUser(user)
             icode = self.registDelegate(user,icode)

        rooikeAwardType = self.handleICode(user,icode)

        if user.gamestate == configs_default['gameState']['forbid']:
                response.nErrorCode = config_error['userforbid']
        elif Dal_User().getLoginer(user.id) and user.room == "":
                response.nErrorCode = config_error['userlogined']
        else:
                sToken = Utils().createToken() #生成token
                user.sToken = sToken
                #//设置位置信息
                user.location = request.location
                #//更新头像
                if request.sHeadImage != "" and request.sHeadImage != user.headimg:
                    user.headimg = request.sHeadImage
                    kwargs = {"headimg": request.sHeadImage}
                    Dal_User().uqdateUser(user.id, **kwargs)
                #更新昵称
                if request.sNick != "" and request.sNick != user.nick:
                    user.sNick = request.sNick
                    kwargs = {"nick": request.sNick}
                    Dal_User().uqdateUser(user.id, **kwargs)

                response.nErrorCode = config_error['success']
                response.rookieAward = rooikeAwardType
                response.requester.nUserID = user.id
                response.requester.sToken = sToken
                if user.name:
                    response.requester.sName = user.name
                if user.nick:
                    response.requester.sNick = user.nick
                if user.exp:
                    response.requester.nExp = user.exp
                if user.gold!= None:
                    response.requester.nGold = user.gold
                if user.money!= None:
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
                    response.requester.bLuckyToday = (Utils().dbTime2Number(user.luckytime) >= Utils().LastDayEndTime())
                else:
                    response.requester.bLuckyToday = False
                if user.welfaretime:
                    response.requester.bWelfareToday = (Utils().dbTime2Number(user.welfaretime) >= Utils().LastDayEndTime())
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
                #response.requester.sIP = self.request.remote_ip


                delegater = Dal_Delegate().getDelegate(user.id)
                response.requester.sICode = delegater.icode

                # 登录记录
                Dal_User().addLoginer(user.id)
                #//更新登录时间
                Dal_User().updateLoginTime(user.id)

        data = msgResp.SerializeToString()
        self.write(data)

    def registDelegate(self,user,icode):#注册新用户同时注册代理,同时处理邀请者
        parent = Dal_Delegate().getDelegateByICode(icode)
        if parent :
            #这里只是普通用户，建立代理关系的时候，有另外的协议，后台管理处理
            #给推荐者发新人奖励,每周领一次现金
            parent.newaward =  parent.newaward + 1
            kwargs = {"newaward":parent.newaward }
            Dal_Delegate().updateDelegate(parent.id, **kwargs)
            icode = 'share'


        delegater = Delegate(id=user.id, logintime=Utils().dbTimeCreate(),
                             awards=0, shareaward=0, newaward=0,
                             levelaward=0, actaward=0, level=0,
                             parent = 0,parentslevel =0,slevel=0,
                             icode = Utils().encodeRandomCode(user.id),
                             children = '')
        Dal_Delegate().addDelegate(delegater)
        return icode

    def handleICode(self, user, icode):  # 处理邀请码，奖励
        #自己进入的
        mailType = configs_default['mail']['type']['rookieaward']
        rookieAwardType = configs_default['actAwardType']['invalid']
        icodeGGL = icode
        if configs_default['actAwardType'].has_key(icode) and icode != 'share':
            icodeGGL = 'ggl'
            mailType = configs_default['mail']['type']['gglaward']

        if  Dal_User().ownActAwardFlag(user.id,icodeGGL):
            rookieAwardType = configs_default['actAwardType']['post']
        elif  configs_default['actAwardType'].has_key(icode):
            rookieAwardType = configs_default['actAwardType'][icode]
            rookieAward = configs_default['actAward'][icode]

            # 给新人发新手奖励
            if rookieAward > 0:
                user.money = user.money + rookieAward
                kwargs = {"money": user.money}
                Dal_User().uqdateUser(user.id, **kwargs)
                Dal_User().addActAwardFlag(user.id,icodeGGL)

                # 邮件记录
                mail = Mail()
                mail.uid = user.id
                mail.type = mailType
                mail.content = str(rookieAward)
                mail.time = Utils().dbTimeCreate()
                Dal_Mail().addMail(mail)
                Dal_User().addMails(user.id, mail.id)

        return rookieAwardType


