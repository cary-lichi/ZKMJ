/**Created by the LayaAirIDE,do not modify.*/
package ui.MahjongRoot {
	import laya.ui.*;
	import laya.display.*; 

	public class VIPhallPageUI extends View {
		public var m_imgBg:Image;
		public var m_imgTop:Image;
		public var m_imgTitle:Image;
		public var m_btnBack:Button;
		public var m_imgContent:Image;
		public var m_boxContent:Box;
		public var m_createRoom:Button;
		public var m_tip:Label;
		public var m_cbCypdx:CheckBox;
		public var m_cbCzm:CheckBox;
		public var m_cbCsfdh:CheckBox;
		public var m_cbCcft:CheckBox;
		public var m_cbClsdy:CheckBox;
		public var m_cbCtybb:CheckBox;
		public var m_cbCybc:CheckBox;
		public var m_cbCzfb:CheckBox;
		public var m_RadioGamerNum:RadioGroup;
		public var m_RadioNum:RadioGroup;
		public var m_TextDiamonds:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1136,"height":640},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1136,"var":"m_imgBg","skin":"common/img_conBigBg.png","sizeGrid":"0,0,0,0","height":640},"child":[{"type":"Image","props":{"y":1,"width":1136,"var":"m_imgTop","skin":"common/img_conBigBg1.png","sizeGrid":"5,50,40,50","height":55,"centerX":0},"child":[{"type":"Image","props":{"x":399,"var":"m_imgTitle","skin":"gameHall/img_title_createroom.png","centerY":0,"centerX":0}},{"type":"Button","props":{"x":20,"var":"m_btnBack","skin":"common/btn_back.png","centerY":0}}]},{"type":"Image","props":{"y":60,"width":1120,"var":"m_imgContent","skin":"gameHall/img_textBg_createjoinroom.png","height":575,"centerX":0}}]},{"type":"Box","props":{"width":1136,"var":"m_boxContent","name":"content","mouseThrough":true,"height":640,"centerY":0,"centerX":0},"child":[{"type":"Button","props":{"y":520,"x":482,"var":"m_createRoom","skin":"common/btn_Bg.png"},"child":[{"type":"Label","props":{"y":3,"x":1,"width":174,"valign":"middle","text":"创建房间","styleSkin":"comp/label.png","strokeColor":"#3b7204","stroke":2,"height":59,"fontSize":30,"font":"SimHei","color":"#ffffff","align":"center"}}]},{"type":"Label","props":{"y":603,"x":360,"var":"m_tip","text":"注：钻石在开始游戏后扣除，提前解散不扣钻石","styleSkin":"comp/label.png","fontSize":20,"font":"SimHei","color":"#a86148"}},{"type":"Label","props":{"y":96,"x":62,"text":"玩   法：","styleSkin":"comp/label.png","fontSize":28,"font":"SimHei","color":"#91592a"},"child":[{"type":"Label","props":{"y":0,"x":240,"visible":false,"text":"一炮多响","styleSkin":"comp/label.png","fontSize":24,"font":"SimHei","color":"#91592a"}},{"type":"Label","props":{"y":0,"x":470,"text":"不摸不赢","styleSkin":"comp/label.png","fontSize":24,"font":"SimHei","color":"#91592a"}},{"type":"Label","props":{"y":0,"x":695,"visible":false,"text":"煽风点火","styleSkin":"comp/label.png","fontSize":24,"font":"SimHei","color":"#91592a"}},{"type":"Label","props":{"y":64,"x":240,"visible":false,"text":"亮四打一","styleSkin":"comp/label.png","fontSize":24,"font":"SimHei","color":"#91592a"}},{"type":"Label","props":{"y":1,"x":245,"text":"偷赢不报","styleSkin":"comp/label.png","fontSize":24,"font":"SimHei","color":"#91592a"}},{"type":"Label","props":{"y":0,"x":920,"visible":true,"text":"出风听","styleSkin":"comp/label.png","fontSize":24,"font":"SimHei","color":"#91592a"}},{"type":"Label","props":{"y":-1,"x":696,"width":72,"text":"一把成","styleSkin":"comp/label.png","height":24,"fontSize":24,"font":"SimHei","color":"#91592a"}},{"type":"Label","props":{"y":64,"x":920,"visible":false,"text":"庄翻倍","styleSkin":"comp/label.png","fontSize":24,"font":"SimHei","color":"#91592a"}},{"type":"CheckBox","props":{"y":-4,"x":195,"visible":false,"var":"m_cbCypdx","skin":"common/check.png","name":"ypdx","disabled":false}},{"type":"CheckBox","props":{"y":-4,"x":420,"var":"m_cbCzm","skin":"common/check.png","name":"zm"}},{"type":"CheckBox","props":{"y":-4,"x":645,"visible":false,"var":"m_cbCsfdh","skin":"common/check.png","name":"sfdh"}},{"type":"CheckBox","props":{"y":-4,"x":870,"visible":true,"var":"m_cbCcft","skin":"common/check.png","name":"cft"}},{"type":"CheckBox","props":{"y":60,"x":195,"visible":false,"var":"m_cbClsdy","skin":"common/check.png","name":"lsdy"}},{"type":"CheckBox","props":{"y":-3,"x":195,"var":"m_cbCtybb","skin":"common/check.png","name":"tybb"}},{"type":"CheckBox","props":{"y":-5,"x":646,"var":"m_cbCybc","skin":"common/check.png","name":"ybc"}},{"type":"CheckBox","props":{"y":60,"x":870,"visible":false,"var":"m_cbCzfb","skin":"common/check.png","selected":false,"name":"zfb"}}]},{"type":"Label","props":{"y":278,"x":59,"text":"人   数：","styleSkin":"comp/label.png","fontSize":28,"font":"SimHei","color":"#91592a"},"child":[{"type":"Label","props":{"y":2,"x":245,"text":"4人","styleSkin":"comp/label.png","fontSize":24,"font":"SimHei","color":"#91592a"}},{"type":"Label","props":{"y":2,"x":475,"text":"3人","styleSkin":"comp/label.png","fontSize":24,"font":"SimHei","color":"#91592a"}},{"type":"Label","props":{"y":2,"x":700,"text":"2人","styleSkin":"comp/label.png","fontSize":24,"font":"SimHei","color":"#91592a"}},{"type":"RadioGroup","props":{"y":-7,"x":195,"var":"m_RadioGamerNum","selectedIndex":0},"child":[{"type":"Radio","props":{"skin":"common/radio.png","name":"item0"}},{"type":"Radio","props":{"x":230,"skin":"common/radio.png","name":"item1"}},{"type":"Radio","props":{"x":450,"skin":"common/radio.png","name":"item2"}}]}]},{"type":"Label","props":{"y":347,"x":58,"text":"局   数：","styleSkin":"comp/label.png","fontSize":28,"font":"SimHei","color":"#91592a"},"child":[{"type":"Label","props":{"y":2,"x":245,"text":"4局","styleSkin":"comp/label.png","fontSize":24,"font":"SimHei","color":"#91592a"}},{"type":"Label","props":{"y":2,"x":475,"text":"8局","styleSkin":"comp/label.png","fontSize":24,"font":"SimHei","color":"#91592a"}},{"type":"Label","props":{"y":2,"x":700,"text":"12局","styleSkin":"comp/label.png","fontSize":24,"font":"SimHei","color":"#91592a"}},{"type":"RadioGroup","props":{"y":-7,"x":195,"var":"m_RadioNum","selectedIndex":0},"child":[{"type":"Radio","props":{"skin":"common/radio.png","name":"item0"}},{"type":"Radio","props":{"y":0,"x":230,"skin":"common/radio.png","name":"item1"}},{"type":"Radio","props":{"y":1,"x":450,"skin":"common/radio.png","name":"item2"}}]}]},{"type":"Label","props":{"y":412,"x":57,"text":"消   耗：","styleSkin":"comp/label.png","fontSize":28,"font":"SimHei","color":"#91592a"},"child":[{"type":"Label","props":{"y":0,"x":260,"var":"m_TextDiamonds","text":"x2","styleSkin":"comp/label.png","fontSize":28,"font":"SimHei","color":"#91592a"}},{"type":"Image","props":{"y":-6,"x":195,"width":40,"skin":"common/img_diamonds.png","height":40}}]}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}