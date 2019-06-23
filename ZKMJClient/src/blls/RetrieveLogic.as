package blls
{
	import core.GameIF;
	import core.LogicManager;
	import laya.events.Event;
	import network.NetworkManager;
	import tool.Tool;
	import view.RetrieveView;
	import laya.utils.Browser;
	
	/**
	 * ...
	 * @author ...
	 */
	public class RetrieveLogic extends BaseLogic
	{
		protected var m_retrieveView:RetrieveView;
		private var m_sName:String;
		private var m_sPassWord:String;
		private var timeStamp:*= Browser.now();
		private var m_Random:int;
		//private var m_iCode:String = "office10";
		private var m_iCode:String = "";
		
		public function RetrieveLogic()
		{
			super();
		}
		
		public override function Init():void
		{
			//初始化RetrieveView
			if (m_retrieveView == null)
			{
				m_retrieveView = new RetrieveView;
				m_retrieveView.Init();
			}
			m_retrieveView.visible = true;
			//注册所有按钮事件
			registerEventClick();
			
			//login();
		}
		
		public function login():void
		{
			
				m_Random = Math.random() * 100;
				m_retrieveView.m_inputUsername.text = timeStamp+"."+m_Random;
				WXlogin();
		}
		
		private function registerEventClick():void
		{
			//账号密码登录
			//m_retrieveView.m_Retrieve.on(Event.CLICK, this, onRetrieve);
			//微信登录
			m_retrieveView.m_Retrieve.on(Event.CLICK, this,WXlogin );
			
			m_retrieveView.m_btnBack.on(Event.CLICK, this, onBackCLicked);
		}
		
		private function onBackCLicked():void
		{
			
			GameIF.DectiveLogic(LogicManager.RETRIEVELOGIC);
		}
		
		//登录
		public function onRetrieve():void
		{  
			
			m_sName = m_retrieveView.m_inputUsername.text;
			m_sPassWord = m_retrieveView.m_inputPassword.text;
			var LoginRequestMsg:* = NetworkManager.m_msgRoot.lookupType("LoginRequest");
			var loginRequestMsg:* = LoginRequestMsg.create({
				sName: m_sName,
				sPassWord: m_sPassWord
			});
			//Request当中具体的内容
			var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
			var requestMsg:* = Request.create({loginRquest: loginRequestMsg});
			////包含了Request的内容
			var Msg:* = NetworkManager.m_msgRoot.lookupType("Msg");
			var MsgMessage:* = Msg.create({
				type: 3,
				request: requestMsg
				
			});
			var encodeMessage:* = Msg.encode(MsgMessage).finish();
			GameIF.getInstance().networkManager.HttpSendMessage(encodeMessage, "login");
			GameIF.DectiveLogic(LogicManager.RETRIEVELOGIC);
		}
		
		public function WXlogin():void 
		{
			m_sName = m_retrieveView.m_inputUsername.text;
			
			var loginlogic:LoginLogic = GameIF.GetLogic(LogicManager.LOGINLOGIC) as LoginLogic;
			loginlogic.TestLogin(m_sName);
			
			GameIF.DectiveLogic(LogicManager.RETRIEVELOGIC);
		}
		
		public override function Destroy():void
		{
			m_retrieveView.Destroy();
			m_retrieveView.destroy();
			m_retrieveView = null;
		}
	
	}

}