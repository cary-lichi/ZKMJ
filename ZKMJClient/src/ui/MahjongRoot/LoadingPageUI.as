/**Created by the LayaAirIDE,do not modify.*/
package ui.MahjongRoot {
	import laya.ui.*;
	import laya.display.*; 

	public class LoadingPageUI extends View {
		public var m_backImage:Image;
		public var m_logo:Image;
		public var m_notice:Label;
		public var m_tip:Label;
		public var m_progressBar:ProgressBar;
		public var m_lable:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1136,"height":640},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1136,"visible":true,"var":"m_backImage","skin":"loading/img_bg.jpg","height":640}},{"type":"Box","props":{"y":0,"x":0,"name":"content"},"child":[{"type":"Image","props":{"y":56,"x":334,"var":"m_logo","skin":"loading/img_text_3.png"}},{"type":"Label","props":{"y":610,"x":0,"width":1136,"var":"m_notice","valign":"middle","text":"抵制不良游戏 拒绝盗版游戏 注意自我保护 谨防上当受骗 适度游戏益脑 沉迷游戏伤身 合理安排时间 享受精彩生活","styleSkin":"comp/label.png","strokeColor":"#3b7204","fontSize":18,"font":"SimHei","color":"#323d52","align":"center"}},{"type":"Label","props":{"y":455,"x":248,"var":"m_tip","valign":"middle","text":"资源加载中......","styleSkin":"comp/label.png","strokeColor":"#3b7204","fontSize":24,"font":"SimHei","color":"#6d3045","align":"center"}},{"type":"ProgressBar","props":{"y":490,"x":240,"width":686,"var":"m_progressBar","value":1,"skin":"loading/progress.png","sizeGrid":"15,15,15,15","height":34}},{"type":"Label","props":{"y":492,"x":555,"var":"m_lable","text":"100%","styleSkin":"comp/label.png","strokeColor":"#000000 ","stroke":3,"fontSize":28,"font":"SimHei","color":"#ffffff"}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}