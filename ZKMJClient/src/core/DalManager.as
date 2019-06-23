package core 
{
	import dal.DalGamer;
	import dal.DalPai;
	import dal.DalRoom;
	import dal.DalUser;
	import model._Room.Room;
	/**
	 * ...
	 * @author dawenhao
	 */
	public class DalManager 
	{
		private var m_daluser:DalUser
		private var m_dalRoom:DalRoom;
		
		public function DalManager() 
		{
			
		}
		
		public function Init():void
		{
			if (m_daluser == null)
			{
				m_daluser = new DalUser;
			}
			
			if (m_dalRoom == null)
			{
				m_dalRoom = new DalRoom;
			}
		}
		public function Destroy():void
		{
			m_daluser = null;
			m_dalRoom = null;
		}
		////////////////////////////////////////////////////////////////////////
		public function get dalRoom():DalRoom 
		{
			return m_dalRoom;
		}
		
		public function set dalRoom(value:DalRoom):void 
		{
			m_dalRoom = value;
		}
		
		public function get daluser():DalUser 
		{
			return m_daluser;
		}
		
		public function set daluser(value:DalUser):void 
		{
			m_daluser = value;
		}
	}

}