#-*-coding:utf-8-*-
'''
统计所有错误的可能性
'''
config_game={
    "gameplay": {#玩法基本结构，type=》房间类型，optionals=》选的玩法
        "type":{
            "common":1, #传统房间
            "hunzi":2, #混子房间
            "happy":3, #欢乐场房间

        },
        "optionals":
            {
                "zimo": 101,  # 自摸
                "dianpao": 102,  # 点炮
                "sfdh": 103,  # 煽风点火
                "cft": 104,  # 出风听
                "lsdy": 105,  # 亮四打一
                "tybb": 106,  # 偷赢不报
                "ybc": 107,  # 一把成
                "zhuang": 108,  # 庄翻倍
            },
    },
    'position': [  # 玩家位置
         0,  # 东：
         1,  # 南：
         2,  # 西：
         3  # 北：
    ],
    'maxGamer': 4,
    'MJ':{
        'MJPAI_ZFB':0, #中，发，白
        'MJPAI_FENG':1,#东西南北风
        'MJPAI_WAN':2,#万
        'MJPAI_TIAO':3,#条
        'MJPAI_BING':4,#饼
        'MJPAI_HUA':5,#花
        'MJPAI_GETPAI':True,#起牌
        'MJPAI_PUTPAI':False#打牌
    },
    "roomType": {
        "common": 1,
        "fangka": 2
    },
    "roomState": {
        "ready": 0,#未开始
        "doing": 1,#战斗进行中
        "ending": 2,#结算进行中
        "disable": 3,  # 禁入不可用
    },
    "putPaiState": {
        "normal": 0,  # 正常打牌
        "moting": 1,  # 摸听打牌
        "qiangting": 2,  # 抢听打牌
    },
    "gangState": {
        "an": 0,  # 暗杠
        "zmming": 1,  # 自摸明杠
        "ming": 2,  # 正常明杠
    },
    "initScore": 500,#初始每个玩家50分
    "rookieAward": {#新手奖励道具
        "1": 1,
        "2": 1
    },
    "rookieIAward": {  # 邀请者奖励道具
        "2": 2
    },
    "authAward": {  # 邀请者奖励道具
        "2": 2
    },
    "jieSuanState": {
        "zimo": 0,  # 结算类型，自摸
        "hupai": 1,  # 胡牌（别人点炮）
        "ting": 2,  # 听
        "tingpao": 3,  # 听点炮
        "unting": 4,  # 不听
        "untingpao": 5,  # 不听点炮
    },
    "canType": {  # can牌类型
        "zmhu": 1,
        "zmting": 2,
        "zmgang": 3,
        "other": 4
    },
    "canLastBaoType": {#can牌通知胡的类型
        "normal":0,
    },
    "gamerState": {#玩家游戏状态
        "ready": 0,  # 准备
        "doing": 1,  # 战斗进行中
        "ending": 2,  # 结算进行中
        "join": 3,  # 未开始
    },
    "gameAction":{ #玩家动作
        "standby":0, #待机中
        "geipai":1, #起牌
        "putpai":2, #打牌
        "canpai":3, #可以 吃碰杠听胡
    },
    "gamerRank": {  # 玩家排名类型
        "day": 0,  # 日
        "week": 1,  # 周
        "month": 2,  # 月
        "year": 3  # 年
    },
    "gamerRankCount": 100,
    "gamerRankAwards": [
         [
             {'min':1,'max':1,'award':10,'aType':1},
             {'min': 2, 'max': 2, 'award': 8, 'aType': 1},
             {'min': 3, 'max': 3, 'award': 6, 'aType': 1},
             {'min': 4, 'max': 10, 'award': 4, 'aType': 1},
             {'min': 11, 'max': 20, 'award': 2, 'aType': 1},
             {'min': 21, 'max': 50, 'award': 15000, 'aType': 2},
             {'min': 50, 'max': 100, 'award': 8800, 'aType': 2}
         ],
        [
            {'min': 1, 'max': 1, 'award': 50, 'aType': 1},
            {'min': 2, 'max': 2, 'award': 40, 'aType': 1},
            {'min': 3, 'max': 3, 'award': 30, 'aType': 1},
            {'min': 4, 'max': 10, 'award': 20, 'aType': 1},
            {'min': 11, 'max': 20, 'award': 10, 'aType': 1},
            {'min': 21, 'max': 50, 'award': 6, 'aType': 1},
            {'min': 50, 'max': 100, 'award': 60000, 'aType': 2}
        ],
        [
            {'min': 1, 'max': 1, 'award': 300, 'aType': 1},
            {'min': 2, 'max': 2, 'award': 240, 'aType': 1},
            {'min': 3, 'max': 3, 'award': 180, 'aType': 1},
            {'min': 4, 'max': 10, 'award': 120, 'aType': 1},
            {'min': 11, 'max': 20, 'award': 60, 'aType': 1},
            {'min': 21, 'max': 50, 'award': 36, 'aType': 1},
            {'min': 50, 'max': 100, 'award': 360000, 'aType': 2}
        ],
        [
            {'min': 1, 'max': 1, 'award': 300, 'aType': 1},
            {'min': 2, 'max': 2, 'award': 240, 'aType': 1},
            {'min': 3, 'max': 3, 'award': 180, 'aType': 1},
            {'min': 4, 'max': 10, 'award': 120, 'aType': 1},
            {'min': 11, 'max': 20, 'award': 60, 'aType': 1},
            {'min': 21, 'max': 50, 'award': 36, 'aType': 1},
            {'min': 50, 'max': 100, 'award': 360000, 'aType': 2}
        ]
    ],
    "timeout": 25,#出牌时间
    "timetick": 1000,
    "addAITime": 5000,#添加机器人倒计时毫秒
    "aiReadTime": 4000,#机器人准备倒计时毫秒
    "aiPutTime": 5000,#机器人出牌倒计时毫秒
    "readyTime": 40000,#准备倒计时毫秒
    "aiInfoCount": 24,
    "aiHeadCount": 10,
    "happyExchange": 500#欢乐城积分兑换
}