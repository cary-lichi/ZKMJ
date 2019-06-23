package dal 
{
	import laya.utils.Dictionary;
	import model.User;
	/**
	 * ...
	 * @author dawenhao
	 */
	public class DalUser 
	{
		private var m_nID:int ;
		private var m_userMap:Dictionary = new Dictionary;
		
		public function DalUser() 
		{
		
		}
		
		public function AddUser(userID:int, user:User):void
		{
			m_nID = userID;
			m_userMap.set(userID, user);
		}
		
		public function GetUser():User
		{
			return m_userMap.get(m_nID);
		}
		
		public function DelUser(userID:int):void
		{
			m_userMap.remove(userID);
		}
		
		public function get nID():int 
		{
			return m_nID;
		}
		
		public function set nID(value:int):void 
		{
			m_nID = value;
		}
	}
}
