package dal 
{
	import core.GameIF;
	import laya.utils.Dictionary;
	import model._Gamer.Gamer;
	import model._Room.Room;
	import view.Room.VIPRoomView;
	/**
	 * ...
	 * @author ...
	 */
	public class DalGamer 
	{
		//private var m_nID:int;
		private var m_gamerPool:Dictionary = new Dictionary;
		
		public function DalGamer() 
		{
			
		}
		
		public function AddGamer(gamer:Gamer):void
		{
			m_gamerPool.set(gamer.nGID, gamer);
		}
		
		public function GetGamer(gamerId:*):Gamer
		{
			return m_gamerPool.get(gamerId);
		}

		public function DelGamer(gamerId:*):void
		{
			m_gamerPool.remove(gamerId);
		}
		
		/////////////////////////////////////////////////////
		//public function get nID():int 
		//{
			//return m_nID;
		//}
		//
		//public function set nID(value:int):void 
		//{
			//m_nID = value;
		//}
		
		public function get gamerPool():Dictionary 
		{
			return m_gamerPool;
		}
		
		public function set gamerPool(value:Dictionary):void 
		{
			m_gamerPool = value;
		}
		
	}

}