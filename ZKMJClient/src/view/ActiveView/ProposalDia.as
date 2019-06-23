package view.ActiveView 
{
	import core.Constants;
	import tool.Tool;
	import ui.MahjongRoot.ProposalDiaUI;
	import core.GameIF;
	import core.UiManager;
	import laya.utils.Browser;
	/**
	 * ...
	 * @author ...
	 */
	public class ProposalDia extends ProposalDiaUI
	{
		
		public function ProposalDia ()
		{
			super();
		}
		public function Init():void 
		{
			var top:int = (640 - this.height) / 2;
			var left:int = (1136 - this.width) / 2;
			this.pos(left,top);
			Laya.stage.addChild(this);
			var viewProposal:ProposalDia= this;
			if (Constants.isAdaptPhone)
			{
				reProposalDiaUi();
			
				Browser.window.addEventListener("resize", function():void {
				Laya.timer.once(1000, viewProposal, reProposalDiaUi);
				});
			}
		}
			
		private function reProposalDiaUi():void
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