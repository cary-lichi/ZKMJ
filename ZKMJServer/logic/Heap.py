#-*-coding:utf-8-*-

from logic.stPAI import stPAI

#牌堆 所有的牌都有
class Heap:
    def __init__(self):
        return
    def InitPai(self):##初始化牌
        m_MJVec = []
        #中发白
        for  i in range(1,4):
            t_Pai = stPAI()
            t_Pai.m_Type = 0
            t_Pai.m_Value = i
            m_MJVec.append(t_Pai)
            m_MJVec.append(t_Pai)
            m_MJVec.append(t_Pai)
            m_MJVec.append(t_Pai)

         #东南西北
        for  i in range(1,5):
            t_Pai = stPAI()
            t_Pai.m_Type = 1
            t_Pai.m_Value = i
            m_MJVec.append(t_Pai)
            m_MJVec.append(t_Pai)
            m_MJVec.append(t_Pai)
            m_MJVec.append(t_Pai)
        # 万 饼 条
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



