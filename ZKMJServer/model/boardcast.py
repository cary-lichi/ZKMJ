#-*-coding:utf-8-*-
'''
对应的是user表
'''
from orm.orm import Model,IntegerField,StringField,FloatField


## 公告类
class BoardCast(Model):
    __table__='boardcast'
    __primary_key__='id'

    id=IntegerField('id',False)
    title=StringField('title',True)
    detail=StringField('detail',True)
    icon=StringField('icon',True)
    url=StringField('url',True)
    time=StringField('time',True)