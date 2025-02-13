package config 
{
	/**
	 * ...
	 * @author ...
	 */
	public class ConfigGame 
	{
		public var m_Config:*;
		
		public function ConfigGame() 
		{
			m_Config ={
				"equipType":5,
				"equipName":
					{
						"0":"Web",
						"1":"android",
						"2":"iphone",
						"5":"test"
					},
				"equipEnum":
					{
						"Web":0,
						"Android":1,
						"IOS":2,
						"wxWeb":3,
						"wxMin":4,
						"test":5
					},
				"goodsType":
					{
						"roomCard":0,
						"diamonds":1,
						"gold":2
					},
				"goods": {
				"0": {"desc": "欢乐房卡（1局）","type": 0, "roundNum":1},
				"1": {"desc": "4局","type": 0, "roundNum": 4},  
				"2": {"desc": "8局", "type": 0, "roundNum": 8},
				"3": {"desc": "12局", "type": 0, "roundNum": 12},
				"4": {"desc": "6钻石", "type": 1, "money": 6, "num": 6, "text":6},
				"5": {"desc": "19钻石", "type": 1, "money": 18, "num": 19, "text":19},
				"6": {"desc": "32钻石", "type": 1, "money": 30, "num": 32, "text":32},
				"7": {"desc": "65钻石", "type": 1, "money": 60, "num": 65, "text":65},
				"8": {"desc": "100钻石", "type": 1, "money": 93, "num": 100, "text":100},
				"9": {"desc": "200钻石", "type": 1, "money": 178, "num": 200, "text":200},
				"10": {"desc": "12000金币", "type": 2, "money": 1, "num": 12000, "text":"1.2万"},
				"11": {"desc": "25000金币", "type": 2, "money": 2, "num": 25000, "text":"2.5万"},
				"12": {"desc": "60000金币", "type": 2, "money": 5, "num": 60000, "text":"6万"},
				"13": {"desc": "28万金币", "type": 2, "money": 20, "num": 280000, "text":"28万"},
				"14": {"desc": "50万金币", "type": 2, "money": 65, "num": 500000, "text":"50万"},
				"15": {"desc": "150万金币", "type": 2, "money": 100, "num": 1500000, "text":"150万"}},
				"Recommend":
					{
						"Gold":10,
						"Card":4
					},
				"cardType":
					{
						"happyRoom":0,
						"vipRoom4":1,
						"vipRoom8":2,
						"vipRoom12":3
					},
				"roomType":
					{
						"common":1,
						"hunzi":2,
						"happy":3
					},
				"gamePlay":
					{
						"zimo": 101,  
						"dianpao": 102,
						"sfdh": 103,  
						"cft": 104,  
						"lsdy": 105, 
						"tybb": 106, 
						"ybc": 107,  
						"zhuang":108,
						"daihun":109
					},
				"gamePlayName":
					{
						"101":"不摸不赢",
						"102":"一炮多响",
						"103":"煽风点火",
						"104":"出风听 ",
						"105":"亮四打一 ",
						"106":"偷赢不报 ",
						"107":"一把成 ",
						"108":"庄翻倍 ",
						"109":"带混子 " 
					},
				"hupaiType":
					{
						"0":"自摸",
						"1":"胡牌",
						"2":"听牌",
						"3":"听牌 点炮",
						"4":"未听牌",
						"5":"未听牌 点炮",
						"6":"摸宝",
						"7":"宝中宝",
						"8":"刮大风"
					},
				"prize":
					{
						"0": {"desc": "200金币",  "type": "ma", "title": "200" },  
						"1": {"desc": "2000金币",  "type": "ma", "title": "2000" },  
						"2": {"desc": "4000金币",  "type": "ma", "title": "4000" },
						"3": {"desc": "8800金币",  "type": "ma", "title": "8800" },
						"4": {"desc": "28000金币", "type": "ma", "title": "28000" },
						"5": {"desc": "66000金币",  "type": "ma", "title": "66000" },
						"6": {"desc": "88000金币",   "type": "ma", "title": "88000" },
						"7": {"desc": "10钻",  "type": "diamonds", "title": "10钻" },
						"8": {"desc": "60钻", "type": "diamonds", "title": "60钻" }
					},
				"nPos":
					{
						"BottoPos":0,
						"LeftPos":1,
						"TopPos": 2,
						"RightPos":3
					},
				"poolType":
					{
						"agang":0,
						"chi":1,
						"mgang":2,
						"peng":3,
						"pai":4,
						"put":5,
						"tan":6
					},
				"soundType":
					{
						"chi":"chi",
						"gang":"gang",
						"peng":"peng",
						"hu":"hu",
						"zimo":"zimo",
						"loss":"loss",
						"win":"win",
						"putPaiDown":"putPaiDown",
						"gameStar":"gameStar",
						"ting":"ting",
						"clock":"clock"
					},
				"canPaiAnmiType":
					{
						"chi":"chi",
						"peng":"peng",
						"gang":"gang",
						"ting":"ting",
						"hu":"hu"
					},
				"PutState":
					{
						"putpai":0,
						"moting":1,
						"qiangting":2
					},
				"GuoType":
					{
						"ziMo":1,
						"moTing":2,
						"moGang":3,
						"canPai":4
					},
				"GangType":
					{
						"AnGang":0,
						"MoGang":1,
						"MiGang":2
					},
				"lastHuType":
					{
						"bao":1,
						"feng":2
					},
				"gameState":
					{
						"readyed":0,
						"playing":1,
						"over":2,
						"join":3
					},
				"roomState":
					{
						"readyed":0,
						"playing":1,
						"over":2
					},
				"nErrorCode":
					{
						"success":0,
						"userinvaild":1,
						"pwderror":2,
						"moneyerror":3 ,
						"notrookie": 4,
						"roominvalid": 5,
						"roomfull": 6,
						"userrepeated": 7,
						"autherror": 8,
						"bossleft": 9,
						"userlogined": 10,
						"roomstateerror": 11,
						"notroomowner": 12,
						"alreadyinroom": 13,
						"notinroom": 14,
						"readyed": 15,
						"luckytimeerror": 16,
						"welfareerror": 17,
						"rankawarderror": 18,
						"userforbid":19,
						"delegateinvaid":20,
						"idlistisnull":21,
						"sharetimeerror": 22,
						"dlevelerror": 23,
						"applepayerror": 24,
						"delepayforothererror": 25,
						"pageNonexistent":26,
						"loginExpires":27
					},
				"aiInfo":
					{
						"备注":{"desc":"未知","gender":"0"},
						"0":{"desc":"男","gender":"1","nick":"心中日月"},
						"1":{"desc":"女","gender":"2","nick":"宝妈"},
						"2":{"desc":"男","gender":"1","nick":"拾光"},
						"3":{"desc":"女","gender":"2","nick":"单紫言"},
						"4":{"desc":"男","gender":"1","nick":"高小憨"},
						"5":{"desc":"女","gender":"2","nick":"踏雪寻花"},
						"6":{"desc":"男","gender":"1","nick":"看山似水"},
						"7":{"desc":"女","gender":"2","nick":"祝雪"},
						"8":{"desc":"男","gender":"1","nick":"老范"},
						"9":{"desc":"女","gender":"2","nick":"香雪海"},
						"10":{"desc":"女","gender":"2","nick":"咕噜天使"},
						"11":{"desc":"男","gender":"1","nick":"陆胜朝"},
						"12":{"desc":"男","gender":"1","nick":"段东"},
						"13":{"desc":"女","gender":"2","nick":"小雪"},
						"14":{"desc":"男","gender":"1","nick":"John"},
						"15":{"desc":"女","gender":"2","nick":"轻轻的听"},
						"16":{"desc":"男","gender":"1","nick":"辉亮"},
						"17":{"desc":"女","gender":"2","nick":"王老师"},
						"18":{"desc":"男","gender":"1","nick":"断灭阐提"},
						"19":{"desc":"女","gender":"2","nick":"朱布衣"},
						"20":{"desc":"男","gender":"1","nick":"邓胖子"},
						"21":{"desc":"女","gender":"2","nick":"梅"},
						"22":{"desc":"女","gender":"2","nick":"不一样的天空"},
						"23":{"desc":"男","gender":"1","nick":"齐了咔嚓"}
					},
				"rookieAward":
					{
						"0":"<div style='margin:0; padding:0;font-size: 24px; align: center; color:#8a4622;font-family: SimHei;line-height:60px;width: 500px;'><span style='font-size: 36px;'>分享成功</span><br><span>恭喜你，获得朋友分享2&nbsp;</span><img src='gameHall/img_shareZuan.png' width='30' height='28'/><span>&nbsp;奖励</span> </div>",
						"1":"<div style='margin:0; padding:0;font-size: 24px; align: center; color:#8a4622;font-family: SimHei;line-height:60px;width: 500px;'><span style='font-size: 36px;'>恭喜获得</span><br><span>恭喜你获得刮刮乐二等奖，5&nbsp;</span><img src='gameHall/img_shareZuan.png' width='30' height='28' /><span>&nbsp;奖励</span> </div>",
						"2":"<div style='margin:0; padding:0;font-size: 24px; align: center; color:#8a4622;font-family: SimHei;line-height:60px;width: 500px;'><span style='font-size: 36px;'>恭喜获得</span><br><span>恭喜你获得刮刮乐一等奖，10&nbsp;</span><img src='gameHall/img_shareZuan.png' width='30' height='28' /><span>&nbsp;奖励</span> </div>",
						"3":"<div style='margin:0; padding:0;font-size: 24px; align: center; color:#8a4622;font-family: SimHei;line-height:40px;width: 500px;'><span style='font-size: 36px;'>恭喜获得</span><br><span>恭喜你获得刮刮乐三等奖，0.5元&nbsp;</span><img src='gameHall/img_hongbao.png' width='24' height='28' /><br><span>截图给客服领取现金红包，微信号：THMJ08</span> </div>",
						"shareSuccess":"<div style='margin:0; padding:0;font-size: 24px; align: center; color:#8a4622;font-family: SimHei;line-height:60px;width: 500px;'><span style='font-size: 36px;'>分享成功</span><br><span>恭喜你获得分享3&nbsp;</span><img src='gameHall/img_shareZuan.png' width='30' height='28' /><span>&nbsp;奖励</span> </div>"
					},
				"mail":
					{
						"1":{"title":"分享成功","state":"分享成功"},
						"2":{"title":"下级代理充值奖励","state":"返利成功"},
						"3":{"title":"幸运大转盘奖励","state":"抽取成功"},
						"4":{"title":"刮刮乐奖励","state":"领取成功"},
						"5":{"title":"获得好友分享奖励","state":"领取成功"}
					},
				"mailContent":
					{
						"2":"2个钻石",
						"3":"3个钻石",
						"5":"5个钻石",
						"10":"10个钻石",
						"2:2000":"2000金币",
						"2:4000":"4000金币"
					},
				"cacheURL":"/sdcard/com.tianhu.majiang/test.png"
			};
		}
		public function GetJson():Object 
		{
			return m_Config 
		}
	}

}