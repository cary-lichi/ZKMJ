/**Created by the LayaAirIDE,do not modify.*/
package ui.MahjongRoot {
	import laya.ui.*;
	import laya.display.*; 

	public class NoticeWindowUI extends View {
		public var m_root:Box;
		public var m_backImage:Image;
		public var m_top:Image;
		public var btn_close:Button;
		public var tab_notice:Tab;
		public var btn_new:Button;
		public var btn_limit:Button;
		public var vs_notic:ViewStack;
		public var m_box1:Box;
		public var m_bg1:Image;
		public var m_update:Image;
		public var m_label1:Label;
		public var m_date1:Label;
		public var m_box2:Box;
		public var m_bg2:Image;
		public var m_free:Image;
		public var m_label2:Label;
		public var m_date2:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1136,"height":640},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1136,"skin":"common/img_blankBg.png","sizeGrid":"2,2,2,2","height":640}},{"type":"Box","props":{"y":73,"x":152,"var":"m_root","name":"content"},"child":[{"type":"Image","props":{"width":805,"var":"m_backImage","skin":"common/img_bomb boxBg.png","sizeGrid":"75,75,75,75","height":493},"child":[{"type":"Image","props":{"y":-47,"x":216,"skin":"common/img_popupBg.png"},"child":[{"type":"Image","props":{"y":10,"x":115,"var":"m_top","skin":"gameHall/img_title_notic.png"}}]}]},{"type":"Button","props":{"y":-28,"x":760,"var":"btn_close","skin":"common/btn_close.png"}},{"type":"Tab","props":{"y":43,"x":30,"var":"tab_notice","space":10,"selectedIndex":0,"direction":"vertical"},"child":[{"type":"Button","props":{"var":"btn_new","stateNum":3,"skin":"gameHall/btn_tapNew_notice.png","name":"item0"}},{"type":"Button","props":{"y":100,"x":0,"visible":false,"var":"btn_limit","stateNum":3,"skin":"gameHall/btn_tapFreelimit_notice.png","name":"item1"}}]},{"type":"ViewStack","props":{"y":43,"x":200,"var":"vs_notic","selectedIndex":0},"child":[{"type":"Box","props":{"y":0,"x":0,"var":"m_box1","name":"item0"},"child":[{"type":"Image","props":{"y":0,"x":0,"width":570,"var":"m_bg1","skin":"gameHall/img_text_notice.png","height":400},"child":[{"type":"Image","props":{"y":25,"x":130,"var":"m_update","skin":"gameHall/img_update_notice.png"}},{"type":"Label","props":{"y":80,"x":25,"wordWrap":true,"width":525,"var":"m_label1","text":"亲爱的朋友们 \\n   《地道周口麻将》上线啦！玩法地道，绝无外挂！祝大家玩的开心，有意见反馈客服有奖。客服微信：THMJ08  \\n   诚招代理，待遇优厚。申请加入请加，微信：THMJ06","styleSkin":"comp/label.png","leading":15,"height":255,"fontSize":23,"font":"SimHei","color":"#3b2500"}},{"type":"Label","props":{"y":338,"x":25,"width":525,"var":"m_date1","valign":"middle","text":"2017-12-16","styleSkin":"comp/label.png","leading":15,"fontSize":25,"font":"SimHei","color":"#3b2500","align":"right"}}]}]},{"type":"Box","props":{"y":0,"x":0,"var":"m_box2","name":"item1"},"child":[{"type":"Image","props":{"y":0,"x":0,"width":570,"var":"m_bg2","skin":"gameHall/img_text_notice.png","height":400},"child":[{"type":"Image","props":{"y":25,"x":130,"var":"m_free","skin":"gameHall/img_Freelimit_notice.png"}},{"type":"Label","props":{"y":80,"x":25,"wordWrap":true,"width":544,"var":"m_label2","text":"亲爱的亲友们：\\n    为感谢大家支持，先推出两重活动 \\n1、每日12:00-13:00开房免房卡，快来整一局！ \\n2、签到送房卡：只需前往公众号【添胡麻将】签到、即可领取房卡，一共5天呦！","styleSkin":"comp/label.png","leading":15,"height":255,"fontSize":23,"font":"SimHei","color":"#3b2500"}},{"type":"Label","props":{"y":338,"x":25,"width":525,"var":"m_date2","valign":"middle","text":"2017-8-10","styleSkin":"comp/label.png","leading":15,"fontSize":25,"font":"SimHei","color":"#3b2500","align":"right"}}]}]}]}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}