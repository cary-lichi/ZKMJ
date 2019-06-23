package model._Room 
{
	import model._Room.Room;
	import view.Room.HappyRoomView;
	/**
	 * ...
	 * @author ...
	 */
	public class RoomHappy extends Room 
	{
		
		public function RoomHappy() 
		{
			super();
			
		}
		protected override function InitRoomView():void 
		{
			
			if (m_RoomView == null)
			{
				m_RoomView = new HappyRoomView;
				m_RoomView.Init();
			}
			
		}
	}

}