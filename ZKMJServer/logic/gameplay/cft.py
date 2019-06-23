#-*-coding:utf-8-*-
from logic.gameplay.ACMJ import ACMJ
class Cft(ACMJ):
    def __init__(self):
        ACMJ.__init__(self)
        return
    # 检测胡
    def CheckHU(self,cmj):  ##检测是否胡牌
        if cmj.m_Gamer.m_bTinged == False: #是否听了
            if cmj.m_PutTingPai.m_Type == self.MJPAI_ZFB or cmj.m_PutTingPai.m_Type == self.MJPAI_FENG:
                return True
            else:
                return False
        return True