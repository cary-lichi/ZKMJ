#-*-coding:utf-8-*-
'''
逻辑玩家类
'''
# //  m_Type      m_Value
# //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-//
# //  0       |   中   1
# //          |
# //  1       |   一万  二万  ……  九万
# //          |
# //  2       |   一条  二条  ……  九条
# //          |
# //  3       |   一饼  二饼  ……  九饼
# //          |
# //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-//

from logic.stPAI import stPAI
from logic.stCHI import stCHI
from logic.stGoodInfo import stGoodInfo
from configs.config_game import config_game
from logic.CMJ import CMJ
from collections import Counter
from CMJManager import CMJManage

## 定义牌墙类。周口麻将玩法 混子
class CMJHui(CMJ):
    def __init__(self):
        CMJ.__init__(self)
        self.Init()

    def Init(self):
        return

    def AddPaiReal(self,p_Type,p_Value):##真正加入新牌,并排序
        if CMJManage.m_baoPai.m_Type == p_Type and CMJManage.m_baoPai.m_Value == p_Value :
            newPai = stPAI()
            newPai.m_Type = p_Type
            newPai.m_Value = p_Value
            self.m_BaoPAIVec.append(newPai)
            return True
        self.AddPai(p_Type,p_Value)
        self.m_LastRealPAI.m_Type = p_Type#玩家真正的最后一张摸牌
        self.m_LastRealPAI.m_Value = p_Value