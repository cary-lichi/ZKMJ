package dal 
{
	import laya.utils.Dictionary;
	import model._Room.Room;
	/**
	 * ...
	 * @author ...
	 */
	public class DalRoom
	{	
		private var m_myRoomID:String;
		private var m_roomMap:Dictionary = new Dictionary;
		
		public function DalRoom() 
		{
			
		}
		
		public function AddRoom(room:Room):void
		{
			m_roomMap.clear();
			m_myRoomID = room.sRoomID;
			m_roomMap.set(room.sRoomID, room);
		}
		
		//public function GetRoom(roomId:String = m_myRoomID):Room
		//{
			//return m_roomMap.get(roomId);
		//}
		//不是很明白这里为什么不这么写。。by dawenhao
		public function GetRoom():Room
		{
			return m_roomMap.get(m_myRoomID);
		}
		
		public function DelRoom(roomId:String):void
		{
			m_roomMap.remove(roomId);
		}
		
		////////////////////////////////////////////////////////////
		public function get myRoomID():String 
		{
			return m_myRoomID;
		}
		
		public function set myRoomID(value:String):void 
		{
			m_myRoomID = value;
		}
		
	}

}