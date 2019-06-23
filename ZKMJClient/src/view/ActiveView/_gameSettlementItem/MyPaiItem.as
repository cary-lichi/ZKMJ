package view.ActiveView._gameSettlementItem 
{
	import laya.ui.Box;
	import laya.ui.Button;
	import laya.ui.Image;
	/**
	 * ...
	 * @author ...
	 */
	public class MyPaiItem extends BaseItem
	{
		
		
		public function MyPaiItem() 
		{
			m_paiBg.width = 58;
			m_paiBg.height = 85;
			
			m_imgPaiValue.width = 58;
			m_imgPaiValue.height = 76;
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