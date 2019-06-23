package blls._GamehallLogic._ServiceLogic 
{
	import blls.BaseLogic;
	import core.GameIF;
	import core.LogicManager;
	import laya.events.Event;
	import view.ActiveView.ProposalDia;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ProposalLogic extends BaseLogic 
	{
		private var m_proposalDia:ProposalDia;
		
		public function ProposalLogic() 
		{
			super();
			
		}
		public override function Init():void
		{
			if (m_proposalDia == null)
			{
				m_proposalDia = new ProposalDia;
				m_proposalDia.Init();
			}
			m_proposalDia.visible = true;
			
			//注册所有按钮事件
			registerEventClick();
		}
		
		private function registerEventClick():void 
		{
			//关闭按钮
			m_proposalDia.m_btnClose.on(Event.CLICK, this, onCloseClick);
			//确定按钮
			m_proposalDia.m_btnIsOK.on(Event.CLICK, this, onIsOKClicked);
		}
		
		
		//确定按钮
		private function onIsOKClicked():void 
		{
			var tel:String = m_proposalDia.m_iTel.text; 
			var content:String = m_proposalDia.m_iContent.text;
			var pattern:RegExp =/^[1][3,4,5,7,8][0-9]{9}$/;
			
			if (tel.length == 0)
			{
				GameIF.GetPopUpDia("请输入手机号");
			}
			else
			{
				if (!pattern.test(tel))
				{
					GameIF.GetPopUpDia("您所输入的号码有误");
				}
				else
				{
					if (tel && content)
					{
						GameIF.DectiveLogic(LogicManager.PROPOSALDIA);
						GameIF.GetPopUpDia("你的建议已提交\n感谢你的支持");
					}
					else
					{
						GameIF.GetPopUpDia("请填写完整信息");
					}
				}
			}
		}
		
		//关闭按钮点击事件
		private function onCloseClick():void 
		{
			GameIF.DectiveLogic(LogicManager.PROPOSALDIA);
			GameIF.ActiveLogic(LogicManager.SERVICELOGIC);
		}
		
		public override function Destroy():void
		{
			m_proposalDia.Destroy();
			m_proposalDia.destroy();
			m_proposalDia.visible = false;
			m_proposalDia = null;	
		}
	}

}