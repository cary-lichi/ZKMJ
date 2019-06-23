/**Created by the LayaAirIDE,do not modify.*/
package ui.MahjongRoot {
	import laya.ui.*;
	import laya.display.*; 

	public class SharePromptViewUI extends View {
		public var m_imgBg:Image;
		public var m_boxShare:Box;
		public var m_imgFloatArrow:Image;
		public var m_boxShareIOS:Box;
		public var m_imgIOSFloatArrow:Image;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1136,"height":640},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1136,"var":"m_imgBg","skin":"common/img_blankBg.png","sizeGrid":"3,3,3,3","height":640}},{"type":"Box","props":{"y":0,"x":0,"width":1136,"var":"m_boxShare","name":"content","height":640},"child":[{"type":"Label","props":{"y":93,"x":195,"text":"点      发送群或者好友","styleSkin":"comp/label.png","fontSize":26,"font":"SimHei","color":"#fffef2","align":"right"},"child":[{"type":"Image","props":{"y":-13,"x":42,"skin":"game/img_share.png"}}]},{"type":"Label","props":{"y":40,"x":171,"text":"点击右上角分享与好友组局","styleSkin":"comp/label.png","fontSize":26,"font":"SimHei","color":"#fffef2","align":"left"}},{"type":"Image","props":{"y":83,"x":40,"var":"m_imgFloatArrow","skin":"game/img_floatArrow.png","rotation":-90}}]},{"type":"Box","props":{"y":0,"x":0,"width":1136,"visible":false,"var":"m_boxShareIOS","name":"content","height":640},"child":[{"type":"Label","props":{"y":100,"x":741,"text":"点      发送群或者好友","styleSkin":"comp/label.png","fontSize":26,"font":"SimHei","color":"#fffef2","align":"right"},"child":[{"type":"Image","props":{"y":-13,"x":42,"skin":"game/img_share.png"}}]},{"type":"Label","props":{"y":47,"x":717,"text":"点击右上角分享与好友组局","styleSkin":"comp/label.png","fontSize":26,"font":"SimHei","color":"#fffef2","align":"left"}},{"type":"Image","props":{"y":39,"var":"m_imgIOSFloatArrow","skin":"game/img_floatArrow.png","right":24}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}