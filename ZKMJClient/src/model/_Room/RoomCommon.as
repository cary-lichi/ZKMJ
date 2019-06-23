package model._Room 
{
	import model._Room.Room;
	import view.Room.VIPRoomView;
	/**
	 * ...
	 * @author ...
	 */
	public class RoomCommon extends Room 
	{
		
		public function RoomCommon() 
		{
			super();
			
		}
		protected override function InitRoomView():void 
		{
			if (m_RoomView == null)
			{
				m_RoomView = new VIPRoomView;
				
				m_RoomView.Init();
			}
		}
	}

}