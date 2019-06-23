package blls 
{
	import core.GameIF;
	import laya.media.SoundManager;
	import model._Pai.Pai;
	/**
	 * ...
	 * @author ...
	 */
	public class SoundLogic 
	{
		private var m_sAudioFormat:String= ".mp3";	
		public function SoundLogic() 
		{
			
		}
		public function Init():void 
		{
			//InitEquip();
		}
		private function InitEquip():void 
		{
			var json:* = GameIF.GetJson();
			if (json["equipType"] == json["equipEnum"]["wxWeb"])
				henderWXWeb();
			if (json["equipType"] == json["equipEnum"]["Web"])
				henderWeb();
			if (json["equipType"] == json["equipEnum"]["Android"])
				henderAndroid();
			if (json["equipType"] == json["equipEnum"]["IOS"])
				henderIOS();
		}
		
		private function henderWXWeb():void 
		{
			m_sAudioFormat = ".mp3";
		}
		
		private function henderWeb():void 
		{
			m_sAudioFormat = ".mp3";
		}
		
		private function henderIOS():void 
		{
			m_sAudioFormat = ".mp3";
		}
		
		private function henderAndroid():void 
		{
			m_sAudioFormat = ".ogg";
		}
		
		//putpai
		/*
		 * sex男为man
		 * 女为woman
		 * */
		public function GetPutPaiSound(pai:Pai,sex:String):void
		{
			InitEquip();
			if (!pai)
			{
				trace("错误提示：当前牌为"+pai);
			}
			var Url:String = "Sound/"+sex+"Sound/pai_t" +pai.nType+ "_v" + pai.nValue+m_sAudioFormat;
			SoundManager.playSound(Url, 1);
		}
		//canPai
		public function GetCanPaiSound(type:String,sex:String):void 
		{
			InitEquip();
			var Url:String = "Sound/"+sex+"Sound/g_"+type+m_sAudioFormat;
			SoundManager.playSound(Url, 1);
		}
		//游戏音效
		public function GetGameSound(type:String):void
		{
			InitEquip();
			var Url:String = "sound/system/g_" +type+m_sAudioFormat;
			SoundManager.playSound(Url, 1);
		}
		//游戏音效大小
		public function ChangeSoundVolume(value:Number):void
		{
		
			SoundManager.setSoundVolume(value);
		}
		
	}

}