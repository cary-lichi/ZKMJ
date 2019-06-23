/**Created by the LayaAirIDE,do not modify.*/
package ui.MahjongRoot {
	import laya.ui.*;
	import laya.display.*; 

	public class GamehallPageUI extends View {
		public var m_boxContent:Box;
		public var m_btnSet:Button;
		public var m_btnService:Button;
		public var m_btnRegular:Button;
		public var m_btnGrade:Button;
		public var m_imgRecordPrompt:Image;
		public var m_btnShop:Button;
		public var m_btnAnnounce:Button;
		public var m_btnCooperation:Button;
		public var m_btnBand:Button;
		public var m_btnGaim:Button;
		public var m_imgDefenseG:Image;
		public var m_btnAddMe:Button;
		public var m_btnShare:Button;
		public var m_imgSharePrompt:Image;
		public var imgCarousel:Panel;
		public var roll:Image;
		public var m_panelCarousel:Panel;
		public var rollLable:Label;
		public var m_imgGoldBG:Image;
		public var gold:Image;
		public var m_boxMa:Box;
		public var m_imgMaW:Image;
		public var m_imgCardBG:Image;
		public var card:Image;
		public var m_btnAddCard:Button;
		public var m_boxCard:Box;
		public var m_imgCardW:Image;
		public var m_btn_Award:Button;
		public var m_btnJoinRoom:Button;
		public var m_btnCreateCommonRoom:Button;
		public var m_btnCreateLanziRoom:Button;
		public var m_btnHappyRoom:Button;
		public var m_labBonusNum:Label;
		public var m_btnDetail:Image;
		public var m_Avatar:Image;
		public var m_userName:Label;
		public var m_lableUserID:Label;
		public var m_btnMeil:Button;
		public var m_imgMailPrompt:Image;
		public var m_btnDeleCreateRoom:Button;
		public var m_imgDeleBackBg:Image;
		public var m_boxDeleBtn:Box;
		public var m_btnDeleMDJRoom:Button;
		public var m_btnDeleHRBRoom:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1136,"visible":true,"height":640},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1136,"visible":true,"skin":"gameHall/img_Bg.jpg","height":640}},{"type":"Box","props":{"y":0,"x":0,"width":1136,"var":"m_boxContent","name":"content","height":640},"child":[{"type":"Button","props":{"y":529,"x":780,"var":"m_btnSet","stateNum":1,"skin":"gameHall/btn_set_lobby.png"}},{"type":"Button","props":{"y":529,"x":650,"var":"m_btnService","stateNum":1,"skin":"gameHall/btn_service_lobby.png"}},{"type":"Button","props":{"y":540,"x":455,"visible":false,"var":"m_btnRegular","stateNum":1,"skin":"gameHall/btn_regular_lobby.png"}},{"type":"Button","props":{"y":529,"x":520,"var":"m_btnGrade","stateNum":1,"skin":"gameHall/btn_grade_lobby.png"},"child":[{"type":"Image","props":{"y":-5,"x":50,"visible":false,"var":"m_imgRecordPrompt","skin":"gameHall/img_mailPrompt.png"}}]},{"type":"Button","props":{"y":510,"x":910,"var":"m_btnShop","stateNum":1,"skin":"gameHall/btn_shop_lobby.png"}},{"type":"Button","props":{"y":529,"x":399,"var":"m_btnAnnounce","stateNum":1,"skin":"gameHall/btn_announcement_lobby.png"}},{"type":"Button","props":{"y":556,"x":543,"visible":false,"var":"m_btnCooperation","stateNum":1,"skin":"gameHall/btn_cooperation_lobby.png"}},{"type":"Button","props":{"y":556,"x":459,"visible":false,"var":"m_btnBand","stateNum":1,"skin":"gameHall/btn_band_lobby.png"}},{"type":"Button","props":{"y":540,"x":267,"width":53,"visible":false,"var":"m_btnGaim","stateNum":1,"skin":"gameHall/btn_gain_lobby.png","height":74},"child":[{"type":"Image","props":{"y":-5,"x":43,"skin":"gameHall/img_mailPrompt.png"}}]},{"type":"Image","props":{"y":3,"x":10,"visible":false,"var":"m_imgDefenseG","top":133,"skin":"gameHall/img_antiCheating_lobby.png"}},{"type":"Button","props":{"y":306,"x":24,"visible":false,"var":"m_btnAddMe","stateNum":1,"skin":"gameHall/btn_addMe_lobby.png"}},{"type":"Button","props":{"y":529,"x":130,"var":"m_btnShare","stateNum":1,"skin":"gameHall/btn_share_lobby.png"},"child":[{"type":"Image","props":{"y":-45,"x":-20,"var":"m_imgSharePrompt","skin":"gameHall/img_shareBg.png"},"child":[{"type":"Label","props":{"y":8,"x":8,"text":"分享得3","styleSkin":"comp/label.png","fontSize":20,"font":"SimHei","color":"#fffeb5"}},{"type":"Image","props":{"y":4,"x":79,"width":26,"skin":"common/img_diamonds.png","height":26}}]}]},{"type":"Panel","props":{"x":730,"width":395,"var":"imgCarousel","top":13,"name":"imgCarousel","height":40},"child":[{"type":"Image","props":{"y":0,"x":0,"width":395,"var":"roll","skin":"gameHall/img_noticeBg.png_lobby.png","sizeGrid":"10,10,10,10","height":40},"child":[{"type":"Image","props":{"y":9,"x":19,"skin":"gameHall/img_horn_lobby.png"}}]},{"type":"Panel","props":{"y":0,"x":50,"width":350,"var":"m_panelCarousel","height":40},"child":[{"type":"Label","props":{"y":10,"x":0,"var":"rollLable","valign":"middle","text":"周口棋牌纯绿色休闲平台，严禁赌博。","styleSkin":"comp/label.png","fontSize":20,"font":"SimHei","color":"#fffcf3","align":"center"}}]}]},{"type":"Image","props":{"y":64,"x":265,"width":140,"var":"m_imgGoldBG","skin":"common/img_dise.png","height":30},"child":[{"type":"Image","props":{"y":-3,"x":-26,"width":40,"var":"gold","skin":"common/img_ma.png","height":40}},{"type":"Box","props":{"y":4,"x":20,"var":"m_boxMa"},"child":[{"type":"Clip","props":{"y":0,"x":0,"skin":"common/clip.png","name":"item0","index":0,"clipY":1,"clipX":11}},{"type":"Clip","props":{"y":0,"x":16,"skin":"common/clip.png","name":"item1","index":0,"clipY":1,"clipX":11}},{"type":"Clip","props":{"y":0,"x":32,"skin":"common/clip.png","name":"item2","index":0,"clipY":1,"clipX":11}},{"type":"Clip","props":{"y":0,"x":48,"skin":"common/clip.png","name":"item3","index":0,"clipY":1,"clipX":11}},{"type":"Image","props":{"y":-2,"x":63,"var":"m_imgMaW","skin":"common/img_w.png"}}]}]},{"type":"Image","props":{"y":18,"x":265,"width":140,"var":"m_imgCardBG","skin":"common/img_dise.png","height":30},"child":[{"type":"Image","props":{"y":0,"x":-24,"width":40,"var":"card","skin":"common/img_diamonds.png","height":40}},{"type":"Button","props":{"y":-3,"x":113,"var":"m_btnAddCard","skin":"common/btn_add.png"}},{"type":"Box","props":{"y":4,"x":20,"var":"m_boxCard"},"child":[{"type":"Clip","props":{"skin":"common/clip.png","name":"item0","clipY":1,"clipX":11}},{"type":"Clip","props":{"y":0,"x":16,"skin":"common/clip.png","name":"item1","clipY":1,"clipX":11}},{"type":"Clip","props":{"y":0,"x":32,"skin":"common/clip.png","name":"item2","clipY":1,"clipX":11}},{"type":"Clip","props":{"y":0,"x":48,"skin":"common/clip.png","name":"item3","clipY":1,"clipX":11}},{"type":"Image","props":{"y":-2,"x":64,"var":"m_imgCardW","skin":"common/img_w.png"}}]}]},{"type":"Button","props":{"y":556,"x":711,"visible":false,"var":"m_btn_Award","stateNum":1,"skin":"gameHall/btn_award_lobby.png"}},{"type":"Button","props":{"y":109,"x":323,"var":"m_btnJoinRoom","stateNum":1,"skin":"gameHall/btn_joinRoom_lobby.png"}},{"type":"Button","props":{"y":113,"x":705,"var":"m_btnCreateCommonRoom","stateNum":1,"skin":"gameHall/btn_zhoukouRoom.png"}},{"type":"Button","props":{"y":243,"x":705,"var":"m_btnCreateLanziRoom","stateNum":1,"skin":"gameHall/btn_shangshuiRoom.png"}},{"type":"Button","props":{"y":373,"x":705,"visible":true,"var":"m_btnHappyRoom","stateNum":1,"skin":"gameHall/btn_bonus_lobby.png"},"child":[{"type":"Label","props":{"y":63,"x":153,"width":84,"var":"m_labBonusNum","valign":"middle","text":"437","styleSkin":"comp/label.png","height":20,"fontSize":20,"font":"SimHei","color":"#f4f3e3","align":"center"}}]},{"type":"Box","props":{"y":5,"x":5},"child":[{"type":"Image","props":{"y":0,"x":0,"var":"m_btnDetail","skin":"common/img_alphaHeadBg.png"},"child":[{"type":"Image","props":{"y":5,"x":5,"width":92,"var":"m_Avatar","skin":"common/img_head.png","height":92}}]},{"type":"Label","props":{"y":20,"x":106,"width":136,"var":"m_userName","valign":"middle","text":"玩家姓玩家姓","styleSkin":"comp/label.png","strokeColor":"#000000","stroke":3,"overflow":"hidden","height":24,"fontSize":22,"font":"SimHei","color":"#ffffff","align":"left"}},{"type":"Label","props":{"y":61,"x":106,"valign":"middle","text":"ID:","styleSkin":"comp/label.png","strokeColor":"#000000","stroke":3,"fontSize":22,"font":"SimHei","color":"#ffffff","align":"left"}},{"type":"Label","props":{"y":61,"x":145,"var":"m_lableUserID","valign":"middle","text":"12345","styleSkin":"comp/label.png","strokeColor":"#000000","stroke":3,"fontSize":22,"font":"SimHei","color":"#ffffff","align":"left"}}]},{"type":"Button","props":{"y":540,"x":267,"width":53,"var":"m_btnMeil","stateNum":1,"skin":"gameHall/btn_gain_lobby.png","height":74},"child":[{"type":"Image","props":{"y":-5,"x":43,"visible":false,"var":"m_imgMailPrompt","skin":"gameHall/img_mailPrompt.png"}}]},{"type":"Button","props":{"y":138,"x":7,"var":"m_btnDeleCreateRoom","skin":"gameHall/btn_deleCreateRoom.png"}}]},{"type":"Image","props":{"y":0,"x":0,"width":1136,"visible":false,"var":"m_imgDeleBackBg","skin":"game/img_tingBlackBg.png","sizeGrid":"9,9,9,9","height":640,"alpha":1}},{"type":"Box","props":{"y":0,"x":0,"width":1136,"visible":false,"var":"m_boxDeleBtn","name":"content","mouseThrough":true,"height":640},"child":[{"type":"Button","props":{"y":321,"x":378,"var":"m_btnDeleMDJRoom","stateNum":1,"skin":"gameHall/btn_shangshuiRoom.png"}},{"type":"Button","props":{"y":179,"x":378,"var":"m_btnDeleHRBRoom","stateNum":1,"skin":"gameHall/btn_zhoukouRoom.png"}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}