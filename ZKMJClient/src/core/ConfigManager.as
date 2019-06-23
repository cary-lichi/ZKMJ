package core
{
	import config.ConfigGame;
	import laya.events.Event;
	import laya.net.Loader;
	import laya.net.LocalStorage;
	import laya.utils.Handler;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ConfigManager
	{
		private var m_config:Object;
		private var m_strBgMusicName:String;
		private var m_json:Object;
		
		public function ConfigManager()
		{
		
		}
		public function Init():void 
		{
			//设置初始的背景音乐。由配置文件确定
			onLoaded();
			var configGame:ConfigGame = new ConfigGame();
			//m_json = configGame.GetJson();
			Laya.loader.load("config.json", Handler.create(this, onJsonLoad), null, Loader.JSON);
		}
		
		
		//加载json
		private function onJsonLoad():void 
		{
            m_json= Laya.loader.getRes("config.json");
		}
		//加载LocalStorage
		public function onLoaded():void
		{
			if (!LocalStorageGetJSON("Config"))
			{
				m_config = {"Language": "Putonghua", "MusicVolume": 30,"SoundVolume": 30};
				var str:String = JSON.stringify(m_config);
				LocalStorageSetJSON("Config", str);
			}
			//trace("LocalStorage获取成功");
		}
		
		public function GetBgMusicName():String
		{
			m_strBgMusicName = LocalStorageGetJSON("Config").Language;
			return m_strBgMusicName;
			trace(m_strBgMusicName);
		}
		public function GetMusicVolume():int
		{
			
			return  LocalStorageGetJSON("Config").MusicVolume;
		}
		public function SetBgMusicName(name:String):void
		{
			m_config = LocalStorageGetJSON("Config")
			m_config.Language = name;
			var str:String = JSON.stringify(m_config);
			LocalStorageSetJSON("Config", str);
		}
		public function SetMusicVolume(value:int):void
		{
			m_config = LocalStorageGetJSON("Config")
			m_config.MusicVolume = value;
			var str:String = JSON.stringify(m_config);
			LocalStorageSetJSON("Config", str);
			GameIF.getInstance().musicManager.ChangeMusicVolume(value / 100);
		}
		public function GetSoundVolume():int
		{
			return  LocalStorageGetJSON("Config").SoundVolume;
		}
		public function SetSoundVolume(value:int):void
		{
			m_config = LocalStorageGetJSON("Config")
			m_config.SoundVolume = value;
			var str:String = JSON.stringify(m_config);
			LocalStorageSetJSON("Config", str);
			GameIF.getInstance().musicManager.ChangeSoundVolume(value / 100);
		}
		private function LocalStorageGetJSON(key:String):Object 
		{
			if (LocalStorage.support)
			{
				return LocalStorage.getJSON(key);
			}
			else
			{
				m_config = {"Language": "Putonghua", "MusicVolume": 30,"SoundVolume": 30};
				return m_config;
			}
			
		}
		private function LocalStorageSetJSON(key:String,value:String):void 
		{
			if (LocalStorage.support)
			{
				if (value.length < 100000)
				{
					LocalStorage.setItem(key, value);
				}
			}
		}
		public function get json():Object 
		{
			return m_json;
		}


	}

}