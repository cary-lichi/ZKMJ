package blls
{
	import blls._Game.GamerInfoLogic;
	import blls._Game.CreateRoomLogic;
	import blls._GamehallLogic.InputRoomIDLogic;
	import blls._GamehallLogic.MailLogic;
	import core.GameIF;
	import core.LogicManager;
	import core.SdkManager;
	import laya.events.Event;
	import laya.net.Loader;
	import laya.ui.Clip;
	import laya.utils.Byte;
	import laya.utils.Handler;
	import laya.webgl.WebGL;
	import model._Gamer.Gamer;
	import model._Pai.Pai;
	import model._Room.Room;
	import model.User;
	import network.NetworkManager;
	import view.ActiveView.ListMoreView;
	import view.ActiveView.PopUpDia;
	import view.GamehallView;
	import laya.utils.Tween;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GamehallLogic extends BaseLogic
	{
		//声明
		private var m_gamehallView:GamehallView;
		
		//动态加载回调参数数组
		private var m_paramArr:Array = [];
		//需动态加载所要加载的逻辑序号
		private var m_nLogicIndex:int = 0;
		private var m_popUpDia:view.ActiveView.PopUpDia;
		
		public function GamehallLogic()
		{
			super();
		}
		
		public override function Init():void
		{
			if (m_gamehallView == null)
			{
				m_gamehallView = new GamehallView;
				m_gamehallView.Init();
			}
			m_gamehallView.visible = true;
			//注册所有按钮事件
			InitClickEvent();
			//初始化信息
			InitDal();
			//激活加入房间逻辑
			GameIF.ActiveLogic(LogicManager.INPUTROOMIDLOGIC);
			//规则
			GameIF.ActiveLogic(LogicManager.REGULARLOGIC);
			//个人信息
			GameIF.ActiveLogic(LogicManager.GAMEINFOLOGIC);
			
			//不同设备有特殊需求
			InitEquip();
			
			//测试//
			//SendWelfareRequest();
			SendMailRequest();
		}
		
		//初始化信息
		public function InitDal():void
		{
			if (m_gamehallView == null)
			{
				return;
			}
			var user:User = GameIF.GetUser();
			//初始化金币
			GameIF.getInstance().uiManager.showNumber(m_gamehallView.m_boxMa, user.nGold);
			//初始化房卡
			GameIF.getInstance().uiManager.showNumber(m_gamehallView.m_boxCard, user.nMoney);
			//初始化ID
			m_gamehallView.m_lableUserID.text = user.nUserID.toString();
			m_gamehallView.m_Avatar.skin = user.sHeadimg;
			m_gamehallView.m_userName.text = user.sNick;
			m_gamehallView.m_imgSharePrompt.visible = user.bShareAwardWeek?false:true;
			
		}
		private function InitEquip():void 
		{
			var json:* = GameIF.GetJson();
			if (json["equipType"] == json["equipEnum"]["Web"])
			{
				//网页
				InitWebEquip();
			}
			else if (json["equipType"] == json["equipEnum"]["Android"])
			{
				//Android
				InitAndroidEquip();
			}
			else if (json["equipType"] == json["equipEnum"]["IOS"])
			{
				//IOS
				InitIOSEquip();
			}
			else if (json["equipType"] == json["equipEnum"]["wxWeb"])
			{
				//微信
				InitwxWebEquip();
			}
			else if (json["equipType"] == json["equipEnum"]["wxMin"])
			{
				//微信
				InitwxMinEquip();
			}
		}
		
		private function InitWebEquip():void 
		{
			m_gamehallView.m_btnShare.visible = false;
		}
		
		private function InitAndroidEquip():void 
		{
			
		}
		
		private function InitIOSEquip():void 
		{
			m_gamehallView.m_btnShare.visible = false;
		}
		
		private function InitwxWebEquip():void 
		{
			
		}
		private function InitwxMinEquip():void{
			m_gamehallView.m_btnShare.visible = false;
		}
		
		//接受message
		public override function OnReceiveMessage(msg:*):void
		{
			if (m_gamehallView == null)
			{
				return;
			}
			else if (msg.type == 88)//welfareResponse
			{
				OnWelfareResponse(msg.response.welfareResponse);
			}
			else if (msg.type == 96)//loginHeartResponse
			{
				OnLoginHeartResponse(msg.response.loginHeartResponse);
			}
			else if (msg.type == 98)//shareResponse
			{
				OnShareResponse(msg.response.shareResponse);
			}
			else if (msg.type == 100)//mailResponse
			{
				OnMailResponse(msg.response.mailResponse);
			}
			
		}
		private function OnWelfareResponse(message:*):void
		{
			if (message.nErrorCode == 0)
			{
				GameIF.GetUser().nGold = message.newAssets.nGold;
				GameIF.GetUser().bWelfareToday = true;
				InitDal();
				//测试//
				//onHappyRoomClicked();
			}
		}
		
		private function OnLoginHeartResponse(message:*):void
		{
			var nErrorCode:JSON = GameIF.GetJson()["nErrorCode"];
			if (message.nErrorCode == nErrorCode["success"])
			{
				m_gamehallView.m_labBonusNum.text = 437 + message.nHappyNum;	
			}
		}
		private function OnShareResponse(message:*):void 
		{
			if (message.nErrorCode == 0)
			{
				GameIF.GetShareSuccessDia(GameIF.GetJson()["rookieAward"]["shareSuccess"]);
				GameIF.GetUser().nMoney = message.newAssets.nMoney;
				GameIF.GetUser().bShareAwardWeek = true;
				InitDal();
			}
		}
		private function OnMailResponse(message:*):void 
		{
			if (message.nErrorCode == 0)
			{
				
			}
		}
		
		///m_gamehallView的点击事件注册
		private function InitClickEvent():void
		{
			//代开房间
			m_gamehallView.m_btnDeleCreateRoom.on(Event.CLICK, this, onBtnDeleCreateRoomClicked);
			//代开房间背景
			m_gamehallView.m_imgDeleBackBg.on(Event.CLICK, this, onBtnDeleBackBgClicked);
			//创建代理房间
			m_gamehallView.m_btnDeleHRBRoom.on(Event.CLICK, this, onBtnDeleHRBRoomClicked);
			m_gamehallView.m_btnDeleMDJRoom.on(Event.CLICK, this, onBtnDeleMDJRoomClicked);
			//创建房间
			m_gamehallView.m_btnCreateCommonRoom.on(Event.CLICK, this, onCreateCommonRoomClicked);
			m_gamehallView.m_btnCreateLanziRoom.on(Event.CLICK, this, onBtnCreateMDJRoomClicked);
			//加入房间
			m_gamehallView.m_btnJoinRoom.on(Event.CLICK, this, onBtnJoinRoomClicked);
			//欢乐场
			m_gamehallView.m_btnHappyRoom.on(Event.CLICK, this, onHappyRoomClicked);
			//商城
			m_gamehallView.m_btnShop.on(Event.CLICK, this, onBtnShopClicked);
			//规则
			m_gamehallView.m_btnRegular.on(Event.CLICK, this, onReuglarClicked);
			//服务
			m_gamehallView.m_btnService.on(Event.CLICK, this, onServiceClicked);
			//合作
			m_gamehallView.m_btnCooperation.on(Event.CLICK, this, onCoopClicked);
			//绑定
			m_gamehallView.m_btnBand.on(Event.CLICK, this, onBandClicked);
			//公告
			m_gamehallView.m_btnAnnounce.on(Event.CLICK, this, onAnnounceClicked);
			//设置
			m_gamehallView.m_btnSet.on(Event.CLICK, this, onSetClicked);
			//获取
			m_gamehallView.m_btnGaim.on(Event.CLICK, this, onGaimClicked);
			//加微信
			m_gamehallView.m_btnAddMe.on(Event.CLICK, this, onAddMeClicked);
			//分享
			m_gamehallView.m_btnShare.on(Event.CLICK, this, onShareClicked);
			//战绩
			m_gamehallView.m_btnGrade.on(Event.CLICK, this, onGradeClicked);
			//我的信息
			m_gamehallView.m_btnDetail.on(Event.CLICK, this, onDetailClicked);
			//领奖
			m_gamehallView.m_btn_Award.on(Event.CLICK, this, onAwardClicked);
			//房卡加号
			m_gamehallView.m_btnAddCard.on(Event.CLICK, this, onBtnShopClicked);
			//邮件
			m_gamehallView.m_btnMeil.on(Event.CLICK, this, onMeilClicked);
		}
		
		private function onServiceClicked():void
		{
			GameIF.ActiveLogic(LogicManager.SERVICELOGIC);
		}
		
		public override function Destroy():void
		{
			if (m_gamehallView)
			{
				m_gamehallView.Destroy();
				m_gamehallView.destroy();
				m_gamehallView = null;
				
				//销毁输入房间逻辑
				GameIF.DectiveLogic(LogicManager.INPUTROOMIDLOGIC);
				//规则
				GameIF.DectiveLogic(LogicManager.REGULARLOGIC);
				//个人信息
				GameIF.DectiveLogic(LogicManager.GAMEINFOLOGIC);
			}
		
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		///               进入规则界面的内容                                                              ///
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		private function onReuglarClicked():void
		{
			var logic:RegularLogic = GameIF.GetLogic(LogicManager.REGULARLOGIC) as RegularLogic;
			logic.Show();
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		///               进入合作的内容                                                              ///
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		private function onCoopClicked():void
		{
			GameIF.DectiveLogic(LogicManager.GAMEHALLLOGIC);
			GameIF.ActiveLogic(LogicManager.COOPLOGIC);
		
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		///                显示绑定的内容                                                              ///
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		private function onBandClicked():void
		{
			GameIF.ActiveLogic(LogicManager.CERTIFICATIONLOGIC);
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		///                显示公告的内容                                                              ///
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		private function onAnnounceClicked():void
		{
			GameIF.ActiveLogic(LogicManager.NOTICELOGIC);
		
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		///                显示设置的内容                                                              ///
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		private function onSetClicked():void
		{
			GameIF.ActiveLogic(LogicManager.SETLOGIC);
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		///                显示获取的内容                                                              ///
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		private function onGaimClicked():void
		{
			GameIF.ActiveLogic(LogicManager.SPREELOGIC);
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		///                显示加我的内容                                                              ///
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		private function onAddMeClicked():void
		{
			GameIF.ActiveLogic(LogicManager.ADDWXLOGIC);
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		///                显示分享的内容                                                              ///
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		//private function onShareClicked():void
		//{
			//GameIF.ActiveLogic(LogicManager.INVITEWINDOW);
		//}
		private function onShareClicked():void 
		{
			
			var json:* = GameIF.GetJson();
				if (json["equipType"] == json["equipEnum"]["Web"])
					henderWebWX();
				if (json["equipType"] == json["equipEnum"]["Android"])
					henderAndroidWX();
				if (json["equipType"] == json["equipEnum"]["IOS"])
					henderIOSWX();
				if (json["equipType"] == json["equipEnum"]["wxWeb"])
					henderwxWebWX();
		}
		
		private function henderWebWX():void 
		{
			
			GameIF.ActiveLogic(LogicManager.SHAREPROMPTLOGIC);
		} 
		
		private function henderAndroidWX():void 
		{
			//创建Test类
			var Test:*=Laya.PlatformClass.createClass("com.tianhu.majiang.WxAndroid");
			//创建Test 对象
			var testAdd:* = Test.newObject(); //不支持构造函数
			//调用成员函数
			testAdd.callWithBack(ShareSuccess,"wxSharePicture");
		}
		
		private function henderIOSWX():void 
		{
			//创建Test类
			var Test:*=Laya.PlatformClass.createClass("SwxClass");
			//创建Test 对象
			var testAdd:* = Test.newObject(); //不支持构造函数
			//调用成员函数
			testAdd.callWithBack(null,"wxShareSceneTimeline");
		}
		private function henderwxWebWX():void 
		{
			GameIF.ActiveLogic(LogicManager.SHAREPROMPTLOGIC);
			var logich:GamehallLogic = this;
			__JS__('btnShareMessage(this)');
		}
		
		private function ShareSuccess(message:*=null):void 
		{
			var ShareRequestMsg:* = NetworkManager.m_msgRoot.lookupType("ShareRequest");
			var shareRequestMsg:* = ShareRequestMsg.create({nUserID: GameIF.GetUser().nUserID});
			//Request当中具体的内容
			var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
			var requestMsg:* = Request.create({shareRequest: shareRequestMsg});
			////包含了Request的内容
			var Msg:* = NetworkManager.m_msgRoot.lookupType("Msg");
			var MsgMessage:* = Msg.create({type: 97, request: requestMsg});
			var encodeMessage:* = Msg.encode(MsgMessage).finish();
			GameIF.getInstance().networkManager.HttpSendMessage(encodeMessage, "share");
		}
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		///                显示战绩的内容                                                              ///
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function onGradeClicked():void
		{
			GameIF.DectiveLogic(LogicManager.GAMEHALLLOGIC);
			GameIF.ActiveLogic(LogicManager.RECORDLOGIC);
			//GameIF.GetPopUpDia("敬请开放");
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		///                显示我的信息                                                              ///
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		private function onDetailClicked():void
		{
			//GameIF.ActiveLogic(LogicManager.GAMEINFOLOGIC);
			var logic:GamerInfoLogic = GameIF.GetLogic(LogicManager.GAMEINFOLOGIC) as GamerInfoLogic;
			logic.ShowGamerInfo();
			logic.DalInit(GameIF.GetUser());
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		///                显示商城按钮的内容                                                             ///
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		private function onBtnShopClicked():void
		{
			m_nLogicIndex = LogicManager.ROOMGOLDLOGIC;
			m_paramArr.push(m_nLogicIndex);
			//显示加载界面
			GameIF.ActiveLogic(LogicManager.LOADINGLOGIC);
			Laya.loader.load([{url: "res/atlas/roomGold.json", type: Loader.ATLAS}], Handler.create(this, onLoaded, m_paramArr), Handler.create(this, onLoading, null, false));
		}
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		///                显示邮件的内容                                                             ///
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		private function onMeilClicked():void
		{
			//GameIF.GetPopUpDia("敬请期待");
			GameIF.ActiveLogic(LogicManager.MAILLOGIC);
			var mailLogic:MailLogic = GameIF.GetLogic(LogicManager.MAILLOGIC) as MailLogic;
			mailLogic.InitDal();
		}
		//动态加载的过程
		private function onLoading(progress:Number):void
		{
			var lg:LoadingLogic = GameIF.GetLogic(LogicManager.LOADINGLOGIC) as LoadingLogic;
			lg.changeValue(progress);
		}
		
		//动态加载完成回调
		private function onLoaded(activeLogic:int):void
		{
			GameIF.DectiveLogic(LogicManager.LOADINGLOGIC);
			GameIF.ActiveLogic(activeLogic);
			m_paramArr = [];
		}
		
		private function onBtnAddMaClicked():void
		{
			GameIF.ActiveLogic(LogicManager.ROOMGOLDLOGIC);
			var roomlogic:RoomGoldLogic = GameIF.GetLogic(LogicManager.ROOMGOLDLOGIC) as RoomGoldLogic;
			roomlogic.JoinMa();
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		///                显示领奖按钮的内容                                                             ///
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		private function onAwardClicked():void
		{
			GameIF.DectiveLogic(LogicManager.GAMEHALLLOGIC);
			GameIF.ActiveLogic(LogicManager.TURNTABLELOGIC);
		}
		
		//显示分享成功弹窗
		private function ShowPopUpDia():void 
		{
			m_popUpDia = null;
			m_popUpDia = new PopUpDia;
			m_popUpDia.Init();
			m_popUpDia.m_lableisOK.text = "确定";
			m_popUpDia.m_lableTitle.visible = false;
			m_popUpDia.m_boxShare.visible = true;
			m_popUpDia.m_btnIsOK.on(Event.CLICK, this, OnIsOkClicked);
			m_popUpDia.m_imgBackBg.on(Event.CLICK, this, OnBackBgClicked);
		}
		private function OnIsOkClicked():void 
		{
			m_popUpDia.Destroy();
			m_popUpDia = null;
		}
		
		private function OnBackBgClicked():void 
		{
			return;
		}

		//进入创建房间
		private function onBtnCreateRoomClicked():void
		{
			GameIF.DectiveLogic(LogicManager.GAMEHALLLOGIC);
			
			m_nLogicIndex = LogicManager.VIPHALLLOGIC;
			m_paramArr.push(m_nLogicIndex);
			//显示加载界面
			GameIF.ActiveLogic(LogicManager.LOADINGLOGIC);
			Laya.loader.load([{url: "res/atlas/game/pai.json", type: Loader.ATLAS}, {url: "res/atlas/game.json", type: Loader.ATLAS}], Handler.create(this, onLoaded, m_paramArr), Handler.create(this, onLoading, null, false));
		
			//GameIF.ActiveLogic(LogicManager.VIPHALLLOGIC);
		}
		
		//创建代理房间
		private function onBtnDeleCreateRoomClicked():void 
		{
			m_gamehallView.m_imgDeleBackBg.visible = true;
			m_gamehallView.m_boxDeleBtn.visible = true;
		}
		private function onBtnDeleBackBgClicked():void 
		{
			m_gamehallView.m_imgDeleBackBg.visible = false;
			m_gamehallView.m_boxDeleBtn.visible = false;
		}
		private function onBtnDeleHRBRoomClicked():void 
		{
			GameIF.DectiveLogic(LogicManager.GAMEHALLLOGIC);
			GameIF.ActiveLogic(LogicManager.VIPHALLLOGIC);
			var logic:CreateRoomLogic = GameIF.GetLogic(LogicManager.VIPHALLLOGIC) as CreateRoomLogic;
			logic.SetDeleReateRoom();
			//logic.ShowHRBCreateRoom();
		}
		private function onBtnDeleMDJRoomClicked():void 
		{
			GameIF.DectiveLogic(LogicManager.GAMEHALLLOGIC);
			GameIF.ActiveLogic(LogicManager.VIPHALLLOGIC);
			var logic:CreateRoomLogic = GameIF.GetLogic(LogicManager.VIPHALLLOGIC) as CreateRoomLogic;
			logic.SetDeleReateRoom();
			//logic.ShowMDJCreateRoom();
		}
		//创建传统房间
		private function onCreateCommonRoomClicked():void
		{
			GameIF.DectiveLogic(LogicManager.GAMEHALLLOGIC);
			GameIF.ActiveLogic(LogicManager.VIPHALLLOGIC);
			var logic:CreateRoomLogic = GameIF.GetLogic(LogicManager.VIPHALLLOGIC) as CreateRoomLogic;
			logic.SetCommon()
		}
		
		//创建混子房间
		private function onBtnCreateMDJRoomClicked():void
		{
			GameIF.DectiveLogic(LogicManager.GAMEHALLLOGIC);
			GameIF.ActiveLogic(LogicManager.VIPHALLLOGIC);
			var logic:CreateRoomLogic = GameIF.GetLogic(LogicManager.VIPHALLLOGIC) as CreateRoomLogic;
			logic.SetHunzi();
		}
		
		//显示输入房间号
		private function onBtnJoinRoomClicked():void
		{
			//显示加载界面
			GameIF.ActiveLogic(LogicManager.INPUTROOMIDLOGIC);
			var logic:InputRoomIDLogic = GameIF.GetLogic(LogicManager.INPUTROOMIDLOGIC) as InputRoomIDLogic;
			logic.ShowInputRoomID();
			//Laya.loader.load([{url: "res/atlas/game/pai.json", type: Loader.ATLAS}, {url: "res/atlas/game.json", type: Loader.ATLAS}], Handler.create(this, ShowInput), Handler.create(this, onLoading, null, false));
		}
		
		private function ShowInput():void
		{
			GameIF.DectiveLogic(LogicManager.LOADINGLOGIC);
			var logic:InputRoomIDLogic = GameIF.GetLogic(LogicManager.INPUTROOMIDLOGIC) as InputRoomIDLogic;
			logic.ShowInputRoomID();
		}
		
		//进入欢乐场赛
		private function onHappyRoomClicked():void
		{
			//GameIF.DectiveLogic(LogicManager.GAMEHALLLOGIC);
			//GameIF.ActiveLogic(LogicManager.BONUSHALLLOGIC);
			if (GameIF.GetUser().nGold <= 500 && !GameIF.GetUser().bWelfareToday)
			{
				GameIF.GetPopUpDia("你的金币不足，可以领取4000金币", SendWelfareRequest, this);
			}
			else
			{
				GameIF.getInstance().networkManager.InitSocket(this, CreateHappyRoom);
				GameIF.getInstance().networkManager.SocketConnect(GameIF.GetDalManager().daluser.nID);
			}
		}
		//发送请求邮件数据请求
		private function SendMailRequest():void 
		{
			var MailRequestMsg:* = NetworkManager.m_msgRoot.lookupType("MailRequest");
			var mailRequestMsg:* = MailRequestMsg.create({
				nUserID:GameIF.GetUser().nUserID
			});
			//Request当中具体的内容
			var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
			var requestMsg:* = Request.create({
				mailRequest:mailRequestMsg
			});
			////包含了Request的内容
			var Msg:* = NetworkManager.m_msgRoot.lookupType("Msg");
			var MsgMessage:* = Msg.create({
				type:99,
				request:requestMsg
			});
			var encodeMessage:* = Msg.encode(MsgMessage).finish();
			GameIF.getInstance().networkManager.HttpSendMessage(encodeMessage, "mail");
		}
		//发送请求排行数据请求
		private function SendRankRequest():void 
		{
			var RankRequestMsg:* = NetworkManager.m_msgRoot.lookupType("RankRequest");
			var rankRequestMsg:* = RankRequestMsg.create({
				nUserID:GameIF.GetUser().nUserID
			});
			//Request当中具体的内容
			var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
			var requestMsg:* = Request.create({
				rankRequest:rankRequestMsg
			});
			////包含了Request的内容
			var Msg:* = NetworkManager.m_msgRoot.lookupType("Msg");
			var MsgMessage:* = Msg.create({
				type:89,
				request:requestMsg
			});
			var encodeMessage:* = Msg.encode(MsgMessage).finish();
			GameIF.getInstance().networkManager.HttpSendMessage(encodeMessage, "rank");
		}
		//发送领取救济金请求
		private function SendWelfareRequest():void
		{
			GameIF.ClosePopUpDia();
			
			var WelfareRequestMsg:* = NetworkManager.m_msgRoot.lookupType("WelfareRequest");
			var welfareRequestMsg:* = WelfareRequestMsg.create({nUserID: GameIF.GetUser().nUserID});
			//Request当中具体的内容
			var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
			var requestMsg:* = Request.create({welfareRequest: welfareRequestMsg});
			////包含了Request的内容
			var Msg:* = NetworkManager.m_msgRoot.lookupType("Msg");
			var MsgMessage:* = Msg.create({type: 87, request: requestMsg});
			var encodeMessage:* = Msg.encode(MsgMessage).finish();
			GameIF.getInstance().networkManager.HttpSendMessage(encodeMessage, "welfare");
		}
		
		//进入欢乐场
		private function CreateHappyRoom():void
		{
			var nType:int = GameIF.GetJson()["roomType"]["happy"];
			var m_PlayWayArr:Array = [];
			var CardType:String = GameIF.GetJson()["cardType"]["happyRoom"].toString();
			var CreateGamePlayMsg:* = NetworkManager.m_msgRoot.lookupType("GamePlay");
			var createGamePlayMsg:* = CreateGamePlayMsg.create({nType: nType, optionals: m_PlayWayArr});
			
			//Request当中具体的内容
			var CreateRoomRequest:* = NetworkManager.m_msgRoot.lookupType("CreateRoomRequest");
			var createRoomRequestMsg:* = CreateRoomRequest.create({nUserID: GameIF.GetDalManager().daluser.nID, sCardType: CardType, gamePlay: createGamePlayMsg, nPlayers: 4});
			
			//包含了Request的内容
			var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
			var requestMsg:* = Request.create({createRoomRequest: createRoomRequestMsg});
			
			//最终发送的是这个Msg，它里面包含了所嵌套的消息
			var Msg:* = NetworkManager.m_msgRoot.lookupType("Msg");
			var MsgMessage:* = Msg.create({type: 5, request: requestMsg});
			
			//发送之前需要编码，编码使用具体发送时用于查找的那个lookup的变量
			var encodeMessage:* = Msg.encode(MsgMessage).finish();
			GameIF.getInstance().networkManager.SocketSendMessage(encodeMessage);
		}
		
		//<-----------------------我是漂亮的分割线----------------------->
		//<-----------------------下面是接口----------------------->
		public function get gamehallView():GamehallView
		{
			return m_gamehallView;
		}
		
		public function set gamehallView(value:GamehallView):void
		{
			m_gamehallView = value;
		}
	
	}

}