#coding:utf-8

import json
import traceback

import tornado.web
import time
from datetime import datetime
import os

from configs.config_default import configs_default
from model.suggest import Suggest
from dal.dal_record import Dal_Record
from dal.dal_user import Dal_User
from configs.config_error import config_error
from configs.config_game import config_game
from tools.utils import Utils
from handlers.BaseHandler import BaseHandler
from protobuf import msg_pb2

class RankHandler(BaseHandler):
    def post(self):
        try:
            msgReq = msg_pb2.Msg()
            msgReq.ParseFromString(self.request.body)

            msgResp = msg_pb2.Msg()
            msgResp.type = msg_pb2.EnumMsg.Value('rankresponse')
            user = Dal_User().getUser(msgReq.request.rankRequest.nUserID)
            if user == None:
                msgResp.response.rankResponse.nErrorCode = config_error['userinvaild']
            else:
                msgResp.response.rankResponse.nErrorCode = config_error['success']
                #这里取排名
                rankCache = Dal_Record().getRankCache()
                for k,rankList in rankCache.iteritems():
                    index = 0
                    respRD = None
                    if k == config_game['gamerRank']['day']:
                        respRD = msgResp.response.rankResponse.rankDayRecords
                    elif k == config_game['gamerRank']['week']:
                        respRD = msgResp.response.rankResponse.rankWeekRecords
                    elif k == config_game['gamerRank']['month']:
                        respRD = msgResp.response.rankResponse.rankMonthRecords
                    elif k == config_game['gamerRank']['year']:
                        respRD = msgResp.response.rankResponse.rankYearRecords

                    rd = Dal_Record().getRankData(user.id,k)
                    if rd:
                        respRD.rankRequster.nWinCount = (int)(rd.m_nWinCount)
                        respRD.rankRequster.nScore = (int)(rd.m_nScore)
                    else:
                        respRD.rankRequster.nWinCount = 0
                        respRD.rankRequster.nScore = 0
                    respRD.rankRequster.nUserID = (int)(user.id)
                    rankUser = Dal_User().getUser(user.id)
                    respRD.rankRequster.sName = rankUser.nick
                    respRD.rankRequster.sHeadimg = rankUser.headimg
                    respRD.rankRequster.nRank =  Dal_Record().getRankOrder(user.id,k)
                    respRD.rankRequster.bCanAward =  not Dal_User().getRankedFlag(user.id,k)

                    for rank,rd in enumerate(rankList):
                        index = index + 1
                        if index > config_game['gamerRankCount']:break
                        uid = (int)(rd.m_nID)
                        if uid<0:continue
                        respRDCell = respRD.rankRecords.add()
                        respRDCell.nUserID = (int)(rd.m_nID)
                        respRDCell.nWinCount = (int)(rd.m_nWinCount)
                        respRDCell.nScore = (int)(rd.m_nScore)
                        rankUser = Dal_User().getUser(respRDCell.nUserID)
                        respRDCell.sName =   rankUser.nick
                        respRDCell.sHeadimg = rankUser.headimg
                        rankAwardConfig = Dal_Record().getRankAward(rank+1, k)
                        if rankAwardConfig:
                            respRDCell.nRankAwardType = rankAwardConfig['aType']
                            respRDCell.nRankAward = rankAwardConfig['award']

            dataR = msgResp.SerializeToString()
            self.write(dataR)
        except Exception, e:
            msg = traceback.format_exc()  # 方式1
            Utils().logMainDebug(msg)

