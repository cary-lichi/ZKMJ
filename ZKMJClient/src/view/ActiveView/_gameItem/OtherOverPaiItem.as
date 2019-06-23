package view.ActiveView._gameItem 
{
	import laya.ui.Button;
	import laya.ui.Image;
	/**
	 * ...
	 * @author ...
	 */
	public class OtherOverPaiItem extends Gamer0PaiItem
	{	
		public function OtherOverPaiItem() 
		{
			super();
			this.pivot(0.5, 0.5);
			this.scale(0.6, 0.6);
			m_nSpaceX = m_paiBg.width * 0.6;
		}
	}

}