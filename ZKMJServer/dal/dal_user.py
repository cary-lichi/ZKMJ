#-*-coding:utf-8-*-
'''
dal 层user继承了dal_base的所有的方法 增删改查 缓存
'''
from logic.mainTimerMamager import MainTimerManager
from model.user import User
from dal.dal_base import Dal_base
from configs.config_default import configs_default
from tools.utils import Utils


class Dal_User(Dal_base):
    def __init__(self):
        Dal_base.__init__(self)
        self.m_loginCache = []#登录缓存
        self.m_loginTimerMgr = MainTimerManager()
        self.m_outLineCache = []  #离线缓存


    ##增
    def addUser(self,newUser):
        return self.add(newUser)
        # newUser.id = newUser.save()
        # self._m_cache[newUser.id]=newUser
        # ## 返回一个新增user的id
        # return newUser.id

    ## 查
    def getUser(self,pk):
        return self.get(pk,User)

    ## 改
    def uqdateUser(self,pk,**kwargs):
        return self.update(pk,User,**kwargs)

    ## 删
    def deleteUser(self,pk):
        self.delete(pk,User)

    ## 缓存
    def initCache(self):
        self.initDB('user',User)
        for k,v in self._m_cache.iteritems():
            self.setRoom(k,'')
            id = v.id
            self.m_outLineCache.append(id)

    def getLoginCache(self):
        value_list = self.m_loginCache
        return value_list

    def getOutLineCache(self):
        value_list = self.m_outLineCache
        return value_list

    def getLoginUser(self,name,password):
        for k,v in self._m_cache.iteritems():
            if v.name == name:
                return v
        return None

    def getLoginDeleAgent(self, account, dpassword):
        for k, v in self._m_cache.iteritems():
            if v.account == account and v.dpassword == dpassword:
                return v
        return None

    def addLoginer(self,id):
         lg = self.getLoginer(id)
         if lg == False:
             self.m_loginCache.append(id)
             self.onHeartBeat(id)#启动心跳计时
         ol = self.getOutliner(id)
         if ol: self.m_outLineCache.remove(id)

    def getLoginer(self, id):
         return id in self.m_loginCache

    def getOutliner(self, id):
         return id in self.m_outLineCache

    def delLoginer(self, id):
         lg = self.getLoginer(id)
         if lg :
             user = self.m_loginCache.remove(id)
             if user:
                 self.getUser(user).sToken = ""
         ol = self.getOutliner(id)
         if ol == False:
             self.m_outLineCache.append(id)


    def onHeartBeat(self,id):#响应心跳协议
        if self.m_loginTimerMgr.getTimer(id):#删除原来定时
            self.m_loginTimerMgr.delTimer(id)
        # 每次心跳重新启动定时
        self.m_loginTimerMgr.addTimer(id, self.onHeartBeatTimeOut, configs_default['loginTimeOut'] * 1000, id)

    def onHeartBeatTimeOut(self,id):#过期清空登录状态，可以重新登录
        self.delLoginer(id)
        self.m_loginTimerMgr.delTimer(id)

    def setRoom(self,uid,rid):
        user = self.getUser(uid)
        if user == None:return
        user.room = rid
        kwargs = {"room": user.room}
        self.uqdateUser(user.id, **kwargs)

    def updateAllRankFlag(self,timeType):#更新所有人的排行奖励领取信息
      for k, v in self._m_cache.iteritems():
          flagList = v.rankaward.split(';')
          if flagList[timeType] == '0':continue
          flagList[timeType] = '0'
          v.rankaward = Utils().encodeIDFormat(flagList)
          kwargs = {"rankaward": v.rankaward}
          self.uqdateUser(k, **kwargs)

    def updateRankFlag(self,uid, timeType):  # 更新所有人的排行奖励领取信息
        user = self.getUser(uid)
        if user == None:return
        flagList = user.rankaward.split(';')
        flagList[timeType] = '1'
        user.rankaward = Utils().encodeIDFormat(flagList)
        kwargs = {"rankaward": user.rankaward}
        self.uqdateUser(uid, **kwargs)

    def updateLoginTime(self,uid):  # 更新登录时间
        user = self.getUser(uid)
        if user == None:return
        time = Utils().dbTimeCreate()
        kwargs = {"logintime":time}
        self.uqdateUser(uid, **kwargs)
        user.logintime=Utils().String2dateTime(time)

    def getRankedFlag(self,uid,timeType):#获取某种类型的排行奖励
        user = self.getUser(uid)
        if user == None:return True
        flagList = user.rankaward.split(';')
        return (flagList[timeType] == '1')


    def addMails(self,uid,mid):#获取某种类型的排行奖励
        user = self.getUser(uid)
        if user == None:return False
        if user.mails == '':
            mailList = []
        else:
            mailList = user.mails.split(';')
            if len(mailList) > 20:
                del mailList[0]
        mailList.append(mid)
        user.mails = Utils().encodeIDFormat(mailList)
        kwargs = {"mails": user.mails}
        self.uqdateUser(uid, **kwargs)

    def addActAwardFlag(self,uid,act):#添加某种活动奖励领过标志
        user = self.getUser(uid)
        if user == None: return False
        actFlagList = user.actawards.split(';')
        if act in actFlagList:return  False
        actFlagList.append(act)
        user.actawards = Utils().encodeIDFormat(actFlagList)
        kwargs = {"actawards": user.actawards}
        self.uqdateUser(uid, **kwargs)

    def ownActAwardFlag(self,uid,act):#是否某种活动奖励领过
        user = self.getUser(uid)
        if user == None: return True
        actFlagList = user.actawards.split(';')
        return( (act in actFlagList) and act != '')
