#-*-coding:utf-8-*-
'''
dal 层user继承了dal_base的所有的方法 增删改查 缓存
'''
from configs.config_game import config_game
from dal.dal_user import Dal_User
from logic.mainTimerMamager import MainTimerManager
from model.operate import Operate
from dal.dal_base import Dal_base
from model.recordAssist import RecordAssist
from tools.utils import Utils


class Dal_Operate(Dal_base):
    def __init__(self):
        Dal_base.__init__(self)

    ##增
    def addOperate(self,newM):
        # newM.id = newM.save()
        # self._m_cache[newM.id]=newM
        # ## 返回一个新增user的id
        # return newM.id
        return self.add(newM)

    ## 查
    def getOperate(self,pk):
        return self.get(pk,Operate)

    ## 改
    def uqdateOperate(self,pk,**kwargs):
        return self.update(pk,Operate,**kwargs)

    ## 删
    def deleteOperate(self,pk):
        self.delete(pk,Operate)

    ## 缓存
    def initCache(self):
        self.initDB('operate',Operate)


