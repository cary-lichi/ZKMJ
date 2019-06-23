package view 
{
	import core.Constants;
	import core.GameIF;
	import tool.Tool;
	import ui.MahjongRoot.LoadingPageUI;
	import core.UiManager;
	import laya.utils.Browser;
	
	/**
	 * ...
	 * @author dawenhao
	 */
	public class LoadingView extends LoadingPageUI
	{
		
		public function LoadingView() 
		{
			super();
		}
		
		public function Init():void
		{ 
			
			Laya.stage.addChild(this);
			var viewLoading:LoadingView = this;
			
			if (Constants.isAdaptPhone)
			{
				reSetLoadingViewUi();
			
				Browser.window.addEventListener("resize", function():void {
					Laya.timer.once(1000, viewLoading, reSetLoadingViewUi);
				});
			}
		}
		
		private function reSetLoadingViewUi():void
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