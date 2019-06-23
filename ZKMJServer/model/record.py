#-*-coding:utf-8-*-
'''
对应的是user表
'''
from orm.orm import Model,IntegerField,StringField,FloatField

## 对局记录类
class Record(Model):
    __table__='record'
    __primary_key__='id'

    id=IntegerField('id',False)
    time=IntegerField('time',True)
    gameplay=StringField('gameplay',True)
    gamers=StringField('gamers',True)