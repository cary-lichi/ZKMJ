package view.ActiveView._gameItem 
{
	import laya.ui.Box;
	import laya.ui.Button;
	import laya.ui.Image;
	import laya.ui.Label;
	/**
	 * ...
	 * @author ...
	 */
	public class HuTipItem extends BaseFacePaiItem
	{
		
		private var m_bg:Image;
		private var m_paiNum:Label;
		private var m_zhang:Label;
		
		public function HuTipItem() 
		{
			super();
			
			m_bg = new Image;
			m_bg.skin = "game/img_HuTipContent.png";
			m_bg.width = 131;
			m_bg.height = 88;
			m_bg.sizeGrid = "15,15,15,15";
			m_bg.zOrder = -1;
			this.addChild(m_bg);
			
			m_paiBg.skin = "game/pai/img_chiPaiBg.png";
			m_paiBg.pos(10, 5);
			
			m_imgPaiValue.width = 57;
			m_imgPaiValue.height = 77;
			
			m_paiNum = new Label;
			m_paiNum.color = "#be4917";
			m_paiNum.font = "SimHei";
			m_paiNum.fontSize = 20;
			m_paiNum.pos(80, 34);
			m_paiBg.addChild(m_paiNum);
			
			m_zhang = new Label;
			m_zhang.color = "#6b3c27";
			m_zhang.font = "SimHei";
			m_zhang.fontSize = 20;
			m_zhang.text = "张";
			m_zhang.pos(95, 34);
			m_paiBg.addChild(m_zhang);
		}
		
		public function get paiNum():Label 
		{
			return m_paiNum;
		}
		
		public function set paiNum(value:Label):void 
		{
			m_paiNum = value;
		}
	}

}