#coding=utf-8
import math

from configs.config_default import configs_default
from dal.dal_admin import Dal_Admin
from dal.dal_user import Dal_User
from dal.dal_delegate import Dal_Delegate
from dal.dal_operate import Dal_Operate
from dal.dal_recharge import Dal_Recharge
from model.recharge import Recharge
from model.user import User
from model.delegate import Delegate
from model.admin import Admin
from model.operate import Operate
from handlers.BaseHandler import BaseHandler
from configs.config_error import config_error
from tools.utils import Utils


class AmminBaseHandler(BaseHandler):

    # 验证权限  超级管理员
    def IsSuperadmin(self,post):
        respon = None
        Admin = Dal_Admin().getAdminuser(post["Aid"])
        if Admin != None:  # admin是否存在
            if Admin["admin"] <= configs_default['adminRights']['Superadmin'] and  Admin["admin"] >0:
                if post["token"] == Admin["token"]:
                    respon = None
                else:
                    respon = {
                        'errorcode': config_error['loginExpires'],  # 登录超时
                    }
            else:
                respon = {
                    'errorcode': config_error['adminRights'],  # 没有权限
                }
        else:
            respon = {
                'errorcode': config_error['userinvaild'],  # 管理员不存在
            }
        return respon

    def IsSubadmin(self,post):
        Admin = Dal_Admin().getAdminuser(post["Aid"])
        if Admin != None:  # admin是否存在
            if Admin["admin"] <= configs_default['adminRights']['Subadmin'] and  Admin["admin"] >0:
                if post["token"] == Admin["token"]:
                    respon = None
                else:
                    respon = {
                        'errorcode': config_error['loginExpires'],  # 登录超时
                    }
            else:
                respon = {
                    'errorcode': config_error['adminRights'],  # 没有权限
                }
        else:
            respon = {
                'errorcode': config_error['userinvaild'],  # 管理员不存在
            }
        return respon
    # 验证三级管理员权限
    def IsSub3admin(self,post):
        Admin = Dal_Admin().getAdminuser(post["Aid"])
        if Admin != None:  # admin是否存在
            if Admin["admin"] <= configs_default['adminRights']['Sub3admin'] and  Admin["admin"] >0:
                if post["token"] == Admin["token"]:
                    respon = None
                else:
                    respon = {
                        'errorcode': config_error['loginExpires'],  # 登录超时
                    }
            else:
                respon = {
                    'errorcode': config_error['adminRights'],  # 没有权限
                }
        else:
            respon = {
                'errorcode': config_error['userinvaild'],  # 管理员不存在
            }
        return respon

