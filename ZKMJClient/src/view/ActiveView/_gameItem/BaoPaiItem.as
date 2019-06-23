package view.ActiveView._gameItem 
{
	import laya.ui.Button;
	import laya.ui.Image;
	import model._Pai.Pai;
	/**
	 * ...
	 * @author MailWindow
	 */
	public class BaoPaiItem extends BaseFacePaiItem 
	{
		private var m_imgPaiValue:Image;
		public function BaoPaiItem() 
		{
			super();					
			m_paiBg.skin = "game/pai/btn_green.png";
			m_imgPaiValue = new Image;
			m_imgPaiValue.y = 15;
			m_paiBg.addChild(m_imgPaiValue);
			
		}
		public override function set pai(value:Pai):void
		{
			m_pai = value;
			
			m_imgPaiValue.skin = GetSkin();
		}
	}

}