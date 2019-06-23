package view.ActiveView._gameItem 
{
	import laya.ui.Box;
	import laya.ui.Button;
	import laya.ui.Image;
	/**
	 * ...
	 * @author ...
	 */
	public class Gamer2CanPaiItem extends BaseFacePaiItem
	{
		
		public function Gamer2CanPaiItem() 
		{
			super();
			m_paiBg.skin = "game/pai/btn_2canPai.png";
			
			m_imgPaiValue.x = 33;
			m_imgPaiValue.y = 28;
			m_imgPaiValue.pivot(0.5, 0.5);
			m_imgPaiValue.scale(0.46,0.28);
			m_imgPaiValue.rotation = 180;
			
			
		}	
	}

}