package view.ActiveView 
{
	import core.Constants;
	import core.GameIF;
	import laya.utils.Browser;
	import tool.Tool;
	import ui.MahjongRoot.MailContentWindowUI;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MailContentWindow extends MailContentWindowUI 
	{
		
		public function MailContentWindow() 
		{
			super();
		}
		public function Init():void 
		{
			Laya.stage.addChild(this);
			var view:MailContentWindow = this;
			if (Constants.isAdaptPhone)
			{
				reWindowUi();
			
				Browser.window.addEventListener("resize", function():void {
				Laya.timer.once(1000, view, reWindowUi);
				});
			}
		}	
		private function reWindowUi():void
		{
			Tool.Adaptation(this);
		}
		public function InitDal(data:*):void 
		{
			var mail:JSON = GameIF.GetJson()["mail"][data.nType];
			var mailContent:JSON = GameIF.GetJson()["mailContent"];
			this.m_labelTitle.text = mail["title"];
			this.m_labelTime.text = data.sTime;
			this.m_labekState.text = mail["state"];
			this.m_labekReward.text = mailContent[data.sContent];
			this.m_labelArrivalTime.text = data.sTime;
			
		}
		public function Destroy():void 
		{
			Laya.stage.removeChild(this);
			this.destroy();
		}
	}

}