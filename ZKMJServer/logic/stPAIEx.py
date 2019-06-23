#-*-coding:utf-8-*-
'''
逻辑玩家类
'''
from logic.stPAI import stPAI
## 牌信息
class stPAIEx:
    def __init__(self):##牌类型，牌字
       self.m_NewPai = stPAI() #起的新牌
       self.m_PaiNum = 0   #剩余牌数
       self.m_IsHZ = False #是否黄庄

