package blls 
{
	import blls._Game.GameSettlementLogic;
	import core.GameIF;
	import core.LogicManager;
	import dal.DalUser;
	import laya.events.Event;
	import laya.net.HttpRequest;
	import network.NetworkManager;
	import view.RegisterView;
	import laya.utils.Browser;
	/**
	 * ...
	 * @author dawenhao
	 */
	public class RegisterLogic extends BaseLogic
	{
		private var m_vRegisterView:RegisterView;
		private var m_sName:String;//用户名
		private var m_sPassowrd:String;//密码
		private var m_sOpenID:String;
		private var m_sNick:String;
		private var m_sHeadImage:String;
		private var m_nSex:int=2;
		private var m_siCode:String = "";
		private var m_nUserID:int;
		private var m_sRoomID:int;
		
		public function RegisterLogic() 
		{
			super();
		}
		public override function Init():void
		{	
			//初始化RegisterMainView
			if (m_vRegisterView == null)
			{
				m_vRegisterView = new RegisterView;
				m_vRegisterView.Init();
			}
			m_vRegisterView.visible = true;
			//注册所有按钮事件
			registerEventClick();
			
			//设置用户名，密码
			m_sName = "q";
			m_sPassowrd = "1";
			WebRegister();
		}
		//销毁
		public override function Destroy():void
		{
			m_vRegisterView.Destroy();
			m_vRegisterView.destroy();
			m_vRegisterView = null;
		}
		private function registerEventClick():void 
		{
			m_vRegisterView.m_Retrieve.on(Event.CLICK,this,onisOKClick);
			
		}
		//注册按钮
		private function onisOKClick():void 
		{
			WxRegister();
		}
		//接受message
		public override function OnReceiveMessage(msg:*):void
		{
			return;
			if (msg.type == 2)//RegisterResponse
			{
				Register(msg.response.registerResponse);
			}
			else if (msg.type == 4)//RegisterResponse
			{
				OnLoginResponse(msg.response.loginResponse);
			}
			else if (msg.type == 6)//createroomresponse
			{
				OnCreateRoomResponse(msg.response.createRoomResponse);
			}
			else if (msg.type == 8)//joinroomresponse
			{
				OnJoinRoomResponse(msg.response.joinRoomResponse);
			}
			else if (msg.type == 37)//gameEndNotify
			{
				OnGameEndNotify(msg.notify.gameEndNotify);
			}
			else if (msg.type == 85)//RegisterResponse
			{
				OnluckyRequest(msg.response.luckyResponse);
			}
		}
		
		//LoginResponse 响应
		private function OnLoginResponse(message:*):void 
		{
			if (message.nErrorCode==0)
			{
				m_nUserID = message.requester.nUserID;
				//请求奖励
				SendStart();
			}
		}
		//领奖品
		private function OnluckyRequest(message:*):void 
		{
			if (message.nErrorCode==0)
			{
				//发送加入房间请求
				GameIF.getInstance().networkManager.InitSocket(this, CreateHappyRoom);
				GameIF.getInstance().networkManager.SocketConnect(GameIF.GetDalManager().daluser.nID);
			
			}
		}
		
		//创建房间
		private function OnCreateRoomResponse(message:*):void 
		{
			if (message.nErrorCode == 0)
			{
				m_sRoomID = message.sRoomID;
				//准备
				var logic:GameSettlementLogic = GameIF.GetLogic(LogicManager.GAMESETTLEMENTLOGIC) as GameSettlementLogic;
				logic.SendReadyGameRequest();
			}
			
		}
		//加入房间
		private function OnJoinRoomResponse(message:*):void 
		{
			if (message.nErrorCode == 0)
			{
				m_sRoomID =  message.joinRoom.sID;
				//准备
				var logic:GameSettlementLogic = GameIF.GetLogic(LogicManager.GAMESETTLEMENTLOGIC) as GameSettlementLogic;
				logic.SendReadyGameRequest();
			}
		}
		//游戏结束
		private function OnGameEndNotify(message:*):void 
		{
			//再次准备
			var logic:GameSettlementLogic = GameIF.GetLogic(LogicManager.GAMESETTLEMENTLOGIC) as GameSettlementLogic;
				logic.SendReadyGameRequest();
		}
		//registerResponse 响应
		private function Register(message:*):void 
		{
			if (message.nErrorCode==0)
			{
				m_nUserID = message.nUserID;
				
				var LoginRequestMsg:* = NetworkManager.m_msgRoot.lookupType("LoginRequest");
				var loginRequestMsg:* = LoginRequestMsg.create({
					sName:m_sName,
					sPassWord:m_sPassowrd
				});
				//Request当中具体的内容
				var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
				var requestMsg:* = Request.create({
					loginRquest:loginRequestMsg
				});
				//包含了Request的内容
				var Msg:* = NetworkManager.m_msgRoot.lookupType("Msg");
				var MsgMessage:* = Msg.create({
					type:3,
					request:requestMsg
				});
				var encodeMessage:* = Msg.encode(MsgMessage).finish();
				GameIF.getInstance().networkManager.HttpSendMessage(encodeMessage, "login");
				
				GameIF.DectiveLogic(LogicManager.REGISTERLOGIC);
			}
			else if (message.nErrorCode == 1)
			{
				trace("用户已存在");
			}			
		}
		
		//游客登录
		private function henderWebYKLogin():void 
		{
			//进入模拟登录界面
			//GameIF.ActiveLogic(LogicManager.RETRIEVELOGIC);
			var Random:int = Math.random() * 100;
			var timeStamp:*= Browser.now();
			var m_sName:String = timeStamp + "." + Random;
			m_sNick = GameIF.GetJson()["equipName"][GameIF.GetJson()["equipType"]];
			m_nSex = Math.floor(Math.random() * 2)+1;
			m_sHeadImage = "ai/img_youkeHead_"+m_nSex+".png"
			m_sOpenID = m_sName;
			SendLoginMsg();
		}
		
		//登录请求
		private function SendLoginMsg():void 
		{
			
			var LoginWXRequest:* = NetworkManager.m_msgRoot.lookupType("LoginWXRequest");
			var loginWXRequest:* = LoginWXRequest.create({
				sOpenID:m_sOpenID,
				sNick:m_sNick,
				sHeadImage:m_sHeadImage,
				nGender:m_nSex,
				iCode:m_siCode
			});
			//Request当中具体的内容
			var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
			var requestMsg:* = Request.create({
				loginWXRequest:loginWXRequest
			});
			////包含了Request的内容
			var Msg:* = NetworkManager.m_msgRoot.lookupType("Msg");
			var MsgMessage:* = Msg.create({
				type:82,
				request:requestMsg
			});
			var encodeMessage:* = Msg.encode(MsgMessage).finish();
			GameIF.getInstance().networkManager.HttpSendMessage(encodeMessage, "loginWX");
		}
		//发送大转盘
		private function SendStart():void
		{
			var LuckyRequestMsg:* = NetworkManager.m_msgRoot.lookupType("LuckyRequest");
			var luckyRequestMsg:* = LuckyRequestMsg.create({
				nUserID:m_nUserID
			});
			//Request当中具体的内容
			var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
			var requestMsg:* = Request.create({
				luckyRequest:luckyRequestMsg
			});
			////包含了Request的内容
			var Msg:* = NetworkManager.m_msgRoot.lookupType("Msg");
			var MsgMessage:* = Msg.create({
				type:84,
				request:requestMsg
			});
			var encodeMessage:* = Msg.encode(MsgMessage).finish();
			GameIF.getInstance().networkManager.HttpSendMessage(encodeMessage, "lucky");
		}
		//进入欢乐场
		private function CreateHappyRoom():void
		{
			var gameplay:JSON = GameIF.GetJson()["happyRoom"];
			var nType:int = gameplay["id"];
			var m_PlayWayArr:Array = [gameplay["zimo"], gameplay["dianpao"], gameplay["bao"], gameplay["baozhongbao"], gameplay["hongzhong"]];
			
			var CreateGamePlayMsg:* = NetworkManager.m_msgRoot.lookupType("GamePlay");
			var createGamePlayMsg:* = CreateGamePlayMsg.create({nType: nType, optionals: m_PlayWayArr});
			
			//Request当中具体的内容
			var CreateRoomRequest:* = NetworkManager.m_msgRoot.lookupType("CreateRoomRequest");
			var createRoomRequestMsg:* = CreateRoomRequest.create({
				nUserID: m_nUserID,
				sCardType: "0",
				gamePlay: createGamePlayMsg,
				nPlayers: 4
			});
			
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
		//准备
		public function SendReadyGameRequest():void 
		{
			var ReadyGameRequestMsg:* = NetworkManager.m_msgRoot.lookupType("ReadyGameRequest");
			var readyGameRequestMsg:* = ReadyGameRequestMsg.create({
				nUserID:m_nUserID,
				sRoomID:m_sRoomID
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
		
		private function WxRegister():void 
		{
			var LoginWXRequest:* = NetworkManager.m_msgRoot.lookupType("LoginWXRequest");
			var loginWXRequest:* = LoginWXRequest.create({
				sOpenID:m_sName,
				sNick:"我是"+m_sName,
				sHeadImage:"common/img_head.png"
			});
			//Request当中具体的内容
			var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
			var requestMsg:* = Request.create({
				loginWXRequest:loginWXRequest
			});
			////包含了Request的内容
			var Msg:* = NetworkManager.m_msgRoot.lookupType("Msg");
			var MsgMessage:* = Msg.create({
				type:82,
				request:requestMsg
			});
			var encodeMessage:* = Msg.encode(MsgMessage).finish();
			GameIF.getInstance().networkManager.HttpSendMessage(encodeMessage, "loginWX");
		}
		
		private function WebRegister():void 
		{
			var RegisterRequestMsg:* = NetworkManager.m_msgRoot.lookupType("RegisterRequest");
			var registerRequestMsg:* = RegisterRequestMsg.create({
				sName:m_sName,
				sPassWord:m_sPassowrd
			});
			//Request当中具体的内容
			var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
			var requestMsg:* = Request.create({
				registerRequest:registerRequestMsg
			});
			//包含了Request的内容
			var Msg:* = NetworkManager.m_msgRoot.lookupType("Msg");
			var MsgMessage:* = Msg.create({
				type:1,
				request:requestMsg
			});
			var encodeMessage:* = Msg.encode(MsgMessage).finish();
			GameIF.getInstance().networkManager.HttpSendMessage(encodeMessage,"reg");
		}
		
		public function get sName():String 
		{
			return m_sName;
		}
		
		public function set sName(value:String):void 
		{
			m_sName = value;
		}
		
		public function get sPassowrd():String 
		{
			return m_sPassowrd;
		}
		
		public function set sPassowrd(value:String):void 
		{
			m_sPassowrd = value;
		}
		
	}
}