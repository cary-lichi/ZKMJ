/**Created by the LayaAirIDE,do not modify.*/
package ui.MahjongRoot {
	import laya.ui.*;
	import laya.display.*; 

	public class SetWindowUI extends View {
		public var m_root:Box;
		public var m_backImage:Image;
		public var btn_close:Button;
		public var m_cener:Image;
		public var m_music:Image;
		public var m_progress1:Image;
		public var m_hsBgMusic:HSlider;
		public var m_sound:Image;
		public var m_progress2:Image;
		public var m_hsSound:HSlider;
		public var m_boxSet:Box;
		public var m_btnQuit:Button;
		public var m_labelQuit:Label;
		public var m_btnRule:Button;
		public var m_btnAbout:Button;
		public var m_LabAddress:Label;
		public var m_gps:Image;
		public var m_checkLocation:CheckBox;
		public var m_boxRoomSet:Box;
		public var m_btnQuitRoom:Button;
		public var m_labelQuitRoom:Label;
		public var m_btnDissolveRoom:Button;
		public var m_labelBreak:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1136,"height":640},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1136,"skin":"common/img_blankBg.png","sizeGrid":"2,2,2,2","height":640}},{"type":"Box","props":{"y":161,"x":273,"width":600,"var":"m_root","name":"content","height":376},"child":[{"type":"Image","props":{"width":600,"var":"m_backImage","skin":"common/img_bomb boxBg.png","sizeGrid":"75,75,75,75","height":376},"child":[{"type":"Image","props":{"y":-47,"x":114,"skin":"common/img_popupBg.png"},"child":[{"type":"Image","props":{"y":14,"x":154,"skin":"gameHall/img_title_set.png"}}]}]},{"type":"Button","props":{"y":-26,"x":550,"var":"btn_close","skin":"common/btn_close.png"}},{"type":"Image","props":{"y":44,"x":47,"width":506,"var":"m_cener","skin":"gameHall/hsliderBg_set.png","height":217},"child":[{"type":"Image","props":{"y":30,"x":44,"var":"m_music","skin":"gameHall/img_yinyue_set.png"},"child":[{"type":"Image","props":{"y":0,"x":74,"var":"m_progress1","skin":"gameHall/img_hsliderBg_set.png"},"child":[{"type":"HSlider","props":{"y":8,"x":15,"width":322,"var":"m_hsBgMusic","skin":"gameHall/hslider_set.png","max":100,"height":42,"allowClickBack":true}}]}]},{"type":"Image","props":{"y":96,"x":44,"var":"m_sound","skin":"gameHall/img_yinxiao_set.png"},"child":[{"type":"Image","props":{"y":0,"x":74,"var":"m_progress2","skin":"gameHall/img_hsliderBg_set.png"},"child":[{"type":"HSlider","props":{"y":8,"x":15,"width":322,"var":"m_hsSound","value":20,"skin":"gameHall/hslider_set.png","min":0,"max":100,"height":42,"allowClickBack":true}}]}]}]},{"type":"Box","props":{"y":270,"x":47,"width":505,"var":"m_boxSet","height":68},"child":[{"type":"Button","props":{"y":0,"x":355,"width":155,"var":"m_btnQuit","skin":"common/btn_Bg.png","height":65},"child":[{"type":"Label","props":{"y":0,"x":0,"width":155,"var":"m_labelQuit","valign":"middle","text":"退出游戏","styleSkin":"comp/label.png","strokeColor":"#3b7204","stroke":2,"height":60,"fontSize":26,"font":"SimHei","color":"#ffffff","align":"center"}}]},{"type":"Button","props":{"y":0,"x":0,"width":155,"var":"m_btnRule","skin":"common/btn_orange.png","height":65},"child":[{"type":"Label","props":{"y":0,"x":0,"width":155,"valign":"middle","text":"规则","styleSkin":"comp/label.png","strokeColor":"#be3a00","stroke":2,"height":60,"fontSize":26,"font":"SimHei","color":"#ffffff","align":"center"}}]},{"type":"Button","props":{"y":0,"x":180,"width":155,"var":"m_btnAbout","skin":"common/btn_orange.png","height":65},"child":[{"type":"Label","props":{"y":0,"x":0,"width":155,"valign":"middle","text":"关于","styleSkin":"comp/label.png","strokeColor":"#be3a00","stroke":2,"height":60,"fontSize":26,"font":"SimHei","color":"#ffffff","align":"center"}}]},{"type":"Box","props":{"y":-81,"x":42},"child":[{"type":"Label","props":{"y":10,"text":"位置","fontSize":28,"font":"SimHei","color":"#9d431c","bold":true}},{"type":"Label","props":{"y":10,"x":116,"wordWrap":true,"width":249,"var":"m_LabAddress","text":"啊啊啊啊啊啊啊啊啊啊啊啊","height":50,"fontSize":18,"font":"SimHei","color":"#9d431c","align":"left"}},{"type":"Image","props":{"x":76,"var":"m_gps","skin":"gameHall/img_locationIcon_set.png"}},{"type":"CheckBox","props":{"x":360,"visible":true,"var":"m_checkLocation","stateNum":1,"skin":"gameHall/img_locationClose_set.png","selected":false}}]}]},{"type":"Box","props":{"y":265,"x":80,"var":"m_boxRoomSet"},"child":[{"type":"Button","props":{"var":"m_btnQuitRoom","skin":"common/btn_Bg.png"},"child":[{"type":"Label","props":{"y":2,"x":0,"width":176,"var":"m_labelQuitRoom","valign":"middle","text":"退出房间","styleSkin":"comp/label.png","strokeColor":"#3b7204","stroke":2,"height":61,"fontSize":30,"font":"SimHei","color":"#ffffff","align":"center"}}]},{"type":"Button","props":{"x":246,"var":"m_btnDissolveRoom","skin":"common/btn_bule.png"},"child":[{"type":"Label","props":{"y":2,"x":0,"width":176,"var":"m_labelBreak","valign":"middle","text":"解散房间","styleSkin":"comp/label.png","strokeColor":"00499c","stroke":2,"height":61,"fontSize":30,"font":"SimHei","color":"#ffffff","align":"center"}}]}]}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}