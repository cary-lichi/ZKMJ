#coding=utf-8
from orm.orm import Model,IntegerField,StringField,FloatField
class Admin(Model):
    __table__ = 'Admin'
    __primary_key__ = 'id'

    id = IntegerField("id",True)
    nickname = StringField("nickname",True)
    userName = StringField("userName",True)
    passWord = StringField("passWord",True)
    token = StringField("token",True)
    admin = IntegerField("admin",True)
    type = StringField("type",True)