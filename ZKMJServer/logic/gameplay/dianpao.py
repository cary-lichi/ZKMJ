#-*-coding:utf-8-*-
from logic.gameplay.ACMJ import ACMJ
class Dianpao(ACMJ):
    def __init__(self):
        ACMJ.__init__(self)
        return
    # 检测胡
    def CheckHU(self,cmj):  ##检测是否胡牌
        return False