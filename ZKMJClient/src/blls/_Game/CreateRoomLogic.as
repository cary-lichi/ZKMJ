package blls._Game 
{
	import blls.BaseLogic;
	import core.GameIF;
	import core.LogicManager;
	import laya.events.Event;
	import laya.ui.Image;
	import laya.utils.Handler;
	import model._Gamer.Gamer;
	import model._Gamer.GamerBottom;
	import model._Room.Room;
	import model.User;
	import network.NetworkManager;
	import tool.Tool;
	import view.ActiveView.PopUpDia;
	import view.ActiveView.VIPHallView;
	/**
	 * ...
	 * @author ...
	 */
	public class CreateRoomLogic extends BaseLogic 
	{
		private var m_vipHallView:VIPHallView;
		//玩法子类
		private var m_PlayWayArr:Array = [];
		//房间类型
		private var m_nRoomType:int = 1;
		//房卡类型(2、4、8圈房卡)
		private var m_CardType:int = 1;
		//房间人数（ 2 3 4 人）
		private var m_nPlayers:int = 4;
		
		private  var m_Tcommon:int;
		private  var m_Thunzi:int ;
		
		private  var m_Czimo:int;
		private  var m_Cdianpao:int ;
		private  var m_Csfdh:int ;
		private  var m_Ccft:int ;
		private  var m_Clsdy:int ;
		private  var m_Ctybb:int ;
		private  var m_Cybc:int ;
		private  var m_Czfb:int ;
		private  var m_Cdaihun:int ;
		
		private var m_popUpDia:PopUpDia;
		
		public function CreateRoomLogic() 
		{
			super();
			
		}
		public override function Init():void
		{
			//初始化LoginView
			if (m_vipHallView == null)
			{
				m_vipHallView = new VIPHallView;
				m_vipHallView.Init();
			}
			m_vipHallView.visible = true;

			//注册所有按钮事件
			registerEventClick();
			//哈尔滨玩法
			InitEvent();
			//从配置文件获取信息
			InitJson();
			
			m_PlayWayArr = [];
		}
		//从配置文件获取信息
		private function InitJson():void 
		{
			var roomType:JSON = GameIF.GetJson()["roomType"];
			m_Tcommon = roomType["common"];
			m_Thunzi = roomType["hunzi"];
			
			var gamePlay:JSON = GameIF.GetJson()['gamePlay'];
			m_Czimo = gamePlay["zimo"];
			m_Cdianpao = gamePlay["dianpao"];
			m_Csfdh = gamePlay["sfdh"];
			m_Ccft = gamePlay["cft"];
			m_Clsdy = gamePlay["lsdy"];
			m_Ctybb = gamePlay["tybb"];
			m_Cybc = gamePlay["ybc"];
			m_Czfb = gamePlay["zhuang"];
			m_Cdaihun = gamePlay["daihun"];
		}
		private function InitEvent():void 
		{
			m_vipHallView.m_cbCcft.on(Event.CLICK, this, OnGamePlayClicked);
			m_vipHallView.m_cbClsdy.on(Event.CLICK, this, OnGamePlayClicked);
			m_vipHallView.m_cbCsfdh.on(Event.CLICK, this, OnGamePlayClicked);
			m_vipHallView.m_cbCtybb.on(Event.CLICK, this, OnGamePlayClicked);
			m_vipHallView.m_cbCybc.on(Event.CLICK, this, OnGamePlayClicked);
			m_vipHallView.m_cbCypdx.on(Event.CLICK, this, OnGamePlayClicked);
			m_vipHallView.m_cbCzfb.on(Event.CLICK, this, OnGamePlayClicked);
			m_vipHallView.m_cbCzm.on(Event.CLICK, this, OnGamePlayClicked);
		}
		
		private function OnGamePlayClicked(e:Event):void
		{
			switch(e.target.name)
			{
				case "ypdx":
					if (m_vipHallView.m_cbCypdx.selected)
					{
						AddPlayWay(m_Cdianpao);
					}
					else if (!m_vipHallView.m_cbCypdx.selected)
					{
						DelPlayWay(m_Cdianpao);
					}
					break;
				case "zm":
					if (m_vipHallView.m_cbCzm.selected)
					{
						AddPlayWay(m_Czimo);
					}
					else if (!m_vipHallView.m_cbCzm.selected)
					{
						DelPlayWay(m_Czimo);
					}
					break;
				case "sfdh":
					if (m_vipHallView.m_cbCsfdh.selected)
					{
						AddPlayWay(m_Csfdh);
					}
					else if (!m_vipHallView.m_cbCsfdh.selected)
					{
						DelPlayWay(m_Csfdh);
					}
					break;
				case "cft":
					if (m_vipHallView.m_cbCcft.selected)
					{
						AddPlayWay(m_Ccft);
					}
					else if (!m_vipHallView.m_cbCcft.selected)
					{
						DelPlayWay(m_Ccft);
					}
					break;
				case "lsdy":
					if (m_vipHallView.m_cbClsdy.selected)
					{
						AddPlayWay(m_Clsdy);
					}
					else if (!m_vipHallView.m_cbClsdy.selected)
					{
						DelPlayWay(m_Clsdy);
					}
					break;
				case "tybb":
					if (m_vipHallView.m_cbCtybb.selected)
					{
						AddPlayWay(m_Ctybb);
					}
					else if (!m_vipHallView.m_cbCtybb.selected)
					{
						DelPlayWay(m_Ctybb);
					}
					break;
				case "ybc":
					if (m_vipHallView.m_cbCybc.selected)
					{
						AddPlayWay(m_Cybc);
					}
					else if (!m_vipHallView.m_cbCybc.selected)
					{
						DelPlayWay(m_Cybc);
					}
					break;
				case "zfb":
					if (m_vipHallView.m_cbCzfb.selected)
					{
						AddPlayWay(m_Czfb);
					}
					else if (!m_vipHallView.m_cbCzfb.selected)
					{
						DelPlayWay(m_Czfb);
					}
					break;
				
			}
		}

		private function AddPlayWay(index:Number):void
		{
			m_PlayWayArr.push(index);
		}
		
		private function DelPlayWay(index:Number):void
		{
			for (var i:Number = 0; i < m_PlayWayArr.length; i++ )
			{
				if (m_PlayWayArr[i] == index)
				{
					m_PlayWayArr.splice(i, 1);
					break;
				}
			}
		}
		//哈尔滨 牡丹江  圈数 
		private function onNumCHange(index:int):void 
		{
			m_CardType = index + 1;
			m_vipHallView.m_TextDiamonds.text = "x" + (m_vipHallView.m_RadioNum.selectedIndex+2);
		}
		//人数
		private function onGamerNumCHange(index:int):void 
		{
			m_nPlayers = 4 - index;
		}
		public override function Destroy():void
		{
			if (m_vipHallView)
			{
				m_vipHallView.Destroy();
				m_vipHallView.destroy();
				m_vipHallView = null;
			}
		}
		
		//注册所有按钮事件	
		private function registerEventClick():void 
		{
			m_vipHallView.m_btnBack.on(Event.CLICK, this, onBackClicked);
			 //创建房间
			 m_vipHallView.m_createRoom.offAll();
			 m_vipHallView.m_createRoom.on(Event.CLICK, this, onCreateRoomClicked);
			//局数
			m_vipHallView.m_RadioNum.selectHandler = new Handler(this, onNumCHange);
			//人数
			m_vipHallView.m_RadioGamerNum.selectHandler = new Handler(this,onGamerNumCHange);
		}
		
		//普通房间
		private function onCreateRoomClicked():void 
		{
			//连接Socket
			GameIF.getInstance().networkManager.InitSocket(this,CreateVIPRoom);
			GameIF.getInstance().networkManager.SocketConnect(GameIF.GetDalManager().daluser.nID);
		}
		//代理房间
		private function onCreateDeleRoomClicked():void 
		{
			//直接发送
			CreateDeleRoom();
		}
		
		private function onBackClicked():void 
		{
			GameIF.DectiveLogic(LogicManager.VIPHALLLOGIC);
			GameIF.ActiveLogic(LogicManager.GAMEHALLLOGIC);
		}
		//代理房间
		public function SetDeleReateRoom():void 
		{
			m_vipHallView.m_createRoom.offAll();
			m_vipHallView.m_createRoom.on(Event.CLICK, this, onCreateDeleRoomClicked);
		}
		//传统玩法
		public function SetCommon():void 
		{
			m_nRoomType = m_Tcommon;
		}
		//混子玩法
		public function SetHunzi():void 
		{
			m_nRoomType = m_Thunzi;
		}
		//VipHall创建房间
		private function CreateVIPRoom():void
		{	
			var CreateGamePlayMsg:* = NetworkManager.m_msgRoot.lookupType("GamePlay");
			var createGamePlayMsg:* = CreateGamePlayMsg.create({
				nType:m_nRoomType,
				optionals:m_PlayWayArr
			});
			
			//Request当中具体的内容
			var CreateRoomRequest:* = NetworkManager.m_msgRoot.lookupType("CreateRoomRequest");
			var createRoomRequestMsg:* = CreateRoomRequest.create({
				nUserID:GameIF.GetDalManager().daluser.nID,
				sCardType:m_CardType.toString(),
				nPlayers:m_nPlayers.toString(),
				gamePlay:createGamePlayMsg
			});
			
			//包含了Request的内容
			var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
			var requestMsg:* = Request.create({
				createRoomRequest:createRoomRequestMsg
			});
			
			//最终发送的是这个Msg，它里面包含了所嵌套的消息
			var Msg:* = NetworkManager.m_msgRoot.lookupType("Msg");
			var MsgMessage:* = Msg.create({
				type:5,
				request:requestMsg
			});
			
			//发送之前需要编码，编码使用具体发送时用于查找的那个lookup的变量
			var encodeMessage:* = Msg.encode(MsgMessage).finish();
			GameIF.getInstance().networkManager.SocketSendMessage(encodeMessage);
		}
		//创建代理房间
		private function CreateDeleRoom():void 
		{
			var CreateGamePlayMsg:* = NetworkManager.m_msgRoot.lookupType("GamePlay");
			var createGamePlayMsg:* = CreateGamePlayMsg.create({
				nType:m_nRoomType,
				optionals:m_PlayWayArr
			});
			
			//Request当中具体的内容
			var CreateRoomRequest:* = NetworkManager.m_msgRoot.lookupType("CreateDeleRoomRequest");
			var createRoomRequestMsg:* = CreateRoomRequest.create({
				nUserID:GameIF.GetDalManager().daluser.nID,
				sCardType:m_CardType.toString(),
				nPlayers:m_nPlayers.toString(),
				gamePlay:createGamePlayMsg
			});
			
			//包含了Request的内容
			var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
			var requestMsg:* = Request.create({
				createRoomRequest:createRoomRequestMsg
			});
			
			//最终发送的是这个Msg，它里面包含了所嵌套的消息
			var Msg:* = NetworkManager.m_msgRoot.lookupType("Msg");
			var MsgMessage:* = Msg.create({
				type:5,
				request:requestMsg
			});
			
			//发送之前需要编码，编码使用具体发送时用于查找的那个lookup的变量
			var encodeMessage:* = Msg.encode(MsgMessage).finish();
			GameIF.getInstance().networkManager.HttpSendMessage(encodeMessage,"deleCreateRoom");
		}
		
		//创建房间时接收到的消息
		public override function OnReceiveMessage(msg:*):void
		{
			//最好写个枚举类型定义或直接用Proto中定义的
			if (msg.type == 6)//createroomresponse
			{
				OnCreateRoomResponse(msg.response.createRoomResponse);
			}
			else if (msg.type == 102)
			{
				OnCreateDeleRoomResponse(msg.response.createRoomResponse);
			}
		}
		
		//接受消息
		private function OnCreateRoomResponse(message:*):void
		{
			var nErrorCode:JSON = GameIF.GetJson()["nErrorCode"];
			if (message.nErrorCode == nErrorCode["success"])
			{
				var room:Room = Tool.getNewRoom(message.gamePlay.nType);
				room.sRoomID = message.sRoomID;
				room.sCardType = message.sCardType;
				room.SetPlayers(message.nPlayers);
				//添加一个room
				GameIF.GetDalManager().dalRoom.AddRoom(room);
				
				var gamer:Gamer = Tool.getNewGamer(0,0);
				var user:User = GameIF.GetUser();
				gamer.nGID = user.nUserID;
				gamer.nPos = 0;//东南西北
				gamer.bBoss = true;
				gamer.bOwner = true;
				gamer.sNick = user.sNick;
				gamer.sHeadimg = user.sHeadimg;
				gamer.vipRoomView = room.vipRoomView;
				gamer.nGameState = GameIF.GetJson()["gameState"]["join"];
				gamer.nGender = user.nGender;
				gamer.bIsLocation = user.bIsLocation;
				gamer.sLat = user.sLat;
				gamer.sLng = user.sLng;
				gamer.sAddress = user.sAddress;
				gamer.Init();
				room.AddGamer(gamer);
				room.SetGamePlay(message.gamePlay);
				room.ShowMyGPS();
				//进入游戏逻辑
				
				if (m_vipHallView)
				{
					GameIF.DectiveLogic(LogicManager.VIPHALLLOGIC);
				}
				else
				{
					GameIF.DectiveLogic(LogicManager.GAMEHALLLOGIC);
				}
				GameIF.ActiveLogic(LogicManager.VIPROOMLOGIC);
				
				//测试//
				//room.OnStartGameClicked();
			}
			else if (message.nErrorCode == nErrorCode["moneyerror"])
			{
				ShowPopUpDia();
			}
		}
		
		//代开房间
		private function OnCreateDeleRoomResponse(message:*):void 
		{
			var nErrorCode:JSON = GameIF.GetJson()["nErrorCode"];
			if (message.nErrorCode == nErrorCode["success"])
			{
				InviteFriend(message);
			}
			else
			{
				GameIF.GetPopUpDia("网络繁忙，创建失败");
			}
		}
		//分享好友
		protected function InviteFriend(message:*):void 
		{
			var json:* = GameIF.GetJson();
				if (json["equipType"] == json["equipEnum"]["Web"])
					henderWeb(message);
				if (json["equipType"] == json["equipEnum"]["Android"])
					henderAndroidWX(message);
				if (json["equipType"] == json["equipEnum"]["IOS"])
					henderIOSWX(message);
				if (json["equipType"] == json["equipEnum"]["wxWeb"])
					henderWX(message);
			
		}
		
		protected function henderWeb(message:*):void 
		{
			//GameIF.ActiveLogic(LogicManager.SHAREPROMPTLOGIC);
			return ;
		} 
		
		protected function henderAndroidWX(message:*):void 
		{
			//创建Test类
			var Test:*=Laya.PlatformClass.createClass("com.tianhu.majiang.WxAndroid");
			//创建Test 对象
			var testAdd:* = Test.newObject(); //不支持构造函数
			//调用成员函数
			var roomID:String = message.sRoomID;
			var sICode:String= GameIF.GetUser().sICode;
			testAdd.callWithBack(null,"wxShareSceneSession",roomID,sICode);
		}
		
		protected function henderIOSWX(message:*):void 
		{
			//创建Test类
			var Test:*=Laya.PlatformClass.createClass("SwxClass");
			//创建Test 对象
			var testAdd:* = Test.newObject(); //不支持构造函数
			//调用成员函数
			testAdd.callWithBack(null,"wxShareSceneSession");
		}
		protected function henderWX(message:*):void 
		{
			GameIF.ActiveLogic(LogicManager.SHAREPROMPTLOGIC);
			var roomID:String = message.sRoomID;
			var sICode:String= GameIF.GetUser().sICode;
			__JS__('btnShareAppMessage(roomID,sICode)');
			
		}
		
		private function ShowPopUpDia():void 
		{
			m_popUpDia = null;
			m_popUpDia = new PopUpDia;
			m_popUpDia.Init();
			m_popUpDia.m_lableisOK.text = "去充值";
			m_popUpDia.m_lableTitle.text = "您的钻石不足";
			m_popUpDia.m_btnIsOK.on(Event.CLICK, this, OnIsOkClicked);
			m_popUpDia.m_imgBackBg.on(Event.CLICK, this, OnBackBgClicked);
			m_popUpDia.m_btnClose.visible = true;
			m_popUpDia.m_btnClose.on(Event.CLICK, this, OnCloseClicked);
		}
		
		private function OnCloseClicked():void 
		{
			m_popUpDia.Destroy();
			m_popUpDia = null;
		}
		
		private function OnBackBgClicked():void 
		{
			return;
		}
		
		private function OnIsOkClicked():void 
		{
			GameIF.ActiveLogic(LogicManager.ROOMGOLDLOGIC);
		}
	}

}