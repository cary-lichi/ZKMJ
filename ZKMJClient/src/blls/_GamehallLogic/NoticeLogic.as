package blls._GamehallLogic 
{
	import blls.BaseLogic;
	import core.GameIF;
	import core.LogicManager;
	import laya.events.Event;
	import laya.utils.Handler;
	import view.ActiveView.NoticeWindow;
	/**
	 * ...
	 * @author ...
	 */
	public class NoticeLogic extends BaseLogic
	{
		private var m_noticeWindow:NoticeWindow;
		
		public function NoticeLogic() 
		{
			super();
		}
		
		public override function Init():void
		{
			if (m_noticeWindow == null)
			{
				m_noticeWindow = new NoticeWindow;
				m_noticeWindow.Init();
			}
			m_noticeWindow.visible = true;
			
			//注册所有按钮事件
			registerEventClick();
			
		}
		private function registerEventClick():void 
		{
			//关闭按钮
			m_noticeWindow.btn_close.on(Event.CLICK, this, btnCloseClick);
			//Tab选择按钮
			m_noticeWindow.tab_notice.selectHandler=new Handler(this,onSelecte);    
		}
		
		 //点击Tab选择按钮的处理
        private function onSelecte(index:int):void
        {
            //切换ViewStack子页面
           m_noticeWindow.vs_notic.selectedIndex = index;
        }
		
		//关闭按钮点击事件
		private function btnCloseClick():void 
		{
			GameIF.DectiveLogic(LogicManager.NOTICELOGIC);
		}
		public override function Destroy():void
		{
			m_noticeWindow.Destroy();
			m_noticeWindow.destroy();
			m_noticeWindow.visible = false;
			m_noticeWindow = null;	
		}
	}

}