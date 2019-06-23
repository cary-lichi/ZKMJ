# -*-coding:utf-8-*-
from orm.orm import Model,IntegerField,StringField,FloatField
from tools.utils import Utils

## 定义一个类
class Delegate(Model):
    __table__='delegate'
    __primary_key__='id'

    id = IntegerField('id',True) #代理id,就是玩家的id
    logintime = StringField('logintime',True)  # 登录时间
    awards = IntegerField('awards',True)
    shareaward = IntegerField('shareaward',True) # 分享奖励
    newaward = IntegerField('newaward',True) # 新人奖励
    levelaward = IntegerField('levelaward',True) # 分级活动奖励
    actaward = IntegerField('actaward',True) # 活动奖励
    level = IntegerField('level',True) # 代理权限 0 表示普通玩家 1,2,3分别代表1,2,3级代理
    slevel = IntegerField('slevel',True) # 原始代理级别(初创代理的时候)
    parent = IntegerField('parent',True) # 推荐上级代理id
    parentslevel = IntegerField('parentslevel',True) # 推荐上级代理原始级别
    children = StringField('children',True)  # 下级代理
    icode=StringField('icode',True)#邀请码
