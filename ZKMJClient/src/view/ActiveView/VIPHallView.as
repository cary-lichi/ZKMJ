package view.ActiveView 
{
	import core.Constants;
	import core.GameIF;
	import tool.Tool;
	import ui.MahjongRoot.VIPhallPageUI;
	import core.UiManager;
	import laya.utils.Browser;
	
	
	/**
	 * ...
	 * @author ...
	 */
	public class VIPHallView extends VIPhallPageUI 
	{
		
		public function VIPHallView() 
		{
			super();	
		}
		public function Init():void
		{
			m_RadioNum.selectedIndex = 0;
			Laya.stage.addChild(this);
			if (Constants.isAdaptPhone)
			{
				reSetVIPHallViewUi();
				var viewViphall:VIPHallView = this;
				Browser.window.addEventListener("resize", function():void {
					Laya.timer.once(1000, viewViphall, reSetVIPHallViewUi);
				});
			}
		}
		
		private function reSetVIPHallViewUi():void
		{
			Tool.Adaptation(this);
			this.m_imgTop.width = this.width;
			this.m_imgContent.width = this.width *(1120/1136);
			this.m_btnBack.x = 20 * Tool.getScale();
		}
		public function Destroy():void
		{
			Laya.stage.removeChild(this);
			this.destroy();
		}
	}
}