# 获取分页  post_data 前端传入数据；list_id 分页数据
    # return respon；r_list
    #  respon 返回给前端的数据，
    # r_list 返回分页后的数据
    def GetPaging(self,post_data,list_id,one_page_num):
        r_list = []
        respon = None
        page = int(post_data['page'])
        # state = 0 查询所有用户  state
        all_num = float(len(list_id))
        all_page = math.ceil(all_num / one_page_num)
        if all_num == 0:
            respon = {
                'errorcode': config_error['success'],
                'pageCount': 0,
            }
            return respon,r_list ,all_page

        if all_page !=0:
            if (page > all_page or page <= 0) :
                respon = {
                    'errorcode': config_error['pageNonexistent'], #不存在当前页
                    'pageCount': all_page
                }
            else:
                r_list = Utils().GetPaging(page,one_page_num,list_id)

        return respon , r_list ,all_page

    # 处理不同代理查询状态并分页的返回
    def GetDeleResultData(self, post_data, list_id):
        Aid = post_data["Aid"]
        result_data = {}
        item = 0
        one_page_num = configs_default['onePageNum']
        respon, r_list, all_page = self.GetPaging(post_data, list_id, one_page_num)
        if respon == None and r_list != []:
            # 根据代理id得到每一个user
            for k in r_list:
                # 根据代理id得到每一个代理
                delegater = Dal_Delegate().getDelegate(k)
                if delegater == None:
                    continue
                result_data[item] = {}
                user = Dal_User().getUser(k)
                result_data[item]['account'] = user.account
                result_data[item]['did'] = k
                result_data[item]['dgid'] = user.name
                result_data[item]['nick'] = user.nick
                result_data[item]['gender'] = user.gender
                result_data[item]['logintime'] = Utils().dateTime2String(user.logintime)
                result_data[item]['online'] = (Dal_User().getLoginer(k) != None)
                result_data[item]['money'] = user.money
                result_data[item]['totalmoney'] = user.totalmoney
                result_data[item]['rmb'] = user.totalrmb
                result_data[item]['awards'] = delegater.awards
                result_data[item]['shareawards'] = delegater.shareaward
                result_data[item]['newawards'] = delegater.newaward
                result_data[item]['levelawards'] = delegater.levelaward
                result_data[item]['actawards'] = delegater.actaward
                result_data[item]['dlevel'] = delegater.level
                result_data[item]['equipid'] = 0
                result_data[item]['parent'] = delegater.parent
                item += 1
            respon = {
                'pageCount': all_page,
                'errorcode': config_error['success'],
                'deleInfo': result_data,
            }
            #     更新操作
            operate = configs_default['adminOperate']['viewdele']
            Dal_Admin().addOperate(Aid, operate)
        return respon

 #处理玩家不同查询状态并分页的返回
    def GetResultData(self,post_data,list_id):
        Aid = post_data["Aid"]
        result_data = {}
        item =0
        one_page_num = configs_default['onePageNum']
        respon, r_list, all_page = self.GetPaging(post_data,list_id,one_page_num)
        if respon == None and r_list != []:
            # 根据代理id得到每一个user
            for k in r_list:
                # 根据代理id得到每一个代理
                # user = Dal_User().get()
                user = Dal_User().get(k, User)
                if user == None:
                    continue
                k = int(k)
                result_data[item] = {}
                result_data[item]['room'] =(user['room'] !="")
                result_data[item]['gid'] = user.id
                result_data[item]['ggid'] = user.name
                result_data[item]['nick'] = user.nick
                result_data[item]['gender'] = user.gender
                result_data[item]['logintime'] = Utils().dateTime2String(user.logintime)
                result_data[item]['online'] = (Dal_User().getLoginer(k))
                result_data[item]['money'] = user.money
                result_data[item]['gold'] = user.gold
                result_data[item]['rmb'] = user.totalrmb
                result_data[item]['equipid'] = 0
                result_data[item]['source'] = "默认"
                result_data[item]['canKick'] = (user.room != '')
                result_data[item]['canForbid'] = (user.gamestate != configs_default['gameState']['forbid'])
                item +=1
            respon = {
                'pageCount': all_page,
                'errorcode': config_error['success'],
                'userInfo': result_data,
            }
            #     更新操作
            operate = configs_default['adminOperate']['viewplayer']
            Dal_Admin().addOperate(Aid, operate)
        return respon

    #处理管理员分页的返回
    def GetResultAdmin(self,post_data,list_id):
        Aid = post_data["Aid"]
        result_data = {}
        item =0
        one_page_num = configs_default['onePageNum']
        respon, r_list, all_page = self.GetPaging(post_data,list_id,one_page_num)
        if respon == None and r_list != []:
            # 根据id得到每个操作记录
            for k in r_list:
                # 根据id得到每个操作记录
                operate = Dal_Operate().get(k,Operate)
                if operate == None:
                    continue
                aid = operate.aid
                # 通过aid找到管理员
                Admin = Dal_Admin().getAdminuser(aid)
                if Admin ==None:
                    continue
                result_data[item] = {}
                result_data[item]['nickname'] =Admin.nickname
                result_data[item]['id'] = Admin.id
                result_data[item]['admin'] = Admin.admin
                result_data[item]['type'] = Admin.type
                result_data[item]['operate'] = operate.operate
                item +=1
                respon = {
                    'pageCount': all_page,
                    'errorcode': config_error['success'],
                    'adminInfo': result_data,
                }
                #     更新操作
                operate = configs_default['adminOperate']['operateView']
                Dal_Admin().addOperate(Aid, operate)

        return respon

        # 处理充值记录分页的返回
    def GetResultRecharge(self, post_data, list_id):
        Aid = post_data["Aid"]
        result_data = {}
        item = 0
        one_page_num = configs_default['pageNum']
        respon, r_list, all_page = self.GetPaging(post_data, list_id, one_page_num)
        if respon == None and r_list != []:
            # 根据id得到每个操作记录
            for k in r_list:
                # 根据id得到每个充值记录
                recharge = Dal_Recharge().get(k, Recharge)
                if recharge == None:
                    continue
                uid = recharge.uid
                # 通过uid找到管理员
                user = Dal_User().getUser(uid)
                if user == None:
                    continue
                #判断充值类型得充值的用户
                result_data[item] = {}
                if recharge.fromc ==configs_default['rechargeType']['normal'] or recharge.fromc ==configs_default['rechargeType']['iphoto']:
                    result_data[item]['uid'] = uid
                else:
                    result_data[item]['uid'] = recharge.good

                result_data[item]['ordernum'] = recharge.id
                result_data[item]['account'] = user.account
                result_data[item]['identifier'] = user.name
                result_data[item]['type'] = recharge.fromc
                result_data[item]['time'] = Utils().dateTime2String(recharge.time)
                result_data[item]['money'] = recharge.money
                item += 1
                respon = {
                    'pageCount': all_page,
                    'errorcode': config_error['success'],
                    'adminInfo': result_data,
                }
                #     更新操作
                operate = configs_default['adminOperate']['operateView']
                Dal_Admin().addOperate(Aid, operate)

        return respon




