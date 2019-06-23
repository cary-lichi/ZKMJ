/**Created by the LayaAirIDE,do not modify.*/
package ui.MahjongRoot {
	import laya.ui.*;
	import laya.display.*; 

	public class GamerInfoWindowUI extends Dialog {
		public var m_boxContent:Box;
		public var m_imgHeadimg:Image;
		public var m_lableNick:Label;
		public var m_lableID:Label;
		public var m_labelIP:Label;
		public var m_labelWinCount:Label;
		public var m_labelTotalCount:Label;
		public var m_btnClose:Button;
		public var m_LabAddress:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"y":0,"x":0,"width":1136,"name":"content","height":640},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1136,"skin":"common/img_blankBg.png","sizeGrid":"2,2,2,2","height":640}},{"type":"Box","props":{"y":0,"x":0,"width":1136,"name":"content","height":640},"child":[{"type":"Box","props":{"y":120,"x":238,"width":660,"var":"m_boxContent","height":400,"centerY":0,"centerX":0},"child":[{"type":"Image","props":{"y":0,"x":0,"width":660,"skin":"common/img_bomb boxBg.png","sizeGrid":"50,50,50,50","height":350}},{"type":"Button","props":{"y":40,"x":40,"width":110,"stateNum":1,"skin":"common/img_alphaHeadBg.png","height":110},"child":[{"type":"Image","props":{"y":5,"x":5,"width":100,"var":"m_imgHeadimg","skin":"common/img_head.png","height":100}}]},{"type":"Label","props":{"y":55,"x":166,"text":"昵称：","styleSkin":"comp/label.png","fontSize":30,"font":"SimHei","color":"#533423"},"child":[{"type":"Label","props":{"y":0,"x":75,"width":181,"var":"m_lableNick","text":"二狗子收到二狗","styleSkin":"comp/label.png","overflow":"hidden","height":30,"fontSize":30,"font":"SimHei","color":"#533423"}}]},{"type":"Label","props":{"y":55,"x":427,"text":"ID：","styleSkin":"comp/label.png","fontSize":30,"font":"SimHei","color":"#533423"},"child":[{"type":"Label","props":{"y":3,"x":45,"width":92,"var":"m_lableID","text":"123456","styleSkin":"comp/label.png","overflow":"hidden","height":24,"fontSize":30,"font":"SimHei","color":"#533423"}}]},{"type":"Label","props":{"y":105,"x":169,"visible":false,"text":"IP：","styleSkin":"comp/label.png","fontSize":30,"font":"SimHei","color":"#533423"},"child":[{"type":"Label","props":{"y":0,"x":40,"width":286,"var":"m_labelIP","text":"1129339","styleSkin":"comp/label.png","overflow":"hidden","height":30,"fontSize":30,"font":"SimHei","color":"#533423"}}]},{"type":"Image","props":{"y":222,"x":15,"width":626,"skin":"gameHall/img_GamerInfoBg.png","sizeGrid":"0,30,0,30","height":105},"child":[{"type":"Label","props":{"y":39,"x":43,"visible":false,"text":"胜利局数：","styleSkin":"comp/label.png","fontSize":26,"font":"SimHei","color":"#9e572f"},"child":[{"type":"Label","props":{"y":0,"x":130,"width":138,"var":"m_labelWinCount","text":"0","styleSkin":"comp/label.png","height":25,"fontSize":26,"font":"SimHei","color":"#9e572f"}}]},{"type":"Label","props":{"y":39,"x":295,"visible":false,"text":"总局数：","styleSkin":"comp/label.png","fontSize":26,"font":"SimHei","color":"#9e572f"},"child":[{"type":"Label","props":{"y":0,"x":105,"var":"m_labelTotalCount","text":"0","styleSkin":"comp/label.png","fontSize":26,"font":"SimHei","color":"#9e572f"}}]}]},{"type":"Button","props":{"y":-23,"x":614,"var":"m_btnClose","skin":"common/btn_close.png"}},{"type":"Image","props":{"y":133,"x":184,"skin":"gameHall/img_locationIcon_set.png"},"child":[{"type":"Label","props":{"y":7,"x":45,"wordWrap":true,"width":340,"var":"m_LabAddress","text":"啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊","leading":10,"height":27,"fontSize":18,"font":"SimHei","color":"#9d431c","align":"left"}}]}]}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}