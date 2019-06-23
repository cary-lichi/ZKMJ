package view 
{
	import core.Constants;
	import core.GameIF;
	import laya.events.Event;
	import laya.utils.Browser;
	import tool.Tool;
	import ui.MahjongRoot.RoomGoldPageUI;
	import view.ActiveView.GoodsItem;
	
	/**
	 * ...
	 * @author ...
	 */
	public class RoomGoldPage extends RoomGoldPageUI 
	{
		private var m_goods:GoodsItem;
		
		public function RoomGoldPage() 
		{
			super();
		}
		
		public function Init():void
		{
			Laya.stage.addChild(this);
			if (Constants.isAdaptPhone)
			{
				reSetViewUi();
				var roomGoldPage:RoomGoldPage = this;
				Browser.window.addEventListener("resize", function():void {
				Laya.timer.once(1000, roomGoldPage, reSetViewUi);
				
				});
				
			}
		}
			
		private function reSetViewUi():void
		{
			Tool.Adaptation(this);
			this.m_imgTop.width = this.width;
			//this.m_.x = 20 * Tool.getScale();
			this.m_boxTop.scale(Tool.getScale(), Tool.getScale());
			this.m_boxTop.centerX = 0;
			this.m_imgTop.height = 55 * Tool.getScale();
			//this.btn_Back.x = 20 * Tool.getScale();
			//this.m_imgMa.x = 182 * Tool.getScale();
			//this.m_imgCard.x = 357 * Tool.getScale();
			//this.btn_tab.x = 696 * Tool.getScale();
		}
		public function Destroy():void
		{
			Laya.stage.removeChild(this);
			this.destroy();
		}

		
	}

}