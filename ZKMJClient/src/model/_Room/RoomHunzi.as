package model._Room 
{
	import blls._Game.RoomLogic;
	import core.GameIF;
	import core.LogicManager;
	import model._Gamer.Gamer;
	import model._Pai.Pai;
	import view.Room.HunziRoomView;
	/**
	 * ...
	 * @author ...
	 */
	public class RoomHunzi extends Room 
	{
		
		public function RoomHunzi() 
		{
			super();
			
		}
		protected override function InitRoomView():void 
		{
			
			if (m_RoomView == null)
			{
				m_RoomView = new HunziRoomView;
				m_RoomView.Init();
			}
			
		}
		public override function OnBaopaiShow(message:*):void 
		{
			m_BaoPai = new Pai();
			m_BaoPai.nType = message.baopai.nType;
			m_BaoPai.nValue = message.baopai.nValue;
			m_RoomView.BaoPaiShowStart(m_BaoPai,BaoPaiShowStop,this);
		}
		public override function BaoPaiShowStop():void
		{
			for each(var gamer:Gamer in m_dalGamer.gamerPool.values)
			{
				gamer.RenderBaoPai(m_BaoPai);
			}
			
			var logic:RoomLogic = GameIF.GetLogic(LogicManager.VIPROOMLOGIC) as RoomLogic;
			logic.stateMsgHandle = false;
			logic.HandleMsgList();
		}
	}

}