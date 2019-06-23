package model._Gamer 
{
	import laya.ui.Component;
	import model._Gamer.GamerTop;
	import model._Pai.Pai;
	import view.ActiveView._gameItem.Gamer2PutPaiItem;
	
	/**
	 * ...
	 * @author ...
	 */
	public class RoomTwoGamerTop extends GamerTop 
	{
		
		public function RoomTwoGamerTop() 
		{
			super();
			
		}
		protected override function InitGamer():void 
		{
			//设置putpai的属性
			vipRoomView.m_list2PutPai.x = 305;
			vipRoomView.m_list2PutPai.repeatX = 14;
		}
	}

}