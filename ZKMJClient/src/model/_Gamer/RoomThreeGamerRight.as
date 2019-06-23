package model._Gamer 
{
	import laya.ui.Component;
	import model._Gamer.GamerRight;
	import model._Pai.Pai;
	import view.ActiveView._gameItem.Gamer3PutPaiItem;
	
	/**
	 * ...
	 * @author ...
	 */
	public class RoomThreeGamerRight extends GamerRight 
	{
		
		public function RoomThreeGamerRight() 
		{
			super();
		}
		protected override function InitGamer():void 
		{
			//设置putpai的属性
			vipRoomView.m_list3PutPai.x = 668;
			vipRoomView.m_list3PutPai.y = 80;
			vipRoomView.m_list3PutPai.repeatY = 8;
		}
	}

}