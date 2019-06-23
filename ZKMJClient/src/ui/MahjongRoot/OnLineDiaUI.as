/**Created by the LayaAirIDE,do not modify.*/
package ui.MahjongRoot {
	import laya.ui.*;
	import laya.display.*; 

	public class OnLineDiaUI extends View {
		public var m_root:Box;
		public var m_backImage:Image;
		public var m_online:Image;
		public var m_btnClose:Button;
		public var m_lable1:Label;
		public var m_lable2:Label;
		public var m_lable3:Label;
		public var m_lable4:Label;
		public var m_erweima:Image;
		public var m_tip:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1136,"height":640},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1136,"skin":"common/img_blankBg.png","sizeGrid":"2,2,2,2","height":640}},{"type":"Box","props":{"y":120,"x":268,"width":600,"var":"m_root","name":"content","height":400},"child":[{"type":"Image","props":{"width":600,"var":"m_backImage","skin":"common/img_bomb boxBg.png","sizeGrid":"75,75,75,75","height":400},"child":[{"type":"Image","props":{"y":-47,"x":114,"skin":"common/img_popupBg.png"},"child":[{"type":"Image","props":{"y":10,"x":116,"var":"m_online","skin":"gameHall/img_customerservice_service.png"}}]}]},{"type":"Button","props":{"y":-28,"x":554,"var":"m_btnClose","skin":"common/btn_close.png"}},{"type":"Label","props":{"y":50,"x":40,"var":"m_lable1","text":"关注 微信公众平台：周口麻将","styleSkin":"comp/label.png","fontSize":22,"font":"SimHei","color":"#b9612c"}},{"type":"Label","props":{"y":85,"x":40,"var":"m_lable2","text":"充值咨询客服","styleSkin":"comp/label.png","fontSize":22,"font":"SimHei","color":"#b9612c"}},{"type":"Label","props":{"y":120,"x":40,"var":"m_lable3","text":"QQ：447018441","styleSkin":"comp/label.png","fontSize":22,"font":"SimHei","color":"#b9612c"}},{"type":"Label","props":{"y":155,"x":40,"var":"m_lable4","text":"微信：447018441","styleSkin":"comp/label.png","fontSize":22,"font":"SimHei","color":"#b9612c"}},{"type":"Image","props":{"y":192,"x":229,"var":"m_erweima","skin":"gameHall/img_code_service.png"}},{"type":"Label","props":{"y":345,"x":102,"var":"m_tip","text":"扫码关注微信公众号，更多精彩等着你！","styleSkin":"comp/label.png","fontSize":22,"font":"SimHei","color":"#915d3d"}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}