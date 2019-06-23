# -*-coding:utf-8-*-
from orm.orm import Model,IntegerField,StringField,FloatField
from tools.utils import Utils

## 定义一个类
class Operate(Model):
    __table__='operate'
    __primary_key__='id'

    id = IntegerField('id',True) #操作id
    aid = IntegerField('aid',True)#谁操作的
    operate = StringField('operate',True) # 操作类型
    time=StringField('time',True)#时间
