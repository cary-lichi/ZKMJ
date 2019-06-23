package view.ActiveView 
{
	import laya.ui.Box;
	import laya.ui.Image;
	import laya.ui.Label;
	/**
	 * ...
	 * @author dawenhao
	 */
	public class PrizeItem extends Box
	{
		protected var m_imgBg:Image;
		protected var m_imgPrizeType:Image;	
		protected var m_labName:Label;
		protected var m_nPrizeID:int;
		
		
		
		public function PrizeItem() 
		{
			m_imgBg = new Image;
			m_imgBg.width = 80;
			m_imgBg.height = 80;
			m_imgBg.centerX = 0;
			//m_imgBg.top = 40;
			this.addChild(m_imgBg);
			
			m_imgPrizeType = new Image;
			m_imgPrizeType.centerX = 0;
			m_imgPrizeType.width = 60;
			m_imgPrizeType.height = 60;
			//m_imgPrizeType.centerY = 0;
			m_imgBg.addChild(m_imgPrizeType);
			
			m_labName = new Label;
			m_labName.width = 80;
			//m_labName.height = 15;
			m_labName.bottom = 0;
			m_labName.align = "center";
			m_labName.color = "#ab3a02" ;
			m_labName.font = "SimHei";
			m_labName.fontSize = 18;
			m_labName.bold = true;
			m_imgBg.addChild(m_labName);
		}
		
		public function get imgPrizeType():Image 
		{
			return m_imgPrizeType;
		}
		
		public function set imgPrizeType(value:Image):void 
		{
			m_imgPrizeType = value;
		}
		
		public function get labName():Label 
		{
			return m_labName;
		}
		
		public function set labName(value:Label):void 
		{
			m_labName = value;
		}
		
		public function get nPrizeID():int 
		{
			return m_nPrizeID;
		}
		
		public function set nPrizeID(value:int):void 
		{
			m_nPrizeID = value;
		}
		
		
	}

}