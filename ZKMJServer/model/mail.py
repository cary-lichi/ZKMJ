# -*-coding:utf-8-*-
from orm.orm import Model,IntegerField,StringField,FloatField
from tools.utils import Utils

## 定义一个类
class Mail(Model):
    __table__='mail'
    __primary_key__='id'

    id = IntegerField('id',False) #邮件id
    uid = IntegerField('uid',True)#谁的邮件
    type = IntegerField('type',True) # 邮件类型
    content = StringField('content',True)  # 邮件内容
    time=StringField('time',True)#时间
