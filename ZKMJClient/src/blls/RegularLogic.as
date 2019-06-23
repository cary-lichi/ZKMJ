package blls 
{
	import core.GameIF;
	import core.LogicManager;
	import laya.events.Event;
	import laya.utils.Handler;
	import view.RegularView;
	/**
	 * ...
	 * @author ...
	 */
	public class RegularLogic extends BaseLogic
	{
		private var m_regularView:RegularView;
		public function RegularLogic() 
		{
			
		}
		public override function Init():void
		{
			if (m_regularView == null)
			{
				m_regularView = new RegularView;
				m_regularView.Init();
			}
			m_regularView.visible = false;
			m_regularView.m_btnClose.on(Event.CLICK, this, OnCloseClicked);
			InitTab();
			// 垂直方向滚动
			m_regularView.m_panel00.vScrollBarSkin = "";
			m_regularView.m_panel01.vScrollBarSkin = "";
			m_regularView.m_panel02.vScrollBarSkin = "";
			m_regularView.m_panel03.vScrollBarSkin = "";
			m_regularView.m_panel10.vScrollBarSkin = "";
			m_regularView.m_panel11.vScrollBarSkin = "";
			m_regularView.m_panel12.vScrollBarSkin = "";
			m_regularView.m_panel13.vScrollBarSkin = "";
		}
		public function Show():void 
		{
			m_regularView.visible = true;
		}
		private function InitTab():void 
		{
			m_regularView.m_tabPlaySelect.selectedIndex = 0;
			m_regularView.m_tabHRBSelect.selectedIndex = 0;
			m_regularView.m_tabMDJSelect.selectedIndex = 0;
			m_regularView.m_tabPlaySelect.selectHandler = new Handler(this, onPlaySelect);
			m_regularView.m_tabMDJSelect.selectHandler = new Handler(this, onMDJSelect);
			m_regularView.m_tabHRBSelect.selectHandler = new Handler(this, onHRBSelect);
		}
		
		private function OnCloseClicked():void 
		{
			m_regularView.visible = false;
			//规则滚动条回滚到最初。
			m_regularView.m_panel00.vScrollBar.value = 0;
			m_regularView.m_panel01.vScrollBar.value = 0;
			m_regularView.m_panel02.vScrollBar.value = 0;
			m_regularView.m_panel03.vScrollBar.value = 0;
			m_regularView.m_panel10.vScrollBar.value = 0;
			m_regularView.m_panel11.vScrollBar.value = 0;
			m_regularView.m_panel12.vScrollBar.value = 0;
			m_regularView.m_panel13.vScrollBar.value = 0;
			this.InitTab();
		}
		
		private function onPlaySelect(index:int):void 
		{
			m_regularView.m_stackPlay.selectedIndex = index;
			if (index == 0)
			{
				m_regularView.m_imgArrow.y = 21;
			}
			else if (index == 1)
			{
				m_regularView.m_imgArrow.y = 87;
			}
		}
		private function onHRBSelect(index:int):void 
		{
			m_regularView.m_stackHRB.selectedIndex = index;
		}
		
		private function onMDJSelect(index:int):void 
		{
			m_regularView.m_stackMDJ.selectedIndex = index;
		}
		public override function Destroy():void
		{
			m_regularView.Destroy();
			m_regularView.destroy();
			m_regularView = null;
		}
		
	}

}