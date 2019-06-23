#-*-coding:utf-8-*-
from handlers.admin.adminChangeDInfoHandler import AdminChangeDInfoHandler
from handlers.admin.adminLoginHeartHandler import AdminLoginHeartHandler
from handlers.admin.adminOutloginHandler import AdminOutLoginHandlder
from handlers.admin.adminRechargeHandler import AdminRechargeHandler
from handlers.admin.adminRegSubadminHandler import AdminRegSubadminHandler
from handlers.admin.adminSearchUserHandler import AdminSearchUserHandler
from handlers.appleBuyHandler import AppleBuyHandler
from handlers.delegate.deleGetChildrenHandler import DeleGetChildrenHandler
from handlers.delegate.deleLoginHandler import DeleLoginHandler
from handlers.delegate.deleRechargeHandler import DeleRechargeHandler
from handlers.delegate.deleCreateRoomHandler import DeleCreateRoomHandler
from handlers.indexHandler import IndexHandlers
from handlers.gameHandler import GameHandler
from handlers.mailsHandler import MailsHandler
from handlers.rankAwardHandler import RankAwardHandler
from handlers.rankHandler import RankHandler
from handlers.registerHandler import RegisterHandler
from handlers.loginHandler import LoginHandler
from handlers.loginOutHandler import LoginOutHandler
from handlers.loginWXHandler import LoginWXHandler
from handlers.rechargeHandler import RechargeHandler
from handlers.exchangeHandler import ExchangeHandler
from handlers.buyHandler import BuyHandler
from handlers.rookieHandler import RookieHandler
from handlers.irookieHandler import IRookieHandler
from handlers.irookieShowHandler import IRookieShowHandler
from handlers.loginHeartHandler import LoginHeartHandler
from handlers.clientLogHandler import ClientLogHandler
from handlers.payResultWXHandler import PayResultWXHandler
from handlers.luckyHandler import LuckyHandler
from handlers.welfareHandler import WelfareHandler
from handlers.admin.adminBanGamerHandler import AdminBanGamerHandler
from handlers.admin.adminGetDelegateHandler import AdminGetDelegateHandler
from handlers.admin.adminGetUserHandler import AdminGetUserHandler
from handlers.admin.adminKickGamerHandler import AdminKickGamerHandler
from handlers.shareHandler import ShareHandler
from handlers.admin.adminLoginHandler import AdminLoginHandler
from handlers.delegate.deleWxLoginHandler import DeleWxLoginHandler
from handlers.admin.adminSearchDelegateHandler import AdminSearchDelegateHandler
from handlers.admin.adminGetadminHandler import AdminGetadminHandler
from handlers.admin.adminRechargeInfoHandler import AdminRechargeInfoHandler
from handlers.delegate.deleChangePasswordHandler import DeleChangePasswordHandler
from handlers.delegate.deleAddChildrenHandler import DeleAddChildrenHandler
from handlers.delegate.deleGetdeleHandler import DeleGetdeleHandler
from handlers.delegate.deleGetRechatgeInfoHandler import DeleGetRechatgeInfoHandler
from handlers.delegate.deleDelChildrenHandler import DeleDelChildrenHandler


urls= {
    (r"/index", IndexHandlers),
    (r"/game", GameHandler),
    (r"/reg", RegisterHandler),
    (r"/login", LoginHandler),
    (r"/loginout", LoginOutHandler),
    (r"/loginWX", LoginWXHandler),
    (r"/recharge", RechargeHandler),
    (r"/exchange", ExchangeHandler),
    (r"/buy", BuyHandler),
    (r"/applebuy", AppleBuyHandler),
    (r"/rookie", RookieHandler),
    (r"/irookie", IRookieHandler),
    (r"/irookieshow", IRookieShowHandler),
    (r"/loginheart", LoginHeartHandler),
    (r"/clientlog", ClientLogHandler),
    (r"/payResultWX", PayResultWXHandler),
    (r"/lucky", LuckyHandler),
    (r"/welfare", WelfareHandler),
    (r"/rank", RankHandler),
    (r"/rankAward", RankAwardHandler),
    (r"/share", ShareHandler),
    (r"/mail", MailsHandler),
    (r"/adminGetUser", AdminGetUserHandler),
    (r"/adminGetDelegate", AdminGetDelegateHandler),
    (r"/adminBanGamer", AdminBanGamerHandler),
    (r"/adminKickGamer", AdminKickGamerHandler),
    (r"/adminChangeDInfo", AdminChangeDInfoHandler),
    (r"/adminRecharge", AdminRechargeHandler),
    (r"/adminSearch", AdminSearchUserHandler),
    (r"/deleLogin", DeleLoginHandler),
    (r"/deleRecharge", DeleRechargeHandler),
    (r"/deleGetChildren", DeleGetChildrenHandler),
    (r"/deleCreateRoom", DeleCreateRoomHandler),
    (r"/adminLogin", AdminLoginHandler),
    (r"/adminRegSubadmin", AdminRegSubadminHandler),
    (r"/adminLoginHeart",AdminLoginHeartHandler),
    (r"/adminOutLogin",AdminOutLoginHandlder),
    (r"/deleWxLogin",DeleWxLoginHandler),
    (r"/adminSearchDelegate",AdminSearchDelegateHandler),
    (r"/adminGetadmin",AdminGetadminHandler),
    (r"/adminRechargeInfo",AdminRechargeInfoHandler),
    (r"/deleChangePassword",DeleChangePasswordHandler),
    (r"/deleAddChildren",DeleAddChildrenHandler),
    (r"/deleGetdele",DeleGetdeleHandler),
    (r"/deleGetRechatgeInfo",DeleGetRechatgeInfoHandler),
    (r"/deleDelChildren",DeleDelChildrenHandler),

}