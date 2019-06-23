package blls 
{
	/**
	 * ...
	 * @author ...
	 */
	public class BaseLogic 
	{
		
		public function BaseLogic() 
		{
			
		}
		
		public function OnLogicEnter():void
		{
			Init();
		}
		
		public function OnLogicQuit():void
		{
			Destroy();
		}
		
		public function Init():void 
		{
			
		}
		
		public function OnReceiveMessage(msg:*):void
		{
			
		}
		
		public function Destroy():void 
		{
			
		}
	}

}