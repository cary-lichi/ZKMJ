package blls._GamehallLogic 
{
	import blls.BaseLogic;
	import core.GameIF;
	import core.LogicManager;
	import laya.events.Event;
	import view.RecordRuleView;
	import view.BlackWindowView;
	import laya.utils.Handler;
	
	
	/**
	 * ...
	 * @author ...
	 */
	public class RecordRuleLogic extends BaseLogic 
	{
		private var m_recordRuleView:RecordRuleView;
		private var m_blackWindowView:BlackWindowView;
		
		public function RecordRuleLogic() 
		{
			super();
			
		}
		
		public override function Init():void
		{
			if (m_blackWindowView == null)
			{
				m_blackWindowView = new BlackWindowView;
				m_blackWindowView.Init();
			}
			m_blackWindowView.visible = true;
			
			if (m_recordRuleView == null)
			{
				m_recordRuleView = new RecordRuleView;
				m_recordRuleView.Init();
			}
			m_recordRuleView.visible = true;
			InitTab();
			//注册所有按钮事件
			registerEventClick();
			m_recordRuleView.m_panel00.vScrollBarSkin = "";
			m_recordRuleView.m_panel01.vScrollBarSkin = "";
			m_recordRuleView.m_panel02.vScrollBarSkin = "";
		}
		
		private function InitTab():void 
		{
			m_recordRuleView.m_tabTop.selectedIndex = 0;
			m_recordRuleView.m_tabTop.selectHandler = new Handler(this, onTopSelect);
		}
		
		private function onTopSelect(index:int):void 
		{
			m_recordRuleView.m_stackMDJ.selectedIndex = index;
		}
		
		
		private function registerEventClick():void 
		{
			//关闭按钮点击
			m_recordRuleView.m_close.on(Event.CLICK, this, onIsCloseClicked);
			//黑幕被电击
			m_blackWindowView.on(Event.CLICK, this, onBlackScreenClicked);
		}
		
		private function onIsCloseClicked():void 
		{
			GameIF.DectiveLogic(LogicManager.RECORDRULELOGIC);
		}
		
		private function onBlackScreenClicked():void 
		{
			return;
		}
		
		
		
		public override function Destroy():void
		{
			
			m_blackWindowView.Destroy();
			m_blackWindowView.destroy();
			m_blackWindowView.visible = false;
			m_blackWindowView = null;
			
			m_recordRuleView.Destroy();
			m_recordRuleView.destroy();
			m_recordRuleView.visible = false;
			m_recordRuleView = null;	
		}
		
	}

}