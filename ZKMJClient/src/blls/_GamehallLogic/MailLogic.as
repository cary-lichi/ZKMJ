package blls._GamehallLogic 
{
	import blls.BaseLogic;
	import core.GameIF;
	import core.LogicManager;
	import laya.events.Event;
	import laya.ui.Component;
	import laya.utils.Handler;
	import view.ActiveView.MailContentWindow;
	import view.ActiveView.MailItem;
	import view.ActiveView.MailWindow;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MailLogic extends BaseLogic 
	{
		private var m_meilWindow:view.ActiveView.MailWindow;
		private var m_msgMailResponse:*=null;
		private var m_mailContentWindow:view.ActiveView.MailContentWindow;
		
		public function MailLogic() 
		{
			super();
			
		}
		public override function Init():void
		{
			if (m_meilWindow == null)
			{
				m_meilWindow = new MailWindow;
				m_meilWindow.Init();
			}
			m_meilWindow.visible = true;
			
			if (m_mailContentWindow == null)
			{
				m_mailContentWindow = new MailContentWindow;
				m_mailContentWindow.Init();
			}
			m_mailContentWindow.visible = false;
			
			//注册所有按钮事件
			registerEventClick();
			
			InitDal();
		}
		public function InitDal():void 
		{
			InitMail(m_msgMailResponse);
		}
		//接受message
		public override function OnReceiveMessage(msg:*):void
		{
			if (msg.type == 100)//mailResponse
			{
				OnMailResponse(msg.response.mailResponse);
			}
		}
		
		private function OnMailResponse(message:*):void 
		{
			if (message.nErrorCode == 0)
			{
				m_msgMailResponse = message.mails;	
			}
		}
		private function registerEventClick():void 
		{
			//关闭按钮
			m_meilWindow.m_imgBackBg.on(Event.CLICK, this, btnCloseClick);
			//邮件
			m_meilWindow.m_list.mouseHandler = new Handler(this, OnMailItemClicked);
			
			//邮件按钮
			//关闭
			m_mailContentWindow.m_btnClose.on(Event.CLICK, this, OnMailCloseClicked);
			
			return;
		}
		
		//关闭按钮点击事件
		private function btnCloseClick():void 
		{
			GameIF.DectiveLogic(LogicManager.MAILLOGIC);
		}
		private function OnMailCloseClicked():void 
		{
			m_mailContentWindow.visible = false;
		}
		//初始化邮箱
		public function InitMail(MailArr:Array):void 
		{	
			
			m_meilWindow.m_list.itemRender = MailItem;
			//商品的信息
			m_meilWindow.m_list.array = MailArr;
			m_meilWindow.m_list.renderHandler = new Handler(this, RenderMailList);
			m_meilWindow.m_list.repeatY = MailArr.length;
			m_meilWindow.m_list.scrollBar.value = 0;	
		}
		//渲染方法
		private function RenderMailList(item:Component,index:int):void 
		{
			if (index < m_meilWindow.m_list.length)
			{
				var m_item:MailItem = item as MailItem;
				var data:*= m_meilWindow.m_list.array[index];
				//设置信息
				m_item.SetDal(data);
			}
			
		}
		//邮件
		private function OnMailItemClicked(e:Event):void 
		{
			if (e.type == Event.CLICK)
			{
				var mailItem:MailItem = e.currentTarget as MailItem;
				m_mailContentWindow.InitDal(mailItem.data);
				m_mailContentWindow.visible = true;	
			}
		}
		
		public override function Destroy():void
		{
			if (m_meilWindow)
			{
				m_meilWindow.Destroy();
				m_meilWindow.visible = false;
				m_meilWindow = null;	
			}
			if (m_mailContentWindow)
			{
				m_mailContentWindow.Destroy();
				m_mailContentWindow.visible = false;
				m_mailContentWindow = null;	
			}
		}
	}

}