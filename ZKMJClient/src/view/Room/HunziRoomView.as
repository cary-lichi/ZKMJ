package view.Room 
{
	import core.GameIF;
	import laya.utils.Ease;
	import laya.utils.Tween;
	import laya.utils.Handler;
	import model._Pai.Pai;
	import view.ActiveView._gameItem.BaoPaiItem;
	/**
	 * ...
	 * @author ...
	 */
	public class HunziRoomView extends RoomView 
	{
		private var Baopai:BaoPaiItem;
		public function HunziRoomView() 
		{
			super();
		}
		protected override function InitView():void 
		{
			super.InitView();
		}
		//—————————————————混子出场动画—————————————————————//
		public override function BaoPaiShowStart(pai:Pai, callback:Function, caller:*):void 
		{
			
			Baopai = new BaoPaiItem;
			Baopai.pai = pai;
			Baopai.centerX = 0;
			Baopai.centerY = 0;
			Baopai.anchorX = 0.5;
			Baopai.anchorY = 0.5;
			Laya.stage.addChild(Baopai);
			Action1();
		}
		private function Action1():void
		{
			Tween.to(Baopai, {"scaleX":1.5,"scaleY":1.5}, 1000, Ease.bounceOut,Handler.create(this,Action2));
		}
		private function Action2():void
		{
			Tween.to(Baopai, {"scaleX":0.3,"scaleY":0.3,"x":1161, "y":400}, 300, Ease.quintOut,Handler.create(this,BaoPaiShowStop));
		}
		private function BaoPaiShowStop():void 
		{
			GameIF.GetRoom().BaoPaiShowStop();
		}
	}

}