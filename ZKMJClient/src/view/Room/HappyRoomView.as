package view.Room 
{
	import view.Room.RoomView;
	/**
	 * ...
	 * @author ...
	 */
	public class HappyRoomView extends RoomView 
	{
		
		public function HappyRoomView() 
		{
			super();
		}
		protected override function InitView():void 
		{
			super.InitView();
			//欢乐城专属
			m_imgRoomInfo.visible = false;
			m_btnQuitRoom.visible = true;
			m_imgPaiNum.width = 20;
			m_imgPaiNum.height = 30;
			m_imgPaiNum.x = 17;
			m_imgPaiNum.y = 97;
			
			m_labPaiNum.fontSize = 24;
			m_labPaiNum.x = 45;
			m_labPaiNum.y = 100;
			
			m_labCurTime.fontSize = 24;
			m_labCurTime.x = 88;
			m_labCurTime.y = 30;
			
			//隐藏玩家头像下的金币
			m_imgScore0.visible = false;
			m_imgScore1.visible = false;
			m_imgScore2.visible = false;
			m_imgScore3.visible = false;
			
		}
	}

}