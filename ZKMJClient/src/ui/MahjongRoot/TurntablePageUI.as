/**Created by the LayaAirIDE,do not modify.*/
package ui.MahjongRoot {
	import laya.ui.*;
	import laya.display.*; 

	public class TurntablePageUI extends View {
		public var m_content:Box;
		public var m_imgPrizeBg:Image;
		public var m_imgSelected:Image;
		public var m_listPrize:List;
		public var m_imgPointer:Image;
		public var m_btnStart:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1136,"name":"content","height":640},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1136,"visible":true,"skin":"common/img_blankBg.png","sizeGrid":"2,2,2,2","height":640}},{"type":"Box","props":{"y":0,"x":0,"width":1136,"var":"m_content","pivotY":0.5,"pivotX":0.5,"name":"content","height":640},"child":[{"type":"Image","props":{"y":310,"x":570,"width":483,"var":"m_imgPrizeBg","skin":"turntable/img_zhuanpan.png","pivotY":241.5,"pivotX":241,"height":483},"child":[{"type":"Image","props":{"y":237,"x":241,"width":148,"var":"m_imgSelected","skin":"turntable/img_xuanzhong.png","rotation":18,"pivotY":222.65116279069764,"pivotX":74.34883720930225,"height":182}},{"type":"List","props":{"y":241,"x":241,"width":482,"var":"m_listPrize","pivotY":241,"pivotX":241,"height":482}},{"type":"Image","props":{"y":155,"x":155,"skin":"turntable/img_choujiangBg.png"}},{"type":"Image","props":{"y":235,"x":240,"width":43,"var":"m_imgPointer","skin":"turntable/img_pointer.png","pivotY":113.53488372093022,"pivotX":20.186046511627865,"height":52}},{"type":"Button","props":{"y":170,"x":170,"var":"m_btnStart","stateNum":1,"skin":"turntable/btn_choujiang.png","rotation":0}}]}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}