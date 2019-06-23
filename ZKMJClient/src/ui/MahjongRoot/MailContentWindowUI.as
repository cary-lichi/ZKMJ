/**Created by the LayaAirIDE,do not modify.*/
package ui.MahjongRoot {
	import laya.ui.*;
	import laya.display.*; 

	public class MailContentWindowUI extends View {
		public var m_imgBackBg:Image;
		public var m_labelTitle:Label;
		public var m_labelTime:Label;
		public var m_labekState:Label;
		public var m_labekReward:Label;
		public var m_labelArrivalTime:Label;
		public var m_btnClose:Button;
		public var m_boxEnclosure:Box;
		public var m_btnReceive:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1136,"height":640},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1136,"var":"m_imgBackBg","skin":"common/img_blankBg.png","sizeGrid":"2,2,2,2","height":640}},{"type":"Box","props":{"y":67,"x":177,"width":782,"name":"content","height":444},"child":[{"type":"Image","props":{"y":0,"x":0,"width":782,"skin":"common/img_bomb boxBg.png","sizeGrid":"75,75,75,75","height":444}},{"type":"Image","props":{"y":40,"x":35,"width":65,"skin":"common/img_LOGO.png","height":65}},{"type":"Label","props":{"y":47,"x":122,"var":"m_labelTitle","text":"分享成功，获得3钻石","styleSkin":"comp/label.png","fontSize":24,"font":"SimHei","color":"#533423"},"child":[{"type":"Label","props":{"y":38,"x":0,"var":"m_labelTime","text":"2017-12-14  21:01","styleSkin":"comp/label.png","fontSize":18,"font":"SimHei","color":"#ba9881"}}]},{"type":"Label","props":{"y":135,"x":42,"text":"状态：","styleSkin":"comp/label.png","fontSize":24,"font":"SimHei","color":"#533423"},"child":[{"type":"Label","props":{"y":0,"x":66,"var":"m_labekState","text":"分享成功","styleSkin":"comp/label.png","fontSize":24,"font":"SimHei","color":"#533423"}}]},{"type":"Label","props":{"y":175,"x":42,"text":"奖励：","styleSkin":"comp/label.png","fontSize":24,"font":"SimHei","color":"#533423"},"child":[{"type":"Label","props":{"y":0,"x":66,"var":"m_labekReward","text":"3钻石","styleSkin":"comp/label.png","fontSize":24,"font":"SimHei","color":"#533423"}}]},{"type":"Label","props":{"y":215,"x":42,"text":"到账时间：","styleSkin":"comp/label.png","fontSize":24,"font":"SimHei","color":"#533423"},"child":[{"type":"Label","props":{"y":0,"x":115,"var":"m_labelArrivalTime","text":"2017-12-14  21:01","styleSkin":"comp/label.png","fontSize":24,"font":"SimHei","color":"#533423"}}]},{"type":"Button","props":{"y":-22,"x":735,"var":"m_btnClose","skin":"common/btn_close.png"}},{"type":"Box","props":{"y":255,"x":42,"visible":false,"var":"m_boxEnclosure"},"child":[{"type":"Label","props":{"text":"附件：","styleSkin":"comp/label.png","fontSize":24,"font":"SimHei","color":"#533423"},"child":[{"type":"Label","props":{"y":0,"x":66,"text":"5钻石","styleSkin":"comp/label.png","fontSize":24,"font":"SimHei","color":"#533423"}}]},{"type":"Button","props":{"y":65,"x":278,"width":142,"var":"m_btnReceive","skin":"common/btn_Bg.png","height":62},"child":[{"type":"Label","props":{"y":0,"x":0,"width":142,"valign":"middle","text":"领取","styleSkin":"comp/label.png","strokeColor":"#3b7204","stroke":2,"height":60,"fontSize":24,"font":"SimHei","color":"#ffffff","align":"center"}}]}]}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}