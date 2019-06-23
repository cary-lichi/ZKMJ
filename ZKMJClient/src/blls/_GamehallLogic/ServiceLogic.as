package blls._GamehallLogic 
{
	import blls.BaseLogic;
	import core.GameIF;
	import core.LogicManager;
	import laya.events.Event;
	import view.ActiveView.ServiceWindow;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ServiceLogic extends BaseLogic 
	{
		private var m_serviceWindow:ServiceWindow;
		
		public function ServiceLogic() 
		{
			super();
		}
		public override function Init():void
		{
			if (m_serviceWindow == null)
			{
				m_serviceWindow = new ServiceWindow;
				m_serviceWindow.Init();
			}
			m_serviceWindow.visible = true;
			
			//注册所有按钮事件
			registerEventClick();
		}
		private function registerEventClick():void 
		{
			//关闭按钮
			m_serviceWindow.btn_close.on(Event.CLICK, this, btnCloseClick);
			//在线客服
			m_serviceWindow.m_btnOnline.on(Event.CLICK, this, onOnlineClicked);
			//收集建议
			m_serviceWindow.m_btnProposal.on(Event.CLICK,this, onProposalClicked)
		}
		//收集建议
		private function onProposalClicked():void 
		{
			GameIF.DectiveLogic(LogicManager.SERVICELOGIC);
			GameIF.ActiveLogic(LogicManager.PROPOSALDIA);
		}
		//在线客服
		private function onOnlineClicked():void 
		{
			GameIF.DectiveLogic(LogicManager.SERVICELOGIC);
			GameIF.ActiveLogic(LogicManager.ONLINELOGIC);
		}
		//关闭按钮点击事件
		private function btnCloseClick():void 
		{
			GameIF.DectiveLogic(LogicManager.SERVICELOGIC);
		}
		public override function Destroy():void
		{
			m_serviceWindow.Destroy();
			m_serviceWindow.destroy();
			m_serviceWindow.visible = false;
			m_serviceWindow = null;	
		}
		
	}

}