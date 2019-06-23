package view 
{
	import blls.RegularLogic;
	import core.Constants;
	import core.GameIF;
	import tool.Tool;
	import ui.MahjongRoot.RegularPageUI;
	import core.UiManager;
	import laya.utils.Browser;
	/**
	 * ...
	 * @author ...
	 */
	public class RegularView extends RegularPageUI
	{
		
		public function RegularView() 
		{
			super();
		}
		
		public function Init():void
		{
			Laya.stage.addChild(this);
			if (Constants.isAdaptPhone)
			{
				reSetViewUi();
				var viewRegular:RegularView = this;
				Browser.window.addEventListener("resize", function():void {
				Laya.timer.once(1000, viewRegular, reSetViewUi);
				
				});
				
			}
		}
			
		private function reSetViewUi():void
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