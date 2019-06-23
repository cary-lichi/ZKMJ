#-*-coding:utf-8-*-
'''
对应的是user表
'''
from orm.orm import Model,IntegerField,StringField,FloatField

## 充值记录类
class Recharge(Model):
    __table__='recharge'
    __primary_key__='id'

    id=IntegerField('id',False)
    time=IntegerField('time',True)
    money=IntegerField('money',True)
    uid=IntegerField('uid',True)
    good=StringField('good',True)
    count=IntegerField('count',True)
    fromc=IntegerField('fromc',True)