/**Created by the LayaAirIDE,do not modify.*/
package ui.MahjongRoot {
	import laya.ui.*;
	import laya.display.*; 

	public class CreateJoinRoomPageUI extends View {

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1136,"height":640},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"createjoinroom/img_bg.png","name":"bg"}},{"type":"Image","props":{"y":60,"x":245,"skin":"common/img_textBox.png"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}