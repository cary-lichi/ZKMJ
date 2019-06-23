package view.ActiveView 
{
	import core.Constants;
	import core.GameIF;
	import core.LogicManager;
	import laya.utils.Browser;
	import model._Room.Room;
	import tool.Tool;
	import ui.MahjongRoot.ChatWindowUI;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ChatWindow extends ChatWindowUI 
	{
		
		public function ChatWindow() 
		{
			super();     
		}
		
		public function Init():void 
		{
			Laya.stage.addChild(this);
			//GameIF.GetRoom().vipRoomView.m_boxContent.addChild(this);
			if (Constants.isAdaptPhone)
			{
				reSetViewUi();
				var view:* = this;
				Browser.window.addEventListener("resize", function():void {
				Laya.timer.once(1000, view, reSetViewUi);
				
				});
				
			}
		}
			
		private function reSetViewUi():void
		{
			Tool.Adaptation(this);
		}
		
		public function Destroy():void 
		{
			Laya.stage.removeChild(this);
			this.destroy();
		}
		
	}

}