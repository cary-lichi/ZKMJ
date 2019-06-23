package blls._Game 
{
	import blls.BaseLogic;
	import core.GameIF;
	import core.LogicManager;
	import laya.events.Event;
	import model._Gamer.Gamer;
	import model.User;
	import view.ActiveView.GamerInfoDia;
	import view.AlphaWindowView;
	/**
	 * ...
	 * @author ...
	 */
	public class GamerInfoLogic extends BaseLogic
	{
		private var m_gamerInfoDia:GamerInfoDia;
		private var m_alphaWindowView:AlphaWindowView;
		public function GamerInfoLogic() 
		{
			super();
		}
		
		public override function Init():void
		{
			if (m_alphaWindowView == null)
			{
				m_alphaWindowView = new AlphaWindowView;
				m_alphaWindowView.Init();
			}
			m_alphaWindowView.visible = false;
			if (m_gamerInfoDia == null)
			{
				m_gamerInfoDia = new GamerInfoDia;
				m_gamerInfoDia.Init();
			}
			m_gamerInfoDia.visible = false;
			
			//注册所以点击事件
			RegisterEventClick()
		}
		//注册所以点击事件
		private function RegisterEventClick():void 
		{
			m_gamerInfoDia.m_btnClose.on(Event.CLICK, this, onCloseClicked);
			m_alphaWindowView.on(Event.CLICK,this,onCloseClicked);
			
		}
		public function ShowGamerInfo():void
		{
			m_gamerInfoDia.visible = true;
			m_alphaWindowView.visible = true;
		}
		public function HideGamerInfo():void 
		{
			m_gamerInfoDia.visible = false;
			m_alphaWindowView.visible = false;
		}
		public function DalInit(gamer:*):void 
		{
			m_gamerInfoDia.m_lableID.text = gamer.nGID;
			m_gamerInfoDia.m_lableNick.text = gamer.sNick;
			m_gamerInfoDia.m_imgHeadimg.skin = gamer.sHeadimg;
			m_gamerInfoDia.m_LabAddress.text = gamer.sAddress;
		}
		private function onCloseClicked():void 
		{
			HideGamerInfo();
		}
		
		public override function Destroy():void
		{
			if (m_alphaWindowView != null)
			{
				m_alphaWindowView.visible = false;
				m_alphaWindowView.Destroy();
				m_alphaWindowView = null;
			}
			if (m_gamerInfoDia)
			{			
				m_gamerInfoDia.visible = false;
				m_gamerInfoDia.Destroy();
				m_gamerInfoDia = null;	
			}
		}
		
	}

}