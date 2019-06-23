/**Created by the LayaAirIDE,do not modify.*/
package ui.MahjongRoot {
	import laya.ui.*;
	import laya.display.*; 
	import laya.html.dom.HTMLDivElement;

	public class PopUpDiaUI extends Dialog {
		public var m_imgBackBg:Image;
		public var m_root:Box;
		public var m_backImage:Image;
		public var m_lableTitle:Label;
		public var m_btnIsOK:Button;
		public var m_lableisOK:Label;
		public var m_btnClose:Button;
		public var m_boxShare:Box;
		public var m_htmlShare:HTMLDivElement;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":1136,"height":640},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1136,"var":"m_imgBackBg","skin":"common/img_blankBg.png","sizeGrid":"2,2,2,2","height":640}},{"type":"Box","props":{"y":170,"x":268,"var":"m_root","name":"content"},"child":[{"type":"Image","props":{"y":0,"x":0,"width":600,"var":"m_backImage","skin":"common/img_bomb boxBg.png","sizeGrid":"50,50,50,50","height":300}},{"type":"Label","props":{"y":50,"x":0,"width":600,"var":"m_lableTitle","valign":"middle","text":"充值失败","styleSkin":"comp/label.png","leading":15,"height":134,"fontSize":32,"font":"SimHei","color":"#8a4622","align":"center"}},{"type":"Button","props":{"y":180,"x":212,"var":"m_btnIsOK","skin":"common/btn_Bg.png"},"child":[{"type":"Label","props":{"y":3,"x":1,"width":174,"var":"m_lableisOK","valign":"middle","text":"确定","styleSkin":"comp/label.png","strokeColor":"#3b7204","stroke":2,"height":59,"fontSize":30,"font":"SimHei","color":"#ffffff","align":"center"}}]},{"type":"Button","props":{"y":-22,"x":557,"visible":false,"var":"m_btnClose","skin":"common/btn_close.png"}},{"type":"Box","props":{"y":21,"x":0,"visible":false,"var":"m_boxShare"},"child":[{"type":"HTMLDivElement","props":{"y":8,"x":57,"width":500,"var":"m_htmlShare","styleSkin":"comp/html.png","innerHTML":"<div style='margin:0; padding:0;font-size: 24px; align: center; color:#8a4622;font-family: SimHei;line-height:60px;width: 500px;'><span style='font-size: 36px;'>分享成功</span><br><span>恭喜你获得分享3&nbsp;</span><img src='gameHall/img_shareZuan.png' width='30' height='28' /><span>&nbsp;奖励</span> </div>"}}]}]}]};
		override protected function createChildren():void {
			View.regComponent("HTMLDivElement",HTMLDivElement);
			super.createChildren();
			createView(uiView);

		}

	}
}