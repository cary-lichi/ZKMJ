#-*-coding:utf-8-*-
'''
dal 层user继承了dal_base的所有的方法 增删改查 缓存
'''
from configs.config_game import config_game
from dal.dal_user import Dal_User
from logic.mainTimerMamager import MainTimerManager
from model.record import Record
from dal.dal_base import Dal_base
from model.recordAssist import RecordAssist
from tools.utils import Utils


class Dal_Record(Dal_base):
    def __init__(self):
        Dal_base.__init__(self)
        self.m_timerMgr= MainTimerManager()  ##超时处理队列
        self.m_sortOrginCache = dict()
        self.m_sortCache = dict()
        self.m_sortCache[config_game['gamerRank']['day']] = []
        self.m_sortCache[config_game['gamerRank']['week']] = []
        self.m_sortCache[config_game['gamerRank']['month']] = []
        self.m_sortCache[config_game['gamerRank']['year']] = []

    ##增
    def addRecord(self,newBC):
        # newBC.id = newBC.save()
        # self._m_cache[newBC.id]=newBC
        # ## 返回一个新增user的id
        # return newBC.id
        return self.add(newBC)

    ## 查
    def getRecord(self,pk):
        return self.get(pk,Record)

    ## 改
    def uqdateRecord(self,pk,**kwargs):
        return self.update(pk,Record,**kwargs)

    ## 删
    def deleteRecord(self,pk):
        self.delete(pk,Record)

    ## 缓存
    def initCache(self):
        self.initDB('record',Record)
        #启动定时器，每日0点更新排名
        self.rankCacheAll()

    def rankCacheAll(self):
        self.rankCache({'timetype':config_game['gamerRank']['day'],'updateFlag':False})
        self.rankCache({'timetype':config_game['gamerRank']['week'],'updateFlag':False})
        self.rankCache({'timetype':config_game['gamerRank']['month'],'updateFlag':False})
        self.rankCache({'timetype':config_game['gamerRank']['year'],'updateFlag':False})

    ## 获取某个时间段排行,定时做排名更新
    def rankCache(self,args):
        timeType = args['timetype']
        updateFlag = args['updateFlag']
        if updateFlag:
           Dal_User().updateAllRankFlag(timeType)
        self.m_sortCache[timeType] = []
        self.m_sortOrginCache[timeType] = {}

        # timeStart = Utils().LastDayEndTime()#Utils().LastDayBeginTime()
        # timeEnd =timeStart + 86400
        timeStart =  Utils().LastDayBeginTime()
        timeEnd = Utils().LastDayEndTime()
        timeID = "rank"+str(timeType)
        timeDelta = Utils().TodayDeltaTime()
        self.m_timerMgr.delTimer(timeID) ##

        if timeType == config_game['gamerRank']['week']:
            timeStart = Utils().LastWeekBeginTime()
            timeEnd = Utils().LastWeekEndTime()
            timeDelta = Utils().WeekDeltaTime()
        elif timeType == config_game['gamerRank']['month']:
            timeStart = Utils().LastMonthBeginTime()
            timeEnd = Utils().LastMonthEndTime()
            timeDelta = Utils().MonthDeltaTime()
        elif timeType == config_game['gamerRank']['year']:
            timeStart = Utils().LastYearBeginTime()
            timeEnd = Utils().LastYearEndTime()
            timeDelta = Utils().YearDeltaTime()

        args = {'timetype':timeType,'updateFlag':True}
        self.m_timerMgr.addTimer(timeID,self.rankCache,timeDelta,args)

        for id,rd in  self._m_cache.iteritems():
             timeNum = Utils().dbTime2Number(rd.time)
             if timeNum < timeStart or timeNum > timeEnd:#不在时间范围
                 continue
             gamerList = rd.gamers.split(';')
             for substr in gamerList:# id:wincount-score
                 infoList = substr.split(':')
                 gID = infoList[0]
                 ws = infoList[1]
                 wsList = ws.split(',')
                 winCount = (int)(wsList[0])
                 score = (int)(wsList[1]) + config_game['initScore']
                 if  self.m_sortOrginCache[timeType].has_key(gID):
                     ra = self.m_sortOrginCache[timeType][gID]
                     ra.m_nWinCount = ra.m_nWinCount + winCount
                     ra.m_nScore = ra.m_nScore + score
                 else:
                     newRA =  RecordAssist()
                     newRA.m_nID = gID
                     newRA.m_nWinCount = winCount
                     newRA.m_nScore = score
                     self.m_sortOrginCache[timeType][gID] = newRA


        tempList = list(self.m_sortOrginCache[timeType].values())
        self.m_sortCache[timeType] = sorted(tempList)


    def getRankCache(self):
         return  self.m_sortCache

    def getRankData(self,gID,timeType):
        if self.m_sortOrginCache[timeType].has_key(gID):
            return   self.m_sortOrginCache[timeType][gID]
        return None

    def getRankOrder(self,gID,timeType):
        rankList = self.m_sortCache[timeType]
        rank = -1
        for k,v in enumerate(rankList):
            uid = int(v.m_nID)
            if uid < 0 :continue
            rank = rank + 1
            if v.m_nID == str(gID):
                return rank
        return -1

    def getRankAward(self,rankOrder,timeType):
        rankAwardConfigList = config_game['gamerRankAwards'][timeType]
        for k,raConfig in enumerate(rankAwardConfigList):
            min = (int)(raConfig['min'])
            max = (int)(raConfig['max'])
            if rankOrder>= min and rankOrder<=max:
                return raConfig
        return None

