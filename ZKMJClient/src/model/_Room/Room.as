package model._Room 
{
	import blls.BaseLogic;
	import blls.RegularLogic;
	import blls._Game.GameSettlementLogic;
	import blls._Game.RoomSetLogic;
	import blls._GamehallLogic.SetLogic;
	import core.GameIF;
	import core.LogicManager;
	import dal.DalGamer;
	import laya.events.Event;
	import laya.utils.Dictionary;
	import laya.utils.Tween;
	import model._Gamer.Gamer;
	import model._Pai.Pai;
	import network.NetworkManager;
	import tool.Tool;
	import view.Room.RoomView;
	import view.Room.VIPRoomView;
	/**
	 * ...
	 * @author ...
	 */
	public class Room 
	{
		protected var m_sChiSound:String;
		protected var m_sPengSound:String;
		protected var m_sHuSound:String;
		protected var m_sGangSound:String;
		protected var m_sTingSound:String;
		protected var m_sZimoSound:String;
		protected var m_sGameStarSound:String;
		protected var m_sPutPaiDownSound:String;
		protected var m_sLossSound:String;
		protected var m_sWinSound:String;
		protected var m_sClockSound:String;
		
		protected var m_sRoomID:String;
		protected var m_nUserID:int;
		protected var m_nType:int;
		protected var m_dalGamer:DalGamer;
		protected var m_nPaiNum:String;
		protected var m_RoomView:RoomView;
		protected var m_sCardType:int;//房间类型 0 欢乐场 1 四圈 2 八圈 3 12圈
		protected var m_nRoundNum:int=8;//总圈数
		protected var m_nRound:int = 1;//当前是第几圈
		protected var m_nRoomState:int=0;//0 未开始 1 正在游戏 2游戏结束
		protected var m_nLastUserID:int;
		protected var m_nPlayers:int = 4;
		protected var m_bNetWeak:Boolean;//网络是否异常
		protected var m_BaoPai:Pai;
		public function Room() 
		{
			Init();
		}
		
		public function DalInit():void 
		{
			vipRoomView.m_labRoomID.text = m_sRoomID;
			vipRoomView.m_labRoundNum.text = m_nRound + "/" + m_nRoundNum;
		}
		public function Init():void 
		{
			InitRoomView();
			if (m_dalGamer == null)
			{
				m_dalGamer = new DalGamer;
			}
			jsonInit();
			registerEventClick();
			
			InitCurTime()
			
			m_nUserID = GameIF.GetUser().nUserID;
			m_nLastUserID = m_nUserID;
			
		}
		protected function InitRoomView():void 
		{
			if (m_RoomView == null)
			{
				m_RoomView = new RoomView;
				m_RoomView.Init();
			}
		}
		protected function InitCurTime():void 
		{
			//先初始化一次
			SetCurTime();
			Laya.timer.loop(5000, this, SetCurTime);
		}
		
		//提示网络信号差
		public function ShowNetWeak():void
		{
			
			if (GameIF.GetRoom())
			{
				var room:Room = GameIF.GetRoom();
				room.vipRoomView.m_boxNetWeak.visible = true;
				Laya.timer.once(2000,this,HideNetWeak);
			}
		}
		
		//隐藏
		private function HideNetWeak():void 
		{
			if (GameIF.GetRoom())
			{
				m_RoomView.m_boxNetWeak.visible = false;
			}
		}
		
		//显示自己的位置信息
		public function ShowMyGPS():void
		{
			m_RoomView.m_boxMyGPS.visible = true;
			var gamer:Gamer = GetGamer(m_nUserID);
			m_RoomView.m_labelMyGPS.text = gamer.sNick + "  " + gamer.sAddress;
			//Laya.timer.once(1000,this,HideMyGPS);
		}
		
		//隐藏
		private function HideMyGPS():void 
		{
			m_RoomView.m_boxMyGPS.visible = false;
			
		}
		//显示其他人的位置信息，自己和他的距离
		public function ShowOtherGPS():void
		{
			m_RoomView.m_boxOtherGPS.visible = true;
			m_RoomView.m_imgOtherGPSBg.visible = true;
			for each(var gamer1:Gamer in m_dalGamer.gamerPool.values)
			{
				for each(var gamer2:Gamer in m_dalGamer.gamerPool.values)
				{
					if (gamer1.nPosGame != gamer2.nPosGame)
					{
						SetGameDistance(gamer1,gamer2);
					}
				}
			}
		}
		//隐藏
		public function HideOtherGPS():void
		{
			m_RoomView.m_boxOtherGPS.visible = false;
			m_RoomView.m_imgOtherGPSBg.visible = false;
		}
		//设置两个玩家的距离
		private function SetGameDistance(gamer1:Gamer,gamer2:Gamer):void 
		{
			
			var pos1:int =  gamer1.nPosGame;
			var pos2:int =  gamer2.nPosGame;
			var distance:String = Tool.GetGamerDistance(gamer1, gamer2);
			if (!gamer1.bIsLocation || !gamer2.bIsLocation)
			{
				distance = "没有开启定位"
			}
			if (pos1 == 0 && pos2 == 1 )
			{
				vipRoomView.m_boxGPS01.visible = true;
				vipRoomView.m_labelGPS01.text = distance;
			}
			else if (pos1 == 0 && pos2 == 2)
			{
				vipRoomView.m_boxGPS02.visible = true;
				vipRoomView.m_labelGPS02.text = distance;
			}
			else if (pos1 == 0 && pos2 == 3)
			{
				vipRoomView.m_boxGPS03.visible = true;
				vipRoomView.m_labelGPS03.text = distance;
			}
			else if (pos1 == 1 && pos2 == 2)
			{
				vipRoomView.m_boxGPS12.visible = true;
				vipRoomView.m_labelGPS12.text = distance;
			}
			else if (pos1 == 2 && pos2 == 3)
			{
				vipRoomView.m_boxGPS23.visible = true;
				vipRoomView.m_labelGPS23.text = distance;
			}
		}
		
		protected function SetCurTime():void 
		{
			var date:Date = new Date;
			var hour:* = date.getHours();
			var minute:* = date.getMinutes();
			if(hour<10){hour="0"+hour}
			if(minute<10){minute="0"+minute}
			m_RoomView.m_labCurTime.text = hour.toString() + ":" + minute.toString();
			date = null;
		}
		public function SetPlayers(nPlayers:int):void 
		{
			m_nPlayers = nPlayers?nPlayers:4;
			switch(m_nPlayers)
			{
				case 2:
					vipRoomView.m_btnAvatar1.visible = false;
					vipRoomView.m_btnAvatar3.visible = false;
					break;
				case 3:
					vipRoomView.m_btnAvatar2.visible = false;
					break;
				case 4:
					break
				default:
					break;
			}
		}
		public function SetGamePlay(gamePlay:*):void 
		{
			
			var gamePlayName:JSON=GameIF.GetJson()["gamePlayName"];
			vipRoomView.m_labelGamePlay.text = gamePlayName[gamePlay.nType]!= undefined?gamePlayName[gamePlay.nType]:"";
			var i:int = 1;
			for each (var name:* in gamePlay.optionals)
			{
				if (i % 3==0)
				{
					vipRoomView.m_labelGamePlay.text += "\n";
				}
				i++;
				if (gamePlayName[name] != undefined)
				{
					vipRoomView.m_labelGamePlay.text += gamePlayName[name];	
				}
				
			}
		}
		protected function jsonInit():void 
		{
			var json:*=GameIF.GetJson();
			m_sChiSound = json["soundType"]["chi"];
			m_sGangSound = json["soundType"]["gang"];
			m_sPengSound = json["soundType"]["peng"];
			m_sHuSound = json["soundType"]["hu"];
			m_sTingSound = json["soundType"]["ting"];
			m_sZimoSound = json["soundType"]["zimo"];
			m_sLossSound = json["soundType"]["loss"];
			m_sWinSound = json["soundType"]["win"];
			m_sGameStarSound = json["soundType"]["gameStar"];
			m_sPutPaiDownSound = json["soundType"]["putPaiDown"];
			m_sClockSound = json["soundType"]["clock"];
			
		}
		protected function registerEventClick():void 
		{
			
			//开始游戏
			vipRoomView.m_btnStartGame.on(Event.CLICK, this, OnStartGameClicked);
			//退出房间
			vipRoomView.m_btnQuitRoom.on(Event.CLICK, this, OnQuitRoomClicked);
			//设置
			vipRoomView.m_btnSet.on(Event.CLICK, this, OnSetClicked);
			//聊天
			vipRoomView.m_btnChat.on(Event.CLICK, this, OnChatClicked);
			//邀请好友
			vipRoomView.m_btnDefaultHead1.on(Event.CLICK, this, OnInviteClicked);
			vipRoomView.m_btnDefaultHead2.on(Event.CLICK, this,  OnInviteClicked);
			vipRoomView.m_btnDefaultHead3.on(Event.CLICK, this,  OnInviteClicked);
			vipRoomView.btn_InviteFriend.on(Event.CLICK, this,  OnInviteClicked);
			//打开导航栏
			vipRoomView.m_open.on(Event.CLICK, this, OnOpenClicked);
			//关闭导航栏
			vipRoomView.m_back.on(Event.CLICK, this, OnBackClicked);
			//导航栏透明背景
			vipRoomView.m_imgSetAlphaBg.on(Event.CLICK, this, OnBackClicked);
			//开启托管
			vipRoomView.m_btnDelegateOn.on(Event.CLICK, this, OnDelegateOnClicked);
			//取消托管
			vipRoomView.m_btnDelegateOff.on(Event.CLICK, this, OnDelegateOffClicked);
			vipRoomView.m_imgDelegateAlpha.on(Event.CLICK, this, OnDelegateOffClicked);
			//设置
			vipRoomView.m_newSet.on(Event.CLICK, this, OnSetClicked);
			//规则
			vipRoomView.m_btnRegular.on(Event.CLICK, this, OnRegularClicked);
			//黑幕
			vipRoomView.m_imgSetBlackBg.on(Event.CLICK, this, onAlphaScreenClicked);
			//隐藏其他人的GPS
			vipRoomView.m_btnGPSisOk.on(Event.CLICK, this, HideOtherGPS);
			//退出房间
			vipRoomView.m_btnGPSquit.on(Event.CLICK, this, OnQuitRoomClicked);
		}
		
		public function OnStartGameClicked():void 
		{
			var logic:GameSettlementLogic = GameIF.GetLogic(LogicManager.GAMESETTLEMENTLOGIC) as GameSettlementLogic;
			logic.SendReadyGameRequest();
		}
		//收回
		protected function OnBackClicked():void 
		{
			vipRoomView.m_setBox.visible = false;
			vipRoomView.m_imgSetBlackBg.visible = false;
			//Tween.to(vipRoomView.m_open, {"alpha":1 }, 200, null);
			vipRoomView.m_open.x = 1052;
			//Tween.to(vipRoomView.m_setBox, { "y":vipRoomView.m_open.y - 450}, 300, null);
			GameIF.ActiveLogic(LogicManager.ROOMSETLOGIC);
		}
		//下拉
		protected function OnOpenClicked():void 
		{
			vipRoomView.m_setBox.visible = true;
			vipRoomView.m_imgSetBlackBg.visible = true;
			//Tween.to(vipRoomView.m_open, {"alpha":0 }, 200, null);
			vipRoomView.m_open.x = 5000;
			//Tween.to(vipRoomView.m_setBox, { "y":vipRoomView.m_open.y}, 300, null);
		}
		
		public function onAlphaScreenClicked():void 
		{
			return ;
		}
		//退出房间
		private function OnQuitRoomClicked():void 
		{
			var logic:RoomSetLogic = GameIF.GetLogic(LogicManager.ROOMSETLOGIC) as RoomSetLogic;
			logic.onQuitRoomClicked();
		}
		//开启托管
		private function OnDelegateOnClicked():void 
		{
			SendDelegateRequest(true);
		}
		//取消托管
		private function OnDelegateOffClicked():void 
		{
			SendDelegateRequest(false);
		}
		//设置
		protected function OnSetClicked():void 
		{
			
			var logic:RoomSetLogic = GameIF.GetLogic(LogicManager.ROOMSETLOGIC) as RoomSetLogic;
			logic.ShowRoomSet();
		}
		protected function OnRegularClicked():void 
		{
			var logic:RegularLogic = GameIF.GetLogic(LogicManager.REGULARLOGIC) as RegularLogic;
			logic.Show();
		}
		//聊天
		protected function OnChatClicked():void 
		{
			GameIF.ActiveLogic(LogicManager.CHATLOGIC);
		}
		//邀请好友
		protected function OnInviteClicked():void 
		{
			var json:* = GameIF.GetJson();
				if (json["equipType"] == json["equipEnum"]["Web"])
					henderWeb();
				if (json["equipType"] == json["equipEnum"]["Android"])
					henderAndroidWX();
				if (json["equipType"] == json["equipEnum"]["IOS"])
					henderIOSWX();
				if (json["equipType"] == json["equipEnum"]["wxWeb"])
					henderWX();
				if (json["equipType"] == json["equipEnum"]["wxMin"])
					henderWX();
			
		}
		
		protected function henderWeb():void 
		{
			//GameIF.ActiveLogic(LogicManager.SHAREPROMPTLOGIC);
			return ;
		} 
		
		protected function henderAndroidWX():void 
		{
			//创建Test类
			var Test:*=Laya.PlatformClass.createClass("com.tianhu.majiang.WxAndroid");
			//创建Test 对象
			var testAdd:* = Test.newObject(); //不支持构造函数
			//调用成员函数
			var roomID:String = m_sRoomID;
			var sICode:String= GameIF.GetUser().sICode;
			testAdd.callWithBack(null,"wxShareSceneSession",roomID,sICode);
		}
		
		protected function henderIOSWX():void 
		{
			//创建Test类
			var Test:*=Laya.PlatformClass.createClass("SwxClass");
			//创建Test 对象
			var testAdd:* = Test.newObject(); //不支持构造函数
			//调用成员函数
			testAdd.callWithBack(null,"wxShareSceneSession");
		}
		protected function henderWX():void 
		{
			GameIF.ActiveLogic(LogicManager.SHAREPROMPTLOGIC);
			var roomID:String = m_sRoomID;
			var sICode:String = GameIF.GetUser().sICode;
			__JS__('btnShareAppMessage(roomID,sICode)');
			console.log('btnShareAppMessage over');
		}
		/////////////////////////////////////////////////////////
		
		public function get sRoomID():String 
		{
			return m_sRoomID;
		}
		
		public function set sRoomID(value:String):void 
		{
			m_sRoomID = value;
		}
		
		/////////////////////////////////////////////////////////////
		
		public function get nType():int 
		{
			return m_nType;
		}
		
		public function set nType(value:int):void 
		{
			m_nType = value;
		}
		public function get nRound():int 
		{
			return m_nRound;
		}
		
		public function set nRound(value:int):void 
		{
			m_nRound = value;
		}
		
		public function get nRoundNum():int 
		{
			return m_nRoundNum;
		}
		
		public function set nRoundNum(value:int):void 
		{
			m_nRoundNum = value;
		}
		
		public function get nRoomState():int 
		{
			return m_nRoomState;
		}
		
		public function set nRoomState(value:int):void 
		{
			m_nRoomState = value;
		}
		
		public function get sCardType():int 
		{
			return m_sCardType;
		}
		
		public function set sCardType(value:int):void 
		{
			value = value?value:0;
			m_nRoundNum = GameIF.GetJson()["goods"][value]["roundNum"];
			m_sCardType = value;
		}
		
		public function get nPlayers():int 
		{
			return m_nPlayers;
		}
		
		public function set nPlayers(value:int):void 
		{
			m_nPlayers = value;
		}
		
		public function get vipRoomView():RoomView 
		{
			return m_RoomView;
		}
		
		public function set vipRoomView(value:RoomView):void 
		{
			m_RoomView = value;
		}
		
		public function get bNetWeak():Boolean 
		{
			return m_bNetWeak;
		}
		
		public function set bNetWeak(value:Boolean):void 
		{
			m_bNetWeak = value;
		}
		
		public function get BaoPai():Pai 
		{
			return m_BaoPai;
		}
		
		public function set BaoPai(value:Pai):void 
		{
			m_BaoPai = value;
		}
		
		
		//////////////////////////add by wangn//////////////////////
		public function AddGamer(gamer:Gamer):void
		{
			gamer.vipRoomView = vipRoomView;
			m_dalGamer.AddGamer(gamer);
		}
		
		public function GetGamer(gamerid:*):Gamer
		{
			return m_dalGamer.GetGamer(gamerid);
		}
		
		public function DelGamer(gamerid:*):void
		{
			m_dalGamer.DelGamer(gamerid);
		}
		
		
		//viproom传过来的消息
		public function InitPaipool(PaiPoolArr:*):void 
		{
			for each(var PaiPool:* in PaiPoolArr)
			{
				GetGamer(PaiPool.nID).InitPaiPool(PaiPool);
			}
			InitPaiWall();
		}
		//初始话牌墙
		public function InitPaiWall():void
		{
			for each(var gamer:Gamer in m_dalGamer.gamerPool.values)
			{
				gamer.RenderInit();
			}
		}
		public function OnStartGameNotify(message:*):void 
		{
			GetGamer(message.nBossID).bBoss = true;
			GetGamer(message.nBossID).renderInfo();
			vipRoomView.m_labRoundNum.text = m_nRound + "/" + m_nRoundNum;
			GameStart();	
			HideOtherGPS();
			HideMyGPS();
		}
		public function GameStart():void 
		{
			for each(var gamer:Gamer in m_dalGamer.gamerPool.values)
			{
				gamer.GameStart();
			}
			gameReadying();
			vipRoomView.m_imgReadyed0.visible = false;
			vipRoomView.m_imgReadyed1.visible = false;
			vipRoomView.m_imgReadyed2.visible = false;
			vipRoomView.m_imgReadyed3.visible = false;
		}
		public function gameReadying():void 
		{
			vipRoomView.m_boxGameBg.visible = true;
			vipRoomView.btn_InviteFriend.visible = false;
			//移动玩家头像到正确的位置
			Tween.to(vipRoomView.m_btnAvatar0, { "x":7, "y":500 }, 300, null);
			Tween.to(vipRoomView.m_btnAvatar1, { "x":5, "y":237 }, 300, null);
			Tween.to(vipRoomView.m_btnAvatar2, { "x":947, "y":10 }, 300, null);
			Tween.to(vipRoomView.m_btnAvatar3, { "x":1063, "y":238 }, 300, null);
			vipRoomView.m_btnAvatar0.scale(0.875, 0.875);
			vipRoomView.m_btnAvatar1.scale(0.875, 0.875);
			vipRoomView.m_btnAvatar2.scale(0.875, 0.875);
			vipRoomView.m_btnAvatar3.scale(0.875, 0.875);
			
		}
		public function OnLeaveRoomNotify(message:*):void 
		{
			GetGamer(message.nUserID).OnLeaveRoomNotify();
			for each(var gamer:Gamer in m_dalGamer.gamerPool.values)
			{
				if (gamer.nGID == message.nUserID)
				{
					gamer.Destroy();
					DelGamer(gamer.nGID);
					gamer = null;
				}
			}
		}
		//上线
		public function OnConnectNotify(message:*):void 
		{
			GetGamer(message.nUserID).OnConnectNotify();
		}
		//掉线
		public function OnDisConnectNotify(message:*):void 
		{
			GetGamer(message.nUserID).OnDisConnectNotify();
		}
		//设置房主
		public function SetOwner(message:*):void 
		{
			//先关掉所有的在显示房主的
			GetGamer(message.nOwnerID).HideOwner();
			GetGamer(message.nOwnerID).ShowOwner();
			for each(var gamer:Gamer in m_dalGamer.gamerPool.values)
			{
				if (gamer.nGID == message.nOwnerID)
				{
					gamer.bOwner = true;
					
				}
				else
				{
					gamer.bOwner = false;	
				}
			}
		}
		//游戏结束
		public function GameOver():void 
		{
			
			//roomRest();
			
		}
		/////event////
		//起牌
		public function OnGetPai(message:*):void
		{
			var newPai:Pai = new Pai;
			newPai.nType = message.getPai.nType;
			newPai.nValue = message.getPai.nValue;
			if (BaoPai)
			{//如果已经存在宝牌
				if (BaoPai.nType == newPai.nType && BaoPai.nValue == newPai.nValue)
				{//当前的牌是宝牌
					
					newPai.bBao = true;
				}
			}
			GetGamer(message.nUserID).OnGetPai(newPai);
			vipRoomView.m_labPaiNum.text = message.nLeft;
			//关掉上一个人的灯
			GetGamer(m_nLastUserID).OffCur();
			//当前可操作用户开灯
			GetGamer(message.nUserID).OpennCur();
		}
		public function OnBaopaiShow(message:*):void 
		{
			
		}
		public function BaoPaiShowStop():void
		{
			
		}
		//打牌通知
		public function OnPutPai(message:*):void
		{
			GetGamer(message.nUserID).OnPutPai(message);
			//关掉上一个人的灯
			GetGamer(m_nLastUserID).OffCur();
			//当前可操作用户开灯
			GetGamer(message.nUserID).OpennCur();
		}
		//打牌响应
		public function OnPutPaiResponse(message:*):void
		{
			var gamer:Gamer = GetGamer(m_nUserID);
			GameIF.GetPutPaiSound(message.putPai,gamer.sSex);
			gamer.OnPutPaiResponse(message.putPai);
			m_nLastUserID = m_nUserID;
		}
		//打牌成功
		public function OnPutPaiNotify(message:*):void
		{
			var gamer:Gamer = GetGamer(message.nUserID);
			GameIF.GetPutPaiSound(message.putPai,gamer.sSex);
			gamer.OnPutPaiNotify(message.putPai);
			m_nLastUserID = message.nUserID;
		}

		//吃碰杠听胡
		public function OnCanPai(message:*):void
		{
			GetGamer(message.nUserID).OnCanPai(message);
		}
		//过牌响应
		public function OnGuoPaiResponse(message:*):void
		{
			GetGamer(m_nUserID).OnGuoPaiResponse();
		}
		//吃牌响应
		public function OnDoChiPaiResponse(message:*):void 
		{
			GameIF.GetCanPaiSound(m_sChiSound,GetGamer(m_nUserID).sSex);
			GetGamer(m_nUserID).OnDoChiPaiResponse(message);
			GetGamer(message.nLastID).DelLastputPai(message.lastPai);
			vipRoomView.m_boxCurPutPai.visible = false;
		}
		//吃牌成功通知
		public function OnDoChiPaiNotify(message:*):void 
		{
			GameIF.GetCanPaiSound(m_sChiSound,GetGamer(message.nUserID).sSex);
			GetGamer(message.nUserID).OnDoChiPaiNotify(message.pai, message.lastPai);
			GetGamer(message.nLastID).DelLastputPai(message.lastPai);
			vipRoomView.m_boxCurPutPai.visible = false;
		}
		//碰牌响应
		public function OnDoPengPaiResponse(message:*):void 
		{
			GameIF.GetCanPaiSound(m_sPengSound,GetGamer(m_nUserID).sSex);
			GetGamer(m_nUserID).OnDoPengPaiResponse();
			GetGamer(message.nLastID).DelLastputPai(message.lastPai);
			vipRoomView.m_boxCurPutPai.visible = false;
		}
		//碰牌成功通知
		public function OnDoPengPaiNotify(message:*):void 
		{
			GameIF.GetCanPaiSound(m_sPengSound,GetGamer(message.nUserID).sSex);
			GetGamer(message.nUserID).OnDoPengPaiNotify(message.pai);
			GetGamer(message.nLastID).DelLastputPai(message.lastPai);
			vipRoomView.m_boxCurPutPai.visible = false;
		}
		//杠牌响应
		public function OnDoGangPaiResponse(message:*):void 
		{
			GameIF.GetCanPaiSound(m_sGangSound,GetGamer(m_nUserID).sSex);
			var json:JSON = GameIF.GetJson()["GangType"];
			if(message.pai.nGangState==json["AnGang"])
			{
				GetGamer(m_nUserID).OnDoAnGangPaiResponse(message);
			}
			else if (message.pai.nGangState==json["MiGang"])
			{
				GetGamer(m_nUserID).OnDoGangPaiResponse();
				GetGamer(message.nLastID).DelLastputPai(message.lastPai);
				vipRoomView.m_boxCurPutPai.visible = false;
			}
			else if (message.pai.nGangState==json["MoGang"])
			{
				GetGamer(m_nUserID).OnDoMoGangPaiResponse(message);
			}
		
		}
		//杠牌成功通知
		public function OnDoGangPaiNotify(message:*):void 
		{
			GameIF.GetCanPaiSound(m_sGangSound,GetGamer(message.nUserID).sSex);
			var json:JSON = GameIF.GetJson()["GangType"];
			if (message.pai.nGangState==json["MiGang"])
			{
				vipRoomView.m_boxCurPutPai.visible = false;
				GetGamer(message.nLastID).DelLastputPai(message.lastPai);
				GetGamer(message.nUserID).OnDoGangPaiNotify(message);
			}
			else if(message.pai.nGangState==json["AnGang"])
			{
				GetGamer(message.nUserID).OnDoAnGangPaiNotify(message);
			}
			else if (message.pai.nGangState==json["MoGang"])
			{
				GetGamer(message.nUserID).OnDoGangPaiNotify(message);
			}
		}
		//听牌响应
		public function OnDoTingPaiResponse(message:*):void 
		{
			GameIF.GetCanPaiSound(m_sTingSound,GetGamer(m_nUserID).sSex);
			GetGamer(m_nUserID).OnDoTingPaiResponse();
		}
		//听牌成功通知
		public function OnDoTingPaiNotify(message:*):void 
		{
			GameIF.GetCanPaiSound(m_sTingSound,GetGamer(message.nUserID).sSex);
			GetGamer(message.nUserID).OnDoTingPaiNotify();
		}
		
		//抢听牌响应
		public function OnDoQiangTingPaiResponse(message:*):void 
		{
			GameIF.GetCanPaiSound(m_sTingSound,GetGamer(m_nUserID).sSex);
			GetGamer(m_nUserID).OnDoQiangTingPaiResponse(message);
			GetGamer(message.nLastID).DelLastputPai(message.lastPai);
			vipRoomView.m_boxCurPutPai.visible = false;
		}
		//抢牌成功通知
		public function OnDoQiangTingPaiNotify(message:*):void 
		{
			GameIF.GetCanPaiSound(m_sTingSound,GetGamer(message.nUserID).sSex);
			GetGamer(message.nUserID).OnDoQiangTingPaiNotify(message);
			GetGamer(message.nLastID).DelLastputPai(message.lastPai);
			vipRoomView.m_boxCurPutPai.visible = false;
		}
		
		//胡牌响应
		public function OnDoHuPaiResponse(gamerid:*):void 
		{
			GameIF.GetCanPaiSound(m_sHuSound,GetGamer(m_nUserID).sSex);
			GetGamer(m_nUserID).OnDoHuPaiResponse();
		}
		//胡牌成功通知
		public function OnDoHuPaiNotify(message:*):void 
		{
			GameIF.GetCanPaiSound(m_sHuSound,GetGamer(message.nUserID).sSex);
			GetGamer(message.nUserID).OnDoHuPaiNotify();
		}
		//游戏结束通知
		public function OnGameEndNotify(message:*):void 
		{
			m_nRound += 1;
			vipRoomView.m_boxCurPutPai.visible = false;
			GetGamer(m_nUserID).OffCur();
			for each(var gamer:Gamer in m_dalGamer.gamerPool.values)
			{
				//gamer.OnTanPai();
				gamer.OnTanPai();
			}
			//取消托管
			GetGamer(m_nUserID).bAI = false;
		}
		//结算
		public function OnGameTimeTickNotify(message:*):void 
		{
			
		}
		//准备
		public function OnReadygamenotify(message:*):void 
		{
			GetGamer(message.nUserID).OnReady();
		}
		public function OnReadygameresponse():void 
		{
			roomReset();
			GetGamer(m_nUserID).OnReady();
		}
		//重置房间
		public function roomReset():void 
		{
			
			for each(var gamer:Gamer in m_dalGamer.gamerPool.values)
			{
				gamer.Reset();
			}
			m_BaoPai = null;
			vipRoomViewReset();
		}
		protected function vipRoomViewReset():void
		{
			vipRoomView.m_boxCurPutPai.visible = false;
			vipRoomView.m_labPaiNum.text = "00";
			
			vipRoomView.m_imgTingSign0.visible = false;
			vipRoomView.m_imgTingSign1.visible = false;
			vipRoomView.m_imgTingSign2.visible = false;
			vipRoomView.m_imgTingSign3.visible = false;
		}
		//聊天
		public function OnChatResponse(message:*):void
		{
			GetGamer(m_nUserID).OnChatResponse(message);
		}
		public function OnChatNotify(message:*):void
		{
			GetGamer(message.nUserID).OnChatNotify(message);
		}
		//托管
		public function onDelegateResponse(message:*):void 
		{
			GetGamer(m_nUserID).bAI = message.bDo;
		}
		public function SendDelegateRequest(bDelegate:Boolean):void 
		{
			var DelegateRequestMsg:* = NetworkManager.m_msgRoot.lookupType("DelegateRequest");
			var delegateRequestMsg:* = DelegateRequestMsg.create({
				nUserID:GameIF.GetDalManager().daluser.nID,
				sRoomID:GameIF.GetRoom().sRoomID,
				bDo:bDelegate
			});
			//Request当中具体的内容
			var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
			var requestMsg:* = Request.create({
				delegateRequest:delegateRequestMsg
			});
			////包含了Request的内容
			var Msg:* = NetworkManager.m_msgRoot.lookupType("Msg");
			var MsgMessage:* = Msg.create({
				type:93,
				request:requestMsg
			});
			var encodeMessage:* = Msg.encode(MsgMessage).finish();
			GameIF.getInstance().networkManager.SocketSendMessage(encodeMessage);
		}
		public function Destroy():void 
		{
			GameIF.getInstance().dalmanager.dalRoom.DelRoom(m_sRoomID);
			for each(var gamer:Gamer in m_dalGamer.gamerPool.values)
			{
				gamer.Destroy();
				DelGamer(gamer.nGID);
				gamer = null;
			}
			m_dalGamer = null;
			
			Laya.timer.clear(this,SetCurTime);
			
			//销毁结算逻辑
			GameIF.DectiveLogic(LogicManager.GAMESETTLEMENTLOGIC);
			//销毁房间设置逻辑
			GameIF.DectiveLogic(LogicManager.ROOMSETLOGIC);
			//销毁玩家信息逻辑
			GameIF.DectiveLogic(LogicManager.GAMEINFOLOGIC);
			//规则
			GameIF.DectiveLogic(LogicManager.REGULARLOGIC);
			
			if (vipRoomView)
			{
				vipRoomView.visible = false;
				vipRoomView.Destroy();
				vipRoomView = null;
			}
			
		}
	}

}