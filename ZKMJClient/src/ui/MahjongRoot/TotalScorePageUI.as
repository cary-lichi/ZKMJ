/**Created by the LayaAirIDE,do not modify.*/
package ui.MahjongRoot {
	import laya.ui.*;
	import laya.display.*; 

	public class TotalScorePageUI extends View {
		public var m_imgTopBg:Image;
		public var m_boxTop:Box;
		public var m_btnBack:Button;
		public var m_btnShare:Button;
		public var m_imgBoss0:Image;
		public var m_imgHead0:Image;
		public var m_lableName0:Label;
		public var m_lableID0:Label;
		public var m_lableHuCount0:Label;
		public var m_lableMoBaoCount0:Label;
		public var m_lableZiMoCount0:Label;
		public var m_lableGangCount0:Label;
		public var m_lableDianPaoCount0:Label;
		public var m_imgScore0:Image;
		public var m_imgPlus0:Image;
		public var m_clipTen0:Clip;
		public var m_clipBit0:Clip;
		public var m_boxGamer1:Box;
		public var m_imgBoss1:Image;
		public var m_imgHead1:Image;
		public var m_lableName1:Label;
		public var m_lableID1:Label;
		public var m_lableHuCount1:Label;
		public var m_lableMoBaoCount1:Label;
		public var m_lableZiMoCount1:Label;
		public var m_lableGangCount1:Label;
		public var m_lableDianPaoCount1:Label;
		public var m_imgScore1:Image;
		public var m_imgPlus1:Image;
		public var m_clipTen1:Clip;
		public var m_clipBit1:Clip;
		public var m_boxGamer2:Box;
		public var m_imgBoss2:Image;
		public var m_imgHead2:Image;
		public var m_lableName2:Label;
		public var m_lableID2:Label;
		public var m_lableHuCount2:Label;
		public var m_lableMoBaoCount2:Label;
		public var m_lableZiMoCount2:Label;
		public var m_lableGangCount2:Label;
		public var m_lableDianPaoCount2:Label;
		public var m_imgScore2:Image;
		public var m_imgPlus2:Image;
		public var m_clipTen2:Clip;
		public var m_clipBit2:Clip;
		public var m_boxGamer3:Box;
		public var m_imgBoss3:Image;
		public var m_imgHead3:Image;
		public var m_lableName3:Label;
		public var m_lableID3:Label;
		public var m_lableHuCount3:Label;
		public var m_lableMoBaoCount3:Label;
		public var m_lableZiMoCount3:Label;
		public var m_lableGangCount3:Label;
		public var m_lableDianPaoCount3:Label;
		public var m_imgScore3:Image;
		public var m_imgPlus3:Image;
		public var m_clipTen3:Clip;
		public var m_clipBit3:Clip;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1136,"name":"content","height":640},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1136,"skin":"totalScore/img_bigBg.png","sizeGrid":"40,40,40,40","height":640},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1136,"var":"m_imgTopBg","skin":"common/img_conBigBg1.png","sizeGrid":"0,50,0,50"}},{"type":"Box","props":{"y":0,"x":0,"width":1136,"var":"m_boxTop","height":55},"child":[{"type":"Image","props":{"y":3,"x":414,"skin":"totalScore/img_title.png"}},{"type":"Button","props":{"y":4,"x":20,"var":"m_btnBack","skin":"common/btn_back.png"}}]}]},{"type":"Box","props":{"y":0,"x":0,"name":"content"},"child":[{"type":"Button","props":{"y":565,"x":480,"visible":false,"var":"m_btnShare","skin":"common/btn_Bg.png"},"child":[{"type":"Label","props":{"y":19,"x":58,"text":"分享","strokeColor":"#3b7204","stroke":2,"fontSize":30,"font":"SimHei","color":"#ffffff"}}]},{"type":"Box","props":{"y":70,"x":32},"child":[{"type":"Image","props":{"width":255,"skin":"totalScore/img_bg_user.png","sizeGrid":"50,50,50,50","height":485},"child":[{"type":"Image","props":{"var":"m_imgBoss0","top":0,"skin":"totalScore/img_Identification.png","right":0}},{"type":"Image","props":{"y":41,"x":40,"width":80,"var":"m_imgHead0","skin":"common/img_head.png","height":80}},{"type":"Label","props":{"y":55,"x":124,"width":113,"var":"m_lableName0","text":"玩家名字","height":22,"fontSize":22,"font":"SimHei","color":"#b95d13","align":"left"}},{"type":"Label","props":{"y":90,"x":124,"text":"ID:","fontSize":22,"font":"SimHei","color":"#b95d13"},"child":[{"type":"Label","props":{"y":0,"x":37,"width":69,"var":"m_lableID0","text":"123456","height":22,"fontSize":22,"font":"SimHei","color":"#b95d13"}}]},{"type":"Label","props":{"y":135,"x":30,"width":230,"text":"胡牌","fontSize":26,"font":"SimHei","color":"#7e4a1b"},"child":[{"type":"Label","props":{"y":0,"x":124,"width":77,"var":"m_lableHuCount0","text":"0","height":26,"fontSize":26,"font":"SimHei","color":"#7e4a1b","align":"right"}}]},{"type":"Label","props":{"y":181,"x":30,"width":230,"text":"摸宝","fontSize":26,"font":"SimHei","color":"#7e4a1b"},"child":[{"type":"Label","props":{"y":0,"x":108,"width":90,"var":"m_lableMoBaoCount0","text":"0","right":30,"height":26,"fontSize":26,"font":"SimHei","color":"#7e4a1b","align":"right"}}]},{"type":"Label","props":{"y":227,"x":30,"width":230,"text":"自摸","fontSize":26,"font":"SimHei","color":"#7e4a1b"},"child":[{"type":"Label","props":{"y":0,"x":124,"width":90,"var":"m_lableZiMoCount0","text":"0","right":30,"height":26,"fontSize":26,"font":"SimHei","color":"#7e4a1b","align":"right"}}]},{"type":"Label","props":{"y":273,"x":30,"width":230,"text":"杠牌","fontSize":26,"font":"SimHei","color":"#7e4a1b"},"child":[{"type":"Label","props":{"y":0,"x":110,"width":90,"var":"m_lableGangCount0","text":"0","right":30,"height":26,"fontSize":26,"font":"SimHei","color":"#7e4a1b","align":"right"}}]},{"type":"Label","props":{"y":315,"x":30,"width":230,"text":"点炮","fontSize":26,"font":"SimHei","color":"#7e4a1b"},"child":[{"type":"Label","props":{"y":0,"x":135,"width":65,"var":"m_lableDianPaoCount0","text":"0","right":30,"height":26,"fontSize":26,"font":"SimHei","color":"#7e4a1b","align":"right"}}]},{"type":"Image","props":{"y":405,"x":30,"var":"m_imgScore0","skin":"totalScore/img_achieve_win.png"}},{"type":"Image","props":{"y":405,"var":"m_imgPlus0","skin":"totalScore/img_pr_win.png","right":95}},{"type":"Clip","props":{"y":400,"x":167,"var":"m_clipTen0","skin":"totalScore/clip_win.png","right":60,"clipX":10}},{"type":"Clip","props":{"y":400,"x":197,"var":"m_clipBit0","skin":"totalScore/clip_win.png","right":30,"index":0,"clipX":10}}]}]},{"type":"Box","props":{"y":70,"x":305,"var":"m_boxGamer1"},"child":[{"type":"Image","props":{"width":255,"skin":"totalScore/img_bg_user.png","sizeGrid":"50,50,50,50","height":485},"child":[{"type":"Image","props":{"var":"m_imgBoss1","top":0,"skin":"totalScore/img_Identification.png","right":0}},{"type":"Image","props":{"y":40,"x":40,"width":80,"var":"m_imgHead1","skin":"common/img_head.png","height":80}},{"type":"Label","props":{"y":55,"x":124,"width":101,"var":"m_lableName1","text":"玩家名字","height":22,"fontSize":22,"font":"SimHei","color":"#b95d13"}},{"type":"Label","props":{"y":90,"x":124,"text":"ID:","fontSize":22,"font":"SimHei","color":"#b95d13"},"child":[{"type":"Label","props":{"y":0,"x":37,"var":"m_lableID1","text":"123456","fontSize":22,"font":"SimHei","color":"#b95d13"}}]},{"type":"Label","props":{"y":135,"x":30,"width":230,"text":"胡牌","fontSize":26,"font":"SimHei","color":"#7e4a1b"},"child":[{"type":"Label","props":{"y":-4,"x":122,"width":78,"var":"m_lableHuCount1","text":"0","right":30,"height":26,"fontSize":26,"font":"SimHei","color":"#7e4a1b","align":"right"}}]},{"type":"Label","props":{"y":181,"x":30,"width":230,"text":"摸宝","fontSize":26,"font":"SimHei","color":"#7e4a1b"},"child":[{"type":"Label","props":{"y":0,"x":114,"width":86,"var":"m_lableMoBaoCount1","text":"0","right":30,"height":26,"fontSize":26,"font":"SimHei","color":"#7e4a1b","align":"right"}}]},{"type":"Label","props":{"y":227,"x":30,"width":230,"text":"自摸","fontSize":26,"font":"SimHei","color":"#7e4a1b"},"child":[{"type":"Label","props":{"y":0,"x":114,"width":86,"var":"m_lableZiMoCount1","text":"0","right":30,"height":26,"fontSize":26,"font":"SimHei","color":"#7e4a1b","align":"right"}}]},{"type":"Label","props":{"y":273,"x":30,"width":230,"text":"杠牌","fontSize":26,"font":"SimHei","color":"#7e4a1b"},"child":[{"type":"Label","props":{"y":0,"x":115,"width":85,"var":"m_lableGangCount1","text":"0","right":30,"height":26,"fontSize":26,"font":"SimHei","color":"#7e4a1b","align":"right"}}]},{"type":"Label","props":{"y":315,"x":30,"width":230,"text":"点炮","fontSize":26,"font":"SimHei","color":"#7e4a1b"},"child":[{"type":"Label","props":{"y":0,"x":116,"width":84,"var":"m_lableDianPaoCount1","text":"0","right":30,"height":26,"fontSize":26,"font":"SimHei","color":"#7e4a1b","align":"right"}}]},{"type":"Image","props":{"y":405,"x":30,"var":"m_imgScore1","skin":"totalScore/img_achieve_win.png"}},{"type":"Image","props":{"y":405,"var":"m_imgPlus1","skin":"totalScore/img_pr_win.png","right":95}},{"type":"Clip","props":{"y":400,"x":167,"var":"m_clipTen1","skin":"totalScore/clip_win.png","right":60,"clipX":10}},{"type":"Clip","props":{"y":400,"x":197,"var":"m_clipBit1","skin":"totalScore/clip_win.png","right":30,"index":0,"clipX":10}}]}]},{"type":"Box","props":{"y":70,"x":575,"var":"m_boxGamer2"},"child":[{"type":"Image","props":{"width":255,"skin":"totalScore/img_bg_user.png","sizeGrid":"50,50,50,50","height":485},"child":[{"type":"Image","props":{"var":"m_imgBoss2","top":0,"skin":"totalScore/img_Identification.png","right":0}},{"type":"Image","props":{"y":40,"x":40,"width":80,"var":"m_imgHead2","skin":"common/img_head.png","height":80}},{"type":"Label","props":{"y":55,"x":124,"var":"m_lableName2","text":"玩家名字","fontSize":22,"font":"SimHei","color":"#b95d13"}},{"type":"Label","props":{"y":90,"x":124,"text":"ID:","fontSize":22,"font":"SimHei","color":"#b95d13"},"child":[{"type":"Label","props":{"y":0,"x":37,"var":"m_lableID2","text":"123456","fontSize":22,"font":"SimHei","color":"#b95d13"}}]},{"type":"Label","props":{"y":135,"x":30,"width":230,"text":"胡牌","fontSize":26,"font":"SimHei","color":"#7e4a1b"},"child":[{"type":"Label","props":{"y":-4,"x":129,"width":71,"var":"m_lableHuCount2","text":"0","right":30,"height":26,"fontSize":26,"font":"SimHei","color":"#7e4a1b","align":"right"}}]},{"type":"Label","props":{"y":181,"x":30,"width":230,"text":"摸宝","fontSize":26,"font":"SimHei","color":"#7e4a1b"},"child":[{"type":"Label","props":{"y":0,"x":125,"width":75,"var":"m_lableMoBaoCount2","text":"0","right":30,"height":26,"fontSize":26,"font":"SimHei","color":"#7e4a1b","align":"right"}}]},{"type":"Label","props":{"y":227,"x":30,"width":230,"text":"自摸","fontSize":26,"font":"SimHei","color":"#7e4a1b"},"child":[{"type":"Label","props":{"y":0,"x":119,"width":81,"var":"m_lableZiMoCount2","text":"0","right":30,"height":26,"fontSize":26,"font":"SimHei","color":"#7e4a1b","align":"right"}}]},{"type":"Label","props":{"y":273,"x":30,"width":230,"text":"杠牌","fontSize":26,"font":"SimHei","color":"#7e4a1b"},"child":[{"type":"Label","props":{"y":0,"x":101,"width":99,"var":"m_lableGangCount2","text":"0","right":30,"height":26,"fontSize":26,"font":"SimHei","color":"#7e4a1b","align":"right"}}]},{"type":"Label","props":{"y":315,"x":30,"width":230,"text":"点炮","fontSize":26,"font":"SimHei","color":"#7e4a1b"},"child":[{"type":"Label","props":{"y":0,"x":111,"width":89,"var":"m_lableDianPaoCount2","text":"0","right":30,"height":26,"fontSize":26,"font":"SimHei","color":"#7e4a1b","align":"right"}}]},{"type":"Image","props":{"y":405,"x":30,"var":"m_imgScore2","skin":"totalScore/img_achieve_win.png"}},{"type":"Image","props":{"y":405,"var":"m_imgPlus2","skin":"totalScore/img_pr_win.png","right":95}},{"type":"Clip","props":{"y":400,"x":167,"var":"m_clipTen2","skin":"totalScore/clip_win.png","right":60,"clipX":10}},{"type":"Clip","props":{"y":400,"x":197,"var":"m_clipBit2","skin":"totalScore/clip_win.png","right":30,"index":0,"clipX":10}}]}]},{"type":"Box","props":{"y":70,"x":845,"var":"m_boxGamer3"},"child":[{"type":"Image","props":{"width":255,"skin":"totalScore/img_bg_user.png","sizeGrid":"50,50,50,50","height":485},"child":[{"type":"Image","props":{"var":"m_imgBoss3","top":0,"skin":"totalScore/img_Identification.png","right":0}},{"type":"Image","props":{"y":40,"x":40,"width":80,"var":"m_imgHead3","skin":"common/img_head.png","height":80}},{"type":"Label","props":{"y":55,"x":124,"var":"m_lableName3","text":"玩家名字","fontSize":22,"font":"SimHei","color":"#b95d13"}},{"type":"Label","props":{"y":90,"x":124,"text":"ID:","fontSize":22,"font":"SimHei","color":"#b95d13"},"child":[{"type":"Label","props":{"y":0,"x":37,"var":"m_lableID3","text":"123456","fontSize":22,"font":"SimHei","color":"#b95d13"}}]},{"type":"Label","props":{"y":135,"x":30,"width":230,"text":"胡牌","fontSize":26,"font":"SimHei","color":"#7e4a1b"},"child":[{"type":"Label","props":{"y":-4,"x":102,"width":98,"var":"m_lableHuCount3","text":"0","right":30,"height":26,"fontSize":26,"font":"SimHei","color":"#7e4a1b","align":"right"}}]},{"type":"Label","props":{"y":181,"x":30,"width":230,"text":"摸宝","fontSize":26,"font":"SimHei","color":"#7e4a1b"},"child":[{"type":"Label","props":{"y":0,"x":113,"width":87,"var":"m_lableMoBaoCount3","text":"0","right":30,"height":26,"fontSize":26,"font":"SimHei","color":"#7e4a1b","align":"right"}}]},{"type":"Label","props":{"y":227,"x":30,"width":230,"text":"自摸","fontSize":26,"font":"SimHei","color":"#7e4a1b"},"child":[{"type":"Label","props":{"y":0,"x":101,"width":99,"var":"m_lableZiMoCount3","text":"0","right":30,"height":26,"fontSize":26,"font":"SimHei","color":"#7e4a1b","align":"right"}}]},{"type":"Label","props":{"y":273,"x":30,"width":230,"text":"杠牌","fontSize":26,"font":"SimHei","color":"#7e4a1b"},"child":[{"type":"Label","props":{"y":0,"x":93,"width":107,"var":"m_lableGangCount3","text":"0","right":30,"height":26,"fontSize":26,"font":"SimHei","color":"#7e4a1b","align":"right"}}]},{"type":"Label","props":{"y":315,"x":30,"width":230,"text":"点炮","fontSize":26,"font":"SimHei","color":"#7e4a1b"},"child":[{"type":"Label","props":{"y":0,"x":107,"width":93,"var":"m_lableDianPaoCount3","text":"0","right":30,"height":26,"fontSize":26,"font":"SimHei","color":"#7e4a1b","align":"right"}}]},{"type":"Image","props":{"y":405,"x":30,"var":"m_imgScore3","skin":"totalScore/img_achieve_win.png"}},{"type":"Image","props":{"y":405,"var":"m_imgPlus3","skin":"totalScore/img_pr_win.png","right":95}},{"type":"Clip","props":{"y":400,"x":167,"var":"m_clipTen3","skin":"totalScore/clip_win.png","right":60,"clipX":10}},{"type":"Clip","props":{"y":400,"x":197,"var":"m_clipBit3","skin":"totalScore/clip_win.png","right":30,"index":0,"clipX":10}}]}]}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}