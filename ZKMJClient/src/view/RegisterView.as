package view 
{
	import ui.MahjongRoot.LoginAccountPageUI;
	import ui.MahjongRoot.RetrievePageUI;
	/**
	 * ...
	 * @author dawenhao
	 */
	public class RegisterView extends LoginAccountPageUI
	{
		
		public function RegisterView() 
		{
			super();
		}
		public function Init():void
		{
			Laya.stage.addChild(this);
		}
		
		public function Destroy():void
		{
			Laya.stage.removeChild(this);
			this.destroy();
		}
	}

}