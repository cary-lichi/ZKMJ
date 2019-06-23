package blls._GamehallLogic._ServiceLogic 
{
	import blls.BaseLogic;
	import core.GameIF;
	import core.LogicManager;
	import laya.events.Event;
	import view.ActiveView.OnlineDia;
	
	/**
	 * ...
	 * @author ...
	 */
	public class OnlineLogic extends BaseLogic 
	{
		private var m_onLineDia:OnlineDia;
		public function OnlineLogic() 
		{
			super();
			
		}
		public override function Init():void
		{
			if (m_onLineDia == null)
			{
				m_onLineDia = new OnlineDia;
				m_onLineDia.Init();
			}
			m_onLineDia.visible = true;
			
			//注册所有按钮事件
			registerEventClick();
		}
		
		private function registerEventClick():void 
		{
			//关闭按钮
			m_onLineDia.m_btnClose.on(Event.CLICK,this,onCloseClick);
		}
		
		//关闭按钮点击事件
		private function onCloseClick():void 
		{
			GameIF.DectiveLogic(LogicManager.ONLINELOGIC);
			GameIF.ActiveLogic(LogicManager.SERVICELOGIC);
		}
		
		public override function Destroy():void
		{
			m_onLineDia.Destroy();
			m_onLineDia.destroy();
			m_onLineDia.visible = false;
			m_onLineDia = null;	
		}
		
	}

}