package view.ActiveView 
{
	import core.Constants;
	import tool.Tool;
	import ui.MahjongRoot.ServiceWindowUI;
	import core.GameIF;
	import core.UiManager;
	import laya.utils.Browser;
	/**
	 * ...
	 * @author ...
	 */
	public class ServiceWindow extends ServiceWindowUI 
	{
		
		public function ServiceWindow() 
		{
			super();
		}
		
		public function Init():void 
		{
			var top:int = (640 - this.height) / 2;
			var left:int = (1136 - this.width) / 2;
			this.pos(left,top);
			Laya.stage.addChild(this);
			var viewService:ServiceWindow = this;
			if (Constants.isAdaptPhone)
			{
				reServiceWindowUi();
			
				Browser.window.addEventListener("resize", function():void {
				Laya.timer.once(1000, viewService, reServiceWindowUi);
				});
			}
		}
			
		private function reServiceWindowUi():void
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