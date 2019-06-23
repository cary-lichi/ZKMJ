#-*-coding:utf-8-*-
'''
逻辑玩家类
'''
import copy
from collections import Counter

from logic.stCanHuPAI import stCanHuPAI
from logic.stPAI import stPAI
from logic.stCHI import stCHI
from logic.stPeng import stPeng
from logic.stGang import stGang
from logic.stGoodInfo import stGoodInfo
from configs.config_game import config_game
from logic.gameplay.cft import Cft
from logic.gameplay.common import Common
from logic.gameplay.dianpao import Dianpao
from logic.gameplay.lsdy import Lsdy
from logic.gameplay.sfdh import Sfdh
from logic.gameplay.tybb import Tybb
from logic.gameplay.ybc import Ybc
from logic.gameplay.zimo import Zimo

## 定义牌墙类
class CMJ():
    def __init__(self):
        CMJ.Init(self)
        return


    def Init(self):##初始化
       self.m_BaoPAIVec = []
       self.m_MyPAIVec = [[],[],[],[],[]]#起的种牌型
       self.m_ChiPAIVec = [[],[],[],[],[]]#吃的种牌型
       self.m_PengPAIVec = [[],[],[],[],[]]#碰的种牌型
       self.m_MGangPAIVec = [[],[],[],[],[]]#明杠的种牌型
       self.m_AGangPAIVec = [[],[],[],[],[]]#暗杠的种牌型

       self.m_PassGangPAIVec = []#不能再杠的牌，玩家能杠的时候没杠
       self.m_PutPAIVec = []#打出去的牌
       self.m_OrderPaiVec = []#记录吃碰杠的次序

       self.m_LastPAI = stPAI() #最后起的牌,检测胡用
       self.m_LastRealPAI = stPAI()  # 真正最后起的牌
       self.m_GoodInfo = stGoodInfo()#胡牌信息

       self.m_TempChiPAIVec = []#吃的可选组合
       self.m_TempPengPAIVec = []#碰的可选组合
       self.m_TempGangPAIVec = []#杠的可选组合

       self.m_gamePlay = []  # 玩法子类的组合(有关胡的玩法)
       self.m_gameCMJSuanFen = []  # 玩法子类的组合(有关算分的玩法)

       self.m_bTing = False#玩家是否已经听了

       self.m_winType = []#赢得类型集合

       self.m_canHuList = []#每次判断听牌的时候，这个可能的胡牌列表

       self.m_lastPutPai = stPAI() #最后一张打出的牌
       self.m_PutTingPai = stPAI() #打这张牌可以听
       self.m_checkDanDiao = False

       self.m_Gamer = None
       return True

    def Reset(self):##重置
        for i in range(0, len(self.m_MyPAIVec)):
            self.m_MyPAIVec[i] = []
            self.m_ChiPAIVec[i] = []
            self.m_PengPAIVec[i] = []
            self.m_MGangPAIVec[i] = []
            self.m_AGangPAIVec[i] = []
        self.m_BaoPAIVec = []
        self.m_PutPAIVec = []
        self.m_PassGangPAIVec = []
        self.m_OrderPaiVec = []  # 记录吃碰杠的次序
        self.ResetTemp()
        self.ResetCircle()
        self.m_bTing = False  # 玩家是否已经听了
        self.m_winType = []  # 赢得类型集合
        self.m_LastPAI = stPAI()  # 最后起的牌,检测胡用
        self.m_LastRealPAI = stPAI()  # 真正最后起的牌

    def ResetTemp(self):##重置临时吃碰杠组合
        self.m_TempChiPAIVec = []  # 吃的可选组合
        self.m_TempPengPAIVec = []  # 碰的可选组合
        self.m_TempGangPAIVec = []  # 杠的可选组合

    def ResetCircle(self):  ##重置一轮牌
        return

    def InitGamePlay(self,gamePlay):  ##设置玩法及配置
        self.m_gamePlay.append(Common())
        m_configGamePlay = config_game['gameplay']['optionals']
        for optional in gamePlay.optionals:
            if optional == m_configGamePlay["zimo"]:
                self.m_gamePlay.append(Zimo())
            elif optional == m_configGamePlay["dianpao"]:
                self.m_gamePlay.append(Dianpao())
            elif optional == m_configGamePlay["sfdh"]:
                self.m_gamePlay.append(Sfdh())
            elif optional == m_configGamePlay["cft"]:
                self.m_gamePlay.append(Cft())
            elif optional == m_configGamePlay["lsdy"]:
                self.m_gamePlay.append(Lsdy())
            elif optional == m_configGamePlay["tybb"]:
                self.m_gamePlay.append(Tybb())
            elif optional == m_configGamePlay["ybc"]:
                self.m_gamePlay.append(Ybc())
            elif optional == m_configGamePlay["zhuang"]:
                self.m_gameCMJSuanFen.append(Zhuang())
    ##赢某种玩法
    def ClearWinOp(self):
        self.m_winType = []

    def SetWinOp(self, op):
        if op == -1 :return
        if (op in self.m_winType): return
        self.m_winType.append(op)
        ##检测是否赢某种玩法

    def CheckWinOp(self, op):
        return (op in self.m_winType)

    ##对牌的基本操作  增删改查
    def AddPaiObj(self,pai):##加入新牌,并排序，给判断用
        return self.AddPai(pai.m_Type,pai.m_Value)

    def AddPai(self,p_Type,p_Value):##加入新牌,并排序，给判断用
          myPaiVec = self.m_MyPAIVec[p_Type]
          newPai = stPAI()
          newPai.m_Type = p_Type
          newPai.m_Value = p_Value
          t_Find = False
          for i,v in enumerate(myPaiVec):
              if v.m_Value>p_Value:
                  myPaiVec.insert(i,newPai)
                  t_Find = True
                  break

          if t_Find==False:
               myPaiVec.append(newPai)

          self.m_LastPAI.m_Type = p_Type
          self.m_LastPAI.m_Value = p_Value

          return True

    def AddPaiReal(self,p_Type,p_Value):##真正加入新牌,并排序
        self.AddPai(p_Type,p_Value)
        self.m_LastRealPAI.m_Type = p_Type#玩家真正的最后一张摸牌
        self.m_LastRealPAI.m_Value = p_Value

    def AddPutPai(self,p_Type,p_Value):##加入出的牌
        putPai = stPAI()
        putPai.m_Type = p_Type
        putPai.m_Value = p_Value
        self.m_PutPAIVec.append(putPai)

    def DelPutPai(self):  ##删掉最后一张出的牌
        self.m_PutPAIVec.pop()

    def AddOrderPai(self,pai):##加入带次序的牌
        self.m_OrderPaiVec.append(pai)

    def AddOrderPaiFromPeng(self,type,value):##加入带次序的牌,删掉碰，加入杠
        for k,v in enumerate(self.m_OrderPaiVec):
            if isinstance(v,stPeng):
                if v.m_Type == type and v.m_Value == value:
                    self.m_OrderPaiVec.remove(v)
                    break
        gangPai = stGang()
        gangPai.m_Type = type
        gangPai.m_Value = value
        gangPai.m_An = False
        self.m_OrderPaiVec.append(gangPai)

    def ResetPaiLast(self):  ##清理上次的摸牌信息，过牌用的
        self.m_LastRealPAI.m_Type = -1
        self.m_LastRealPAI.m_Value = -1

    def GetPaiIndex(self,p_Type,p_Value):##取得对应的牌在牌墙的索引
        count = 0
        for p in self.m_BaoPAIVec:
            if p_Type == p.m_Type and p_Value == p.m_Value:
                return count
            count = count + 1
        for paiArray in self.m_MyPAIVec:
            for p in paiArray:
                if p_Type==p.m_Type and p.m_Value==p_Value:
                    return count
                count = count + 1

        return -1

    def GetPaiCount(self, p_Type, p_Value):  ##取得对应的牌在牌墙的数量
        count = 0
        pool = self.m_MyPAIVec[p_Type]
        for k,v in enumerate(pool):
            if v == p_Value:
                count = count + 1
        pool = self.m_MGangPAIVec[p_Type]
        for k,v in enumerate(pool):
            if v == p_Value:
                count = count + 1
        pool = self.m_AGangPAIVec[p_Type]
        for k, v in enumerate(pool):
            if v == p_Value:
                count = count + 1
        pool = self.m_PengPAIVec[p_Type]
        for k, v in enumerate(pool):
            if v == p_Value:
                count = count + 1
        pool = self.m_ChiPAIVec[p_Type]
        for k, v in enumerate(pool):
            if v == p_Value:
                count = count + 1

        return count

    def DelPai(self,PaiIndex):##删除牌
        count = 0
        for i in range(0,len(self.m_MyPAIVec)):
            paiArray = self.m_MyPAIVec[i]
            for j in range(0, len(paiArray)):
                if count==PaiIndex:
                    paiArray.pop(j)
                    return True

                count = count +1
        return False

    def DelPaiObj(self,pai):##删除牌对象
        return self.DelPaiV(pai.m_Type,pai.m_Value)

    def DelPaiV(self,p_Type,p_Value):##删除牌
        myPaiVec = self.m_MyPAIVec[p_Type]
        for k,v in enumerate(myPaiVec):
                if v.m_Value==p_Value:
                    myPaiVec.pop(k)
                    return True
        return False

    ##吃碰杠听胡的 增删改查
    def DelPaiListV(self,list,p_Type,p_Value):##删除牌
        myPaiVec = list[p_Type]
        for k,v in enumerate(myPaiVec):
                if v==p_Value:
                    myPaiVec.pop(k)
                    return True
        return False

    def DelPengPaiV(self,p_Type,p_Value):##删除牌
        myPaiVec = self.m_PengPAIVec[p_Type]
        for k,v in enumerate(myPaiVec):
                if v==p_Value:
                    myPaiVec.pop(k)
                    return True
        return False

    def DelChiPaiV(self,p_Type,p_Value):##删除牌
        myPaiVec = self.m_ChiPAIVec[p_Type]
        for k,v in enumerate(myPaiVec):
                if v==p_Value:
                    myPaiVec.pop(k)
                    return True
        return False

    def CleanUp(self):##清空牌
       for i in range(0,len(self.m_MyPAIVec)):
            self.m_MyPAIVec[i] = []

       self.m_TempChiPAIVec = []#吃的可选组合
       self.m_TempPengPAIVec = []#碰的可选组合
       self.m_TempGangPAIVec = []#杠的可选组合

    def GetInfo(self):##取得胡牌信息
         return self.m_GoodInfo

    def CheckChiSort(self,p_Type):##检测可以吃牌种类
         if p_Type == config_game['MJ']['MJPAI_ZFB'] or p_Type == config_game['MJ']['MJPAI_FENG']:
             return False
         return  True

    def CheckChiPai(self,p_Type,p_Value):##检测吃牌
         if self.CheckChiSort(p_Type) == False:
             return False
         self.m_TempChiPAIVec = []
         myPai = self.m_MyPAIVec[p_Type]
         iSize  = len(myPai)
         if iSize  > 0 :
            if iSize  >= 2 :
                for i in range(0,iSize-1):##检测吃牌AB C   A B C  A BC 的情况，前后中
                    if (myPai[i].m_Value == (p_Value-2)) and (myPai[i+1].m_Value == (p_Value-1)):
                        t_Chi = stCHI()
                        t_Chi.m_Type = p_Type
                        t_Chi.m_Value1 = p_Value - 2
                        t_Chi.m_Value2 = p_Value - 1
                        t_Chi.m_Value3 = p_Value
                        self.m_TempChiPAIVec.append(t_Chi)
                    if (myPai[i].m_Value == (p_Value-1)) and (myPai[i+1].m_Value == (p_Value+1)):
                        t_Chi = stCHI()
                        t_Chi.m_Type = p_Type
                        t_Chi.m_Value1 = p_Value - 1
                        t_Chi.m_Value2 = p_Value
                        t_Chi.m_Value3 = p_Value + 1
                        self.m_TempChiPAIVec.append(t_Chi)
                    if (myPai[i].m_Value == (p_Value+1)) and (myPai[i+1].m_Value == (p_Value+2)):
                        t_Chi = stCHI()
                        t_Chi.m_Type = p_Type
                        t_Chi.m_Value1 = p_Value
                        t_Chi.m_Value2 = p_Value + 1
                        t_Chi.m_Value3 = p_Value + 2
                        self.m_TempChiPAIVec.append(t_Chi)

            #假设吃B，已有ABC
            if iSize >= 3:
               for i in range(1,iSize-1):
                    if (myPai[i-1].m_Value == (p_Value-1)) and (myPai[i].m_Value == p_Value) and (myPai[i+1].m_Value == (p_Value+1)):
                        t_Chi = stCHI()
                        t_Chi.m_Type = p_Type
                        t_Chi.m_Value1 = p_Value - 1
                        t_Chi.m_Value2 = p_Value
                        t_Chi.m_Value3 = p_Value + 1
                        self.m_TempChiPAIVec.append(t_Chi)
            #假设吃B，已有ABBC
            if iSize >= 4:
               for i in range(1,iSize-2):
                    if (myPai[i-1].m_Value == (p_Value-1)) and (myPai[i].m_Value == p_Value) and (myPai[i+2].m_Value == (p_Value+1)):
                        t_Chi = stCHI()
                        t_Chi.m_Type = p_Type
                        t_Chi.m_Value1 = p_Value - 1
                        t_Chi.m_Value2 = p_Value
                        t_Chi.m_Value3 = p_Value + 1
                        self.m_TempChiPAIVec.append(t_Chi)
            #假设吃B，已有ABBBC
            if iSize >= 5:
               for i in range(1,iSize-3):
                    if (myPai[i-1].m_Value == (p_Value-1)) and (myPai[i].m_Value == p_Value) and (myPai[i+3].m_Value == (p_Value+1)):
                        t_Chi = stCHI()
                        t_Chi.m_Type = p_Type
                        t_Chi.m_Value1 = p_Value - 1
                        t_Chi.m_Value2 = p_Value
                        t_Chi.m_Value3 = p_Value + 1
                        self.m_TempChiPAIVec.append(t_Chi)
            # #假设吃B，已有ABBBBC
            # if iSize >= 6:
            #    for i in range(0,iSize-4):
            #         if (myPai[i-1] == (p_Value-1)) and (myPai[i] == p_Value) and (myPai[i+4] == (p_Value+1)):
            #             t_Chi = stCHI()
            #             t_Chi.m_Type = p_Type
            #             t_Chi.m_Value1 = p_Value - 1
            #             t_Chi.m_Value2 = p_Value
            #             t_Chi.m_Value3 = p_Value + 1
            #             self.m_TempChiPAIVec.append(t_Chi)
            if len(self.m_TempChiPAIVec) > 0:
                return True

         return  False

    def DoChiPai(self,p_iIndex,p_Type,p_Value):##吃牌,注意这里的p_iIndex是指吃牌组合索引
        self.AddPai(p_Type,p_Value)
        for i in range(0,len(self.m_TempChiPAIVec)):
            if i == p_iIndex:
                v = self.m_TempChiPAIVec[i]
                self.DelPaiV(v.m_Type,v.m_Value1)
                self.DelPaiV(v.m_Type,v.m_Value2)
                self.DelPaiV(v.m_Type,v.m_Value3)

                self.m_ChiPAIVec[v.m_Type].append(v.m_Value1)
                self.m_ChiPAIVec[v.m_Type].append(v.m_Value2)
                self.m_ChiPAIVec[v.m_Type].append(v.m_Value3)

                return  True
        return False

    def GetChiPai(self,p_iIndex):##吃牌,注意这里的p_iIndex是指吃牌组合索引
        return self.m_TempChiPAIVec[p_iIndex]

    def GetChiChoseNum(self):##取得吃牌组合数
        return  len(self.m_TempChiPAIVec)

    def CheckPengPai(self,p_Type,p_Value):##检测碰牌
        self.m_TempPengPAIVec = []
        myPai = self.m_MyPAIVec[p_Type]
        iSize = len(myPai)
        if iSize > 0 :
            if iSize >= 2:
                for i in range(0,iSize-1):
                    if (myPai[i].m_Value == p_Value) and (myPai[i+1].m_Value == p_Value):
                        t_Peng = stPAI()
                        t_Peng.m_Type = p_Type
                        t_Peng.m_Value = p_Value
                        self.m_TempPengPAIVec.append(t_Peng)
                        break
            if len(self.m_TempPengPAIVec) > 0:
                return True

        return  False

    def DoPengPai(self,p_Type,p_Value):##碰牌
        self.AddPai(p_Type,p_Value)
        for k,v in enumerate(self.m_TempPengPAIVec):
                self.DelPaiV(v.m_Type,v.m_Value)
                self.DelPaiV(v.m_Type,v.m_Value)
                self.DelPaiV(v.m_Type,v.m_Value)

                self.m_PengPAIVec[v.m_Type].append(v.m_Value)
                self.m_PengPAIVec[v.m_Type].append(v.m_Value)
                self.m_PengPAIVec[v.m_Type].append(v.m_Value)

                return  True

        return False

    def CheckGangPaiFromPeng(self, p_Type, p_Value):  ##检测杠牌，必然是明杠
            self.m_TempGangPAIVec = []
                            # 除了检测个人牌墙中，还要检测碰牌组合
            myPengPai = self.m_PengPAIVec[p_Type]
            for i in range(0, len(myPengPai)):
                if myPengPai[i] == p_Value :
                    t_Gang = stPAI()
                    t_Gang.m_Type = p_Type
                    t_Gang.m_Value = p_Value
                    self.m_TempGangPAIVec.append(t_Gang)
                    break
            if len(self.m_TempGangPAIVec) > 0:
                return True
            return False

    def CheckGangPai(self,p_Type,p_Value,nGangState):##检测杠牌
        if self.CheckPassGangPai(p_Type,p_Value)  == True:return False
        self.m_TempGangPAIVec = []
        myPai = self.m_MyPAIVec[p_Type]
        iSize = len(myPai)
        maxRange = 3
        bGang = False
        if nGangState == config_game['gangState']['an']:maxRange = 4
        if iSize >= maxRange:
            for i in range(0,iSize-(maxRange-1)):
                if nGangState == config_game['gangState']['an']:
                   if (myPai[i].m_Value == p_Value) and (myPai[i+1].m_Value == p_Value) and \
                           (myPai[i+2].m_Value == p_Value) and (myPai[i+3].m_Value == p_Value):bGang = True
                else:
                    if (myPai[i].m_Value == p_Value) and (myPai[i + 1].m_Value == p_Value) and \
                            (myPai[i + 2].m_Value == p_Value) : bGang = True
                if bGang:
                    t_Gang = stPAI()
                    t_Gang.m_Type = p_Type
                    t_Gang.m_Value = p_Value
                    self.m_TempGangPAIVec.append(t_Gang)
                    break

        if len(self.m_TempGangPAIVec) > 0:
                return True
        return  False

    def CheckPassGangPai(self,p_Type,p_Value):##检测某张牌是不是已经不能杠了
        for k,v in enumerate(self.m_PassGangPAIVec):
            if v.m_Type == p_Type and v.m_Value == p_Value:
                return True
        return False

    def DoGangPaiFromPeng(self,p_Type,p_Value):##杠牌从碰牌中来的
        self.DelPaiV(p_Type,p_Value)
        for k,v in enumerate(self.m_TempGangPAIVec):
                self.DelPaiListV(self.m_PengPAIVec,v.m_Type,v.m_Value)
                self.DelPaiListV(self.m_PengPAIVec,v.m_Type,v.m_Value)
                self.DelPaiListV(self.m_PengPAIVec,v.m_Type,v.m_Value)

                #排序放入
                gangList = self.m_MGangPAIVec[v.m_Type]
                if len(gangList) == 0:
                    self.m_MGangPAIVec[v.m_Type].append(v.m_Value)
                    self.m_MGangPAIVec[v.m_Type].append(v.m_Value)
                    self.m_MGangPAIVec[v.m_Type].append(v.m_Value)
                    self.m_MGangPAIVec[v.m_Type].append(v.m_Value)
                else:
                    for k1,v1 in enumerate(gangList):
                         if v1 > v.m_Value:
                             self.m_MGangPAIVec[v.m_Type].insert(k1,v.m_Value)
                             self.m_MGangPAIVec[v.m_Type].insert(k1,v.m_Value)
                             self.m_MGangPAIVec[v.m_Type].insert(k1,v.m_Value)
                             self.m_MGangPAIVec[v.m_Type].insert(k1,v.m_Value)
                             break


                return  True

        return False

    def DoGangPai(self,p_Type,p_Value,nGangState):##杠牌
        if nGangState == config_game['gangState']['ming']:#正常明杠
           self.AddPai(p_Type,p_Value)
        gangPool = self.m_MGangPAIVec[p_Type]
        if nGangState == config_game['gangState']['an']:#暗杠
            gangPool = self.m_AGangPAIVec[p_Type]

        for k,v in enumerate(self.m_TempGangPAIVec):
                self.DelPaiV(v.m_Type,v.m_Value)
                self.DelPaiV(v.m_Type,v.m_Value)
                self.DelPaiV(v.m_Type,v.m_Value)
                self.DelPaiV(v.m_Type,v.m_Value)

                #排序放入
                if len( gangPool) == 0:
                    gangPool.append(v.m_Value)
                    gangPool.append(v.m_Value)
                    gangPool.append(v.m_Value)
                    gangPool.append(v.m_Value)
                else:
                    for k1,v1 in enumerate( gangPool):
                         if v1 > v.m_Value:
                             gangPool.insert(k1,v.m_Value)
                             gangPool.insert(k1,v.m_Value)
                             gangPool.insert(k1,v.m_Value)
                             gangPool.insert(k1,v.m_Value)
                             break


                return  True

        return False

