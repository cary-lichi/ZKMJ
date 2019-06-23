package view 
{
	import core.Constants;
	import laya.utils.Browser;
	import tool.Tool;
	import ui.MahjongRoot.TotalScorePageUI;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TotalScoreView extends TotalScorePageUI 
	{
		
		public function TotalScoreView() 
		{
			super();
		}
		public function Init():void
		{		
			Reset();
			Laya.stage.addChild(this);
			if (Constants.isAdaptPhone)
			{
				reSetViewUi();
				var totalScoreView:TotalScoreView = this;
				Browser.window.addEventListener("resize", function():void {
				Laya.timer.once(1000, totalScoreView, reSetViewUi);
				
				});
				
			}
		}
		public function Reset():void 
		{
			this.visible = false;
			this.m_boxGamer1.visible = false;
			this.m_boxGamer2.visible = false;
			this.m_boxGamer3.visible = false;
		}
		public function reSetViewUi():void
		{
			Tool.Adaptation(this);
			this.m_imgTopBg.width = this.width;
			this.m_imgTopBg.height = 55 * Tool.getScale();
			this.m_boxTop.scale(Tool.getScale(), Tool.getScale());
			this.m_boxTop.centerX = 0;
		}
		public function Destroy():void
		{
			Laya.stage.removeChild(this);
			this.destroy();
		}
	}

}