package view.ActiveView 
{
	import core.Constants;
	import tool.Tool;
	import ui.MahjongRoot.OnLineDiaUI;
	import core.GameIF;
	import core.UiManager;
	import laya.utils.Browser;
	/**
	 * ...
	 * @author ...
	 */
	public class OnlineDia extends OnLineDiaUI 
	{
		
		public function OnlineDia() 
		{
			super();	
		}
		public function Init():void 
		{
			var top:int = (640 - this.height) / 2;
			var left:int = (1136 - this.width) / 2;
			this.pos(left, top);
			Laya.stage.addChild(this);
			var viewOline:OnlineDia = this;
			if (Constants.isAdaptPhone)
			{
				reSetOnlineDiaUi();
			
				Browser.window.addEventListener("resize", function():void {
				Laya.timer.once(1000, viewOline, reSetOnlineDiaUi);
				});
			}
		}
			
		private function reSetOnlineDiaUi():void
		{
			Tool.Adaptation(this);
		}
		
		
		public function Destroy():void 
		{
			Laya.stage.removeChild(this);
			this.destroy();
		}
	}

}