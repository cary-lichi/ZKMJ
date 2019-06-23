/**Created by the LayaAirIDE,do not modify.*/
package ui.MahjongRoot {
	import laya.ui.*;
	import laya.display.*; 

	public class FriendPageUI extends View {

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1136,"height":640},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1136,"skin":"common/MengBgImage.png","height":640}},{"type":"Image","props":{"y":30,"x":30,"skin":"common/tablebk.png"}},{"type":"Image","props":{"y":30,"x":1029,"skin":"friend/AddFriendBtn.png"}},{"type":"Image","props":{"y":116,"x":0,"width":1136,"skin":"friend/FriendListColumnTiTle.png"}},{"type":"Image","props":{"y":30,"x":528,"skin":"friend/friendtitle.png"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}