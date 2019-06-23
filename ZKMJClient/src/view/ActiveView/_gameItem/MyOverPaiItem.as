package view.ActiveView._gameItem 
{
	import laya.ui.Box;
	import laya.ui.Button;
	import laya.ui.Image;
	/**
	 * ...
	 * @author ...
	 */
	public class MyOverPaiItem extends Gamer0PaiItem
	{
		public function MyOverPaiItem() 
		{
			super();
			this.pivot(0.5, 0.5);
			this.scale(0.8, 0.8);
			m_nSpaceX = m_paiBg.width * 0.8;
		}
	}

}