package view.ActiveView._gameItem 
{
	import laya.ui.Button;
	import laya.ui.Image;
	import laya.utils.Handler;
	import laya.utils.Tween;
	import tool.Tool;
	/**
	 * ...
	 * @author ...
	 */
	public class Gamer2PutPaiItem extends BaseFacePaiItem
	{
		
		public function Gamer2PutPaiItem() 
		{
			super();
			m_paiBg.skin = "game/pai/btn_2putPai.png";
			
			m_imgPaiValue.x = 37;
			m_imgPaiValue.y = 33;
			m_imgPaiValue.width = 36;
			m_imgPaiValue.height = 32;
			m_imgPaiValue.rotation = 180;
			
		}
		
		public override function PaiTweenStart(x:int,y:int,caller:*,complete:Function):void 
		{
			this.scale(Tool.getScale(), Tool.getScale());
			this.visible = true;
			Tween.to(this, { "x":x, "y":y }, 300,null,new Handler(caller,complete));
		}
	}

}