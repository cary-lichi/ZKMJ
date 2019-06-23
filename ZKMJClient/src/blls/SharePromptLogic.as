package blls 
{
	import core.GameIF;
	import core.LogicManager;
	import laya.events.Event;
	import view.SharePromptView;
	/**
	 * ...
	 * @author ...
	 */
	public class SharePromptLogic extends BaseLogic 
	{
		private var m_sharePromptView:SharePromptView;
		
		public function SharePromptLogic() 
		{
			super();
		}
		
		public override function Init():void
		{
			if (m_sharePromptView == null)
			{
				m_sharePromptView = new SharePromptView;
				m_sharePromptView.Init();
			}
			m_sharePromptView.visible = true;
			
			//注册所有按钮事件
			registerEventClick();
		}
		private function registerEventClick():void 
		{
			//关闭按钮
			m_sharePromptView.m_imgBg.on(Event.CLICK, this, btnBackBgClick);
		}
		//关闭按钮点击事件
		private function btnBackBgClick():void 
		{
			GameIF.DectiveLogic(LogicManager.SHAREPROMPTLOGIC);
		}
		public override function Destroy():void
		{
			if (m_sharePromptView != null)
			{
				m_sharePromptView.Destroy();
				m_sharePromptView.visible = false;
				m_sharePromptView = null;	
			}
			
		}
	}

}