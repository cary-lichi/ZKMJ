#-*-coding:utf-8-*-
'''
对应的是user表
'''
from orm.orm import Model,IntegerField,StringField,FloatField

## 充值记录类
class CZTime(Model):
    __table__='cztime'
    __primary_key__='time'

    time=StringField('time',True)
