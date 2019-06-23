package view.ActiveView 
{
	import core.Constants;
	import tool.Tool;
	import ui.MahjongRoot.SetWindowUI;
	import core.GameIF;
	import core.UiManager;
	import laya.utils.Browser;
	/**
	 * ...
	 * @author ...
	 */
	public class SetWindow extends SetWindowUI 
	{
		
		public function SetWindow() 
		{
			super();
		}
		
		public function Init():void 
		{
			
			Laya.stage.addChild(this);
			var viewSet:SetWindow = this;
			if (Constants.isAdaptPhone)
			{
				reSetWindowUi();
			
				Browser.window.addEventListener("resize", function():void {
				Laya.timer.once(1000, viewSet, reSetWindowUi);
				});
			}
		}
			
		private function reSetWindowUi():void
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