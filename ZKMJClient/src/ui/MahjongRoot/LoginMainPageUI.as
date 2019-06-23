/**Created by the LayaAirIDE,do not modify.*/
package ui.MahjongRoot {
	import laya.ui.*;
	import laya.display.*; 

	public class LoginMainPageUI extends View {
		public var m_imgBg:Image;
		public var m_boxContent:Box;
		public var m_logo:Image;
		public var m_lable1:Label;
		public var m_lable2:Label;
		public var btn_loginWX:Button;
		public var m_ckeckBox:CheckBox;
		public var m_btnUserAgreement:Button;
		public var m_youke:Button;
		public var m_Success:Image;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1136,"height":640},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1136,"var":"m_imgBg","skin":"loading/img_bg.jpg","height":640}},{"type":"Box","props":{"y":0,"x":0,"var":"m_boxContent","name":"content"},"child":[{"type":"Image","props":{"y":56,"x":334,"var":"m_logo","skin":"loading/img_text_3.png"}},{"type":"Label","props":{"y":580,"width":1136,"var":"m_lable1","valign":"middle","text":"本游戏仅限18岁及以上的玩家娱乐:为了您的健康，请合理控制时间！","styleSkin":"comp/label.png","strokeColor":"#3b7204","fontSize":18,"font":"SimHei","color":"#323d52","centerX":0,"align":"center"}},{"type":"Label","props":{"y":610,"width":1136,"var":"m_lable2","valign":"middle","text":"抵制不良游戏 拒绝盗版游戏 注意自我保护 谨防上当受骗 适度游戏益脑 沉迷游戏伤身 合理安排时间 享受精彩生活","styleSkin":"comp/label.png","strokeColor":"#3b7204","fontSize":18,"font":"SimHei","color":"#323d52","centerX":0,"align":"center"}},{"type":"Button","props":{"y":411,"var":"btn_loginWX","skin":"common/btn_login.png","centerX":2}},{"type":"Box","props":{"y":528,"centerX":0},"child":[{"type":"CheckBox","props":{"var":"m_ckeckBox","skin":"loading/checkbox.png","selected":true}},{"type":"Button","props":{"y":3,"x":38,"var":"m_btnUserAgreement","skin":"loading/btn_text.png"}}]},{"type":"Button","props":{"y":296,"x":406,"width":324,"var":"m_youke","skin":"common/btn_bule.png","height":100},"child":[{"type":"Label","props":{"text":"游客登录","fontSize":40,"font":"SimHei","color":"#ffffff","centerY":-3,"centerX":0}}]},{"type":"Image","props":{"y":315,"x":208,"width":720,"visible":false,"var":"m_Success","skin":"common/img_successBg.png","height":88,"centerX":0},"child":[{"type":"Image","props":{"y":27,"skin":"loading/img_text.png","centerX":0}}]}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}