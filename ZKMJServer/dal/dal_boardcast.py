#-*-coding:utf-8-*-
'''
dal 层user继承了dal_base的所有的方法 增删改查 缓存
'''
from model.boardcast import BoardCast
from dal.dal_base import Dal_base
from tools.singleton import Singleton

class Dal_BoardCast(Dal_base):
    def __init__(self):
        Dal_base.__init__(self)

    ##增
    def addBoardCast(self,newBC):
        # newBC.id = newBC.save()
        # self._m_cache[newBC.id]=newBC
        # ## 返回一个新增user的id
        # return newBC.id
        return self.add(newBC)

    ## 查
    def getBoardCast(self,pk):
        return self.get(pk,BoardCast)

    ## 改
    def uqdateBoardCast(self,pk,**kwargs):
        return self.update(pk,BoardCast,**kwargs)

    ## 删
    def deleteBoardCast(self,pk):
        self.delete(pk,BoardCast)

    ## 缓存
    def initCache(self):
        self.initDB('boardcast',BoardCast)



