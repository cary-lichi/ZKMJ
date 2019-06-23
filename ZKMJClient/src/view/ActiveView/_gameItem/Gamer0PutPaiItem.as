package view.ActiveView._gameItem 
{
	import laya.ui.Button;
	import laya.ui.Image;
	/**
	 * ...
	 * @author ...
	 */
	public class Gamer0PutPaiItem extends BaseFacePaiItem
	{
		
		public function Gamer0PutPaiItem() 
		{
			super();
			m_paiBg.skin = "game/pai/btn_0putPai.png";
			
			m_imgPaiValue.centerX = 0;
			m_imgPaiValue.pivot(0.5, 0.5);
			m_imgPaiValue.scale(0.5,0.5);
			this.height = m_imgPaiValue.height;
			
		}
	}

}