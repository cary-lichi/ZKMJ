package view 
{
	import core.Constants;
	import core.GameIF;
	import core.LogicManager;
	import core.UiManager;
	import laya.display.Node;
	import laya.display.Stage;
	import laya.events.Event;
	import laya.ui.Image;
	import laya.utils.Browser;
	import tool.Tool;
	import ui.MahjongRoot.LoginMainPageUI;
	/**
	 * ...
	 * @author ...
	 */
	public class LoginView extends LoginMainPageUI
	{
		
		public function LoginView() 
		{
			super();
		}
		
		public function Init():void
		{
			var viewLogin:LoginView = this;
			Laya.stage.addChild(this);
			
			if (Constants.isAdaptPhone)
			{
				reSetLoginViewUi();
			
				Browser.window.addEventListener("resize", function():void {
					Laya.timer.once(1000, viewLogin, reSetLoginViewUi);
				});
			}
		}
		
		private function reSetLoginViewUi():void
		{
			Tool.Adaptation(this);
			//Constants.setBGFullScreen(m_root);
			//
			//Constants.setBGFullScreen(m_backImage);
			//
			//Constants.setUiWidth(m_logo, GameIF.GetJson()["LoginView"]["m_logo"]["width"]);
			//Constants.setUiHeight(m_logo, GameIF.GetJson()["LoginView"]["m_logo"]["height"]);
			//m_logo.centerX = 0;
			//Constants.setUiTop(m_logo, GameIF.GetJson()["LoginView"]["m_logo"]["top"]);
			//
			//btn_loginWX.centerX = 0;
			//
			////数值不可修改为设计位置。
			////m_ckeckBox.left = (screenWidth * 450) / 1136;
			//
			////m_btnUserAgreement.left = (screenWidth * 488) / 1136;
			//
			//m_lable1.centerX = 0;
			//m_lable2.centerX = 0;
		}
		
		public function Destroy():void
		{
			Laya.stage.removeChild(this);
		}
	}

}