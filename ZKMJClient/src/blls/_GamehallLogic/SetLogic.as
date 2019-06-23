package blls._GamehallLogic 
{
	import blls.BaseLogic;
	import blls.RegularLogic;
	import core.GameIF;
	import core.LogicManager;
	import core.MusicManager;
	import laya.events.Event;
	import laya.ui.CheckBox;
	import laya.utils.Handler;
	import model.User;
	import network.NetworkManager;
	import view.ActiveView.SetWindow;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SetLogic extends BaseLogic 
	{
		private var m_setWindow:SetWindow;
		private var m_nUserID:int;
		private var m_user:User;
		
		public function SetLogic() 
		{
			super();
		}
		public override function Init():void
		{
			if (m_setWindow == null)
			{
				m_setWindow = new SetWindow;
				m_setWindow.Init();
			}
			m_setWindow.visible = true;
			
			//注册所有按钮事件
			registerEventClick();
			//使rg定位到当前音量上
			InitMusicVolume();
			//初始化信息
			InitDel();
			
			m_setWindow.m_boxSet.visible = true;
			m_setWindow.m_boxRoomSet.visible = false;
		}
		//初始化信息
		private function InitDel():void 
		{
			m_user = GameIF.GetUser();
			m_nUserID = m_user.nUserID;
			
			
			m_setWindow.m_checkLocation.selected = m_user.bIsLocation;
			SetLocationAdd(m_setWindow.m_checkLocation.selected);
		}
		
		private function InitMusicVolume():void 
		{
			var Volume:int = GameIF.GetMusicVolume();
			m_setWindow.m_hsBgMusic.value = Volume;
		}
		//接受message
		public override function OnReceiveMessage(msg:*):void
		{
			if (msg.type == 63)//RegisterResponse
			{
				OnLoginOutResponse(msg.response.loginOutResponse);
			}
		}
		
		private function OnLoginOutResponse(object:Object):void 
		{
			//GameIF.DectiveLogic(LogicManager.SETLOGIC);
			//GameIF.DectiveLogic(LogicManager.GAMEHALLLOGIC);
			//GameIF.ActiveLogic(LogicManager.LOGINLOGIC);
			GameIF.RestartGame();
		}
		private function registerEventClick():void 
		{
			//关闭按钮
			m_setWindow.btn_close.on(Event.CLICK, this, btnCloseClick);
			//处理音乐音量
			m_setWindow.m_hsBgMusic.changeHandler = new Handler(this, onMusicVolumeChange);
			//处理音效大小
			m_setWindow.m_hsSound.changeHandler = new Handler(this, onSoundVolumeChange);
			//退出游戏
			m_setWindow.m_btnQuit.on(Event.CLICK, this, onQuitClicked);
			//规则
			m_setWindow.m_btnRule.on(Event.CLICK, this, OnRuleClicked);
			//关于
			m_setWindow.m_btnAbout.on(Event.CLICK, this, OnAboutClicked);
			//设置定位
			m_setWindow.m_checkLocation.on("change", this, OnLocationChage);
		}
		
		//退出游戏
		private function onQuitClicked():void 
		{
			var LoginOutRequestMsg:* = NetworkManager.m_msgRoot.lookupType("LoginOutRequest");
			var loginOutRequestMsg:* = LoginOutRequestMsg.create({
				nUserID:m_nUserID
			});
			//Request当中具体的内容
			var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
			var requestMsg:* = Request.create({
				loginOutRequest:loginOutRequestMsg
			});
			////包含了Request的内容
			var Msg:* = NetworkManager.m_msgRoot.lookupType("Msg");
			var MsgMessage:* = Msg.create({
				type:62,
				request:requestMsg
			});
			var encodeMessage:* = Msg.encode(MsgMessage).finish();
			GameIF.getInstance().networkManager.HttpSendMessage(encodeMessage, "loginout");
			
		}
		//规则
		private function OnRuleClicked():void 
		{
			var logic:RegularLogic = GameIF.getInstance().logicManager.GetLogic(LogicManager.REGULARLOGIC) as RegularLogic;
			logic.Show();;
			 btnCloseClick();
		}
		//关于
		private function OnAboutClicked():void 
		{
			GameIF.ActiveLogic(LogicManager.ABOUTLOGIC);
			btnCloseClick();
		}
		//滑块移动事件
		private function onMusicVolumeChange(value:int):void 
		{
			GameIF.SetMusicVolume(value);
		}
		private function onSoundVolumeChange(value:int):void 
		{
			GameIF.SetSoundVolume(value);
		}
		
		private function OnLocationChage():void 
		{
			m_setWindow.m_checkLocation.skin = m_setWindow.m_checkLocation.selected == true?"set/img_locationOpen.png":"set/img_locationClose.png";
			m_user.bIsLocation = m_setWindow.m_checkLocation.selected;
			SetLocationAdd(m_setWindow.m_checkLocation.selected);
		}
		
		private function SetLocationAdd(b:Boolean):void
		{
			GameIF.SetLocation(m_user, b);
			m_setWindow.m_LabAddress.text = m_user.sAddress;
		}
		
		//关闭按钮点击事件
		private function btnCloseClick():void 
		{
			GameIF.DectiveLogic(LogicManager.SETLOGIC);
		}
		public override function Destroy():void
		{
			m_setWindow.Destroy();
			m_setWindow.destroy();
			m_setWindow.visible = false;
			m_setWindow = null;			
		}
	}

}