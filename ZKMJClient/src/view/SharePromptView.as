package view 
{
	import core.Constants;
	import laya.utils.Browser;
	import laya.utils.Handler;
	import laya.utils.Tween;
	import tool.Tool;
	import ui.MahjongRoot.SharePromptViewUI;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SharePromptView extends SharePromptViewUI 
	{
		
		public function SharePromptView() 
		{
			super();
		}
		public function Init():void
		{
			Laya.stage.addChild(this);
			if (Constants.isAdaptPhone)
			{
				reSetviewUi();
				var sharePromptView:SharePromptView = this;
				Browser.window.addEventListener("resize", function():void {
					Laya.timer.once(1000, sharePromptView, reSetviewUi);
				});
			}
			
			//初始分享提示
			RenderfloatArrow();
		}
		
		private function reSetviewUi():void
		{
			Tool.Adaptation(this);
		}
		protected function RenderfloatArrow():void 
		{
			SetfloatArrowPosUp();
		}
		protected function SetfloatArrowPosUp():void 
		{
			var x:int = m_imgFloatArrow.x + 20;
			Tween.to(m_imgFloatArrow, { "x":x  }, 300,null,new Handler(this,SetfloatArrowPosDown));
		}
		protected function SetfloatArrowPosDown():void 
		{
			var x:int = m_imgFloatArrow.x - 20;
			Tween.to(m_imgFloatArrow, { "x": x }, 300,null,new Handler(this,SetfloatArrowPosUp));
		}
		public function Destroy():void
		{
			Laya.stage.removeChild(this);
			this.destroy();
		}
		
	}

}