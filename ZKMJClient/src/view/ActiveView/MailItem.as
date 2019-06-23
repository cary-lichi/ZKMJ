package view.ActiveView 
{
	import core.GameIF;
	import laya.ui.Box;
	import laya.ui.Image;
	import laya.ui.Label;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MailItem extends Box 
	{
		private var m_imgBg:laya.ui.Image;
		private var m_imgPrompt:laya.ui.Image;
		private var m_imgHead:laya.ui.Image;
		private var m_labelTitle:laya.ui.Label;
		private var m_labelTime:laya.ui.Label;
		private var m_imgMore:laya.ui.Image;
		
		private var m_data:*;
		
		public function MailItem() 
		{
			this.width = 820;
			this.height = 90;
			//背景
			m_imgBg = new Image;
			m_imgBg.skin = "gameHall/img_mailMenu.png";
			m_imgBg.height = 85;
			m_imgBg.width = 815;
			m_imgBg.left = 5;
			m_imgBg.top = 5;
			m_imgBg.sizeGrid = "20,20,20,20";
			this.addChild(m_imgBg);
			
			//新邮件提示
			m_imgPrompt = new Image;
			m_imgPrompt.skin = "gameHall/img_mailPrompt.png";
			m_imgPrompt.top =-5;
			m_imgPrompt.left =-5;
			m_imgPrompt.visible = false;
			m_imgBg.addChild(m_imgPrompt);
			
			//官方头像
			m_imgHead = new Image;
			m_imgHead.skin = "common/img_LOGO.png";
			m_imgHead.left = 10;
			m_imgHead.centerY = 0;
			m_imgBg.addChild(m_imgHead);
			
			//邮件标题
			m_labelTitle = new Label;
			m_labelTitle.top = 15;
			m_labelTitle.left = 100;
			m_labelTitle.fontSize = 24;
			m_labelTitle.color = "#79310e";
			m_imgBg.addChild(m_labelTitle);
			
			//收件时间
			m_labelTime = new Label;
			m_labelTime.left = 100;
			m_labelTime.top = 54;
			m_labelTime.fontSize = 18;
			m_labelTime.color = "#c0ac9e";
			m_imgBg.addChild(m_labelTime);
			
			//查看更多
			m_imgMore = new Image;
			m_imgMore.skin = "gameHall/img_mailMroe.png";
			m_imgMore.left = 770;
			m_imgMore.centerY = 0;
			m_imgBg.addChild(m_imgMore);
			
			
		}
		public function SetDal(data:*):void 
		{
			m_data = data;
			var mail:JSON = GameIF.GetJson()["mail"][data.nType];
			m_labelTitle.text = mail["title"];
			m_labelTime.text = data.sTime;
		}
		
		public function get data():* 
		{
			return m_data;
		}
		
		public function set data(value:*):void 
		{
			m_data = value;
		}
	}

}