#-*-coding:utf-8-*-
from logic.gameplay.ACMJ import ACMJ
from configs.config_game import config_game
class Zimo(ACMJ):
    def __init__(self):
        ACMJ.__init__(self)
        return
    # 检测胡
    def CheckHU(self,cmj):  ##检测是否胡牌
        if cmj.m_Gamer.m_bTinged and cmj.m_Gamer.m_nGameAction != config_game["gameAction"]["geipai"]:
                return False
        return True