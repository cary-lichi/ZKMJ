package view 
{
	import core.AnimationAltas;
	import core.Constants;
	import core.GameIF;
	import core.UiManager;
	import laya.ui.Box;
	import laya.ui.Component;
	import laya.utils.Handler;
	import tool.Tool;
	import ui.MahjongRoot.GamehallPageUI;
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.utils.Browser;
	/**
	 * ...
	 * @author ...
	 */
	public class GamehallView extends GamehallPageUI
	{
		public function GamehallView() 
		{
			super();
		}
		
		public function Init():void
		{
			var viewGamehall:GamehallView = this;
			Laya.stage.addChild(this);
			if (Constants.isAdaptPhone)
			{
				reSetGamehallViewUi();
			
				Browser.window.addEventListener("resize", function():void {
					Laya.timer.once(1000, viewGamehall, reSetGamehallViewUi);
					
				});
			}
			StartrollLable();
		}
		private function StartrollLable():void 
		{
			Laya.timer.loop(1,this,UpdateRollLable);
		}
		
		private function UpdateRollLable():void 
		{
			this.rollLable.x -= 1;
			if (rollLable.x <=-400)
			{
				this.rollLable.x = 400;
			}
		}
		private function onScreenClicked(e:Event):void 
		{
			trace(e);
		}
		
		private function reSetGamehallViewUi():void 
		{
			Tool.Adaptation(this);
		}
		
		public function Destroy():void
		{
			Laya.stage.removeChild(this);
			Laya.timer.clearAll(this);
		}
	}

}

