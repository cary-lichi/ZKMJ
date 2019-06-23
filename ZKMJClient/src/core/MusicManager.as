package core 
{
	import blls.BaseLogic;
	import blls.MusicLogic;
	import blls.SoundLogic;
	import laya.utils.Dictionary;
	import model._Pai.Pai;
	/**
	 * ...
	 * @author ...
	 */
	public class MusicManager 
	{
		//音乐
		private var m_musicLogic:MusicLogic;
		//音效
		private var m_soundLogic:SoundLogic;
		
		public function MusicManager() 
		{
			
		}
		
		public function Init():void
		{
			if (m_musicLogic == null)
			{
				m_musicLogic = new MusicLogic;
			}
			if (m_soundLogic == null)
			{
				m_soundLogic = new SoundLogic;
			}
			SetMusic();
		}
		//设置初始的背景音乐。由配置文件确定
		private function SetMusic():void
		{
			//GameIF.GetLanguageMusic(GetBgMusicName());
			GameIF.GetBgMusic();
			GameIF.SetMusicVolume(GameIF.GetMusicVolume());
			GameIF.SetSoundVolume(GameIF.GetSoundVolume());
		}
		//putpai音效
		public function GetPutPaiSound(pai:Pai,gender:String):void
		{ 
			m_soundLogic.GetPutPaiSound(pai,gender);
		}
		//canpai音效
		public function GetCanPaiSound(type:String,gender:String):void 
		{
			m_soundLogic.GetCanPaiSound(type,gender);
		}
		//获取背景音乐
		public function GetBgMusic():void 
		{
			m_musicLogic.GetBgMusic();
		}
		//游戏音效
		public function GetGameSound(type:String):void
		{
			m_soundLogic.GetGameSound(type);
		}
		//停止播放
		public function StopMusic():void
		{
			m_musicLogic.StopMusic();
		}
		
		//更改音乐音量value:0-1
		public function ChangeMusicVolume(value:Number):void
		{
			m_musicLogic.ChangeMusicVolume(value);
		}
		//更改音乐音量value:0-1
		public function ChangeSoundVolume(value:Number):void
		{
			m_soundLogic.ChangeSoundVolume(value);
		}
	}

}