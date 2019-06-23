/**Created by the LayaAirIDE,do not modify.*/
package ui.MahjongRoot {
	import laya.ui.*;
	import laya.display.*; 

	public class AboutWinowUI extends View {
		public var m_imgBg:Image;
		public var m_root:Box;
		public var m_backImage:Image;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1136,"height":640},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1136,"var":"m_imgBg","skin":"common/img_blankBg.png","sizeGrid":"2,2,2,2","height":640}},{"type":"Box","props":{"y":156,"x":268,"width":535,"var":"m_root","name":"content","height":327},"child":[{"type":"Image","props":{"y":0,"x":0,"width":535,"var":"m_backImage","skin":"common/img_bomb boxBg.png","sizeGrid":"75,75,75,75","height":327},"child":[{"type":"Image","props":{"y":-47,"x":132,"width":270,"skin":"common/img_popupBg.png","sizeGrid":"0,100,0,100"},"child":[{"type":"Image","props":{"y":8,"x":98,"skin":"gameHall/img_aboutTitle_set.png"}}]}]},{"type":"Image","props":{"y":51,"x":103,"width":329,"skin":"gameHall/img_aboutBg_set.png","sizeGrid":"15,15,15,15"},"child":[{"type":"Label","props":{"y":7,"x":0,"width":329,"text":"版本V0.01介绍","styleSkin":"comp/label.png","fontSize":22,"font":"SimHei","color":"#fff0d0","align":"center"}}]},{"type":"Label","props":{"y":114,"x":45,"width":329,"text":"大吉大利，地道周口麻将！","styleSkin":"comp/label.png","fontSize":22,"font":"SimHei","color":"#6f3616","align":"left"}},{"type":"Label","props":{"y":167,"x":45,"width":329,"text":"1.优化部分游戏体验","styleSkin":"comp/label.png","fontSize":22,"font":"SimHei","color":"#6f3616","align":"left"}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}