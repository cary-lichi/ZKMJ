package view.ActiveView._gameItem 
{
	import laya.ui.Button;
	import laya.ui.Image;
	/**
	 * ...
	 * @author ...
	 */
	public class Gamer0CanPaiItem extends BaseFacePaiItem
	{
		
		public function Gamer0CanPaiItem() 
		{
			super();
			m_paiBg.skin = "game/pai/btn_0canPai.png";

			m_imgPaiValue.centerX = 0;
			m_imgPaiValue.pivot(0.5, 0.5);
			m_imgPaiValue.scale(0.65,0.65);
		}
	}

}