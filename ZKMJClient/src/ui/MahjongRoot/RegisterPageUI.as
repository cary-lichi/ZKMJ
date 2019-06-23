/**Created by the LayaAirIDE,do not modify.*/
package ui.MahjongRoot {
	import laya.ui.*;
	import laya.display.*; 

	public class RegisterPageUI extends View {
		public var btn_isOK:Image;
		public var btn_RegBack:Image;
		public var txt_sName:TextInput;
		public var txt_sPassWord:TextInput;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1136,"height":640},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1136,"skin":"common/MengBgImage.png","name":"bg","height":640}},{"type":"Image","props":{"y":150,"x":365,"skin":"login/Register2.png"}},{"type":"Image","props":{"y":190,"x":365,"skin":"login/Register4.png"}},{"type":"Image","props":{"y":37,"x":535,"skin":"login/RegisterTitle.png"}},{"type":"Image","props":{"y":570,"x":505,"skin":"common/send.png"}},{"type":"Image","props":{"y":570,"x":645,"var":"btn_isOK","skin":"common/pque.png"}},{"type":"Image","props":{"y":20,"x":21,"var":"btn_RegBack","skin":"common/CloseWin1.png"}},{"type":"TextInput","props":{"y":154,"x":504,"width":250,"var":"txt_sName","type":"text","skin":"login/input.png","height":30,"alpha":0.5}},{"type":"TextInput","props":{"y":194,"x":504,"width":250,"var":"txt_sPassWord","type":"password","skin":"login/input.png","height":30,"alpha":0.5}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}