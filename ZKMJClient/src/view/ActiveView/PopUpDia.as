package view.ActiveView 
{
	import core.Constants;
	import tool.Tool;
	import ui.MahjongRoot.PopUpDiaUI;
	import core.GameIF;
	import core.UiManager;
	import laya.utils.Browser;
	/**
	 * ...
	 * @author ...
	 */
	public class PopUpDia extends PopUpDiaUI 
	{
		
		public function PopUpDia() 
		{
			super();
		}
		public function Init():void 
		{
			var top:int = (640 - this.height) / 2;
			var left:int = (1136 - this.width) / 2;
			this.pos(left,top);
			Laya.stage.addChild(this);
			var viewPopUp:PopUpDia= this;
			if (Constants.isAdaptPhone)
			{
				reSetPopUpDiaUi();
			
				Browser.window.addEventListener("resize", function():void {
				Laya.timer.once(1000, viewPopUp, reSetPopUpDiaUi);
				});
			}
		}
			
		private function reSetPopUpDiaUi():void
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