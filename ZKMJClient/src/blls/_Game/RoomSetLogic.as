package blls._Game 
{
	import blls.BaseLogic;
	import core.GameIF;
	import core.LogicManager;
	import laya.events.Event;
	import laya.utils.Handler;
	import model.User;
	import network.NetworkManager;
	import view.ActiveView.SetWindow;
	import view.BlackWindowView;
	
	/**
	 * ...
	 * @author dawenhao
	 */
	public class RoomSetLogic extends BaseLogic 
	{
		private var m_setWindow:SetWindow;
		private var m_nUserID:int;
		private var m_blackWindowView:BlackWindowView;
		private var m_user:User;
		
		public function RoomSetLogic() 
		{
			super();
			
		}
		
		public override function Init():void
		{
			if (m_blackWindowView == null)
			{
				m_blackWindowView = new BlackWindowView
				m_blackWindowView.Init();
			}
			m_blackWindowView.visible = false;
			if (m_setWindow == null)
			{
				m_setWindow = new SetWindow;
				m_setWindow.Init();
			}
			m_setWindow.visible = false;
			
			//注册所有按钮事件
			registerEventClick();
			//使rg定位到当前音量上
			InitMusicVolume();
			//初始化信息
			InitDel();
			
			m_setWindow.m_boxSet.visible = false;
			m_setWindow.m_boxRoomSet.visible = true;
			
		}
		
		public function ShowRoomSet():void 
		{
			m_setWindow.visible = true;
			m_blackWindowView.visible = false;
		}
		public function HideRoomSet():void 
		{
			m_setWindow.visible = false;
			m_blackWindowView.visible = false;
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
		
		private function registerEventClick():void 
		{
			//关闭按钮
			m_setWindow.btn_close.on(Event.CLICK, this, btnCloseClick);
			//处理音乐音量
			m_setWindow.m_hsBgMusic.changeHandler = new Handler(this, onMusicVolumeChange);
			//处理音效大小
			m_setWindow.m_hsSound.changeHandler = new Handler(this, onSoundVolumeChange);
			//退出房间
			m_setWindow.m_btnQuitRoom.on(Event.CLICK, this, onQuitRoomClicked);
			//解散房间
			m_setWindow.m_btnDissolveRoom.on(Event.CLICK, this, onDissolveClicked);
			//设置定位
			m_setWindow.m_checkLocation.on("change", this, OnLocationChage);
		}
		//解散房间
		private function onDissolveClicked():void
		{
			var DissRoomRequestMsg:* = NetworkManager.m_msgRoot.lookupType("DissRoomRequest");
			var dissRoomRequestMsg:* = DissRoomRequestMsg.create({
				nUserID:GameIF.GetDalManager().daluser.nID,
				sRoomID:GameIF.GetRoom().sRoomID
			});
			//Request当中具体的内容
			var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
			var requestMsg:* = Request.create({
				dissRoomRequest:dissRoomRequestMsg
			});
			////包含了Request的内容
			var Msg:* = NetworkManager.m_msgRoot.lookupType("Msg");
			var MsgMessage:* = Msg.create({
				type:75,
				request:requestMsg
			});
			var encodeMessage:* = Msg.encode(MsgMessage).finish();
			GameIF.getInstance().networkManager.SocketSendMessage(encodeMessage);

		}
		
		//退出房间
		public function onQuitRoomClicked():void 
		{
			var LeaveRoomRequestMsg:* = NetworkManager.m_msgRoot.lookupType("LeaveRoomRequest");
			var leaveRoomRequestMsg:* = LeaveRoomRequestMsg.create({
				nUserID:GameIF.GetDalManager().daluser.nID,
				sRoomID:GameIF.GetRoom().sRoomID
			});
			//Request当中具体的内容
			var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
			var requestMsg:* = Request.create({
				leaveRoomRequest:leaveRoomRequestMsg
			});
			////包含了Request的内容
			var Msg:* = NetworkManager.m_msgRoot.lookupType("Msg");
			var MsgMessage:* = Msg.create({
				type:10,
				request:requestMsg
			});
			var encodeMessage:* = Msg.encode(MsgMessage).finish();
			GameIF.getInstance().networkManager.SocketSendMessage(encodeMessage);
			
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
		
		//关闭按钮点击事件
		private function btnCloseClick():void 
		{
			HideRoomSet();
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
		public override function Destroy():void
		{
			if (m_blackWindowView != null)
			{
				m_blackWindowView.Destroy();
				m_blackWindowView.visible = false;
				m_blackWindowView = null;	
			}
			if (m_setWindow != null)
			{
				m_setWindow.Destroy();
				m_setWindow.visible = false;
				m_setWindow = null;	
			}	
		}
	}

}