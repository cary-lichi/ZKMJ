#-*-coding:utf-8-*-
'''
dal 层user继承了dal_base的所有的方法 增删改查 缓存
'''
from model.suggest import Suggest
from dal.dal_base import Dal_base
from tools.singleton import Singleton

class Dal_Suggest(Dal_base):
    def __init__(self):
        Dal_base.__init__(self)

    ##增
    def addSuggest(self,newBC):
        # newBC.id = newBC.save()
        # self._m_cache[newBC.id]=newBC
        # ## 返回一个新增user的id
        # return newBC.id
        return self.add(newBC)

    ## 查
    def getSuggest(self,pk):
        return self.get(pk,Suggest)

    ## 改
    def uqdateSuggest(self,pk,**kwargs):
        return self.update(pk,Suggest,**kwargs)

    ## 删
    def deleteSuggest(self,pk):
        self.delete(pk,Suggest)

    ## 缓存
    def initCache(self):
        self.initDB('suggest',Suggest)



