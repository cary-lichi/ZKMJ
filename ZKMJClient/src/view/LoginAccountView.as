package view 
{
	import core.Constants;
	import core.GameIF;
	import core.LogicManager;
	import laya.events.Event;
	import laya.utils.Browser;
	import tool.Tool;
	import ui.MahjongRoot.LoginAccountPageUI;
	/**
	 * ...
	 * @author ...
	 */
	public class LoginAccountView extends LoginAccountPageUI
	{
		public function LoginAccountView() 
		{
			super();
		}
		
		public function Init():void
		{
			Laya.stage.addChild(this);
			if (Constants.isAdaptPhone)
			{
				reSetViewUi();
				var loginAccountView:LoginAccountView = this;
				Browser.window.addEventListener("resize", function():void {
				Laya.timer.once(1000, loginAccountView, reSetViewUi);
				
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