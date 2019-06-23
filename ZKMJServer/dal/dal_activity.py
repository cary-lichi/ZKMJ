#-*-coding:utf-8-*-
'''
dal 层user继承了dal_base的所有的方法 增删改查 缓存
'''
from model.activity import Activity
from dal.dal_base import Dal_base
from tools.singleton import Singleton

class Dal_Activity(Dal_base):
    def __init__(self):
        Dal_base.__init__(self)

    ##增
    def addActivity(self,newBC):
        # newBC.id = newBC.save()
        # self._m_cache[newBC.id]=newBC
        # ## 返回一个新增user的id
        # return newBC.id
        return self.add(newBC)

    ## 查
    def getActivity(self,pk):
        return self.get(pk,Activity)

    ## 改
    def uqdateActivity(self,pk,**kwargs):
        return self.update(pk,Activity,**kwargs)

    ## 删
    def deleteActivity(self,pk):
        self.delete(pk,Activity)

    ## 缓存
    def initCache(self):
        self.initDB('activity',Activity)



