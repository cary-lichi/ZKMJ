/**Created by the LayaAirIDE,do not modify.*/
package ui.MahjongRoot {
	import laya.ui.*;
	import laya.display.*; 

	public class ServiceWindowUI extends View {
		public var m_root:Box;
		public var m_backImage:Image;
		public var m_top:Image;
		public var m_service:Image;
		public var btn_close:Button;
		public var m_tip:Label;
		public var m_btnProposal:Image;
		public var m_btnOnline:Image;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1136,"height":640},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1136,"skin":"common/img_blankBg.png","sizeGrid":"2,2,2,2","height":640}},{"type":"Box","props":{"y":120,"x":268,"width":600,"var":"m_root","name":"content","height":400},"child":[{"type":"Image","props":{"width":600,"var":"m_backImage","skin":"common/img_bomb boxBg.png","sizeGrid":"75,75,75,75","height":400},"child":[{"type":"Image","props":{"y":-47,"x":114,"var":"m_top","skin":"common/img_popupBg.png"},"child":[{"type":"Image","props":{"y":9,"x":115,"var":"m_service","skin":"gameHall/img_service_service.png","height":36}}]}]},{"type":"Button","props":{"y":-28,"x":554,"var":"btn_close","skin":"common/btn_close.png"}},{"type":"Label","props":{"y":315,"x":0,"width":600,"var":"m_tip","text":"提出的建议被采纳 ，将获得房卡奖励！","styleSkin":"comp/label.png","fontSize":20,"font":"SimHei","color":"#a63303","align":"center"}},{"type":"Image","props":{"y":48,"x":340,"var":"m_btnProposal","skin":"gameHall/img_proposal_service.png"}},{"type":"Image","props":{"y":48,"x":70,"var":"m_btnOnline","skin":"gameHall/img_online_service.png"}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}