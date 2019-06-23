package blls 
{
	import core.MusicManager;
	import laya.media.SoundManager;
	/**
	 * ...
	 * @author ...
	 */
	public class MusicLogic
	{
		
		public function MusicLogic() 
		{
			
		}
		
		public function GetBgMusic():void
		{
			
			SoundManager.playMusic("sound/system/bg_music0.mp3", 0);
			//__JS__('document.addEventListener("WeixinJSBridgeReady",function(){audio.play();},false)');
		}
		
		public function StopMusic():void
		{
			SoundManager.stopMusic();
		}
		
		public function ChangeMusicVolume(value:Number):void
		{
			SoundManager.setMusicVolume(value);
		}
		
	}

}