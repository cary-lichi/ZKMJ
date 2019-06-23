#-*-coding:utf-8-*-
'''
对应的是user表
'''
from orm.orm import Model,IntegerField,StringField,FloatField
from tools.utils import Utils

## 定义一个类
class User(Model):
    __table__='user'
    __primary_key__='id'

    id=IntegerField('id',False)
    name=StringField('name',True)
    account = StringField('account',True)
    password=StringField('password',True)
    dpassword = StringField('dpassword', True)
    nick=StringField('nick',True)
    exp=IntegerField('exp',True)
    gold=IntegerField('gold',True)
    money=IntegerField('money',True)
    headimg=StringField('headimg',True)
    phone=StringField('phone',True)
    records=StringField('records',True)
    assets=StringField('assets',True)
    room=StringField('room',True)
    invitetime = StringField('invitetime', True)
    vcode=StringField('vcode',True)
    sfz=StringField('sfz',True)
    realname=StringField('realname',True)
    luckytime = StringField('luckytime', True)
    welfaretime = StringField('welfaretime', True)
    gender = IntegerField('gender', True)
    rankaward = StringField('rankaward', True)
    logintime = StringField('logintime', True)
    gamestate = IntegerField('gamestate', True)
    totalmoney = IntegerField('totalmoney', True)
    totalrmb = IntegerField('totalrmb', True)
    sharetime = StringField('sharetime', True)
    wincount = IntegerField('wincount', True)
    totalcount = IntegerField('totalcount', True)
    mails = StringField('mails', True)
    actawards = StringField('actawards', True)