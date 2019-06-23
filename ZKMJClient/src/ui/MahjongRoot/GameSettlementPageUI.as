/**Created by the LayaAirIDE,do not modify.*/
package ui.MahjongRoot {
	import laya.ui.*;
	import laya.display.*; 

	public class GameSettlementPageUI extends View {
		public var m_imgBg:Image;
		public var m_boxSettlement:Box;
		public var m_imgHu:Image;
		public var m_imgBai:Image;
		public var m_imgPing:Image;
		public var m_list0pai:List;
		public var m_user0Name:Label;
		public var m_user0Id:Label;
		public var m_win0Type:Label;
		public var m_score0:Label;
		public var m_zhuang0:Image;
		public var m_boxGamer1:Box;
		public var m_list1pai:List;
		public var m_zhuang1:Image;
		public var m_score1:Label;
		public var m_win1Type:Label;
		public var m_user1Id:Label;
		public var m_user1Name:Label;
		public var m_boxGamer2:Box;
		public var m_list2pai:List;
		public var m_zhuang2:Image;
		public var m_score2:Label;
		public var m_win2Type:Label;
		public var m_user2Id:Label;
		public var m_user2Name:Label;
		public var m_boxGamer3:Box;
		public var m_list3pai:List;
		public var m_zhuang3:Image;
		public var m_score3:Label;
		public var m_win3Type:Label;
		public var m_user3Id:Label;
		public var m_user3Name:Label;
		public var m_imgBaoPailight:Image;
		public var m_btnBack:Button;
		public var m_btnShare:Button;
		public var m_btnShowPai:Button;
		public var m_btnToalScore:Button;
		public var m_btnReady:Button;
		public var m_btnShowSetlement:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1136,"name":"content","height":640},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1136,"var":"m_imgBg","skin":"game/img_gameSettlementBG.png","height":640}},{"type":"Box","props":{"y":-5,"x":0,"name":"content"},"child":[{"type":"Box","props":{"y":54,"x":0,"var":"m_boxSettlement"},"child":[{"type":"Image","props":{"skin":"game/img_sltSelfBG.png"},"child":[{"type":"Image","props":{"y":62,"x":31,"visible":false,"var":"m_imgHu","skin":"game/img_sltHu.png"}},{"type":"Image","props":{"y":62,"x":31,"visible":false,"var":"m_imgBai","skin":"game/img_sltBai.png"}},{"type":"Image","props":{"y":62,"x":31,"visible":false,"var":"m_imgPing","skin":"game/img_sltPing.png"}},{"type":"List","props":{"y":57,"x":126,"width":913,"var":"m_list0pai","height":87,"hScrollBarSkin":" "}},{"type":"Label","props":{"y":19,"x":126,"width":140,"var":"m_user0Name","text":"昵称玩家姓名","overflow":"hidden","height":22,"fontSize":22,"font":"SimHei","color":"#dcceaa"}},{"type":"Label","props":{"y":19,"x":300,"visible":false,"text":"ID:","fontSize":22,"font":"SimHei","color":"#dcceaa"}},{"type":"Label","props":{"y":20,"x":331,"visible":false,"var":"m_user0Id","text":"123456","fontSize":22,"font":"SimHei","color":"#dcceaa"}},{"type":"Label","props":{"y":19,"x":612,"var":"m_win0Type","text":"自摸","fontSize":22,"font":"SimHei","color":"#dcceaa"}},{"type":"Label","props":{"y":19,"x":754,"var":"m_score0","text":"+12","fontSize":22,"font":"SimHei","color":"#f7f200"}},{"type":"Image","props":{"y":12,"x":531,"var":"m_zhuang0","skin":"game/img_zhuang.png"}}]},{"type":"Box","props":{"y":160,"visible":false,"var":"m_boxGamer1"},"child":[{"type":"Image","props":{"y":106,"x":126,"skin":"game/img_sltLine.png"}},{"type":"List","props":{"y":32,"x":126,"width":913,"var":"m_list1pai","height":50,"hScrollBarSkin":" "}},{"type":"Image","props":{"y":0,"x":531,"var":"m_zhuang1","skin":"game/img_zhuang.png"}},{"type":"Label","props":{"y":7,"x":754,"var":"m_score1","text":"+12","fontSize":22,"font":"SimHei","color":"#f7f200"}},{"type":"Label","props":{"y":7,"x":612,"var":"m_win1Type","text":"自摸","fontSize":22,"font":"SimHei","color":"#dcceaa"}},{"type":"Label","props":{"y":8,"x":331,"visible":false,"var":"m_user1Id","text":"123456","fontSize":22,"font":"SimHei","color":"#dcceaa"}},{"type":"Label","props":{"y":7,"x":300,"visible":false,"text":"ID:","fontSize":22,"font":"SimHei","color":"#dcceaa"}},{"type":"Label","props":{"y":7,"x":126,"width":140,"var":"m_user1Name","text":"昵称玩家","overflow":"hidden","fontSize":22,"font":"SimHei","color":"#dcceaa"}}]},{"type":"Box","props":{"y":270,"visible":false,"var":"m_boxGamer2"},"child":[{"type":"Image","props":{"y":106,"x":126,"skin":"game/img_sltLine.png"}},{"type":"List","props":{"y":32,"x":126,"width":913,"var":"m_list2pai","height":50,"hScrollBarSkin":" "}},{"type":"Image","props":{"y":0,"x":531,"var":"m_zhuang2","skin":"game/img_zhuang.png"}},{"type":"Label","props":{"y":7,"x":754,"var":"m_score2","text":"+12","fontSize":22,"font":"SimHei","color":"#f7f200"}},{"type":"Label","props":{"y":7,"x":612,"var":"m_win2Type","text":"自摸","fontSize":22,"font":"SimHei","color":"#dcceaa"}},{"type":"Label","props":{"y":8,"x":331,"visible":false,"var":"m_user2Id","text":"123456","fontSize":22,"font":"SimHei","color":"#dcceaa"}},{"type":"Label","props":{"y":7,"x":300,"visible":false,"text":"ID:","fontSize":22,"font":"SimHei","color":"#dcceaa"}},{"type":"Label","props":{"y":7,"x":126,"width":140,"var":"m_user2Name","text":"昵称玩家","overflow":"visible","fontSize":22,"font":"SimHei","color":"#dcceaa"}}]},{"type":"Box","props":{"y":380,"visible":false,"var":"m_boxGamer3"},"child":[{"type":"Image","props":{"y":106,"x":126,"skin":"game/img_sltLine.png"}},{"type":"List","props":{"y":32,"x":126,"width":913,"var":"m_list3pai","height":50,"hScrollBarSkin":" "}},{"type":"Image","props":{"y":0,"x":531,"var":"m_zhuang3","skin":"game/img_zhuang.png"}},{"type":"Label","props":{"y":7,"x":754,"var":"m_score3","text":"+12","fontSize":22,"font":"SimHei","color":"#f7f200"}},{"type":"Label","props":{"y":7,"x":612,"var":"m_win3Type","text":"自摸","fontSize":22,"font":"SimHei","color":"#dcceaa"}},{"type":"Label","props":{"y":8,"x":331,"visible":false,"var":"m_user3Id","text":"123456","fontSize":22,"font":"SimHei","color":"#dcceaa"}},{"type":"Label","props":{"y":7,"x":300,"visible":false,"text":"ID:","fontSize":22,"font":"SimHei","color":"#dcceaa"}},{"type":"Label","props":{"y":7,"x":126,"width":140,"var":"m_user3Name","text":"昵称玩家","overflow":"visible","fontSize":22,"font":"SimHei","color":"#dcceaa"}}]},{"type":"Image","props":{"y":196,"x":849,"var":"m_imgBaoPailight","skin":"game/img_baoPaiLight.png"},"child":[{"type":"Image","props":{"y":16,"x":91,"skin":"game/img_text_baopai.png"}}]},{"type":"Button","props":{"y":-44,"x":10,"var":"m_btnBack","skin":"game/btn_quitRoom.png"}}]},{"type":"Button","props":{"y":552,"x":118,"visible":false,"var":"m_btnShare","skin":"game/btn_share.png","skewX":0}},{"type":"Button","props":{"y":552,"x":806,"width":212,"var":"m_btnShowPai","skin":"common/btn_Bg.png","height":83},"child":[{"type":"Label","props":{"y":3,"x":3,"width":206,"valign":"middle","text":"查看牌面","styleSkin":"comp/label.png","strokeColor":"#3b7204","stroke":2,"height":72,"fontSize":36,"font":"SimHei","color":"#ffffff","align":"center"}}]},{"type":"Button","props":{"y":552,"x":462,"width":212,"var":"m_btnToalScore","skin":"common/btn_yellowBg.png","height":83},"child":[{"type":"Label","props":{"y":3,"x":3,"width":206,"valign":"middle","text":"总成绩","styleSkin":"comp/label.png","strokeColor":"#a24507","stroke":2,"height":72,"fontSize":36,"font":"SimHei","color":"#ffffff","align":"center"}}]},{"type":"Button","props":{"y":552,"x":462,"width":212,"var":"m_btnReady","skin":"common/btn_yellowBg.png","height":83},"child":[{"type":"Label","props":{"y":3,"x":3,"width":206,"valign":"middle","text":"再来一局","styleSkin":"comp/label.png","strokeColor":"#a24507","stroke":2,"height":72,"fontSize":36,"font":"SimHei","color":"#ffffff","align":"center"}}]},{"type":"Button","props":{"y":552,"x":809,"width":212,"visible":false,"var":"m_btnShowSetlement","skin":"common/btn_Bg.png","height":83},"child":[{"type":"Label","props":{"y":3,"x":3,"width":206,"valign":"middle","text":"查看成绩","styleSkin":"comp/label.png","strokeColor":"#3b7204","stroke":2,"height":72,"fontSize":36,"font":"SimHei","color":"#ffffff","align":"center"}}]}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}