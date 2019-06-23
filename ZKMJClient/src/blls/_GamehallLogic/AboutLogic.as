package blls._GamehallLogic 
{
	import blls.BaseLogic;
	import core.GameIF;
	import core.LogicManager;
	import laya.events.Event;
	import view.ActiveView.AboutWindow;
	
	/**
	 * ...
	 * @author ...
	 */
	public class AboutLogic extends BaseLogic 
	{
		private var m_AboutWindow:AboutWindow;
		
		public function AboutLogic() 
		{
			super();
			
		}
		
		public override function Init():void
		{
			if (m_AboutWindow == null)
			{
				m_AboutWindow = new AboutWindow;
				m_AboutWindow.Init();
			}
			m_AboutWindow.visible = true;
			
			//注册所有按钮事件
			registerEventClick();
		}
		private function registerEventClick():void 
		{
			//关闭按钮
			m_AboutWindow.m_imgBg.on(Event.CLICK, this, btnBackBgClick);
		}
		//关闭按钮点击事件
		private function btnBackBgClick():void 
		{
			GameIF.DectiveLogic(LogicManager.ABOUTLOGIC);
		}
		public override function Destroy():void
		{
			m_AboutWindow.Destroy();
			m_AboutWindow.visible = false;
			m_AboutWindow = null;	
		}
	}

}