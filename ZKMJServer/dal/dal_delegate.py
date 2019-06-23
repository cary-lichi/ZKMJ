#-*-coding:utf-8-*-

#dal 层Delegate继承了dal_base的所有的方法 增删改查 缓存

from model.delegate import Delegate
from dal.dal_base import Dal_base
from tools.utils import Utils
from logic.mainTimerMamager import MainTimerManager
from configs.config_default import configs_default


class Dal_Delegate(Dal_base):
    def __init__(self):
        Dal_base.__init__(self)
        self.m_loginCache =[]  # 登录缓存
        self.m_loginTimerMgr = MainTimerManager()
        self.m_outLineCache = []  # 离线缓存
        self.m_onlyPalyerCache = [] #只是玩家的缓存
        self.m_firstDeleCache = []  # 一级代理缓存
        self.m_secondDeleCache = []  # 二级代理缓存
        self.m_threeDeleCache = []  # 三级代理缓存
        self.m_allDeleCache = [] #所有代理缓存
    ##增
    def addDelegate(self,newDelegate):
        # newDelegate.save()
        # self._m_cache[newDelegate.id]=newDelegate
        # ## 返回一个新增Delegate的id
        # return newDelegate.id
        self.m_onlyPalyerCache.append(newDelegate.id)
        return self.add(newDelegate)

    ## 查
    def getDelegate(self,pk):
        return self.get(pk,Delegate)

    ## 改
    def updateDelegate(self,pk,**kwargs):
        return self.update(pk,Delegate,**kwargs)

    ## 删
    def deleteDelegate(self,pk):
        self.delete(pk,Delegate)

    ## 通过邀请码获取代理对象
    def getDelegateByICode(self,icode):
        for k, v in self._m_cache.iteritems():
            if v.icode == icode:
                return v
        return None

    ## 缓存
    def initCache(self):
        self.initDB('delegate',Delegate)
        for k,v in self._m_cache.iteritems():
            id = v.id
            if v.level !=configs_default['deleLevel']['gamer']:
                self.m_outLineCache.append(id)
                self.m_allDeleCache.append(id)
            if v.level ==configs_default['deleLevel']['gamer']:
                self.m_onlyPalyerCache.append(id)
            elif v.level == configs_default['deleLevel']['firstLevel']:
                self.m_firstDeleCache.append(id)
            elif v.level == configs_default['deleLevel']['secondLevel']:
                self.m_secondDeleCache.append(id)
            elif v.level == configs_default['deleLevel']['threeLevel']:
                self.m_threeDeleCache.append(id)


        
    # -------------------------------------------------------------------------#
    # --------------以下为新增的内容，为了解决查询在线代理和离线代理功能-------#
    # --------------这是一条伟大的分界线---------------------------------------#
    # -------------------------------------------------------------------------#
    def updateLoginTime(self,did):  # 更新登录时间
        dele = self.getDelegate(did)
        if dele == None:return
        time = Utils().dbTimeCreate()
        kwargs = {"logintime":time}
        self.updateDelegate(did, **kwargs)
        dele.logintime=Utils().String2dateTime(time)

    # 获取登录的所有代理
    def getLoginCache(self):
        value_list = self.m_loginCache
        return value_list
    # 获取离线的所有代理
    def getOutLineCache(self):
        value_list = self.m_outLineCache
        return value_list
    # 获取一级代理(最高级代理)
    def getfirstDeleCache(self):
        value_list = self.m_firstDeleCache
        return value_list
    # 获取二级代理
    def getsecondDeleCache(self):
        value_list = self.m_secondDeleCache
        return value_list
    # 获取三级代理
    def getthreeDeleCache(self):
        value_list = self.m_threeDeleCache
        return value_list
    #获取只是玩家
    def getonlyPalyerCache(self):
        value_list = self.m_onlyPalyerCache
        return value_list
    # 获取所有的代理
    def getallDeleCache(self):
        value_list = self.m_allDeleCache
        return value_list

    # 添加一级代理
    def addfirstDele(self, id):
        # 删除原级代理的缓存
        Tdele = self.getthreeDele(id)
        if Tdele: self.m_threeDeleCache.remove(id)
        Sdele = self.getsecondDele(id)
        if Sdele: self.m_secondDeleCache.remove(id)
        fdele = self.getfirstDele(id)
        # 加入新的缓存
        if fdele == False:
            self.m_firstDeleCache.append(id)
    # 添加二级代理
    def addsecondDele(self, id):
        # 删除原级代理的缓存
        Tdele = self.getthreeDele(id)
        if Tdele: self.m_threeDeleCache.remove(id)
        # 加入新的缓存
        dele = self.getsecondDele(id)
        if dele == False:
            self.m_secondDeleCache.append(id)
    # 添加三级代理
    def addthreeDele(self, id):
        # 移除旧缓存
        Tdele = self.getonlyPalyer(id)
        if Tdele: self.m_onlyPalyerCache.remove(id)
        # 加入新的缓存
        dele = self.getthreeDele(id)
        if dele == False:
            self.m_threeDeleCache.append(id)
    # 添加登录的代理
    def addLoginer(self, id):
        lg = self.getLoginer(id)
        if lg == False:
            self.m_loginCache.append(id)
            self.onHeartBeat(id)  # 启动心跳计时
        ol = self.getOutliner(id)
        if ol: self.m_outLineCache.remove(id)
    # 添加仅玩家缓存
    def addonlyPalyerCache(self,id):
        # 加入新的缓存
        dele = self.getonlyPalyer(id)
        if dele == False:
            self.m_onlyPalyerCache.append(id)

    # 添加代理缓存
    def addallDeleCache(self,id):
    #     删除玩家的缓存
        Tdele = self.getonlyPalyer(id)
        if Tdele: self.m_onlyPalyerCache.remove(id)
        # 加入新的缓存
        dele = self.getallDele(id)
        if dele == False:
            self.m_allDeleCache.append(id)

    # 获取某个登录的代理
    def getLoginer(self, id):
        return id in self.m_loginCache
    # 获取某个离线的代理
    def getOutliner(self, id):
        return id in self.m_outLineCache
    # 获取某个一级代理
    def getfirstDele(self, id):
        return id in self.m_firstDeleCache
    # 获取某个二级代理
    def getsecondDele(self, id):
        return id in self.m_secondDeleCache
    # 获取某个三级代理
    def getthreeDele(self, id):

        return id in self.m_threeDeleCache
    # 获取某个玩家
    def getonlyPalyer(self,id):
        return id in self.m_onlyPalyerCache

    # 获取某个代理
    def getallDele(self, id):
        return id in self.m_allDeleCache

    # 清除登录的代理（代理退出登录）
    def delLoginer(self, id):
        lg = self.getLoginer(id)
        if lg:
            dele = self.m_loginCache.remove(id)
            if dele:
                self.getDelegate(dele).sToken = ""
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

