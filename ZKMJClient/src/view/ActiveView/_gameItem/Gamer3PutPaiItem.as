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
	public class Gamer3PutPaiItem extends BaseFacePaiItem
	{
		
		public function Gamer3PutPaiItem() 
		{
			super();
			m_paiBg.skin = "game/pai/btn_3putPai.png";
			
			m_imgPaiValue.x = 7;
			m_imgPaiValue.y = 28;
			m_imgPaiValue.width = 26;
			m_imgPaiValue.height = 54;
			m_imgPaiValue.skewY = -7;
			m_imgPaiValue.rotation = -90;
			
		}
		
		public override function PaiTweenStart(x:int,y:int,caller:*,complete:Function):void 
		{
			this.scale(Tool.getScale(), Tool.getScale());
			this.visible = true;
			Tween.to(this, { "x":x, "y":y }, 300,null,new Handler(caller,complete));
		}
	}

}