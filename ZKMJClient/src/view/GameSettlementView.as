package view 
{
	import core.Constants;
	import laya.ui.Image;
	import laya.utils.Browser;
	import tool.Tool;
	import ui.MahjongRoot.GameSettlementPageUI;
	import view.ActiveView._gameItem.Gamer0PaiItem;
	/**
	 * ...
	 * @author ...
	 */
	public class GameSettlementView extends GameSettlementPageUI
	{
		private var m_BaoPai:Gamer0PaiItem;
		
		public function GameSettlementView() 
		{
			super();
		}
		
		public function Init():void
		{
			InitBaoPai();
			Reset();
			Laya.stage.addChild(this);
			if (Constants.isAdaptPhone)
			{
				reSetViewUi();
				var gameSettlementView:GameSettlementView = this;
				Browser.window.addEventListener("resize", function():void {
				Laya.timer.once(1000, gameSettlementView, reSetViewUi);
				
				});
				
			}
		}
			
		private function reSetViewUi():void
		{
			Tool.Adaptation(this);
		}
		public function Reset():void 
		{
			this.m_imgBai.visible = false;
			this.m_imgPing.visible = false;
			this.m_imgHu.visible = false;
			this.visible = false;
			this.m_btnShowPai.visible = true;
			this.m_btnShowSetlement.visible = false;
			this.m_imgBg.visible = true;
			this.m_boxSettlement.visible = true;

			this.m_boxGamer1.visible = false;
			this.m_boxGamer2.visible = false;
			this.m_boxGamer3.visible = false;
		}
		public function SetGamerBottomInfo(gamerInfo:*, gamer:*,message:*):void 
		{
			
		}
		public function SetGamerLeftInfo(gamerInfo:*, gamer:*):void 
		{
			
		}
		public function SetGamerTopInfo(gamerInfo:*, gamer:*):void 
		{
			
		}
		public function SetGamerRightInfo(gamerInfo:*, gamer:*):void 
		{
			
		}
		public function Destroy():void
		{
			Laya.stage.removeChild(this);
			this.destroy();
		}
		
		private function InitBaoPai():void 
		{
			if (m_BaoPai == null)
			{
				m_BaoPai = new Gamer0PaiItem;
				m_BaoPai.left = 94;
				m_BaoPai.top = 82;
				this.m_imgBaoPailight.addChild(m_BaoPai);
			}
			
		}
		
		public function get BaoPai():Gamer0PaiItem 
		{
			return m_BaoPai;
		}
		
		public function set BaoPai(value:Gamer0PaiItem):void 
		{
			m_BaoPai = value;
		}
	}

}