package view 
{
	import core.Constants;
	import core.GameIF;
	import laya.utils.Browser;
	import tool.Tool;
	import ui.MahjongRoot.UserAgreementPageUI;
	
	/**
	 * ...
	 * @author ...
	 */
	public class UserAgreementPage extends UserAgreementPageUI 
	{
		
		public function UserAgreementPage() 
		{
			super();
		}
		
		public function Init():void
		{
			//GameIF.
			
			Laya.stage.addChild(this);
			if (Constants.isAdaptPhone)
			{
				reSetViewUi();
				var userAgreementPage:UserAgreementPage = this;
				Browser.window.addEventListener("resize", function():void {
				Laya.timer.once(1000, userAgreementPage, reSetViewUi);
				
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