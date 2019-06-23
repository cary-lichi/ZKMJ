package view.ActiveView 
{
	import core.Constants;
	import laya.utils.Browser;
	import tool.Tool;
	import ui.MahjongRoot.GamerInfoWindowUI;
	/**
	 * ...
	 * @author ...
	 */
	public class GamerInfoDia extends GamerInfoWindowUI
	{
		
		public function GamerInfoDia() 
		{
			super();
		}
		
		public function Init():void
		{
			var gamerInfoDia:GamerInfoDia = this;
			Laya.stage.addChild(this);
			if (Constants.isAdaptPhone)
				{
					reSetGamerInfoDiaUi();
				
					Browser.window.addEventListener("resize", function():void {
						Laya.timer.once(1000, gamerInfoDia, reSetGamerInfoDiaUi);
					});
				}
		}
		
		private function reSetGamerInfoDiaUi():void
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