#-*-coding:utf-8
'''
配置文件 
'''

configs_default={
    'db':{
        'host':'127.0.0.1',
        'port':3306,
        'user':'root',
        'passwd':'root',
        'db':'mj_game',
        'charset':'utf8',
    },
    'goodType': {
        'card': 0,#'房卡',
        'money': 1,# '钻石',
        'gold': 2#'金币'
    },
    'goods': {
        "0": {"desc": "欢乐房卡（1局）", "type": 0, "gold": 500, "money": 0,"rmb":0, "extra": 100000},
        "1": {"desc": "4局","type":0, "gold": 0, "money":2,"rmb":0,"extra":4},
        "2": {"desc": "8局", "type": 0, "gold": 0, "money": 3,"rmb":0,"extra":8},
        "3": {"desc": "12局", "type": 0, "gold": 0, "money": 4,"rmb":0,"extra":12},
        "4": {"desc": "6钻石","type":1, "gold": 0, "money":0,"rmb":6,"extra":6},
        "5": {"desc": "19钻石", "type": 1, "gold": 0, "money": 0,"rmb":18,"extra":19},
        "6": {"desc": "32钻石", "type": 1, "gold": 0, "money": 0,"rmb":30,"extra":32},
        "7": {"desc": "65钻石", "type": 1, "gold": 0, "money": 0,"rmb":60,"extra":65},
        "8": {"desc": "100钻石", "type": 1, "gold": 0, "money": 0,"rmb":93,"extra":100},
        "9": {"desc": "200钻石", "type": 1, "gold": 0, "money": 0,"rmb":178,"extra":200},
        "10": {"desc": "12000金币", "type": 2, "gold": 0, "money": 1, "rmb": 0, "extra": 12000},
        "11": {"desc": "25000金币", "type": 2, "gold": 0, "money": 2, "rmb": 0, "extra": 25000},
        "12": {"desc": "60000金币", "type": 2, "gold": 0, "money": 5, "rmb": 0, "extra": 60000},
        "13": {"desc": "28万金币", "type": 2, "gold": 0, "money": 20, "rmb": 0, "extra": 280000},
        "14": {"desc": "50万金币", "type": 2, "gold": 0, "money": 65, "rmb": 0, "extra": 500000},
        "15": {"desc": "150万金币", "type": 2, "gold": 0, "money": 100, "rmb": 0, "extra": 1500000}
    },
    'loginTimeOut':20,
    'luckys':[
        {"desc": "200金币", "type": 2, "extra": 200},
        {"desc": "2000金币", "type": 2, "extra": 2000},
        {"desc": "4000金币", "type": 2, "extra": 4000},
        {"desc": "8800金币", "type": 2, "extra": 8800},
        {"desc": "28000金币", "type": 2, "extra": 28000},
        {"desc": "66000金币", "type": 2, "extra": 66000},
        {"desc": "88000金币", "type": 2, "extra": 88000},
        {"desc": "10钻", "type": 1, "extra": 10},
        {"desc": "60钻", "type": 1, "extra": 60}
    ],
    'luckysRate': [0,990000,990000,1000,0,0,0,10,1],
    'welfare':4000,
    'delegateServerHost':'127.0.0.1',
    'delegateServerPort': '8100',
    'gameState': {
        'normal': 0,  # 正常,
        'forbid': 1,  # 被封禁,
    },
    'onePageNum':10,
    'delegate':{
        'payAwards':{
            '0': 0,
            '1': 0,
            '2': 0.2,
            '3': 0.1
        }
    },
    'shareAward':3,
    'actAward':{
        'share': 2,
        'office5':5,
        'office10': 10,
        'officermb': -1
    },
    'actAwardType': {
        'post': -2,#已经领过
        'invalid':-1,#无奖励
        'share':0,#分享进入
        'office5': 1,#刮刮乐5钻
        'office10': 2,#刮刮乐10钻
        'officermb': 3,#刮刮乐0.5元
    },
    'mail': {#邮件相关
        'type': {
            'shareaward':1,#分享奖励
            'deleparentaward': 2,  # 代理充值对上级奖励
            'luckyaward': 3,  # 幸运大转盘奖励
            'gglaward': 4,  # 刮刮乐奖励
            'rookieaward': 5,  #新人奖励
            'adminward':6, #管理员后台发送
        }
    },
    'userState':{
            'all':0, #所有数据表中用户
            'online':1, #只查询在线用户
            'outline':2, #只查询离线用户
            'firstDele':3,  #只查询一级代理用户
            'secondDele':4, #只查询二级代理用户
            'threeDele':5,  #只查询三级代理用户
        },
    'logState':{
        'PaymentLog':0, #支付日志
        'RankingsLog':1,    #排行榜日志
        'MasonryLogs':2,    #砖石日志
        'InternalLog':3,    #内部操作日志
        'PlayerLog':4   #玩家日志
    },
    'adminRights': # 越小权限越高
        {
            'Superadmin':1, #超级管理员  一级 所有权限 代理管理 账号管理 玩家管理 订单查询 日志查询 公告发布 邮件发布 广播管理
            'Subadmin':2,   #子管理员   二级  玩家管理 订单查询 日志查询 公告发布 邮件发布 广播管理
            'Sub3admin':3    #子管理    三级  订单查询 日志查询 公告发布 邮件发布 广播管理
        },
    'deleLevel':
        {
            'gamer':0, #普通玩家
            'firstLevel':1,  #一级代理用户
            'secondLevel':2, #二级代理用户
            'threeLevel':3,  #三级代理用户
        },
    'delePassword':
        {
            'default':"123456", #代理的默认密码
        },
    'adminOperate':{
        'viewplayer':1,#查看玩家
        'viewdele':2,#查看代理
        'upgradedele':3,#升级代理
        'banGamer':4,#封禁玩家
        'kickGamer':5,#提出玩家
        'recharge':6,#充值
        'vieworder':7,#订单查询
        'logquery':8,#日志查询
        'announcement':9,#公告发布
        'sendMail':10,#邮件发送
        'regSubadmin':11,#创建子管理
        'operateView':12,#账号操作查看
    },
    'pageNum':20,
    'rechargeType':{
        'normal':0,#正常充值
        'iphoto':1,#苹果充值
        'admin':2,#后台管理员充值
        'delegate':3,#代理后台充值
    }


}