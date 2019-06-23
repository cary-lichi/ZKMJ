package view.ActiveView._gameSettlementItem 
{
	import laya.ui.Button;
	import laya.ui.Image;
	/**
	 * ...
	 * @author ...
	 */
	public class OtherPaiItem extends BaseItem
	{
		
		public function OtherPaiItem() 
		{
			m_paiBg.width = 34;
			m_paiBg.height = 50;
			
			m_imgPaiValue.width = 34;
			m_imgPaiValue.height = 42;
			m_imgPaiValue.y = 10;
			m_paiBg.addChild(m_imgPaiValue);
		}
		
		public function get paiBg():Button 
		{
			return m_paiBg;
		}
		
		public function set paiBg(value:Button):void 
		{
			m_paiBg = value;
		}
		
		public function get imgPaiValue():Image 
		{
			return m_imgPaiValue;
		}
		
		public function set imgPaiValue(value:Image):void 
		{
			m_imgPaiValue = value;
		}
		
	}

}