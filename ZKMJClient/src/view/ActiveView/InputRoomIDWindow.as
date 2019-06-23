package view.ActiveView 
{
	import core.Constants;
	import tool.Tool;
	import ui.MahjongRoot.InputRoomIDWindowUI;
	import core.GameIF;
	import core.UiManager;
	import laya.utils.Browser;
	/**
	 * ...
	 * @author ...
	 */
	public class InputRoomIDWindow extends InputRoomIDWindowUI
	{
		
		public function InputRoomIDWindow() 
		{
			super();
		}
		
		public function Init():void 
		{
			Laya.stage.addChild(this);
			if (Constants.isAdaptPhone)
			{
				reSetInputRoomIDWindowUi();
				var view:* = this;
				Browser.window.addEventListener("resize", function():void {
				Laya.timer.once(1000, view, reSetInputRoomIDWindowUi);
				
				});
				
			}
		}
			
		private function reSetInputRoomIDWindowUi():void
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