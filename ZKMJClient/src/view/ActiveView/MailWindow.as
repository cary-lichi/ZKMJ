package view.ActiveView 
{
	import core.Constants;
	import laya.ui.Component;
	import laya.utils.Browser;
	import laya.utils.Handler;
	import tool.Tool;
	import ui.MahjongRoot.MailWindowUI;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MailWindow extends MailWindowUI 
	{
		
		public function MailWindow() 
		{
			super();
		}
		public function Init():void 
		{
			Laya.stage.addChild(this);
			var view:MailWindow = this;
			if (Constants.isAdaptPhone)
			{
				reWindowUi();
			
				Browser.window.addEventListener("resize", function():void {
				Laya.timer.once(1000, view, reWindowUi);
				});
			}
			InitView();
		}	
		private function reWindowUi():void
		{
			Tool.Adaptation(this);
		}
		private function InitView():void 
		{
			this.m_list.vScrollBarSkin = "";
			this.m_list.spaceY = 5;
			//滚动在头或底回弹时间
            this.m_list.scrollBar.elasticBackTime = 200;
            //滚动在头或底最大距离
            this.m_list.scrollBar.elasticDistance = 400;
		}
		
		public function Destroy():void 
		{
			Laya.stage.removeChild(this);
			this.destroy();
		}
	}

}