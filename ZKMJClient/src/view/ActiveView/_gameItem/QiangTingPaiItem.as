package view.ActiveView._gameItem 
{
	import tool.Tool;
	/**
	 * ...
	 * @author ...
	 */
	public class QiangTingPaiItem extends BaseCanPaiItem 
	{
		
		public function QiangTingPaiItem() 
		{
			createItem(3);
		}
		public override function renderItem(paiobj:Object):void 
		{
			m_canPaiArr[0].skin = "game/pai/img_" + Tool.GetRenderPai(paiobj.pai1.nType, paiobj.pai1.nValue) + ".png";
			m_canPaiArr[1].skin = "game/pai/img_" + Tool.GetRenderPai(paiobj.pai2.nType, paiobj.pai2.nValue) + ".png";
			m_canPaiArr[2].skin = "game/pai/img_" + Tool.GetRenderPai(paiobj.pai3.nType, paiobj.pai3.nValue) + ".png";
		}
	}

}