#-*-coding:utf-8-*-
'''
逻辑玩家类
'''
import copy

from logic.CMJ import CMJ
from logic.CMJHui import CMJHui


from configs.config_game import config_game
## 定义一个游戏内逻辑玩家类
from logic.stPAI import stPAI
from tools.utils import Utils


class Gamer:
    def __init__(self,id,conn,pos,bAI=False):##房主链接，房主id
       self.id = id#玩家userid
       self.conn = conn
       self.pos = pos#玩家方位
       self.boss = False#庄家标志
       self.state = 0# 1可胡 2可听 4可杠 8可碰 16可吃 1听 2胡
       self.lastMsg = None# 断线重连用，发送上一次的打牌或者can牌消息
       self.m_gamePlay = None
       self.m_score = 0
       self.cmj = None#牌墙类，负责玩家牌池管理和逻辑处理
       self.m_bDianPao = False#是否点炮
       self.m_bZiMo = False#是否自摸
       self.m_nGameState = config_game['gamerState']['join']#是否准备好
       self.m_nGameAction = config_game['gameAction']['standby']#玩家当前动作 默认待机
       self.m_huPai = stPAI()#胡的牌
       self.m_showState=[]#结算显示类型
       self.m_bAI = bAI#玩家是否是机器人
       if bAI:
           #self.m_nGameState = config_game['gamerState']['ready']  # 是否准备好
           self.m_nAIRandInfo = Utils().gen_ai_info_rand()
           self.m_nAIRandHead = Utils().gen_ai_head_rand()
       #总结算临时数据
       self.m_nHuCount = 0#胡牌数量
       self.m_nMoBaoCount = 0#摸宝数量
       self.m_nZiMoCount = 0#自摸数量
       self.m_nGangCount = 0#杠牌数量
       self.m_nDianPaoCount = 0#点炮数量
       self.m_nDanJuBestCount = 0#单句最佳数量
       self.m_TotalScore = 0#总分

    def initGamePlay(self,gamePlay):
        if gamePlay.nType == config_game['gameplay']['type']['hunzi']:
            self.cmj = CMJHui()
        else:#默认是通用玩法
            self.cmj = CMJ()
        self.cmj.m_Gamer = self
        self.cmj.InitGamePlay(gamePlay)

    def onAddPai(self,type,value):
          self.cmj.AddPaiReal(type,value)

    def onDelPai(self,type,value):
          self.cmj.DelPaiV(type,value)

    def reset(self):
        self.cmj.Reset()
        self.resetState()
        self.m_bReady = False;#是否准备好
        self.m_bDianPao = False#是否点炮
        self.m_bZiMo = False
        self.boss = False#庄家标志
        self.lastMsg = None  #
        self.m_huPai.m_Type = None
        self.m_huPai.m_Value = None
        self.m_score = 0
        self.m_showState = []
        self.m_bTinged = False;#是否真正听过了

    def resetCircle(self):
        self.setCanHu(False)
        self.setCanQiangTing(False)
        self.setCanTing(False)
        self.setCanGang(False)
        self.setCanPeng(False)
        self.setCanChi(False)
        self.setHu(False)
        self.cmj.ResetCircle()
        self.m_bDianPao = False

    def resetState(self):
        self.setCanHu(False)
        self.setCanQiangTing(False)
        self.setCanTing(False)
        self.setCanGang(False)
        self.setCanPeng(False)
        self.setCanChi(False)
        self.setHu(False)
        self.setTing(False)
        self.m_bTinged = False

    def getCanGuo(self):
        return  (self.getCanHu() or self.getCanTing() or self.getCanChi() \
                 or self.getCanPeng() or self.getCanGang() or self.getCanQiangTing())

    def getCanHu(self):
        return  (self.state & 0b00000001 != 0)
    def setCanHu(self,isCan):
        if isCan:
           self.state = self.state | 0b00000001
        else:
           self.state = self.state & 0b11111110

    def getCanQiangTing(self):
        return  (self.state & 0b00000010 != 0)
    def setCanQiangTing(self,isCan):
        if isCan:
           self.state = self.state | 0b00000010
        else:
           self.state = self.state & 0b11111101

    def getCanTing(self):
        return  (self.state & 0b10000000 != 0)
    def setCanTing(self,isCan):
        if isCan:
           self.state = self.state | 0b10000000
        else:
           self.state = self.state & 0b01111111

    def getCanGang(self):
        return  (self.state & 0b00000100 != 0)
    def setCanGang(self,isCan):
        if isCan:
           self.state = self.state | 0b00000100
        else:
           self.state = self.state & 0b11111011

    def getCanPeng(self):
        return  (self.state & 0b00001000 != 0)
    def setCanPeng(self,isCan):
        if isCan:
           self.state = self.state | 0b00001000
        else:
           self.state = self.state & 0b11110111

    def getCanChi(self):
        return  (self.state & 0b00010000 != 0)
    def setCanChi(self,isCan):
        if isCan:
           self.state = self.state | 0b00010000
        else:
           self.state = self.state & 0b11101111

    def getTing(self):
        return  (self.state & 0b00100000 != 0)
    def setTing(self,isCan):
        if isCan:
           self.state = self.state | 0b00100000
           self.cmj.m_bTing = True
        else:
           self.state = self.state & 0b11011111

    def getHu(self):
        return  (self.state & 0b01000000 != 0)
    def setHu(self,isCan):
        if isCan:
           self.state = self.state | 0b01000000
        else:
           self.state = self.state & 0b10111111

    def ResetPaiLast(self):
        self.cmj.ResetPaiLast()

#计算最终数据
    def calcOverData(self):
        if self.getHu():
            self.m_nHuCount = self.m_nHuCount + 1
        if self.m_bZiMo:
            self.m_nZiMoCount = self.m_nZiMoCount + 1

        self.m_nGangCount =self.m_nGangCount + self.cmj.GetGangCount()

        if self.m_bDianPao:
           self.m_nDianPaoCount = self.m_nDianPaoCount + 1
        #self.m_nDanJuBestCount = self.m_TotalScore
        self.m_TotalScore = self.m_TotalScore + self.m_score

    # 计算最终数据
    def saveLastPutPai(self,pai):
        self.cmj.m_lastPutPai = pai

    # 判断是否是机器人
    def isAI(self):
        return  (self.id<0 and self.m_bAI)
