#-*-coding:utf-8-*-
'''
逻辑玩家类
'''
from logic.stPAI import stPAI
from logic.stPAIEx import stPAIEx
from logic.Heap import Heap
from configs.config_game import config_game
import random

## 麻将管理器
class CMJManage  :
    m_baoPai = stPAI()  # 宝牌
    def __init__(self,gamePlay):
        self.m_MJVec = []#麻将数据列表
        self.m_HZPaiNum = 0#黄庄的牌数
        self.Heap = Heap() #牌堆
        self.HandCardNum = 13 #玩家手牌的数目
        self.initGamePlay(gamePlay)

    def InitPai(self,p_HZPaiNum):##初始化牌
        self.m_HZPaiNum = p_HZPaiNum
        self.m_MJVec = self.Heap.InitPai()
        self.XiPai()

    def initGamePlay(self,gamePlay):
        for optional in gamePlay.optionals:
            if optional == config_game['gameplay']['optionals']["ybc"]:
                self.HandCardNum = 4

    def GraspPai(self,gamerCache): #发牌
        # # 清理
        for k, v in gamerCache.iteritems():
            v.cmj.CleanUp()

        # #每人十三张，
        for i in range(0, self.HandCardNum):
            for k, v in gamerCache.iteritems():
                paiEx = self.GetAPai()
                v.onAddPai(paiEx.m_NewPai.m_Type, paiEx.m_NewPai.m_Value)

        # for k,v in gamerCache.iteritems():
        #     for i in range(0, self.HandCardNum):
        #         paiEx = self.GetAPai()
        #         v.onAddPai(paiEx.m_NewPai.m_Type,paiEx.m_NewPai.m_Value)

    def XiPai(self):##洗牌
        random.shuffle(self.m_MJVec)

    def GetAPai(self):##起牌

       #如果所有牌都起完了
       if len(self.m_MJVec) <= 0:
           return None

       t_Pai = stPAIEx()
       t_Pai.m_NewPai.m_Type = self.m_MJVec[-1].m_Type
       t_Pai.m_NewPai.m_Value = self.m_MJVec[-1].m_Value
       t_Pai.m_PaiNum = len(self.m_MJVec) - 1
       if(t_Pai.m_PaiNum == self.m_HZPaiNum):
           t_Pai.m_IsHZ = True
       else:
           t_Pai.m_IsHZ = False

       self.m_MJVec.pop()
       return t_Pai

    def GetLeftPai(self):##获取剩余牌数
        return len(self.m_MJVec)

    def GetLeftCanHuPai(self,pai):##获取能胡的牌的剩余牌数
        nLeft = 0
        for k,v in enumerate(self.m_MJVec):
              if v.m_Type == pai.m_Type and v.m_Value == pai.m_Value:
                  nLeft = nLeft + 1
        return  nLeft

    def IsOver(self):##是不是结束了
        return len(self.m_MJVec) <= 0