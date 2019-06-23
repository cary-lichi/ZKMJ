#-*-coding:utf-8-*-
'''
对应的是user表
'''
from orm.orm import Model,IntegerField,StringField,FloatField

## 活动类
class Activity(Model):
    __table__='activity'
    __primary_key__='id'

    id=IntegerField('id',False)
    title=StringField('title',True)
    detail=StringField('detail',True)
    icon=StringField('icon',True)
    url=StringField('url',True)
    time=IntegerField('time',True)