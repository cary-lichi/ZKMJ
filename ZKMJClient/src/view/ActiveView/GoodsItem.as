package view.ActiveView 
{
	import laya.display.Text;
	import laya.ui.Box;
	import laya.ui.Button;
	import laya.ui.Image;
	import laya.ui.Label;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GoodsItem extends Box 
	{
		private var m_imgBg:Image;
		private var m_imgType:Image;
		private var m_labelMoney:Label;
		private var m_btnBg:Button;
		private var m_numText:Label;
		private var m_goodsID:int;
		private var m_imgDiamonds:Image;
		
		public function GoodsItem() 
		{
			m_imgBg = new Image;
			m_imgBg.skin = "roomGold/img_minbg.png";
			m_imgBg.width = 380;
			m_imgBg.height = 145;
			m_imgBg.sizeGrid = "50, 30, 50, 30";
			this.addChild(m_imgBg);
			
			m_numText = new Label;
			m_numText.fontSize = 30;
			m_numText.left = 110;
			m_numText.centerY = 0;
			m_numText.width = 115;
			//m_numText.align = "center";
			m_numText.valign = "middle";
			m_numText.color = "#973e11";
			m_imgBg.addChild(numText);
			
			
			m_imgType = new Image;
			m_imgType.left = 22;
			m_imgType.centerY = 0;
			m_imgType.width = 80;
			m_imgType.height = 80;
			m_imgBg.addChild(m_imgType);
			
			
			m_btnBg = new Button;
			m_btnBg.left = 205;
			m_btnBg.centerY = 0;
			m_btnBg.width = 155;
			m_btnBg.skin="roomGold/btn_buyBg.png"
			m_imgBg.addChild(m_btnBg);
			
			m_imgDiamonds = new Image;
			m_imgDiamonds.width = 40;
			m_imgDiamonds.height = 40;
			m_imgDiamonds.centerY = 0;
			m_imgDiamonds.left = 15;
			m_btnBg.addChild(m_imgDiamonds);
			
			m_labelMoney = new Label;
			m_labelMoney.color = "#fff9af";
			m_labelMoney.stroke = 2;
			m_labelMoney.strokeColor = "#ac4910";
			m_labelMoney.fontSize = 28;
			m_labelMoney.width = 154;
			m_labelMoney.height = 52;
			m_labelMoney.centerX = 0;
			m_labelMoney.align = "center";
			m_labelMoney.valign = "middle";
			m_btnBg.addChild(m_labelMoney);
		}
		
		
		
		public function get numText():Label 
		{
			return m_numText;
		}
		
		public function set numText(value:Label):void 
		{
			m_numText = value;
		}
		
		public function get imgBg():Image 
		{
			return m_imgBg;
		}
		
		public function set imgBg(value:Image):void 
		{
			m_imgBg = value;
		}
		
		
		public function get imgType():Image 
		{
			return m_imgType;
		}
		
		public function set imgType(value:Image):void 
		{
			m_imgType = value;
		}
		
		public function get goodsID():int 
		{
			return m_goodsID;
		}
		
		public function set goodsID(value:int):void 
		{
			m_goodsID = value;
		}
		
		public function get labelMoney():Label 
		{
			return m_labelMoney;
		}
		
		public function set labelMoney(value:Label):void 
		{
			m_labelMoney = value;
		}
		
		public function get imgDiamonds():Image 
		{
			return m_imgDiamonds;
		}
		
		public function set imgDiamonds(value:Image):void 
		{
			m_imgDiamonds = value;
		}
	}

}