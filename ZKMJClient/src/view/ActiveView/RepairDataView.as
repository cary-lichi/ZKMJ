package view.ActiveView 
{
	import laya.ui.Box;
	import laya.ui.Button;
	import laya.ui.Image;
	import laya.ui.TextInput;
	/**
	 * ...
	 * @author ...
	 */
	public class RepairDataView extends Box
	{
		protected var m_imgBg:Image;
		protected var m_inputBindPhone:TextInput;
		protected var m_inputVerificationCode:TextInput;
		protected var m_inputName:TextInput;
		protected var m_inputPersonId:TextInput;
		protected var m_inputAddress:TextInput;
		protected var m_inputWeChat:TextInput;
		protected var m_btnSendVerification:Button;
		protected var m_btnConfirm:Button;
		protected var m_btnClose:Button;
		
		
		public function RepairDataView() 
		{
			this.width = 730;
			this.height = 473;
			
			m_imgBg = new Image;
			m_imgBg.skin = "common/Pnumbg.png";
			m_imgBg.x = 1136 / 2 - 730 / 2;
			m_imgBg.y = 720 / 2 - 473 / 2;
			this.addChild(m_imgBg);
			
			m_inputBindPhone = new TextInput;
			m_inputBindPhone.skin = "common/input1.png";
			m_inputBindPhone.top = 85;
			m_inputBindPhone.left = 190;
			m_inputBindPhone.width = 300;
			m_inputBindPhone.maxChars = 18;
			m_imgBg.addChild(m_inputBindPhone);
			
			m_inputVerificationCode = new TextInput;
			m_inputVerificationCode.skin = "common/input1.png";
			m_inputVerificationCode.top = 130;
			m_inputVerificationCode.left = 190;
			m_inputVerificationCode.width = 300;
			m_inputVerificationCode.maxChars = 18;
			m_imgBg.addChild(m_inputVerificationCode);
			
			m_inputName = new TextInput;
			m_inputName.skin = "common/input1.png";
			m_inputName.top = 170;
			m_inputName.left = 190;
			m_inputName.width = 300;
			m_inputName.maxChars = 18;
			m_imgBg.addChild(m_inputName);
			
			m_inputPersonId = new TextInput;
			m_inputPersonId.skin = "common/input1.png";
			m_inputPersonId.top = 215;
			m_inputPersonId.left = 190;
			m_inputPersonId.width = 300;
			m_inputPersonId.maxChars = 18;
			m_imgBg.addChild(m_inputPersonId);
			
			m_inputAddress = new TextInput;
			m_inputAddress.skin = "common/input1.png";
			m_inputAddress.top = 260;
			m_inputAddress.left = 190;
			m_inputAddress.width = 300;
			m_inputAddress.height *= 2;
			m_inputAddress.maxChars = 18;
			m_imgBg.addChild(m_inputAddress);
			
			m_inputWeChat = new TextInput;
			m_inputWeChat.skin = "common/input1.png";
			m_inputWeChat.top = 330;
			m_inputWeChat.left = 190;
			m_inputWeChat.width = 200;
			m_inputWeChat.maxChars = 18;
			m_imgBg.addChild(m_inputWeChat);
			
			m_btnSendVerification = new Button;
			m_btnSendVerification.skin = "common/send.png";
			m_btnSendVerification.top = 75;
			m_btnSendVerification.left = 520;
			m_btnSendVerification.stateNum = 1;
			m_imgBg.addChild(m_btnSendVerification);
			
			m_btnConfirm = new Button;
			m_btnConfirm.skin = "common/pque.png";
			m_btnConfirm.top = 410;
			m_btnConfirm.left = 730 / 2 - 112 / 2;
			m_btnConfirm.stateNum = 1;
			m_imgBg.addChild(m_btnConfirm);
			
			m_btnClose = new Button;
			m_btnClose.skin = "common/pclose.png";
			m_btnClose.top = 30;
			m_btnClose.left = 705;
			m_btnClose.stateNum = 1;
			m_imgBg.addChild(m_btnClose);
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
		
		
		//------------------------------接口---------------------------------------
		public function get inputBindPhone():TextInput 
		{
			return m_inputBindPhone;
		}
		
		public function set inputBindPhone(value:TextInput):void 
		{
			m_inputBindPhone = value;
		}
		
		public function get inputVerificationCode():TextInput 
		{
			return m_inputVerificationCode;
		}
		
		public function set inputVerificationCode(value:TextInput):void 
		{
			m_inputVerificationCode = value;
		}
		
		public function get inputName():TextInput 
		{
			return m_inputName;
		}
		
		public function set inputName(value:TextInput):void 
		{
			m_inputName = value;
		}
		
		public function get inputPersonId():TextInput 
		{
			return m_inputPersonId;
		}
		
		public function set inputPersonId(value:TextInput):void 
		{
			m_inputPersonId = value;
		}
		
		public function get inputAddress():TextInput 
		{
			return m_inputAddress;
		}
		
		public function set inputAddress(value:TextInput):void 
		{
			m_inputAddress = value;
		}
		
		public function get inputWeChat():TextInput 
		{
			return m_inputWeChat;
		}
		
		public function set inputWeChat(value:TextInput):void 
		{
			m_inputWeChat = value;
		}
		
		public function get btnSendVerification():Button 
		{
			return m_btnSendVerification;
		}
		
		public function set btnSendVerification(value:Button):void 
		{
			m_btnSendVerification = value;
		}
		
		public function get btnConfirm():Button 
		{
			return m_btnConfirm;
		}
		
		public function set btnConfirm(value:Button):void 
		{
			m_btnConfirm = value;
		}
		
		public function get btnClose():Button 
		{
			return m_btnClose;
		}
		
		public function set btnClose(value:Button):void 
		{
			m_btnClose = value;
		}
		
	}

}