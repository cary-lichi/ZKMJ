#coding=utf-8
from configs.config_default import configs_default
from logic.mainTimerMamager import MainTimerManager
from model.admin import Admin
from model.operate import Operate
from dal.dal_base import Dal_base
from dal.dal_operate import Dal_Operate
from tools.singleton import Singleton
from tools.utils import Utils


class Dal_Admin(Dal_base):
    def __init__(self):
        self.m_outLineCache = []  # 离线缓存
        self.m_operateCache = dict() #登陆者 以及操作记录
        self.m_loginTimerMgr = MainTimerManager()
        Dal_base.__init__(self)

    #增
    def addAdmin(self,newAdmin):
        # return self.add(newAdmin)
        newAdmin.id = newAdmin.save()
        self._m_cache[newAdmin.id]=newAdmin
        ## 返回一个新增newAdmin的id
        return newAdmin.id

    #删
    #改
    def updateAdmin(self,pk,**kwargs):
        return self.update(pk,Admin,**kwargs)
    #查
    def getAdminuser(self, pk):
        return self.get(pk, Admin)

    def onHeartBeat(self,id):#响应心跳协议
        if self.m_loginTimerMgr.getTimer(id):#删除原来定时
            self.m_loginTimerMgr.delTimer(id)
        # 每次心跳重新启动定时
        self.m_loginTimerMgr.addTimer(id, self.onHeartBeatTimeOut, configs_default['loginTimeOut'] * 1000, id)

    def onHeartBeatTimeOut(self,id):#过期清空登录状态，可以重新登录
        self.loginOut(id)
        self.m_loginTimerMgr.delTimer(id)

    #退出登录状态
    def loginOut(self, id):
        Aid = str(id)
        self.delLoginer(id)
        updataData = {"token":"1"}
        self.updateAdmin(Aid, **updataData)


    #登录状态
    def login(self,id,token):
        Aid = int(id)
        self.addLoginer(id)
        update_data = {"token": token}
        self.updateAdmin(Aid, **update_data)


    #缓存
    def initCache(self):
        self.initDB('admin',Admin)
        for k, v in self._m_cache.iteritems():
            id = v.id
            self.m_outLineCache.append(id)

#---------------------------------------------------------------------------------
#----------------------------以下代码为新增
#----------------------------操作记录
#---------------------------------------------------------------------------------

 # 获取登录的所有代理
    def getLoginCache(self):
        value_list = self.m_loginCache
        return value_list
    # 获取离线的所有代理
    def getOutLineCache(self):
        value_list = self.m_outLineCache
        return value_list
    #添加操作记录
    def addOperate(self,id,op):
        id = str(id)
        #获取操作记录
        Operate = self.m_operateCache.get(id)
        if Operate != None:
            if op in Operate:
                return
            Operate.append(op)
    # 添加登录的代理
    def addLoginer(self, id):
        id = str(id)
        lg = self.getLoginer(id)
        if lg == False:
            #创建操作记录
            self.m_operateCache[id]=[]
            self.onHeartBeat(id)  # 启动心跳计时
        ol = self.getOutliner(id)
        if ol: self.m_outLineCache.remove(long(id))

    # 获取某个登录的代理
    def getLoginer(self, id):
        return id in self.m_operateCache

    # 获取某个离线的代理
    def getOutliner(self, id):
        id = long(id)
        return id in self.m_outLineCache

    # 清除登录的代理（代理退出登录）
    def delLoginer(self, id):
        lg = self.getLoginer(id)
        if lg:
            #//将操作记录存入数据库，并清除记录
            operate = self.m_operateCache.pop(id)
            if operate:
                op= Utils().encodeIDFormat(operate)
                time = Utils().dbTimeCreate()
                addOperate = Operate(id=None, aid=int(id), operate=op, time=time)
                Dal_Operate().add(addOperate)
                self.getAdminuser(id).token = ""
        ol = self.getOutliner(id)
        if ol == False:
            self.m_outLineCache.append(long(id))