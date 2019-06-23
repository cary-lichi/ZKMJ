#-*-coding:utf-8-*-
'''
逻辑玩家类
'''
import traceback

from logic.room import Room
from configs.config_game import config_game
from configs.config_error import config_error
from logic.stPAI import stPAI
from logic.stPeng import stPeng
from protobuf import msg_pb2
from tools.utils import Utils
from logic.CMJManager import CMJManage
## 周口房间基类
class ZK_Room(Room):
    def __init__(self):
        Room.__init__(self)

    def calcScore(self):
            if self.getDianPaos():
                self.calcDianPaoScore()
                self.calcDianPaoShowState()
            else:
                self.calcZiMoScore()
                self.calcZiMoShowState()

            # #明暗杠
            # for k, v in self.m_gamerCache.iteritems():
            #     cM =  v.cmj.CheckHuXiaDan(True)
            #     self.CalcWinScoreInner(k,cM)
            #     cA = v.cmj.CheckHuXiaDan(False)
            #     self.CalcWinScoreInner(k,cA*2)

    #计算点炮赢
    def calcDianPaoScore(self):
        wins = self.getWins()
        winner = wins[0]
        self.CalcWinScoreInner(winner.id, 2)
        return
        dianpaoer = self.getDianPaos()
        wins = self.getWins()
        lenWin = len(wins)
        deltaScore = 6
        if lenWin > 1:  # 一炮多响
            for k, v in enumerate(wins):
                    if dianpaoer.boss and v.cmj.CheckOPZhuang() and self.IsHappyRoom() == False :
                        deltaScore = deltaScore*2
                    v.m_score = v.m_score + deltaScore
                    v.cmj.CheckHuDuoXiang()
                    dianpaoer.m_score = dianpaoer.m_score - deltaScore
            ##大扣以上分数乘2倍。明杠每家单独给1分。暗杠每家单独给2分。
            for k, v in enumerate(wins):
                oldscore = v.m_score
                if dianpaoer.boss and v.cmj.CheckOPZhuang()  and self.IsHappyRoom() == False:
                    oldscore = oldscore*2
                if v.cmj.CheckHuDaKou():
                    v.m_score = v.m_score + oldscore
                    dianpaoer.m_score = dianpaoer.m_score - oldscore
                oldscore = v.m_score
                if v.cmj.CheckOPZhuang() and v.boss  and self.IsHappyRoom() == False:  # 庄家翻倍
                    v.m_score = v.m_score + oldscore
                    dianpaoer.m_score = dianpaoer.m_score - oldscore
        elif lenWin==1:
            winner = wins[0]
            winner.cmj.CheckHuZiMo()
            if dianpaoer.getTing() == False:  # 未上听点炮给6分，点炮的给
                if dianpaoer.boss and dianpaoer.cmj.CheckOPZhuang()  and self.IsHappyRoom() == False:
                    deltaScore  = deltaScore * 2
                dianpaoer.m_score = dianpaoer.m_score - deltaScore
                winner.m_score = winner.m_score + deltaScore

                ##大扣以上分数乘2倍。明杠每家单独给1分。暗杠每家单独给2分。
                for k, v in enumerate(wins):
                    oldscore = v.m_score
                   # if dianpaoer.boss: oldscore = oldscore * 2
                    if v.cmj.CheckHuDaKou():
                        v.m_score = v.m_score + oldscore
                        dianpaoer.m_score = dianpaoer.m_score - oldscore
                    oldscore = v.m_score
                    if v.cmj.CheckOPZhuang() and v.boss  and self.IsHappyRoom() == False:  # 庄家翻倍
                        v.m_score = v.m_score + oldscore
                        dianpaoer.m_score = dianpaoer.m_score - oldscore
            else:
                self.CalcWinScoreInner(winner.id, 1)
                if dianpaoer.boss and dianpaoer.cmj.CheckOPZhuang()  and self.IsHappyRoom() == False:
                    winner.m_score = winner.m_score  + 1
                    dianpaoer.m_score = dianpaoer.m_score - 1
                ##大扣以上分数乘2倍。明杠每家单独给1分。暗杠每家单独给2分。
                for k, v in enumerate(wins):
                    if v.cmj.CheckHuDaKou():
                        self.CalcWinScoreInnerBoss(v.id)
                    if v.cmj.CheckOPZhuang() and v.boss:  # 庄家翻倍
                        self.CalcWinScoreInnerBoss(v.id)


    # 计算自摸赢
    def calcZiMoScore(self):
        return
        wins = self.getWins()
        lenWin = len(wins)
        if lenWin <= 0:
            return

        winner = wins[0]
        winner.m_bZiMo = True
        self.CalcWinScoreInner(winner.id, 4)
        return
        winner.cmj.CheckHuZiMo()
        oldScore = winner.m_score

        loseBoss = None
        for k,v in self.m_gamerCache.iteritems():
            if k != winner.id and v.boss:loseBoss = v

        self.CalcWinScoreInner(winner.id,2)
        if loseBoss:
            winner.m_score = winner.m_score + 2
            loseBoss.m_score = loseBoss.m_score - 2

        # 摸宝 、摸到大风（上听前碰的牌抓到第四张）等同摸宝每家给4分。
        # 红中满天飞等同于摸宝每家给四分
        if winner.cmj.CheckWinOp(winner.cmj.GetOPByName('bao')) or \
            winner.cmj.CheckWinOp(winner.cmj.GetOPByName('hongzhongbao')):
            self.ClearSocreInner()
            self.CalcWinScoreInner(winner.id, 4)
            if loseBoss:
                winner.m_score = winner.m_score + 4
                loseBoss.m_score = loseBoss.m_score - 4
        if  winner.cmj.CheckOPCommon() == False:
            if winner.cmj.CheckWinOp(winner.cmj.GetOPByName('dafeng')) or \
                    winner.cmj.CheckWinOp(winner.cmj.GetOPByName('hongzhong')):
                self.ClearSocreInner()
                self.CalcWinScoreInner(winner.id, 4)
                if loseBoss:
                    winner.m_score = winner.m_score + 4
                    loseBoss.m_score = loseBoss.m_score - 4
            # 对宝每家给8分 宝中宝每家给8分
            if winner.cmj.CheckWinOp(winner.cmj.GetOPByName('duibao')) or \
                winner.cmj.CheckWinOp(winner.cmj.GetOPByName('baozhongbao')):
                self.ClearSocreInner()
                self.CalcWinScoreInner(winner.id, 8)
                if loseBoss:
                    winner.m_score = winner.m_score + 8
                    loseBoss.m_score = loseBoss.m_score - 8

        ##大扣以上分数乘2倍。明杠每家单独给1分。暗杠每家单独给2分。
        if winner.cmj.CheckHuDaKou():
            self.CalcWinScoreInnerBoss(winner.id)
        if winner.cmj.CheckOPZhuang() and winner.boss  and self.IsHappyRoom() == False:  # 庄家翻倍
            self.CalcWinScoreInnerBoss(winner.id)

    #计算点炮赢
    def calcDianPaoShowState(self):
        dianpaoer = self.getDianPaos()
        for k,v in self.m_gamerCache.iteritems():
            if v.getTing() and k == dianpaoer.id:
                v.m_showState.append(config_game['jieSuanState']['tingpao'])
            elif  v.getTing()==False and k == dianpaoer.id:
                v.m_showState.append(config_game['jieSuanState']['untingpao'])
            elif v.getHu():
                v.m_showState.append(config_game['jieSuanState']['hupai'])
            elif v.getTing():
                v.m_showState.append(config_game['jieSuanState']['ting'])
            elif v.getTing() == False:
                v.m_showState.append(config_game['jieSuanState']['unting'])

    def calcZiMoShowState(self):
        for k,v in self.m_gamerCache.iteritems():
            if v.getHu():
                v.m_showState.append(config_game['jieSuanState']['zimo'])
            elif v.getTing():
                v.m_showState.append(config_game['jieSuanState']['ting'])
            elif v.getTing() == False:
                v.m_showState.append(config_game['jieSuanState']['unting'])