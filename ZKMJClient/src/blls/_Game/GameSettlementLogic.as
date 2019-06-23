package blls._Game 
{
	import blls.BaseLogic;
	import core.GameIF;
	import core.LogicManager;
	import dal.DalPai;
	import laya.events.Event;
	import laya.resource.HTMLCanvas;
	import laya.ui.Component;
	import laya.ui.List;
	import laya.utils.Browser;
	import laya.utils.Handler;
	import model._Gamer.Gamer;
	import model._Pai.Pai;
	import model._Room.Room;
	import network.NetworkManager;
	import tool.Tool;
	import view.ActiveView._gameItem.BasePaiItem;
	import view.ActiveView._gameItem.MyOverPaiItem;
	import view.ActiveView._gameItem.OtherOverPaiItem;
	import view.ActiveView._gameSettlementItem.BaseItem;
	import view.ActiveView._gameSettlementItem.MyPaiItem;
	import view.ActiveView._gameSettlementItem.OtherPaiItem;
	import view.GameSettlementView;
	import view.TotalScoreView;
	/**
	 * ...
	 * @author ...
	 */
	public class GameSettlementLogic extends BaseLogic
	{
		private var m_message:*;
		private var m_gameSettlementView:GameSettlementView;
		private var m_totalScoreView:TotalScoreView;
		private var m_mgrPai:DalPai;
		private var m_nPos:int;
		private var m_nInterval:int;
		public function GameSettlementLogic() 
		{
			super();
		}
		
		public override function Init():void
		{	
			if (m_gameSettlementView == null)
			{
				m_gameSettlementView = Tool.getNewSettlement(GameIF.GetRoom().nType) as GameSettlementView;
				m_gameSettlementView.Init();
			}
			if (m_totalScoreView == null)
			{
				m_totalScoreView = new TotalScoreView;
				m_totalScoreView.Init();
			}
			InitEvent();
			//不同设备有特殊需求
			InitEquip();
			
		}
		
		private function InitEquip():void 
		{
			
			var json:* = GameIF.GetJson();
			if (json["equipType"] == json["equipEnum"]["wxWeb"])
				henderWXWeb();
			if (json["equipType"] == json["equipEnum"]["Web"])
				henderWeb();
			if (json["equipType"] == json["equipEnum"]["Android"])
				henderAndroid();
			if (json["equipType"] == json["equipEnum"]["IOS"])
				henderIOS();
		}
		
		private function henderWXWeb():void 
		{
			m_gameSettlementView.m_btnShare.visible = false;
			m_totalScoreView.m_btnShare.visible = false;
		}
		
		private function henderWeb():void 
		{
			m_gameSettlementView.m_btnShare.visible = false;
			m_totalScoreView.m_btnShare.visible = false;
		}
		
		private function henderAndroid():void 
		{
			
		}
		
		private function henderIOS():void 
		{
			
		}
		
		public override function Destroy():void
		{
			if (m_gameSettlementView != null)
			{
				m_gameSettlementView.visible = false;
				m_gameSettlementView.Destroy();
				m_gameSettlementView = null;
			}
			
			if (m_totalScoreView != null)
			{
				m_totalScoreView.visible = false;
				m_totalScoreView.Destroy();
				m_totalScoreView = null;
			}
		
		}
		public override function OnReceiveMessage(msg:*):void
		{
			if (msg.type == 37)//gameEndNotify
			{
				OnGameEndNotify(msg.notify.gameEndNotify);
			}
			else if (msg.type == 71)//readygameresponse
			{
				OnReadygameresponse(msg.response.readyGameResponse);
			}
		}
		//游戏结算
		private function OnGameEndNotify(message:*):void 
		{
			m_message = null;
			m_message = message;
			//Laya.timer.once(1500, this, ShowView);
			//开始结算拉
			DealInfoList();
			HandlerOver();
			//测试//
			//OnReadyClicked();
		}
		
		private function HandlerOver():void 
		{
			if (m_message.bOver)
			{
				m_gameSettlementView.m_btnToalScore.visible = true;
				m_gameSettlementView.m_btnReady.visible = false;
				if (GameIF.GetRoom().sCardType == GameIF.GetJson()["cardType"]["happyRoom"])
				{
					m_gameSettlementView.m_btnToalScore.visible = false;
					m_gameSettlementView.m_btnReady.visible = true;
				}
			}
			else
			{
				m_gameSettlementView.m_btnToalScore.visible = false;
				m_gameSettlementView.m_btnReady.visible = true;
			}
		}
		private function OnReadygameresponse(message:*):void 
		{
			if (message.nErrorCode == 0)
			{	
				m_gameSettlementView.Reset();
				m_totalScoreView.Reset();
				m_gameSettlementView.m_list0pai.destroyChildren();
				m_gameSettlementView.m_list1pai.destroyChildren();
				m_gameSettlementView.m_list2pai.destroyChildren();
				m_gameSettlementView.m_list3pai.destroyChildren();
			}
		}
		public function ShowView():void 
		{
			m_gameSettlementView.visible = true;
		}
		
		private function DealInfoList():void 
		{
			if (GameIF.GetRoom().BaoPai)
			{
				
				m_gameSettlementView.BaoPai.pai = GameIF.GetRoom().BaoPai;
				m_gameSettlementView.m_imgBaoPailight.visible = true;
			}
			else
			{
				m_gameSettlementView.m_imgBaoPailight.visible = false;
			}
			for each(var gamerInfo:* in m_message.infoList)
			{
				//设置属性
				SetGamerInfo(gamerInfo);
				//设置总结算属性
				SetTotalScoreGamerInfo(gamerInfo);
				
				RenderOverPaiWall(gamerInfo);
			}
		}
		
		private function GetGamerPos(nID:int):int
		{
			var room:Room = GameIF.GetRoom();
			//获得gamer
			var myPos:int = room.GetGamer(GameIF.GetUser().nUserID).nPos;
			var gamerPos:int = room.GetGamer(nID).nPos; 
			var nPlayers:int = GameIF.GetRoom().nPlayers;
			var targetPos:int = (myPos - gamerPos + nPlayers) % nPlayers;
			
			return targetPos;
		}
		

		private function InitEvent():void 
		{
			//单句结算界面
			m_gameSettlementView.m_btnShare.on(Event.CLICK, this, OnShareClicked);
			m_gameSettlementView.m_btnToalScore.on(Event.CLICK, this, OnToalScoreClicked);
			m_gameSettlementView.m_btnReady.on(Event.CLICK, this, OnReadyClicked);
			m_gameSettlementView.m_btnShowPai.on(Event.CLICK, this, onShowPaiClicked);
			m_gameSettlementView.m_btnShowSetlement.on(Event.CLICK, this, OnShowSetlementCLicked);
			m_gameSettlementView.m_btnBack.on(Event.CLICK, this, OnBackClicked);
			//总结算页面点击事件
			m_totalScoreView.m_btnBack.on(Event.CLICK, this, OnBackClicked);
			m_totalScoreView.m_btnShare.on(Event.CLICK,this,OnShareClicked);
		}
		
		private function OnShareClicked():void 
		{
			var json:* = GameIF.GetJson();
				if (json["equipType"] == json["equipEnum"]["Web"])
					henderWebPyq();
				if (json["equipType"] == json["equipEnum"]["Android"])
					henderAndroidPyq();
				if (json["equipType"] == json["equipEnum"]["IOS"])
					henderIOSPyq();
		}
		private function henderWebPyq():void 
		{
			
		}
		private function henderAndroidPyq():void 
		{
		  var htmlCanvas:HTMLCanvas = Laya.stage.drawToCanvas(1136, 640, 0, 0);//把精灵绘制到canvas上面
		  //htmlCanvas.toBase64("image/png", 0.92, getBase64Image);
		  Browser.window.conch.captureScreen(savepng);
		}
		
		private function savepng(arrayBuff,width,height):void 
		{
			 //+Browser.now()+ ".png"
			var imgURL:String = GameIF.GetJson()["cacheURL"];
			Browser.window.conch.saveAsPng(arrayBuff, width, height, imgURL);
			
			//创建Test类
			var Test:*=Laya.PlatformClass.createClass("com.tianhu.majiang.WxAndroid");
			//创建Test 对象
			var testAdd:* = Test.newObject(); //不支持构造函数
			//调用成员函数
			testAdd.callWithBack(null, "wxShareScreenshot", imgURL);
			
		}
		private function getBase64Image(base64):void 
		{
			//创建Test类
			var Test:*=Laya.PlatformClass.createClass("com.tianhu.majiang.WxAndroid");
			//创建Test 对象
			var testAdd:* = Test.newObject(); //不支持构造函数
			//调用成员函数
			testAdd.callWithBack(null, "wxShareScreenshot", base64);
		}
		private function henderIOSPyq():void 
		{
			//创建Test类
			var Test:*=Laya.PlatformClass.createClass("SwxClass");
			//创建Test 对象
			var testAdd:* = Test.newObject(); //不支持构造函数
			//调用成员函数
			testAdd.callWithBack(null,"wxShare0");
		}
		private function OnToalScoreClicked():void 
		{
			m_gameSettlementView.visible = false;
			m_totalScoreView.reSetViewUi();
			m_totalScoreView.visible = true;
		}
		//准备
		private function OnReadyClicked():void 
		{
			SendReadyGameRequest();
		}
		public function SendReadyGameRequest():void 
		{
			var ReadyGameRequestMsg:* = NetworkManager.m_msgRoot.lookupType("ReadyGameRequest");
			var readyGameRequestMsg:* = ReadyGameRequestMsg.create({
				nUserID:GameIF.GetDalManager().daluser.nID,
				sRoomID:GameIF.GetRoom().sRoomID
			});
			//Request当中具体的内容
			var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
			var requestMsg:* = Request.create({
				readyGameRequest:readyGameRequestMsg
			});
			////包含了Request的内容
			var Msg:* = NetworkManager.m_msgRoot.lookupType("Msg");
			var MsgMessage:* = Msg.create({
				type:70,
				request:requestMsg
			});
			var encodeMessage:* = Msg.encode(MsgMessage).finish();
			GameIF.getInstance().networkManager.SocketSendMessage(encodeMessage);
		}
		//查看牌面
		private function onShowPaiClicked():void 
		{
			m_gameSettlementView.m_btnShowPai.visible = false;
			m_gameSettlementView.m_btnShowSetlement.visible = true;
			m_gameSettlementView.m_imgBg.visible = false;
			m_gameSettlementView.m_boxSettlement.visible = false;
		}
		//查看分数
		private function OnShowSetlementCLicked():void 
		{
			m_gameSettlementView.m_btnShowPai.visible = true;
			m_gameSettlementView.m_btnShowSetlement.visible = false;
			m_gameSettlementView.m_imgBg.visible = true;
			m_gameSettlementView.m_boxSettlement.visible = true;
		}
		//返回
		private function OnBackClicked():void 
		{
			var logic:RoomSetLogic = GameIF.GetLogic(LogicManager.ROOMSETLOGIC) as RoomSetLogic;
			logic.onQuitRoomClicked();
		}
		private function RenderOverPaiWall(gamerInfo:*):void 
		{
			m_mgrPai = GameIF.GetRoom().GetGamer(gamerInfo.gamerPai.nID).mgrPai;
			switch(GetGamerPos(gamerInfo.gamerPai.nID))
			{
				case 0:
					RenderOverPaiWallAmni(gamerInfo,20,m_gameSettlementView.m_list0pai,"My");
					break;
				case 1:
					RenderOverPaiWallAmni(gamerInfo,10,m_gameSettlementView.m_list1pai,"Other");
					break;
				case 2:
					RenderOverPaiWallAmni(gamerInfo,10,m_gameSettlementView.m_list2pai,"Other");
					break;
				case 3:
					RenderOverPaiWallAmni(gamerInfo,10,m_gameSettlementView.m_list3pai,"Other");
					break;
			}
		}
		
		private function RenderOverPaiWallAmni(gamerInfo:*,nInterval,listPai:*,className:String):void 
		{
			m_nPos = 0;
			var overPai:BasePaiItem;
			m_nInterval = nInterval;
			for each (var orderPai:* in gamerInfo.gamerPai.orderPai)
			{
				if (orderPai.chipai)
				{
					var pai1:Pai = m_mgrPai.createPai(orderPai.chipai.nType,orderPai.chipai.nValue1) as Pai;
					var pai2:Pai = m_mgrPai.createPai(orderPai.chipai.nType,orderPai.chipai.nValue2) as Pai;
					var pai3:Pai = m_mgrPai.createPai(orderPai.chipai.nType, orderPai.chipai.nValue3) as Pai;
					
					overPai = GetOverPaiItem(className);
					overPai.pai = pai1;
					overPai.x = m_nPos;
					listPai.addChild(overPai);
					m_nPos += overPai.nSpaceX;
					
					overPai = GetOverPaiItem(className);
					overPai.pai = pai2;
					overPai.x = m_nPos;
					listPai.addChild(overPai);
					m_nPos += overPai.nSpaceX;
					
					overPai = GetOverPaiItem(className);
					overPai.pai = pai3;
					overPai.x = m_nPos;
					listPai.addChild(overPai);
					m_nPos += overPai.nSpaceX;
					m_nPos += m_nInterval;
				}
				if (orderPai.pengpai)
				{
					var pengpai:Pai = m_mgrPai.createPai(orderPai.pengpai.nType, orderPai.pengpai.nValue);
					for (var i:int = 0; i < 3;i++)
					{
						overPai = GetOverPaiItem(className);
						overPai.pai = pengpai;
						overPai.x = m_nPos;
						listPai.addChild(overPai);
						m_nPos += overPai.nSpaceX;
					}
					m_nPos += m_nInterval;
				}
				if (orderPai.gangpai)
				{
					var gangpai:Pai = m_mgrPai.createPai(orderPai.gangpai.nType, orderPai.gangpai.nValue);
					for (var j:int = 0; j < 4;j++)
					{
						overPai = GetOverPaiItem(className);
						overPai.pai = gangpai;
						overPai.x = m_nPos;
						listPai.addChild(overPai);
						m_nPos += overPai.nSpaceX;
					}
					m_nPos += m_nInterval;
				}
			}
			if (gamerInfo.hupai)
			{
				for each(var huPaiPool:Array in gamerInfo.gamerPai.pool)
				{
					for (var k:int = 0; k < huPaiPool.nValue.length; k++ )
					{
						if (gamerInfo.hupai.nType == huPaiPool.nType && gamerInfo.hupai.nValue == huPaiPool.nValue[k])
						{
							huPaiPool.nValue.splice(k, 1);
							break;
						}
					}
				}
			}
			
			
			for each(var PaiPool:* in gamerInfo.gamerPai.pool)
			{
				for (var m:int = 0; m < PaiPool.nValue.length; m++ )
				{
					var pai:Pai = m_mgrPai.createPai(PaiPool.nType, PaiPool.nValue[m]);
					overPai = GetOverPaiItem(className);
					overPai.pai = pai;
					overPai.x = m_nPos;
					listPai.addChild(overPai);
					m_nPos += overPai.nSpaceX;
				}
			}
			m_nPos += m_nInterval;
			
			if (gamerInfo.hupai)
			{
				var hupai:Pai = m_mgrPai.createPai(gamerInfo.hupai.nType, gamerInfo.hupai.nValue);
				overPai = GetOverPaiItem(className);
				overPai.pai = hupai;
				overPai.x = m_nPos;
				
				listPai.addChild(overPai);
				m_nPos += overPai.nSpaceX;
			}
		}
		private function GetOverPaiItem(name:String):* 
		{
			switch(name)
			{
				case "My":
					return new MyOverPaiItem;
					break;
				case "Other":
					return new OtherOverPaiItem;
					break
				default:
					break;
			}
		}

		private function SetGamerInfo(gamerInfo:*):void
		{
			var room:Room = GameIF.GetRoom();
			var gamer:Gamer =room.GetGamer(gamerInfo.gamerPai.nID);
			gamer.nScore+= gamerInfo.nGameCoin;
			switch(GetGamerPos(gamerInfo.gamerPai.nID))
			{
				case 0:
					m_gameSettlementView.SetGamerBottomInfo(gamerInfo,gamer,m_message);
					break;
				case 1:
					m_gameSettlementView.SetGamerLeftInfo(gamerInfo,gamer);
					break;
				case 2:
					m_gameSettlementView.SetGamerTopInfo(gamerInfo,gamer);
					break;
				case 3:
					m_gameSettlementView.SetGamerRightInfo(gamerInfo,gamer);
					break;
			}
		}
		
		//总结算界面
		private function SetTotalScoreGamerInfo(gamerInfo:*):void 
		{
			var room:Room = GameIF.GetRoom();
			var gamer:Gamer =room.GetGamer(gamerInfo.gamerPai.nID);
			switch(GetGamerPos(gamer.nGID))
			{
				case 0:	
					SetGamerBottomTotal(gamerInfo, gamer);
					break;
				case 1:	
					SetGamerLeftTotal(gamerInfo, gamer);
					break;
				case 2:	
					SetGamerTopTotal(gamerInfo, gamer);
					break;
				case 3:
					SetGamerRightTotal(gamerInfo, gamer);
					break;
			}
		}
		
		private function SetGamerBottomTotal(gamerInfo:*, gamer:Gamer):void 
		{
			//房主
			m_totalScoreView.m_imgBoss0.visible = gamer.bOwner;
			//头像
			m_totalScoreView.m_imgHead0.skin = gamer.sHeadimg;
			//玩家姓名
			m_totalScoreView.m_lableName0.text = gamer.sNick;
			//玩家ID
			m_totalScoreView.m_lableID0.text = gamer.nGID.toString();
			//胡牌
			m_totalScoreView.m_lableHuCount0.text = gamerInfo.huCount;
			//摸宝
			m_totalScoreView.m_lableMoBaoCount0.text = gamerInfo.moBaoCount;
			//自摸
			m_totalScoreView.m_lableZiMoCount0.text = gamerInfo.ziMoCount;
			//杠牌
			m_totalScoreView.m_lableGangCount0.text = gamerInfo.gangCount;
			//点炮
			m_totalScoreView.m_lableDianPaoCount0.text = gamerInfo.dianPaoCount;
			//总成绩
			if (gamerInfo.totalScore>=0)
			{
				m_totalScoreView.m_imgScore0.skin = "totalScore/img_achieve_win.png";
				m_totalScoreView.m_imgPlus0.skin = "totalScore/img_pr_win.png";
				m_totalScoreView.m_clipTen0.skin = "totalScore/clip_win.png";
				m_totalScoreView.m_clipBit0.skin = "totalScore/clip_win.png";
				m_totalScoreView.m_clipTen0.index = Math.floor(gamerInfo.totalScore/10);
				m_totalScoreView.m_clipBit0.index = gamerInfo.totalScore % 10;
			}
			else if (gamerInfo.totalScore < 0)
			{
				m_totalScoreView.m_imgScore0.skin = "totalScore/img_achieve_lose.png";
				m_totalScoreView.m_imgPlus0.skin = "totalScore/img_pr_lose.png";
				m_totalScoreView.m_clipTen0.skin = "totalScore/clip_lose.png";
				m_totalScoreView.m_clipBit0.skin = "totalScore/clip_lose.png";
				m_totalScoreView.m_clipTen0.index = Math.floor(-gamerInfo.totalScore/10);
				m_totalScoreView.m_clipBit0.index = -gamerInfo.totalScore % 10;
				
			}
		}
		
		private function SetGamerLeftTotal(gamerInfo:*, gamer:Gamer):void 
		{
			m_totalScoreView.m_boxGamer1.visible = true;
			//房主
			m_totalScoreView.m_imgBoss1.visible = gamer.bOwner;
			//头像
			m_totalScoreView.m_imgHead1.skin = gamer.sHeadimg;
			//玩家姓名
			m_totalScoreView.m_lableName1.text = gamer.sNick;
			//玩家ID
			m_totalScoreView.m_lableID1.text = gamer.nGID.toString();
			//胡牌
			m_totalScoreView.m_lableHuCount1.text = gamerInfo.huCount;
			//摸宝
			m_totalScoreView.m_lableMoBaoCount1.text = gamerInfo.moBaoCount;
			//自摸
			m_totalScoreView.m_lableZiMoCount1.text = gamerInfo.ziMoCount;
			//杠牌
			m_totalScoreView.m_lableGangCount1.text = gamerInfo.gangCount;
			//点炮
			m_totalScoreView.m_lableDianPaoCount1.text = gamerInfo.dianPaoCount;
			//总成绩
			if (gamerInfo.totalScore>=0)
			{
				m_totalScoreView.m_imgScore1.skin = "totalScore/img_achieve_win.png";
				m_totalScoreView.m_imgPlus1.skin = "totalScore/img_pr_win.png";
				m_totalScoreView.m_clipTen1.skin = "totalScore/clip_win.png";
				m_totalScoreView.m_clipBit1.skin = "totalScore/clip_win.png";
				m_totalScoreView.m_clipTen1.index = Math.floor(gamerInfo.totalScore/10);
				m_totalScoreView.m_clipBit1.index = gamerInfo.totalScore % 10;
			}
			else if (gamerInfo.totalScore < 0)
			{
				m_totalScoreView.m_imgScore1.skin = "totalScore/img_achieve_lose.png";
				m_totalScoreView.m_imgPlus1.skin = "totalScore/img_pr_lose.png";
				m_totalScoreView.m_clipTen1.skin = "totalScore/clip_lose.png";
				m_totalScoreView.m_clipBit1.skin = "totalScore/clip_lose.png";
				m_totalScoreView.m_clipTen1.index = Math.floor(-gamerInfo.totalScore/10);
				m_totalScoreView.m_clipBit1.index = -gamerInfo.totalScore % 10;
				
			}
		}
		private function SetGamerTopTotal(gamerInfo:*, gamer:Gamer):void 
		{
			m_totalScoreView.m_boxGamer2.visible = true;
			//房主
			m_totalScoreView.m_imgBoss2.visible = gamer.bOwner;
			//头像
			m_totalScoreView.m_imgHead2.skin = gamer.sHeadimg;
			//玩家姓名
			m_totalScoreView.m_lableName2.text = gamer.sNick;
			//玩家ID
			m_totalScoreView.m_lableID2.text = gamer.nGID.toString();
			//胡牌
			m_totalScoreView.m_lableHuCount2.text = gamerInfo.huCount;
			//摸宝
			m_totalScoreView.m_lableMoBaoCount2.text = gamerInfo.moBaoCount;
			//自摸
			m_totalScoreView.m_lableZiMoCount2.text = gamerInfo.ziMoCount;
			//杠牌
			m_totalScoreView.m_lableGangCount2.text = gamerInfo.gangCount;
			//点炮
			m_totalScoreView.m_lableDianPaoCount2.text = gamerInfo.dianPaoCount;
			//总成绩
			if (gamerInfo.totalScore>=0)
			{
				m_totalScoreView.m_imgScore2.skin = "totalScore/img_achieve_win.png";
				m_totalScoreView.m_imgPlus2.skin = "totalScore/img_pr_win.png";
				m_totalScoreView.m_clipTen2.skin = "totalScore/clip_win.png";
				m_totalScoreView.m_clipBit2.skin = "totalScore/clip_win.png";
				m_totalScoreView.m_clipTen2.index = Math.floor(gamerInfo.totalScore/10);
				m_totalScoreView.m_clipBit2.index = gamerInfo.totalScore % 10;
			}
			else if (gamerInfo.totalScore < 0)
			{
				m_totalScoreView.m_imgScore2.skin = "totalScore/img_achieve_lose.png";
				m_totalScoreView.m_imgPlus2.skin = "totalScore/img_pr_lose.png";
				m_totalScoreView.m_clipTen2.skin = "totalScore/clip_lose.png";
				m_totalScoreView.m_clipBit2.skin = "totalScore/clip_lose.png";
				m_totalScoreView.m_clipTen2.index = Math.floor(-gamerInfo.totalScore/10);
				m_totalScoreView.m_clipBit2.index = -gamerInfo.totalScore % 10;
				
			}
		}
		
		private function SetGamerRightTotal(gamerInfo:*, gamer:Gamer):void 
		{
			m_totalScoreView.m_boxGamer3.visible = true;
			//房主
			m_totalScoreView.m_imgBoss3.visible = gamer.bOwner;
			//头像
			m_totalScoreView.m_imgHead3.skin = gamer.sHeadimg;
			//玩家姓名
			m_totalScoreView.m_lableName3.text = gamer.sNick;
			//玩家ID
			m_totalScoreView.m_lableID3.text = gamer.nGID.toString();
			//胡牌
			m_totalScoreView.m_lableHuCount3.text = gamerInfo.huCount;
			//摸宝
			m_totalScoreView.m_lableMoBaoCount3.text = gamerInfo.moBaoCount;
			//自摸
			m_totalScoreView.m_lableZiMoCount3.text = gamerInfo.ziMoCount;
			//杠牌
			m_totalScoreView.m_lableGangCount3.text = gamerInfo.gangCount;
			//点炮
			m_totalScoreView.m_lableDianPaoCount3.text = gamerInfo.dianPaoCount;
			//总成绩
			if (gamerInfo.totalScore>=0)
			{
				m_totalScoreView.m_imgScore3.skin = "totalScore/img_achieve_win.png";
				m_totalScoreView.m_imgPlus3.skin = "totalScore/img_pr_win.png";
				m_totalScoreView.m_clipTen3.skin = "totalScore/clip_win.png";
				m_totalScoreView.m_clipBit3.skin = "totalScore/clip_win.png";
				m_totalScoreView.m_clipTen3.index = Math.floor(gamerInfo.totalScore/10);
				m_totalScoreView.m_clipBit3.index = gamerInfo.totalScore % 10;
			}
			else if (gamerInfo.totalScore < 0)
			{
				m_totalScoreView.m_imgScore3.skin = "totalScore/img_achieve_lose.png";
				m_totalScoreView.m_imgPlus3.skin = "totalScore/img_pr_lose.png";
				m_totalScoreView.m_clipTen3.skin = "totalScore/clip_lose.png";
				m_totalScoreView.m_clipBit3.skin = "totalScore/clip_lose.png";
				m_totalScoreView.m_clipTen3.index = Math.floor(-gamerInfo.totalScore/10);
				m_totalScoreView.m_clipBit3.index = -gamerInfo.totalScore % 10;
				
			}
		}
	}

}