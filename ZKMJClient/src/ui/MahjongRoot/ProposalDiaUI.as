/**Created by the LayaAirIDE,do not modify.*/
package ui.MahjongRoot {
	import laya.ui.*;
	import laya.display.*; 

	public class ProposalDiaUI extends View {
		public var m_root:Box;
		public var m_backImage:Image;
		public var m_top:Image;
		public var m_lableTop:Label;
		public var m_iContent:TextInput;
		public var m_phone:Label;
		public var m_iTel:TextInput;
		public var m_btnClose:Button;
		public var m_btnIsOK:Button;
		public var m_lableBotton:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":1136,"height":640},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1136,"skin":"common/img_blankBg.png","sizeGrid":"2,2,2,2","height":640}},{"type":"Box","props":{"y":120,"x":268,"width":600,"var":"m_root","name":"content","height":400},"child":[{"type":"Image","props":{"width":600,"var":"m_backImage","skin":"common/img_bomb boxBg.png","sizeGrid":"75,75,75,75","height":400},"child":[{"type":"Image","props":{"y":-47,"x":114,"skin":"common/img_popupBg.png"},"child":[{"type":"Image","props":{"y":9,"x":114,"var":"m_top","skin":"gameHall/img_suggest_service.png"}}]}]},{"type":"Label","props":{"y":37,"x":52,"var":"m_lableTop","text":"任何建议都可以提交给我们,您的建议将帮助我们改进产品和服务","fontSize":18,"font":"SimHei","color":"#c24e1b"}},{"type":"TextInput","props":{"y":67,"x":46,"wordWrap":true,"width":500,"var":"m_iContent","valign":"top","skin":"gameHall/img_huangbg_service.png","sizeGrid":"18,18,18,18","promptColor":"#893c0a","prompt":"请输入您宝贵的建议(200字以内)","padding":"10,20,10,20","overflow":"scroll","multiline":true,"height":170,"fontSize":20,"font":"SimHei","color":"#893c0a"}},{"type":"Label","props":{"y":257,"x":66,"var":"m_phone","valign":"top","text":"手机号码","fontSize":24,"font":"SimHei","color":"#9a2e03"}},{"type":"TextInput","props":{"y":247,"x":172,"wordWrap":false,"width":335,"var":"m_iTel","valign":"top","type":"text","skin":"gameHall/img_huangbg_service.png","sizeGrid":"15,15,15,15","restrict":"1234567890","promptColor":"#893c0a","prompt":"请输入您的手机号码","padding":"10,20,10,20","multiline":true,"maxChars":11,"height":40,"fontSize":20,"font":"SimHei","color":"#893c0a"}},{"type":"Button","props":{"y":-28,"x":554,"var":"m_btnClose","skin":"common/btn_close.png"}},{"type":"Button","props":{"y":299,"x":213,"width":176,"var":"m_btnIsOK","skin":"common/btn_Bg.png","height":68},"child":[{"type":"Label","props":{"y":19,"x":58,"var":"m_lableBotton","text":"提交","styleSkin":"comp/label.png","strokeColor":"#3b7204","stroke":2,"fontSize":30,"font":"SimHei","color":"#ffffff"}}]}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}