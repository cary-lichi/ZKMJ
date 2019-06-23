/**Created by the LayaAirIDE,do not modify.*/
package ui.MahjongRoot {
	import laya.ui.*;
	import laya.display.*; 

	public class MailWindowUI extends View {
		public var m_imgBackBg:Image;
		public var m_list:List;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1136,"height":640},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1136,"var":"m_imgBackBg","skin":"common/img_blankBg.png","sizeGrid":"2,2,2,2","height":640}},{"type":"Box","props":{"y":67,"x":124,"width":888,"name":"content","height":505},"child":[{"type":"Image","props":{"y":0,"x":0,"width":888,"skin":"common/img_bomb boxBg.png","sizeGrid":"75,75,75,75","height":505},"child":[{"type":"Image","props":{"y":-58,"x":278,"width":332,"skin":"common/img_popupBg.png","sizeGrid":"0,100,0,100","height":63},"child":[{"type":"Image","props":{"y":10,"x":125,"skin":"gameHall/img_mailTitle.png"}}]}]},{"type":"List","props":{"y":52,"x":34,"width":820,"var":"m_list","repeatX":1,"height":400}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}