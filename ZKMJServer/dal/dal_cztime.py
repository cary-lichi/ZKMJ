#-*-coding:utf-8-*-
'''
dal 层user继承了dal_base的所有的方法 增删改查 缓存
'''
from model.cztime import CZTime
from dal.dal_base import Dal_base
from tools.singleton import Singleton

class Dal_CZTime(Dal_base):
    def __init__(self):
        Dal_base.__init__(self)

    ##增
    def addCZTime(self,newCZ):
        newCZ.save()
        self._m_cache[newCZ.time]=newCZ
        ## 返回一个新增user的id
        return newCZ.time

    ## 查
    def getCZTime(self,pk):
        return self.get(pk,CZTime)

    ## 改
    def uqdateCZTime(self,pk,**kwargs):
        return self.update(pk,CZTime,**kwargs)

    ## 删
    def deleteCZTime(self,pk):
        self.delete(pk,CZTime)

    ## 缓存
    def initCache(self):
        self.initDB('cztime',CZTime)



