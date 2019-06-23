package view.ActiveView 
{
	import laya.ui.Box;
	import laya.ui.Button;
	import laya.ui.Image;
	/**
	 * ...
	 * @author ...
	 */
	public class ListMoreView extends Box
	{
		protected var m_spBg:Image;
		
		protected var m_btnAboutUs:Button;
		protected var m_btnService:Button;
		protected var m_btnSetting:Button;
		protected var m_btnPlayPattern:Button;
		protected var m_btnMoreGame:Button;
		protected var m_btnShare:Button;
		
		public function ListMoreView() 
		{
			//如果不限制宽高的话，他移动的空间也变成了它的地盘。
			//故控制宽高，其余位置应该是透明层的。
			this.height = 304;
			this.width = 195;
			
			m_spBg = new Image;
			m_spBg.skin = "share/selectbg.png";
			m_spBg.height = 304;
			m_spBg.width = 195;
			m_spBg.top = 95;
			m_spBg.left = 890;
			this.addChild(m_spBg);
			
			m_btnAboutUs = new Button;
			m_btnAboutUs.skin = "share/about.png";
			m_btnAboutUs.width = 188;
			m_btnAboutUs.height = 32;
			m_btnAboutUs.top = 20;
			m_btnAboutUs.stateNum = 1;
			m_spBg.addChild(m_btnAboutUs);
			
			m_btnService = new Button;
			m_btnService.skin = "share/service.png";
			m_btnService.width = 188;
			m_btnService.height = 32;
			m_btnService.top = 70;
			m_btnService.stateNum = 1;
			m_spBg.addChild(m_btnService);
			
			m_btnSetting = new Button;
			m_btnSetting.skin = "share/set.png";
			m_btnSetting.width = 188;
			m_btnSetting.height = 32;
			m_btnSetting.top = 120;
			m_btnSetting.stateNum = 1;
			m_spBg.addChild(m_btnSetting);
			
			//玩法
			m_btnPlayPattern = new Button;
			m_btnPlayPattern.skin = "share/game.png";
			m_btnPlayPattern.width = 188;
			m_btnPlayPattern.height = 32;
			m_btnPlayPattern.top = 165;
			m_btnPlayPattern.stateNum = 1;
			m_spBg.addChild(m_btnPlayPattern);
			
			//更多游戏
			m_btnMoreGame = new Button;
			m_btnMoreGame.skin = "share/games.png";
			m_btnMoreGame.width = 188;
			m_btnMoreGame.height = 32;
			m_btnMoreGame.top = 215;
			m_btnMoreGame.stateNum = 1;
			m_spBg.addChild(m_btnMoreGame);
			
			m_btnShare = new Button;
			m_btnShare.skin = "share/shar.png";
			m_btnShare.width = 188;
			m_btnShare.height = 32;
			m_btnShare.top = 260;
			m_btnShare.stateNum = 1;
			m_spBg.addChild(m_btnShare);
		}
		
		public function Init():void
		{
			Laya.stage.addChild(this);
		}
		
		public function Destroy():void
		{
			Laya.stage.removeChild(this);
			this.destroy();
		}
		
		//----------------接口-----------------------------------------------------
		public function get btnAboutUs():Button 
		{
			return m_btnAboutUs;
		}
		
		public function set btnAboutUs(value:Button):void 
		{
			m_btnAboutUs = value;
		}
		
		public function get btnService():Button 
		{
			return m_btnService;
		}
		
		public function set btnService(value:Button):void 
		{
			m_btnService = value;
		}
		
		public function get btnSetting():Button 
		{
			return m_btnSetting;
		}
		
		public function set btnSetting(value:Button):void 
		{
			m_btnSetting = value;
		}
		
		public function get btnPlayPattern():Button 
		{
			return m_btnPlayPattern;
		}
		
		public function set btnPlayPattern(value:Button):void 
		{
			m_btnPlayPattern = value;
		}
		
		public function get btnMoreGame():Button 
		{
			return m_btnMoreGame;
		}
		
		public function set btnMoreGame(value:Button):void 
		{
			m_btnMoreGame = value;
		}
		
		public function get btnShare():Button 
		{
			return m_btnShare;
		}
		
		public function set btnShare(value:Button):void 
		{
			m_btnShare = value;
		}
		
	}

}