package view 
{
	import core.Constants;
	import laya.display.Sprite;
	import laya.ui.Box;
	import laya.utils.Browser;
	import tool.Tool;
	/**
	 * ...
	 * @author ...
	 */
	public class BlackWindowView extends Box
	{
		protected var m_blackBgImg:Sprite;
		
		public function BlackWindowView() 
		{
			//半透明黑屏
			m_blackBgImg = new Sprite;
			m_blackBgImg.graphics.drawRect(0, 0, Laya.stage.width, Laya.stage.height, "black");
			m_blackBgImg.size(Laya.stage.width, Laya.stage.height);
			m_blackBgImg.alpha = 0.5;
			this.addChild(m_blackBgImg);
			if (Constants.isAdaptPhone)
			{
				reSetViewUi();
				var blackWindowView:BlackWindowView = this;
				Browser.window.addEventListener("resize", function():void {
				Laya.timer.once(1000, blackWindowView, reSetViewUi);
				
				});
				
			}
		}
			
		private function reSetViewUi():void
		{
			Tool.Adaptation(this);
		}
		
		public function Init():void
		{
			Laya.stage.addChild(this);
		}
		public function Destroy():void
		{
			Laya.stage.removeChild(this);
		}
		
	}

}