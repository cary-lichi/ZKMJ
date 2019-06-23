/**Created by the LayaAirIDE,do not modify.*/
package ui.MahjongRoot {
	import laya.ui.*;
	import laya.display.*; 

	public class LoginAccountPageUI extends View {
		public var m_Retrieve:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1136,"height":640},"child":[{"type":"Image","props":{"y":177,"x":275,"width":600,"skin":"common/img_bomb boxBg.png","sizeGrid":"75,75,75,75","height":400},"child":[{"type":"Image","props":{"y":-47,"x":114,"skin":"common/img_popupBg.png"}}]},{"type":"TextInput","props":{"y":292,"x":435,"width":365,"valign":"middle","type":"text","skin":"common/input.png","sizeGrid":"10,10,10,10","promptColor":"#ba9d6e","padding":"0,0,0,20","height":40,"fontSize":20,"font":"SimHei","color":"#916539"}},{"type":"TextInput","props":{"y":382,"x":435,"width":365,"valign":"middle","type":"text","skin":"common/input.png","sizeGrid":"10,10,10,10","promptColor":"#ba9d6e","padding":"0,0,0,20","height":40,"fontSize":20,"font":"SimHei","color":"#916539"}},{"type":"Label","props":{"y":302,"x":333,"underline":false,"text":"帐号:","styleSkin":"comp/label.png","fontSize":20,"font":"SimHei","color":"#916539","align":"center"}},{"type":"Label","props":{"y":392,"x":333,"underline":false,"text":"密码:","styleSkin":"comp/label.png","fontSize":20,"font":"SimHei","color":"#916539","align":"center"}},{"type":"Button","props":{"y":150,"x":833,"skin":"common/btn_close.png"}},{"type":"Label","props":{"y":141,"x":538,"text":"注册","styleSkin":"comp/label.png","strokeColor":"#3b7204","stroke":2,"fontSize":30,"font":"SimHei","color":"#ffffff"}},{"type":"Button","props":{"y":485,"x":485,"var":"m_Retrieve","skin":"common/btn_Bg.png"},"child":[{"type":"Label","props":{"y":3,"x":1,"width":174,"valign":"middle","text":"注册","styleSkin":"comp/label.png","strokeColor":"#3b7204","stroke":2,"height":59,"fontSize":30,"font":"SimHei","color":"#ffffff","align":"center"}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}