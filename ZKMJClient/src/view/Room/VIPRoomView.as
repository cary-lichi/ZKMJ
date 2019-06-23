package view.Room 
{
	import view.Room.RoomView;
	/**
	 * ...
	 * @author ...
	 */
	public class VIPRoomView extends RoomView
	{
		public function VIPRoomView() 
		{
			super();
		}
		protected override function InitView():void 
		{
			super.InitView();
			this.m_btnDelegateOn.visible = false;
		}
	}

}