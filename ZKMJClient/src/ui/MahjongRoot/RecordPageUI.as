/**Created by the LayaAirIDE,do not modify.*/
package ui.MahjongRoot {
	import laya.ui.*;
	import laya.display.*; 

	public class RecordPageUI extends View {
		public var m_imgTabBg:Image;
		public var m_imgTopBg:Image;
		public var m_boxTop:Box;
		public var m_btnBack:Button;
		public var m_rule:Button;
		public var tab_record:Tab;
		public var m_list:List;
		public var m_imgMyRank:Image;
		public var m_btnAward:Button;
		public var m_awardLabel:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1136,"height":640,"centerY":0,"centerX":0},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1136,"skin":"common/img_conBigBg.png","sizeGrid":"0,0,0,0","mouseThrough":true,"height":640},"child":[{"type":"Image","props":{"y":0,"width":255,"visible":false,"var":"m_imgTabBg","skin":"common/img_conBigBg_tiezuo.png","left":0,"height":640}},{"type":"Image","props":{"y":0,"x":0,"width":1136,"var":"m_imgTopBg","skin":"common/img_conBigBg1.png","sizeGrid":"0,50,0,50","height":55}},{"type":"Box","props":{"y":0,"x":0,"width":1136,"var":"m_boxTop","height":55},"child":[{"type":"Image","props":{"y":3,"x":414,"skin":"record/img_title.png"}},{"type":"Button","props":{"y":4,"x":20,"var":"m_btnBack","skin":"common/btn_back.png"}},{"type":"Button","props":{"y":1,"x":960,"width":150,"var":"m_rule","stateNum":3,"skin":"record/btn_Award.png","sizeGrid":"0,50,0,50","height":50},"child":[{"type":"Label","props":{"y":0,"x":15,"width":120,"valign":"middle","text":"奖励规则","strokeColor":"#a35910","stroke":2,"height":50,"fontSize":26,"font":"SimHei","color":"#efefef","align":"center"}}]}]}]},{"type":"Box","props":{"y":0,"x":0,"width":1136,"name":"content","mouseThrough":true,"height":640},"child":[{"type":"Image","props":{"y":66,"x":252,"skin":"record/img_bg.png"}},{"type":"Tab","props":{"y":69,"x":7,"var":"tab_record","selectedIndex":0},"child":[{"type":"Button","props":{"skin":"record/btn_day.png","name":"item0"}},{"type":"Button","props":{"y":104,"skin":"record/btn_week.png","name":"item1"}},{"type":"Button","props":{"y":208,"skin":"record/btn_month.png","name":"item2"}}]},{"type":"List","props":{"y":79,"x":271,"width":838,"var":"m_list","repeatX":1,"height":405}},{"type":"Image","props":{"y":490,"x":252,"var":"m_imgMyRank","skin":"record/img_MyRankingBg.png"}},{"type":"Button","props":{"y":527,"x":892,"var":"m_btnAward","stateNum":3,"skin":"record/btn_Award.png"},"child":[{"type":"Label","props":{"y":32,"x":95,"var":"m_awardLabel","text":"领取奖励","fontSize":25,"font":"SimHei","color":"#000000","anchorY":0.5,"anchorX":0.5}}]}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}