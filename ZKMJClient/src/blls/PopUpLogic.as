package blls 
{
	import core.GameIF;
	import core.LogicManager;
	import laya.events.Event;
	import view.ActiveView.PopUpDia;
	import view.BlackWindowView;
	/**
	 * ...
	 * @author ...
	 */
	public class PopUpLogic extends BaseLogic 
	{
		private var m_popUpDia:PopUpDia;
		private var m_blackWindowView:BlackWindowView;
		
		public function PopUpLogic() 
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
			
			if (m_popUpDia == null)
			{
				m_popUpDia = new PopUpDia;
				m_popUpDia.Init();
			}
			m_popUpDia.visible = true;
			
			//注册所有按钮事件
			registerEventClick();
		}
		
		private function registerEventClick():void 
		{
			//确定按钮点击
			m_popUpDia.m_btnIsOK.on(Event.CLICK, this, onIsOKClicked);
			//黑幕被电击
			m_blackWindowView.on(Event.CLICK, this, onBlackScreenClicked);
		}
		
		//黑幕被点击
		private function onBlackScreenClicked():void 
		{
			return;
		}
		
		//确定按钮点击
		private function onIsOKClicked():void 
		{
			GameIF.DectiveLogic(LogicManager.POPUPLOGIC);
		}
		
		public function SetTitle(title:String):void 
		{
			m_popUpDia.m_lableTitle.text = title;
		}
		
		public override function Destroy():void
		{
			
			m_blackWindowView.Destroy();
			m_blackWindowView.destroy();
			m_blackWindowView.visible = false;
			m_blackWindowView = null;
			
			m_popUpDia.Destroy();
			m_popUpDia.destroy();
			m_popUpDia.visible = false;
			m_popUpDia = null;	
		}
		
	}

}