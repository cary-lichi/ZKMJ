package view 
{
	import blls.LoginLogic;
	import core.Constants;
	import core.GameIF;
	import core.LogicManager;
	import laya.events.Event;
	import laya.utils.Browser;
	import tool.Tool;
	import ui.MahjongRoot.RetrievePageUI;
	/**
	 * ...
	 * @author ...
	 */
	public class RetrieveView extends RetrievePageUI
	{
		
		public function RetrieveView() 
		{
			super();
		}
		
		public function Init():void
		{
			Laya.stage.addChild(this);
			if (Constants.isAdaptPhone)
			{
				reSetViewUi();
				var retrieveView:RetrieveView = this;
				Browser.window.addEventListener("resize", function():void {
				Laya.timer.once(1000, retrieveView, reSetViewUi);
				
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