package model._Gamer 
{
	import laya.ui.Component;
	import model._Gamer.GamerBottom;
	import model._Pai.Pai;
	import view.ActiveView._gameItem.Gamer0PutPaiItem;
	
	/**
	 * ...
	 * @author ...
	 */
	public class RoomTwoGamerBottom extends GamerBottom 
	{
		
		public function RoomTwoGamerBottom() 
		{
			super();
			
		}	
		protected override function InitGamer():void 
		{
			//设置putpai的属性
			vipRoomView.m_listPutPai.x = 265;
			vipRoomView.m_listPutPai.repeatX = 14;
		}
	}

}