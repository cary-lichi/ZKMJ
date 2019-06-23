package view.ActiveView._gameItem 
{
	import laya.events.Event;
	import laya.ui.Box;
	import laya.ui.Button;
	import laya.ui.Image;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;
	import model._Pai.Pai;
	import tool.Tool;
	/**
	 * ...
	 * @author dawenhao
	 */
	public class Gamer0PaiItem extends BaseFacePaiItem
	{
		private var m_bPaiStae:Boolean;//牌的状态 弹起或不动
		private var m_backBg:Image;
		private var m_arrow:Image;
		private var m_canHuPai:Array;
		private var m_index:int;
		
		public function Gamer0PaiItem() 
		{
			super();
			m_bPaiStae = false;
			
			m_paiBg.skin = "game/pai/btn_green.png";
			
			m_imgPaiValue.y = 15;
			
			m_arrow = new Image;
			m_arrow.skin = "game/img_tingArrow.png";
			m_arrow.centerX = 0;
			m_arrow.top =-30;
			m_arrow.visible = false;
			m_paiBg.addChild(m_arrow);
			
			m_backBg = new Image;
			m_backBg.skin = "game/img_tingBlackBg.png";
			m_backBg.width = this.width;
			m_backBg.height = this.height;
			m_backBg.centerX = 0;
			m_backBg.name = "backBg";
			m_backBg.visible = false;
			m_backBg.alpha = 0.8;
			m_backBg.on(Event.CLICK, this, onBackBgClicked);
			m_paiBg.addChild(m_backBg);
		}
		
		
		public override function GetPaiTween():void 
		{
			
		}
		
		public override function PaiTweenStart(x:int,y:int,caller:*,complete:Function):void 
		{
			this.scale(Tool.getScale(), Tool.getScale());
			Tween.to(this, { "x":x, "y":y }, 300,null,new Handler(caller,complete));
		}
		public function PutPaiTweenRight():void 
		{
			Tween.to(this, { "x":this.x+20 }, 300);
		}
		public function ClickPaiTweenUp():void 
		{
			Tween.to(this, { "y":this.y-24 }, 100);
		}
		public function ClickPaiTweenDown():void 
		{
			Tween.to(this, { "y":this.y+24 }, 100);
		}
		public function ZhuangPaiTweenLeft():void 
		{
			Tween.to(this, { "x":this.x-70 }, 300);
		}
		public function ZhuangPaiTweenRight():void 
		{
			Tween.to(this, { "x":this.x+70 }, 300);
		}
		
		//黑幕被点击，不能出牌
		private function onBackBgClicked():void 
		{
			return ;
		}
		
		/////////////////////////////////////////////////////

		public function showBlack():void 
		{
			m_backBg.visible = true;
		}
		public function hideBlack():void 
		{
			m_backBg.visible = false;
		}
		public function showArrow():void 
		{
			m_arrow.visible = true;
		}
		public function hideArrow():void 
		{
			m_arrow.visible = false;
		}
		
		public function get bPaiStae():Boolean 
		{
			return m_bPaiStae;
		}
		
		public function set bPaiStae(value:Boolean):void 
		{
			m_bPaiStae = value;
		}
		
		public function get canHuPai():Array 
		{
			return m_canHuPai;
		}
		
		public function set canHuPai(value:Array):void 
		{
			m_canHuPai = value;
		}
		
		public function get index():int 
		{
			return m_index;
		}
		
		public function set index(value:int):void 
		{
			m_index = value;
		}
		
		public function get backBg():Image 
		{
			return m_backBg;
		}
		
		public function set backBg(value:Image):void 
		{
			m_backBg = value;
		}
		
	}

}