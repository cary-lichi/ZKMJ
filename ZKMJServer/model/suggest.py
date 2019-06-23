#-*-coding:utf-8-*-
'''
对应的是user表
'''
from orm.orm import Model,IntegerField,StringField,FloatField

## 建议类
class Suggest(Model):
    __table__='suggest'
    __primary_key__='id'

    id=IntegerField('id',False)
    detail=StringField('detail',True)
    phone=StringField('phone',True)
    time=IntegerField('time',True)