##检测个人手中的牌
    def CheckAllPai(self,GetOrPut):##检测是否胡牌,各种情况
        if GetOrPut == config_game['MJ']['MJPAI_GETPAI']:#起牌的时候
            ##检测是否胡
            return self.CheckHU()
        else:
           ##检测是否听头
                return self.CheckTING()
        self.m_GoodInfo.m_CanHu = False
        return False

    # 检测胡
    def CheckHU(self):  ##检测是否胡牌
        # 检测牌数量
        if self.CheckPaiCount() == False:
            return False
        # 检测单张牌有没有超过5张的
        if self.CheckDanPaiCount() == False:
            return False
        baoNum = len(self.m_BaoPAIVec)
        IsHu = True
        for gameplay in self.m_gamePlay:
            if gameplay.CheckHU(self) == False:
                IsHu = False
        return IsHu

    def CheckTING(self):##检测是否听牌,以及可以胡的牌列表
        self.m_canHuList = []
        bHu = False
        for j in range(0,3):
            #起牌，加一张牌，如果胡了，说明当前可以听
            pai = stPAI()
            pai.m_Type = 0
            pai.m_Value = j + 1
            self.AddPaiObj(pai)
            if self.CheckAllPai(config_game['MJ']['MJPAI_GETPAI']):
                self.m_canHuList.append(pai)
                bHu = True
            self.DelPaiObj(pai)

        for j in range(0,4):
            #起牌，加一张牌，如果胡了，说明当前可以听
            pai = stPAI()
            pai.m_Type = 1
            pai.m_Value = j + 1
            self.AddPaiObj(pai)
            if self.CheckAllPai(config_game['MJ']['MJPAI_GETPAI']):
                self.m_canHuList.append(pai)
                bHu = True
            self.DelPaiObj(pai)

        for i in range(2,5):
          for j in range(0,9):
            #起牌，加一张牌，如果胡了，说明当前可以听
            pai = stPAI()
            pai.m_Type = i
            pai.m_Value = j + 1
            self.AddPaiObj(pai)
            if self.CheckAllPai(config_game['MJ']['MJPAI_GETPAI']):
                self.m_canHuList.append(pai)
                bHu = True
            self.DelPaiObj(pai)

        return bHu

    def CheckPutTING(self):##检测可以听牌的可能打牌列表
        self.m_checkDanDiao = False
        bCheckDanDiao = False
        putTingPais = []
        for index,pool in enumerate(self.m_MyPAIVec):
            for k,v in enumerate(pool):
                 self.DelPaiObj(v)
                 self.m_PutTingPai = v
                 if self.CheckAllPai(config_game['MJ']['MJPAI_PUTPAI']):
                     if bCheckDanDiao == False:bCheckDanDiao = self.m_checkDanDiao
                     self.m_checkDanDiao = False
                     canHuPai = stCanHuPAI()
                     canHuPai.m_canTingPai.m_Type = v.m_Type
                     canHuPai.m_canTingPai.m_Value = v.m_Value
                     for k1,v1 in enumerate(self.m_canHuList):
                         canHuPai.m_canHuList.append(v1)
                     putTingPais.append(canHuPai)
                 self.AddPaiObj(v)
        self.m_PutTingPai = None
        self.m_checkDanDiao = bCheckDanDiao
        return putTingPais

    def CheckHuFormPutTING(self,putTingPaiList):##检测选择一张可以听的牌打出之后，可以胡的牌列表
        for k,v in enumerate(putTingPaiList):
            self.DelPaiV(v.m_Type,v.m_Value)

    def CheckPoolNull(self,pool):##检测牌池是否有牌
        for k,v in enumerate(pool):
            if len(v) > 0 :
                return False
        return True

    def CheckPaiCount(self):##检测牌池牌数量是否少于13张
        lenNow = len(self.m_BaoPAIVec)
        for k,v in enumerate(self.m_MyPAIVec):
            lenNow = lenNow + len(v)
        for k, v in enumerate(self.m_MGangPAIVec):
            if len(v) > 0:lenNow = lenNow + len(v) -1
        for k, v in enumerate(self.m_AGangPAIVec):
            if len(v) > 0:lenNow = lenNow + len(v) -1
        for k, v in enumerate(self.m_PengPAIVec):
            lenNow = lenNow + len(v)
        for k, v in enumerate(self.m_ChiPAIVec):
            lenNow = lenNow + len(v)
        if lenNow % 3 == 2:
            return True
        else:
            return False
    def CheckDanPaiCount(self):
        for arr in self.m_MyPAIVec:
            for i in range(0, len(arr)):
                if arr[i] != 0 and i <= len(arr) - 5:
                    if arr[i].m_Value == arr[i + 4].m_Value and arr[i].m_Type == arr[i + 4].m_Type:
                        return False
        return True
    def GetZPSOverride(self):##检测横顺掌是否存在重叠，仅仅检查手牌
         #删除掌
         bDel1 = self.DelPaiV(self.m_jiangPai.m_Type,self.m_jiangPai.m_Value)
         bDel2 = self.DelPaiV(self.m_jiangPai.m_Type, self.m_jiangPai.m_Value)
         assert bDel1 and bDel2

         #如果有重叠，必然不是3的倍数
         for k,pool in enumerate(self.m_MyPAIVec):
            lenPool = len(pool)
            if lenPool == 0:continue
            if lenPool%3 != 0:
                self.AddPai(self.m_jiangPai.m_Type, self.m_jiangPai.m_Value)
                self.AddPai(self.m_jiangPai.m_Type, self.m_jiangPai.m_Value)
                return False

         self.AddPai(self.m_jiangPai.m_Type,self.m_jiangPai.m_Value)
         self.AddPai(self.m_jiangPai.m_Type, self.m_jiangPai.m_Value)

         return True

    def GetLeftCanHuPai(self,pai):##获取个人牌墙中某张牌数量
        nLeft = 0
        pool = self.m_MyPAIVec[pai.m_Type]
        for k,v in enumerate(pool):
            if pai.m_Value == v.m_Value and pai.m_Type == v.m_Type:
                nLeft = nLeft + 1
        return nLeft

    def GetGangCount(self):##获取杠数量
        nCount = 0
        for type,pool in enumerate(self.m_MGangPAIVec):
            nCount = nCount + len(pool)/4
        for type, pool in enumerate(self.m_AGangPAIVec):
            nCount = nCount + len(pool) / 4

        return nCount

    def HandleAIPutPai(self):##获取杠数量
        if self.m_bTing: return  self.m_LastRealPAI

        putPai = stPAI()
        for index, pool in enumerate(self.m_MyPAIVec):
            cnt = Counter(pool)
            paiVTemp = []
            for paiV, count in cnt.iteritems():
                if count < 2:
                    paiVTemp.append(paiV)
            for k, v in enumerate(paiVTemp):
                if  (self.CreateNearPai(v,1) in pool) and (self.CreateNearPai(v,2) in pool):
                    continue
                elif (self.CreateNearPai(v,-1) in pool) and (self.CreateNearPai(v, 1) in pool):
                    continue
                elif (self.CreateNearPai(v,-2) in pool) and (self.CreateNearPai(v, -1) in pool):
                    continue
                putPai.m_Type = v.m_Type
                putPai.m_Value = v.m_Value
                return putPai
        for index, pool in enumerate(self.m_MyPAIVec):
            for k,paiV in enumerate(pool):
                putPai.m_Type = index
                putPai.m_Value = paiV
                return putPai
    def CreateNearPai(self,pai,apart):
        newpai = stPAI()
        newpai.m_Type = pai.m_Type
        newpai.m_Value = pai.m_Value + apart
        return  newpai