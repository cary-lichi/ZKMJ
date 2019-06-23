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
	public class AlphaWindowView extends Box
	{
		protected var m_alphaBgImg:Sprite;
		
		public function AlphaWindowView() 
		{
			//全透明
			m_alphaBgImg = new Sprite;
			m_alphaBgImg.graphics.drawRect(0, 0, Laya.stage.width, Laya.stage.height, "white");
			m_alphaBgImg.size(Laya.stage.width, Laya.stage.height);
			//设置透明度
			m_alphaBgImg.alpha = 0;
			this.addChild(m_alphaBgImg);
			if (Constants.isAdaptPhone)
			{
				reSetViewUi();
				var alphaWindowView:AlphaWindowView = this;
				Browser.window.addEventListener("resize", function():void {
				Laya.timer.once(1000, alphaWindowView, reSetViewUi);
				
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
			this.destroy();
		}
		
	}

}