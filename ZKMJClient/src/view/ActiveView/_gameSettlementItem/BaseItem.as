package view.ActiveView._gameSettlementItem 
{
	import laya.ui.Box;
	import laya.ui.Button;
	import laya.ui.Image;
	/**
	 * ...
	 * @author ...
	 */
	public class BaseItem extends Box
	{
		protected var m_paiBg:Button;
		protected var m_imgPaiValue:Image;
		
		public function BaseItem() 
		{
			m_paiBg = new Button;
			m_paiBg.skin = "game/pai/btn_green.png";
			m_paiBg.stateNum = 1;
			this.addChild(m_paiBg);
			
			m_imgPaiValue = new Image;
			m_paiBg.addChild(m_imgPaiValue);
		}
		
	}

}