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
	public class Gamer1PutPaiItem extends BaseFacePaiItem
	{
		
		public function Gamer1PutPaiItem() 
		{
			super();
			m_paiBg.skin = "game/pai/btn_1putPai.png";
			
			
			m_imgPaiValue.x = 60;
			m_imgPaiValue.y = 2;
			m_imgPaiValue.width = 26;
			m_imgPaiValue.height = 54;
			m_imgPaiValue.skewY = 7;
			m_imgPaiValue.rotation = 90;
			
		}
		public override function PaiTweenStart(x:int,y:int,caller:*,complete:Function):void 
		{
			this.scale(Tool.getScale(), Tool.getScale());
			this.visible = true;
			Tween.to(this, { "x":x, "y":y }, 300,null,new Handler(caller,complete));
		}
	}

}