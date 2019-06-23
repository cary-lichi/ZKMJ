package blls 
{
	import blls._GamehallLogic.InputRoomIDLogic;
	import core.Constants;
	import core.GameIF;
	import core.LogicManager;
	import core.SdkManager;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.media.SoundManager;
	import laya.resource.HTMLCanvas;
	import laya.resource.Texture;
	import laya.ui.Image;
	import laya.utils.Browser;
	import model.User;
	import network.NetworkManager;
	import tool.Tool;
	import view.ActiveView.PopUpDia;
	import view.AlphaWindowView;
	import view.LoginView;
	/**
	 * ...
	 * @author ...
	 */
	public class LoginLogic extends BaseLogic
	{
		private var m_loginView:LoginView;
		private var m_alphaWindowView:AlphaWindowView;
		private var m_sOpenID:String;
		private var m_sNick:String;
		private var m_sHeadImage:String;
		private var m_nSex:int=2;
		private var m_siCode:String = "";
		//private var m_siCode:String = "office10";
		private var m_popUpDia:view.ActiveView.PopUpDia;
		public function LoginLogic() 
		{
			super();
		}
		
		public override function Init():void
		{
			//初始化LoginView
			if (m_loginView == null)
			{
				m_loginView = new LoginView;
				m_loginView.Init();
			}
			m_loginView.visible = true;
			
			//注册所有按钮事件
			registerEventClick();
			
			//不同设备有特殊需求
			InitEquip();
			
			//测试//
			//TestLogin();
		}
		////测试登录
		//private function TestLogin():void 
		//{
			////进入模拟登录界面
			////GameIF.ActiveLogic(LogicManager.RETRIEVELOGIC);
			//var Random:int = Math.random() * 100;
			//var timeStamp:*= Browser.now();
			//var m_sName:String = timeStamp + "." + Random;
			//var key:int = Math.floor(Math.random() * 23);
			//m_sNick = GameIF.GetJson()["aiInfo"][key]["nick"];
			//m_nSex = GameIF.GetJson()["aiInfo"][key]["gender"];
			//m_sHeadImage = Tool.getHeadUrl();
			//m_sOpenID = m_sName;
			//SendLoginMsg();
		//}
		//测试登录
		public function TestLogin(Name:*):void 
		{	
			m_sNick = "游客"+Name;
			m_sHeadImage = Tool.getHeadUrl();
			m_sOpenID = Name;
			SendLoginMsg();
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
				InitwxWebEquip();
			}
		}
		
		private function InitWebEquip():void 
		{
			m_loginView.m_youke.visible = true;
			m_loginView.btn_loginWX.visible = true;
			henderWXWeb();
		}
		
		private function InitAndroidEquip():void 
		{
			m_loginView.m_youke.visible = false;
			m_loginView.btn_loginWX.visible = true;
		}
		
		private function InitIOSEquip():void 
		{
			m_loginView.m_youke.visible = true ;
			m_loginView.btn_loginWX.visible = false;
		}
		
		private function InitwxWebEquip():void 
		{
			m_loginView.m_youke.visible = false;
			m_loginView.btn_loginWX.visible = false;
			henderWXWeb();
		}
		
		public override function Destroy():void
		{
			if (m_loginView)
			{
				m_loginView.Destroy();
				m_loginView.destroy();
				m_loginView = null;	
			}
			
		}
		
		//接受message
		public override function OnReceiveMessage(msg:*):void
		{
			if (msg.type == 4)//RegisterResponse
			{
				OnLoginResponse(msg.response.loginResponse);
			}
		}
		
		//LoginResponse 响应
		private function OnLoginResponse(message:*):void 
		{
			if (message.nErrorCode==0)
			{
				var user:User = new User;
				user.nUserID = message.requester.nUserID;
				user.sICode = message.requester.sICode;
				user.sNick = message.requester.sNick;
				user.sHeadimg = message.requester.sHeadimg;
				user.sRoom = message.requester.sRoom;
				user.nGold = message.requester.nGold;
				user.nMoney = message.requester.nMoney;
				user.bLuckyToday = message.requester.bLuckyToday;
				user.bWelfareToday = message.requester.bWelfareToday;
				user.nGender = message.requester.nGender;
				user.bShareAwardWeek = message.requester.bShareAwardWeek;
				user.sToken = message.requester.sToken;
				user.sLng = Constants.sSelfLng;
				user.sLat = Constants.sSelfLat;
				user.sAddress = Constants.bIsLocation?Constants.sSelfAddress:"没有开启定位";
				user.bIsLocation = Constants.bIsLocation;
				GameIF.GetDalManager().daluser.AddUser(message.requester.nUserID,user);
				GameIF.getInstance().networkManager.StartLoginHeart();
				//登陆成功跳转页面
				GameIF.DectiveLogic(LogicManager.LOGINLOGIC);
				GameIF.ActiveLogic(LogicManager.GAMEHALLLOGIC);
				
				//检测是否是断线重连
				handleReconnection();
				//检测是否有新手奖励
				handleAward(message);
			}
			else if (message.nErrorCode == 1)
			{
				GameIF.GetPopUpDia("用户名密码错误");
			}
			else if (message.nErrorCode == 10)
			{
				GameIF.GetPopUpDia("你上次异常退出，请20秒后重新登录",ResetLogin,this);
			}
			else if (message.nErrorCode == 19)
			{
				GameIF.GetPopUpDia("你的账号已经被封禁");
			}
			
		}
		
		private function ResetLogin():void 
		{
			GameIF.ClosePopUpDia();
			InitEquip();
		}
		
		private function handleAward(message:*):void 
		{
			//0：2钻石（玩家分享进入） 1：5钻石（官方）2：10钻石（官方）,3:0.5元（官方）
			if (message.rookieAward>=0 && message.rookieAward<=3)
			{	
				GameIF.GetShareSuccessDia(GameIF.GetJson()["rookieAward"][message.rookieAward]);	
			}
			if (message.rookieAward == -2 )
			{
				GameIF.GetPopUpDia("你已经领取过刮刮乐奖励");
			}
			
		}
		
		private function handleReconnection():void 
		{
			var user:User = GameIF.GetUser();
			if (SdkManager.mRoomId!=""&&SdkManager.mRoomId!=null)
			{
				var login:InputRoomIDLogic = GameIF.GetLogic(LogicManager.INPUTROOMIDLOGIC) as InputRoomIDLogic;
				login.SendJoninRoom(SdkManager.mRoomId);
			}
			else if (user.sRoom)
			{
				user.bOffLine = true;
				GameIF.GetPopUpDia("你还有未完成的对局现在进去看看吧~",OffLineCon,this);
			}
			else
			{
				if (user.bLuckyToday==false)
				{
					GameIF.ActiveLogic(LogicManager.TURNTABLELOGIC)	
				}
				
			}
		}
		private function OffLineCon():void 
		{
			GameIF.ClosePopUpDia();
			//连接Socket
			GameIF.getInstance().networkManager.InitSocket(this, null);
			GameIF.getInstance().networkManager.SocketConnect(GameIF.GetUser().nUserID);
		}
		private function registerEventClick():void 
		{
			////loginView界面的事件
			m_loginView.btn_loginWX.on(Event.CLICK, this, onWechatClick);
			//用户同意协议
			m_loginView.m_btnUserAgreement.on(Event.CLICK, this, onUserAgrClicked);
			m_loginView.m_youke.on(Event.CLICK, this, henderWebYKLogin);
		}
		
		//用户同意协议
		private function onUserAgrClicked():void 
		{
			//henderAndroidPyq();
			//return;
			GameIF.DectiveLogic(LogicManager.LOGINLOGIC);
			GameIF.ActiveLogic(LogicManager.USERAGREEMENTLOGIC);
		}
		private function henderAndroidPyq():void 
		{
		//__JS__('getBase64Image()');
		 //<p>绘制 当前<code>Sprite</code> 到 <code>Canvas</code> 上，并返回一个HtmlCanvas。</p>
		 //<p>绘制的结果可以当作图片源，再次绘制到其他Sprite里面，示例：</p>
		
		 //var htmlCanvas:HTMLCanvas = Laya.stage.drawToCanvas(1136, 640, 0, 0);//把精灵绘制到canvas上面
		 //var texture:Texture = new Texture(htmlCanvas);//使用htmlCanvas创建Texture
		 //var sp:Sprite = new Sprite().pos(0, 200);//创建精灵并把它放倒200位置
		 //sp.graphics.drawTexture(texture);//把截图绘制到精灵上
		 //Laya.stage.addChild(sp);//把精灵显示到舞台
		
		  //<p>也可以获取原始图片数据，分享到网上，从而实现截图效果，示例：</p>
		 
		  //var htmlCanvas:HTMLCanvas = Laya.stage.drawToCanvas(1136, 640, 0, 0);//把精灵绘制到canvas上面
		  //
		  //htmlCanvas.toBase64("image/png",0.92,getBase64Image);
		  Browser.window.conch.captureScreen(savepng);
			
		}
		private function savepng(arrayBuff,width,height):void 
		{
			 //+Browser.now()+ ".png"
			var imgURL:String = GameIF.GetJson()["cacheURL"];
			//var imgURL:String = Browser.window.conch.getCachePath() + "/test.png";
			Browser.window.conch.saveAsPng(arrayBuff, width, height, imgURL);
			var img:Image = new Image;
			
			//创建Test类
			var Test:*=Laya.PlatformClass.createClass("com.tianhu.majiang.WxAndroid");
			//创建Test 对象
			var testAdd:* = Test.newObject(); //不支持构造函数
			//调用成员函数
			testAdd.callWithBack(null, "wxShareScreenshot", imgURL);
			alert(imgURL);
			//img.skin = imgURL;
			//img.x = 100;
			//img.y = 10;
			//Laya.stage.addChild(img);
			
		}
		////loginView界面的事件函数
		private function onWechatClick(e:Event):void 
		{
			//测试
			//SendTestMsg();
			//return;
			//必须勾选
			if (m_loginView.m_ckeckBox.selected)
			{
				var json:* = GameIF.GetJson();
				if (json["equipType"] == json["equipEnum"]["Web"])
					henderWebLogin();
				if (json["equipType"] == json["equipEnum"]["Android"])
					henderAndroidLogin();
				if (json["equipType"] == json["equipEnum"]["IOS"])
					henderIOSLogin();
				if (json["equipType"] == json["equipEnum"]["test"])
					henderTestLogin();
			}
			else
			{
				showTipsDia();
			}
		}

    //(r"/adminGetUser", AdminGetUserHandler),
    //(r"/adminGetDelegate", AdminGetDelegateHandler),
    //(r"/adminBanGamer", AdminBanGamerHandler),
    //(r"/adminKickGamer", AdminKickGamerHandler)
		private function SendTestMsg():void 
		{
			var MsgMessage:String = '{"msg":"kickgamer","gid":96}';
			var msh:Object = JSON.parse(MsgMessage);
			GameIF.getInstance().networkManager.HttpSendMessage(MsgMessage, "adminKickGamer");
		}
		
		private function henderWXWeb():void 
		{
			if (SdkManager.mOpenId == null)
			{
				trace("请使用微信登录。");
				return;
			}
			m_sOpenID=SdkManager.mOpenId,
			m_sNick=SdkManager.mUserName,
			m_sHeadImage = SdkManager.mAvatarUrl;
			m_nSex = SdkManager.mSex;
			m_siCode = SdkManager.minviterID;
			SendLoginMsg();
			
		}
		
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
		private function henderWebLogin():void 
		{
			__JS__('wxLogin()');
		}
		private function henderTestLogin():void 
		{
			//进入模拟登录界面
			GameIF.ActiveLogic(LogicManager.RETRIEVELOGIC);
		}
		private function henderAndroidLogin():void 
		{
			//创建Test类
			var Test:*=Laya.PlatformClass.createClass("com.tianhu.majiang.WxAndroid");
			//创建Test 对象
			var testAdd:* = Test.newObject(); //不支持构造函数
			//调用成员函数
			testAdd.callWithBack(loginWX,"wxLogin");
		}
		private function henderIOSLogin():void 
		{
			//创建Test类
			var Test:*=Laya.PlatformClass.createClass("SwxClass");
			//创建Test 对象
			var testAdd:* = Test.newObject(); //不支持构造函数
			//调用成员函数
			testAdd.callWithBack(loginWX,"wxLogin");
		}
		private function loginIOSWX(message:*):void 
		{
			alert(message);
			return;
			//
			//var msg:Object = JSON.parse(message);
			var LoginWXRequest:* = NetworkManager.m_msgRoot.lookupType("LoginWXRequest");
			var loginWXRequest:* = LoginWXRequest.create({
				sOpenID:message,
				sNick:"IOS",
				sHeadImage:"",
				nGender:1,
				iCode:""
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
		private function loginWX(message:*):void 
		{
			
			var msg:Object = JSON.parse(message);
			var LoginWXRequest:* = NetworkManager.m_msgRoot.lookupType("LoginWXRequest");
			var loginWXRequest:* = LoginWXRequest.create({
				sOpenID:msg.unionid,
				sNick:msg.nickname,
				sHeadImage:msg.headimgurl,
				nGender:parseInt(msg.sex),
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
		private function SendLoginMsg():void 
		{
			if (!Constants.bIsLocation)
			{
				GameIF.GetLocation(SetLocation,this);	
			}
			else
			{
				SendLoginLocationMsg()
			}
			
		}		
		
		private function SetLocation(info:*,caller):void 
		{
			Constants.sSelfLng = info.lng.toString();
			Constants.sSelfLat = info.lat.toString();
			Constants.sSelfAddress = info.address;
			Constants.bIsLocation = info.accuracy != null;
			
			caller.SendLoginLocationMsg();
		}
		
		private function SendLoginLocationMsg():void 
		{
			var Location:* = NetworkManager.m_msgRoot.lookupType("Location");
			var location:* = Location.create({
				bIsLocation:Constants.bIsLocation,
				sLng:Constants.sSelfLng,
				sLat:Constants.sSelfLat,
				sAddress:Constants.sSelfAddress
			});
			
			var LoginWXRequest:* = NetworkManager.m_msgRoot.lookupType("LoginWXRequest");
			var loginWXRequest:* = LoginWXRequest.create({
				sOpenID:m_sOpenID,
				sNick:m_sNick,
				sHeadImage:m_sHeadImage,
				nGender:m_nSex,
				iCode:m_siCode,
				location:location
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
		//显示飘字
		private function showTipsDia():void 
		{
			GameIF.getInstance().uiManager.showTipsDia(m_loginView.m_Success);
		}
		
	}

}
