#-*-coding:utf-8-*-
'''
dal 层user继承了dal_base的所有的方法 增删改查 缓存
'''
from model.recharge import Recharge
from dal.dal_base import Dal_base
from tools.singleton import Singleton

class Dal_Recharge(Dal_base):
    def __init__(self):
        Dal_base.__init__(self)

    ##增
    def addRecharge(self,newBC):
        # newBC.id = newBC.save()
        # self._m_cache[newBC.id]=newBC
        # ## 返回一个新增user的id
        # return newBC.id
        return self.add(newBC)

    ## 查
    def getRecharge(self,pk):
        return self.get(pk,Recharge)

    ## 改
    def uqdateRecharge(self,pk,**kwargs):
        return self.update(pk,Recharge,**kwargs)

    ## 删
    def deleteRecharge(self,pk):
        self.delete(pk,Recharge)
    #获取充值记录
    def getallRecharge(self,id):
        money = int()
        idList = self.getValueByAttr('uid',id)
        if len(idList) !=0:
            for k in idList:
                k = int(k)
                recharge = self.getRecharge(k)
                money +=int(recharge.money)
        return money

    ## 缓存
    def initCache(self):
        self.initDB('recharge',Recharge)



