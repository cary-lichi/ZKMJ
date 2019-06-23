package view.ActiveView._gameItem 
{
	import laya.ui.Button;
	import laya.ui.Image;
	/**
	 * ...
	 * @author ...
	 */
	public class Gamer1CanPaiItem extends BaseFacePaiItem
	{
		
		public function Gamer1CanPaiItem() 
		{
			super();
			m_paiBg.skin = "game/pai/btn_1canPai.png";
			
			m_imgPaiValue.x = 57;
			m_imgPaiValue.y = 0;
			m_imgPaiValue.pivot(0.5, 0.5);
			m_imgPaiValue.scale(0.33,0.5);
			m_imgPaiValue.skewY = 17;
			m_imgPaiValue.rotation = 90;
			
		}
	}

}