package blls._Game 
{
	import blls.BaseLogic;
	import core.GameIF;
	import core.LogicManager;
	import laya.events.Event;
	import view.TotalScoreView;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TotalScoreLogic extends BaseLogic 
	{
		private var m_totalScoreView:TotalScoreView;
		public function TotalScoreLogic() 
		{
			super();
			
		}
		public override function Init():void
		{
			//初始化LoginView
			if (m_totalScoreView == null)
			{
				m_totalScoreView = new TotalScoreView;
				m_totalScoreView.Init();
			}
			m_totalScoreView.visible = true;
			
			//注册所有按钮事件
			registerEventClick();
		}
		
		public override function Destroy():void
		{
			m_totalScoreView.Destroy();
			m_totalScoreView.destroy();
			m_totalScoreView = null;
		}
		
		//注册所有按钮事件	
		private function registerEventClick():void 
		{
			m_totalScoreView.m_btnBack.on(Event.CLICK,this,onBackClicked);
			
		}
		
		private function onBackClicked():void 
		{
			GameIF.DectiveLogic(LogicManager.TOTASCORELOGIC);
			//GameIF.ActiveLogic(LogicManager.GAMEHALLLOGIC);
		}
	}

}