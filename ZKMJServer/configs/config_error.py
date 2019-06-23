#-*-coding:utf-8-*-
'''
统计所有错误的可能性
'''
config_error={
    'success':0,
    'userinvaild':1,# 无效的用户
    'pwderror':2, #密码错误
    'moneyerror':3 ,#金币不足
    'notrookie': 4,  # 领过新手奖励了
    'roominvalid': 5,  # 房间无效
    'roomfull': 6,  # 房间已满
    'userrepeated': 7,  # 重复的玩家
    'autherror': 8,  # 实名验证失败
    'bossleft': 9,  # 房主离线，请稍后再加入
    'userlogined': 10,  # 用户已经登录
    'roomstateerror': 11,  # 房间状态错误
    'notroomowner': 12,  # 不是房主
    'alreadyinroom': 13,  # 当前已经在房间里了
    'notinroom': 14,  # 当前不在房间里
    'readyed': 15,  # 当前已经准备过了
    'luckytimeerror': 16,  # 大转盘时间错误
    'welfareerror': 17,  # 救济金领取条件错误
    'rankawarderror': 18,  # 排行奖励领取条件错误
    'userforbid':19,# 用户被封禁
    'delegateinvaid':20,# 代理用户无效
    'idlistisnull':21,
    'sharetimeerror': 22,  # 分享时间错误
    'dlevelerror': 23,  # 代理等级错误
    'applepayerror': 24,  # 苹果支付错误
    'delepayforothererror': 25,  # 代理为下级充值错误
    'pageNonexistent':26, #不存在当前页
    'loginExpires':27, #登录超时
    'adminRights':28, #没有权限
    'noRecord':29,#不存在记录
}