package view.ActiveView._gameItem 
{
	import tool.Tool;
	/**
	 * ...
	 * @author ...
	 */
	public class GangPaiItem extends BaseCanPaiItem 
	{
		
		public function GangPaiItem() 
		{
			createItem(4);
			m_btnBg.width = 272;
		}
		public override function renderItem(paiobj:Object):void 
		{
			for (var i:int = 0; i < 4; i++)
			{
				m_canPaiArr[i].skin = "game/pai/img_" + Tool.GetRenderPai(paiobj.nType, paiobj.nValue) + ".png";	
			}
		}
		
	}

}