package view.ActiveView._gameItem 
{
	import laya.ui.Button;
	import laya.ui.Image;
	/**
	 * ...
	 * @author ...
	 */
	public class Gamer3CanPaiItem extends BaseFacePaiItem
	{
		
		public function Gamer3CanPaiItem() 
		{
			super();
			m_paiBg.skin = "game/pai/btn_3canPai.png";
			
			m_imgPaiValue.x = 13;
			m_imgPaiValue.y = 23;
			m_imgPaiValue.pivot(0.5, 0.5);
			m_imgPaiValue.scale(0.34, 0.51);
			m_imgPaiValue.skewY = -16;
			m_imgPaiValue.rotation = -90;
			
		}
	}

}