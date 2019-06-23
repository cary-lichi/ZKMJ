package blls 
{
	import core.GameIF;
	import core.LogicManager;
	import laya.ani.swf.MovieClip;
	import laya.events.Event;
	import laya.ui.Image;

	/**
	 * ...
	 * @author dawenhao
	 */
	public class WinningLogic extends BaseLogic
	{	
		public function WinningLogic() 
		{
			super();
		}
		public override function Init():void
		{
			createMovieClip();
		}
		private function createMovieClip():void
		{
			//var mc:MovieClip = new MovieClip();
			//mc.load("h5/demo.swf");
			
			
			var mc:Image = new Image;
			mc.skin = "common/m_diamondsMax.png";
			mc.centerX = 0;
			mc.centerY = 0;
			mc.anchorX = 0.5;
			mc.anchorY = 0.5;
			Laya.stage.addChild(mc);
			
			//var title:Image = new Image;
			//mc.skin = "common/m_diamondsMax.png";
			//mc.centerX = 0;
			//mc.centerY = 0;
			//mc.anchorX = 0.5;
			//mc.anchorY = 0.5;
			//Laya.stage.addChild(mc);
		}
		public override function Destroy():void
		{

		}
	
	}

}