package model._Gamer 
{
	import laya.ui.Component;
	import model._Gamer.GamerLeft;
	import model._Pai.Pai;
	import view.ActiveView._gameItem.Gamer1PutPaiItem;
	
	/**
	 * ...
	 * @author ...
	 */
	public class RoomThreeGamerLeft extends GamerLeft 
	{
		
		public function RoomThreeGamerLeft() 
		{
			super();
			
		}
		protected override function InitGamer():void 
		{
			//设置putpai的属性
			vipRoomView.m_list1PutPai.x = 290;
			vipRoomView.m_list1PutPai.y = 110;
			vipRoomView.m_list1PutPai.repeatY = 8;
		}
	}

}