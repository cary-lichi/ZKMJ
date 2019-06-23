package blls 
{
	import blls.BaseLogic;
	import core.GameIF;
	import core.LogicManager;
	import laya.events.Event;
	import view.UserAgreementPage;
	
	/**
	 * ...
	 * @author ...
	 */
	public class UserAgreementLogic extends BaseLogic 
	{
		private var m_userAgreementView:UserAgreementPage;
		public function UserAgreementLogic() 
		{
			super();
			
		}
		
		public override function Init():void
		{
			//初始化LoginView
			if (m_userAgreementView == null)
			{
				m_userAgreementView = new UserAgreementPage;
				m_userAgreementView.Init();
			}
			m_userAgreementView.visible = true;
			
			//注册所有按钮事件
			registerEventClick();
			
			m_userAgreementView.m_panel.vScrollBarSkin = "";
		}
		
		public override function Destroy():void
		{
			m_userAgreementView.Destroy();
			m_userAgreementView.destroy();
			m_userAgreementView = null;
		}
		
		//注册所有按钮事件	
		private function registerEventClick():void 
		{
			m_userAgreementView.m_btnBack.on(Event.CLICK,this,onBackClicked);
			
		}
		
		private function onBackClicked():void 
		{
			GameIF.DectiveLogic(LogicManager.USERAGREEMENTLOGIC);
			GameIF.ActiveLogic(LogicManager.LOGINLOGIC);
		}
	}

}