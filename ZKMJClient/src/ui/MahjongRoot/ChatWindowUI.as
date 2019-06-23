/**Created by the LayaAirIDE,do not modify.*/
package ui.MahjongRoot {
	import laya.ui.*;
	import laya.display.*; 

	public class ChatWindowUI extends View {
		public var m_imgBack:Image;
		public var tab_notice:Tab;
		public var vs_notic:ViewStack;
		public var m_list:List;
		public var m_boxText:Box;
		public var quickSentences0:Button;
		public var quickSentences1:Button;
		public var quickSentences2:Button;
		public var quickSentences3:Button;
		public var quickSentences4:Button;
		public var quickSentences5:Button;
		public var m_labelInput:TextArea;
		public var m_btnSubmit:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1136,"name":"view","height":640},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1136,"var":"m_imgBack","skin":"common/img_blankBg.png","sizeGrid":"2,2,2,2","height":640,"alpha":0}},{"type":"Box","props":{"y":0,"x":0,"width":1136,"name":"content","mouseThrough":true,"height":640},"child":[{"type":"Image","props":{"y":57,"x":659,"width":330,"skin":"chat/img_up.png"},"child":[{"type":"Image","props":{"y":20,"x":0,"width":330,"skin":"chat/img_down.png","sizeGrid":"10,0,10,0","height":500}}]},{"type":"Tab","props":{"y":67,"x":982,"var":"tab_notice","selectedIndex":0},"child":[{"type":"Button","props":{"y":0,"x":0,"skin":"chat/btn_tu.png","name":"item0"}},{"type":"Button","props":{"y":130,"x":0,"stateNum":3,"skin":"chat/btn_changyongyu.png","name":"item1"}}]},{"type":"ViewStack","props":{"y":71,"x":677,"var":"vs_notic","selectedIndex":0},"child":[{"type":"Box","props":{"x":-4,"name":"item0"},"child":[{"type":"List","props":{"y":0,"width":303,"var":"m_list","renderType":"render","height":500}}]},{"type":"Box","props":{"y":0,"x":-4,"name":"item1"},"child":[{"type":"Box","props":{"y":0,"x":0,"width":303,"var":"m_boxText","name":"box","height":426},"child":[{"type":"Button","props":{"y":0,"x":0,"width":303,"var":"quickSentences0","stateNum":2,"skin":"chat/btn_di.png","sizeGrid":"5,5,5,5","name":"item0","height":55},"child":[{"type":"Label","props":{"y":15,"x":12,"text":"哎呀,你打的也太好了","fontSize":24,"font":"SimHei","color":"#4f1c18"}}]},{"type":"Button","props":{"y":60,"x":0,"width":303,"var":"quickSentences1","stateNum":2,"skin":"chat/btn_di.png","sizeGrid":"5,5,5,5","name":"item1","height":55},"child":[{"type":"Label","props":{"y":15,"x":12,"text":"撒冷的,打牌得快","fontSize":24,"font":"SimHei","color":"#4f1c18"}}]},{"type":"Button","props":{"y":120,"x":0,"width":303,"var":"quickSentences2","stateNum":2,"skin":"chat/btn_di.png","sizeGrid":"5,5,5,5","name":"item2","height":55},"child":[{"type":"Label","props":{"y":15,"x":12,"text":"决战到天亮都别走","fontSize":24,"font":"SimHei","color":"#4f1c18"}}]},{"type":"Button","props":{"y":180,"x":0,"width":303,"var":"quickSentences3","stateNum":2,"skin":"chat/btn_di.png","sizeGrid":"5,5,5,5","name":"item3","height":55},"child":[{"type":"Label","props":{"y":15,"x":12,"text":"麻将精华在于单砸","fontSize":24,"font":"SimHei","color":"#4f1c18"}}]},{"type":"Button","props":{"y":240,"x":0,"width":303,"var":"quickSentences4","stateNum":2,"skin":"chat/btn_di.png","sizeGrid":"5,5,5,5","name":"item4","height":55},"child":[{"type":"Label","props":{"y":15,"x":12,"text":"你是炮兵学校毕业的吧","fontSize":24,"font":"SimHei","color":"#4f1c18"}}]},{"type":"Button","props":{"y":300,"x":0,"width":303,"var":"quickSentences5","stateNum":2,"skin":"chat/btn_di.png","sizeGrid":"5,5,5,5","name":"item5","height":55},"child":[{"type":"Label","props":{"y":15,"x":12,"text":"昨天摸啥了手这么臭呢","fontSize":24,"font":"SimHei","color":"#4f1c18"}}]},{"type":"Button","props":{"y":360,"x":0,"width":303,"stateNum":2,"skin":"chat/btn_di.png","sizeGrid":"5,5,5,5","name":"item5","height":55},"child":[{"type":"Label","props":{"y":15,"x":12,"text":"你那是啥网呀太次了","fontSize":24,"font":"SimHei","color":"#4f1c18"}}]}]},{"type":"Image","props":{"y":426,"x":0,"width":210,"skin":"chat/img_shurukuang.png","sizeGrid":"10,10,10,10","height":56},"child":[{"type":"TextArea","props":{"y":0,"x":0,"wordWrap":false,"width":210,"var":"m_labelInput","valign":"middle","type":"text","overflow":"scroll","multiline":true,"maxChars":50,"height":56,"fontSize":24,"font":"SimHei","color":"#79301d","align":"left"}}]},{"type":"Button","props":{"y":430,"x":216,"width":90,"var":"m_btnSubmit","skin":"common/btn_Bg.png","height":48},"child":[{"type":"Label","props":{"y":7,"x":0,"width":90,"valign":"middle","text":"提交","styleSkin":"comp/label.png","strokeColor":"#3b7204","stroke":2,"height":33,"fontSize":20,"font":"SimHei","color":"#ffffff","align":"center"}}]}]}]}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}