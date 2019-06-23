package blls 
{
	import blls._Game.RoomLogic;
	import core.GameIF;
	import core.LogicManager;
	import laya.events.Event;
	import view.LoginAccountView;
	import view.Room.VIPRoomView;
	/**
	 * ...
	 * @author ...
	 */
	public class LoginAccountLogic extends BaseLogic
	{
		protected var m_loginAccountView:LoginAccountView;
		
		public function LoginAccountLogic() 
		{
			super();
		}
		
		public override function Init():void
		{
			//初始化LoginAccountView
			if (m_loginAccountView == null)
			{
				m_loginAccountView = new LoginAccountView;
				m_loginAccountView.Init();
			}
			m_loginAccountView.visible = true;
			//注册所有按钮事件
			registerEventClick();
		}
		
		public override function Destroy():void
		{
			m_loginAccountView.Destroy();
			m_loginAccountView.destroy();
			m_loginAccountView = null;
		}
		
		private function registerEventClick():void 
		{

		}

		
	}

}