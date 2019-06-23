/**Created by the LayaAirIDE,do not modify.*/
package ui.MahjongRoot {
	import laya.ui.*;
	import laya.display.*; 

	public class InputRoomIDWindowUI extends View {
		public var m_imgBack:Image;
		public var m_backImage:Image;
		public var m_top:Image;
		public var m_kuang1:Image;
		public var m_input_1:Clip;
		public var m_kuang2:Image;
		public var m_input_2:Clip;
		public var m_kuang3:Image;
		public var m_input_3:Clip;
		public var m_kuang4:Image;
		public var m_input_4:Clip;
		public var m_kuang5:Image;
		public var m_input_5:Clip;
		public var btn_delete:Button;
		public var btn_1:Button;
		public var m_1:Clip;
		public var btn_2:Button;
		public var m_2:Clip;
		public var btn_3:Button;
		public var m_3:Clip;
		public var btn_4:Button;
		public var m_4:Clip;
		public var btn_5:Button;
		public var m_5:Clip;
		public var btn_6:Button;
		public var m_6:Clip;
		public var btn_7:Button;
		public var m_7:Clip;
		public var btn_8:Button;
		public var m_8:Clip;
		public var btn_9:Button;
		public var m_9:Clip;
		public var btn_0:Button;
		public var m_0:Clip;
		public var btn_reset:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1136,"height":640},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1136,"var":"m_imgBack","skin":"common/img_blankBg.png","sizeGrid":"2,2,2,2","height":640,"alpha":0.5}},{"type":"Box","props":{"y":73,"x":297,"name":"content"},"child":[{"type":"Image","props":{"y":0,"x":0,"var":"m_backImage","skin":"gameHall/img_boxBg.png"}},{"type":"Image","props":{"y":10,"x":180,"var":"m_top","skin":"gameHall/img_title_inputRoomID.png"}},{"type":"Image","props":{"y":85,"x":65,"var":"m_kuang1","skin":"gameHall/img_input_inputRoomID.png"},"child":[{"type":"Clip","props":{"y":15,"x":17,"var":"m_input_1","skin":"gameHall/clip.png","clipY":1,"clipX":10}}]},{"type":"Image","props":{"y":85,"x":150,"var":"m_kuang2","skin":"gameHall/img_input_inputRoomID.png"},"child":[{"type":"Clip","props":{"y":15,"x":17,"var":"m_input_2","skin":"gameHall/clip.png","clipY":1,"clipX":10}}]},{"type":"Image","props":{"y":85,"x":240,"var":"m_kuang3","skin":"gameHall/img_input_inputRoomID.png"},"child":[{"type":"Clip","props":{"y":15,"x":17,"var":"m_input_3","skin":"gameHall/clip.png","clipY":1,"clipX":10}}]},{"type":"Image","props":{"y":85,"x":330,"var":"m_kuang4","skin":"gameHall/img_input_inputRoomID.png"},"child":[{"type":"Clip","props":{"y":15,"x":17,"var":"m_input_4","skin":"gameHall/clip.png","clipY":1,"clipX":10}}]},{"type":"Image","props":{"y":85,"x":420,"var":"m_kuang5","skin":"gameHall/img_input_inputRoomID.png"},"child":[{"type":"Clip","props":{"y":15,"x":17,"var":"m_input_5","skin":"gameHall/clip.png","clipY":1,"clipX":10}}]},{"type":"Button","props":{"y":400,"x":355,"var":"btn_delete","skin":"gameHall/btn_delete_inputRoomID.png","name":"delete"}},{"type":"Button","props":{"y":175,"x":65,"var":"btn_1","skin":"gameHall/btn_bg_inputRoomID.png","name":"1"},"child":[{"type":"Clip","props":{"y":13,"x":44,"var":"m_1","skin":"gameHall/clip.png","index":1,"clipY":1,"clipX":10}}]},{"type":"Button","props":{"y":175,"x":210,"var":"btn_2","skin":"gameHall/btn_bg_inputRoomID.png","name":"2"},"child":[{"type":"Clip","props":{"y":13,"x":44,"var":"m_2","skin":"gameHall/clip.png","index":2,"clipY":1,"clipX":10}}]},{"type":"Button","props":{"y":175,"x":355,"var":"btn_3","skin":"gameHall/btn_bg_inputRoomID.png","name":"3"},"child":[{"type":"Clip","props":{"y":13,"x":44,"var":"m_3","skin":"gameHall/clip.png","index":3,"clipY":1,"clipX":10}}]},{"type":"Button","props":{"y":250,"x":65,"var":"btn_4","skin":"gameHall/btn_bg_inputRoomID.png","name":"4"},"child":[{"type":"Clip","props":{"y":13,"x":44,"var":"m_4","skin":"gameHall/clip.png","index":4,"clipY":1,"clipX":10}}]},{"type":"Button","props":{"y":250,"x":210,"var":"btn_5","skin":"gameHall/btn_bg_inputRoomID.png","name":"5"},"child":[{"type":"Clip","props":{"y":13,"x":44,"var":"m_5","skin":"gameHall/clip.png","index":5,"clipY":1,"clipX":10}}]},{"type":"Button","props":{"y":250,"x":355,"var":"btn_6","skin":"gameHall/btn_bg_inputRoomID.png","name":"6"},"child":[{"type":"Clip","props":{"y":13,"x":44,"var":"m_6","skin":"gameHall/clip.png","index":6,"clipY":1,"clipX":10}}]},{"type":"Button","props":{"y":325,"x":65,"var":"btn_7","skin":"gameHall/btn_bg_inputRoomID.png","name":"7"},"child":[{"type":"Clip","props":{"y":13,"x":44,"var":"m_7","skin":"gameHall/clip.png","index":7,"clipY":1,"clipX":10}}]},{"type":"Button","props":{"y":325,"x":210,"var":"btn_8","skin":"gameHall/btn_bg_inputRoomID.png","name":"8"},"child":[{"type":"Clip","props":{"y":13,"x":44,"var":"m_8","skin":"gameHall/clip.png","index":8,"clipY":1,"clipX":10}}]},{"type":"Button","props":{"y":325,"x":355,"var":"btn_9","skin":"gameHall/btn_bg_inputRoomID.png","name":"9"},"child":[{"type":"Clip","props":{"y":13,"x":44,"var":"m_9","skin":"gameHall/clip.png","index":9,"clipY":1,"clipX":10}}]},{"type":"Button","props":{"y":400,"x":210,"var":"btn_0","skin":"gameHall/btn_bg_inputRoomID.png","name":"0"},"child":[{"type":"Clip","props":{"y":13,"x":44,"var":"m_0","skin":"gameHall/clip.png","index":0,"clipY":1,"clipX":10}}]},{"type":"Button","props":{"y":400,"x":65,"var":"btn_reset","skin":"gameHall/btn_reset_inputRoomID.png","name":"reset"}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}