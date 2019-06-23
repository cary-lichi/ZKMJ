#-*-coding:utf-8-*-

from logic.stPAI import stPAI

#没有风  只有万饼条的牌堆
class HeapNoFeng:
    def __init__(self):
        return

    def InitPai(self):##初始化牌
        m_MJVec = []
        #万 饼 条
        for j in range(2, 5):
            for i in range(1, 10):
                t_Pai = stPAI()
                t_Pai.m_Type = j
                t_Pai.m_Value = i
                m_MJVec.append(t_Pai)
                m_MJVec.append(t_Pai)
                m_MJVec.append(t_Pai)
                m_MJVec.append(t_Pai)
        return m_MJVec