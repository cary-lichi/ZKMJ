package view.ActiveView._gameItem 
{
	import core.GameIF;
	import laya.ui.Image;
	import model._Pai.Pai;
	import tool.Tool;
	/**
	 * ...
	 * @author ...
	 */
	//带牌面的牌
	public class BaseFacePaiItem extends BasePaiItem 
	{
		protected var m_imgPaiValue:Image;
		protected var m_baoTip:Image;
		public function BaseFacePaiItem() 
		{
			super();
			
			m_imgPaiValue = new Image;
			m_paiBg.addChild(m_imgPaiValue);
			
			m_baoTip = new Image;
			m_baoTip.skin = "game/img_baoTip.png";
			m_baoTip.visible = false;
			m_imgPaiValue.addChild(m_baoTip);
		}
		public  function ShowBaoTip():void 
		{
			m_baoTip.right = 0;
			m_baoTip.visible = true;
		}
		public function HideBaoTip():void 
		{
			m_baoTip.visible = false;
		}
		protected function GetSkin():String
		{
			if (m_pai)
			{
				return "game/pai/img_" + Tool.GetRenderPai(m_pai.nType, m_pai.nValue) + ".png";
			}
			else
			{
				trace("错误提示:当前pai为" + m_pai);
				return " ";
			}
		
		}
		public override function set pai(value:Pai):void
		{
			m_pai = value;
			
			m_imgPaiValue.skin = GetSkin();
			var bao:Pai = GameIF.GetRoom().BaoPai;
			if (bao)
			{
				if (bao.nType == value.nType && bao.nValue == value.nValue)
				{
					ShowBaoTip();
				}
				else
				{
					HideBaoTip();
				}
			}
			
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