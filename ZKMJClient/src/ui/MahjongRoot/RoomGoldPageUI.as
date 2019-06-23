/**Created by the LayaAirIDE,do not modify.*/
package ui.MahjongRoot {
	import laya.ui.*;
	import laya.display.*; 

	public class RoomGoldPageUI extends View {
		public var m_imgTop:Image;
		public var m_boxTop:Box;
		public var btn_tab:Tab;
		public var m_imgCard:Image;
		public var m_boxCard:Box;
		public var m_imgCardW:Image;
		public var m_imgMa:Image;
		public var m_boxMa:Box;
		public var m_imgMaW:Image;
		public var btn_Back:Button;
		public var m_boxGoods:Box;
		public var sp_viewStack:ViewStack;
		public var m_btnRecommendCard:Image;
		public var m_btnRecommendGold:Image;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1136,"name":"content","height":640},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1136,"skin":"common/img_conBigBg.jpg","height":640},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1136,"var":"m_imgTop","skin":"common/img_conBigBg1.png","sizeGrid":"5,50,40,50","height":55}},{"type":"Box","props":{"y":0,"x":0,"width":1136,"var":"m_boxTop","height":55},"child":[{"type":"Tab","props":{"y":2,"x":606,"var":"btn_tab","selectedIndex":0},"child":[{"type":"Button","props":{"y":1,"stateNum":3,"skin":"roomGold/btn_Card.png","name":"item0"}},{"type":"Button","props":{"x":256,"stateNum":3,"skin":"roomGold/btn_Gold.png","name":"item1"}}]},{"type":"Image","props":{"y":12,"x":357,"width":140,"var":"m_imgCard","skin":"common/img_dise.png","height":35},"child":[{"type":"Image","props":{"y":0,"x":-16,"width":40,"skin":"common/img_diamonds.png","height":35}},{"type":"Box","props":{"y":6,"x":35,"var":"m_boxCard"},"child":[{"type":"Clip","props":{"skin":"common/clip.png","name":"item0","clipY":1,"clipX":11}},{"type":"Clip","props":{"y":0,"x":16,"skin":"common/clip.png","name":"item1","clipY":1,"clipX":11}},{"type":"Clip","props":{"y":0,"x":32,"skin":"common/clip.png","name":"item2","clipY":1,"clipX":11}},{"type":"Clip","props":{"y":0,"x":48,"skin":"common/clip.png","name":"item3","clipY":1,"clipX":11}},{"type":"Image","props":{"y":-2,"x":64,"var":"m_imgCardW","skin":"common/img_w.png"}}]}]},{"type":"Image","props":{"y":10,"x":182,"width":140,"var":"m_imgMa","skin":"common/img_dise.png","height":35},"child":[{"type":"Image","props":{"y":-3,"x":-20,"width":40,"skin":"common/img_ma.png","height":40}},{"type":"Box","props":{"y":6,"x":29,"var":"m_boxMa"},"child":[{"type":"Clip","props":{"y":0,"x":0,"skin":"common/clip.png","name":"item0","index":0,"clipY":1,"clipX":11}},{"type":"Clip","props":{"y":0,"x":16,"skin":"common/clip.png","name":"item1","index":0,"clipY":1,"clipX":11}},{"type":"Clip","props":{"y":0,"x":32,"skin":"common/clip.png","name":"item2","index":0,"clipY":1,"clipX":11}},{"type":"Clip","props":{"y":0,"x":48,"skin":"common/clip.png","name":"item3","index":0,"clipY":1,"clipX":11}},{"type":"Image","props":{"y":-2,"x":64,"var":"m_imgMaW","skin":"common/img_w.png"}}]}]},{"type":"Button","props":{"y":3,"x":20,"var":"btn_Back","skin":"common/btn_back.png"}}]}]},{"type":"Box","props":{"y":0,"x":0,"width":1136,"name":"content","mouseThrough":true,"height":640},"child":[{"type":"Box","props":{"y":110,"x":350,"width":778,"var":"m_boxGoods","mouseThrough":true,"height":470}},{"type":"ViewStack","props":{"y":88,"x":6,"var":"sp_viewStack","selectedIndex":0},"child":[{"type":"Box","props":{"y":0,"x":0,"name":"item0"},"child":[{"type":"Image","props":{"y":0,"x":0,"var":"m_btnRecommendCard","skin":"roomGold/img_superVbg.png"},"child":[{"type":"Image","props":{"y":132,"x":78,"skin":"common/img_diamonds.png"}},{"type":"Label","props":{"y":356,"x":99,"width":156,"valign":"middle","text":"6","height":52,"fontSize":46,"color":"#9d431c","align":"center"}},{"type":"Label","props":{"y":423,"x":92,"width":160,"valign":"middle","text":"￥6","strokeColor":"#ac4910","stroke":2,"height":55,"fontSize":40,"color":"#fff9af","align":"center"}}]}]},{"type":"Box","props":{"name":"item1"},"child":[{"type":"Image","props":{"y":0,"x":0,"var":"m_btnRecommendGold","skin":"roomGold/img_superVbg.png"},"child":[{"type":"Image","props":{"y":122,"x":79,"width":183,"skin":"common/img_ma.png","height":183}},{"type":"Label","props":{"y":356,"x":99,"width":156,"valign":"middle","text":"2.5万","height":52,"fontSize":46,"font":"SimHei","color":"#9d431c","align":"center"}},{"type":"Label","props":{"y":423,"x":110,"width":142,"valign":"middle","text":"  2","strokeColor":"#ac4910","stroke":2,"height":55,"fontSize":40,"color":"#fff9af","align":"center"},"child":[{"type":"Image","props":{"y":10,"x":0,"width":40,"skin":"common/img_diamonds.png","height":35}}]}]}]}]}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}