package view 
{
	import ui.MahjongRoot.RecordRuleDiaUI;
	import core.Constants;
	import laya.utils.Browser;
	import tool.Tool;
	/**
	 * ...
	 * @author ...
	 */
	public class RecordRuleView extends RecordRuleDiaUI 
	{
		
		public function RecordRuleView() 
		{
			super();
		}
		
		public function Init():void
		{ 
			
			Laya.stage.addChild(this);
			var viewLoading:RecordRuleView = this;
			
			if (Constants.isAdaptPhone)
			{
				reSetRecordRuleViewUi();
			
				Browser.window.addEventListener("resize", function():void {
					Laya.timer.once(1000, viewLoading, reSetRecordRuleViewUi);
				});
			}
		}
	
		
		private function reSetRecordRuleViewUi():void
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