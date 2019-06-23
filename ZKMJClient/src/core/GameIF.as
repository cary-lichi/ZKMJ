package core 
{
	import blls.BaseLogic;
	import dal.DalUser;
	import laya.events.Event;
	import laya.utils.Stat;
	import model._Pai.Pai;
	import model._Room.Room;
	import model.User;
	import network.NetworkManager;
	import view.ActiveView.PopUpDia;
	import view.AlphaWindowView;
	import view.BlackWindowView;
	/**
	 * ...
	 * @author ...
	 */
	public class GameIF 
	{
		private static var instance:GameIF = null;
		
		private var m_logicManager:LogicManager;
		private var m_uiManager:UiManager;
		private var m_musicManager:MusicManager;
		private var m_configManager:ConfigManager;
		private var m_dalmanager:DalManager;
		private var m_networkManager:NetworkManager;
		private var m_animationAltas:AnimationAltas;
		private var m_sdkManager:SdkManager;
		
		public function GameIF() 
		{
			
		}
		
		public static function getInstance():GameIF
		{
            if ( instance == null )
			{
                instance = new GameIF();  
            }  
            return instance;  
        }
		
		public function Init() :void
		{
			//显示帧率
			//Stat.show();
			InitManagers();
			m_configManager.Init();
			m_sdkManager.Init();
			m_logicManager.RegisterAllLogics();
			m_musicManager.Init();
			//m_configManager.LoadConfig(this, OnConfigLoaded);
			m_dalmanager.Init();
		}
		public function Destroy() :void
		{
			m_logicManager.UnRegisterAllLogics();
			m_dalmanager.Destroy();
		}

		public function InitManagers():void
		{
			m_sdkManager = new SdkManager;
			m_logicManager = new LogicManager;
			m_uiManager = new UiManager;
			m_musicManager = new MusicManager;
			if (m_configManager == null)
			{
				m_configManager = new ConfigManager;
				m_configManager.Init();
			}
			m_dalmanager = new DalManager;
			m_networkManager = new NetworkManager;
			m_animationAltas = new AnimationAltas;
		}
		//重新开始游戏
		public static function RestartGame():void
		{
			QuitGame();
			GameIF.instance.Init();
			GameIF.ActiveLogic(LogicManager.LOGINLOGIC);
		}
		//退出游戏
		public static function QuitGame():void
		{
			GameIF.getInstance().networkManager.StopLoginHeart();
			Laya.stage.removeChildren(0, Laya.stage._childs.length);
		}
		//获取位置信息
		public static function GetLocation(LocationCallBack:Function,caller):void 
		{
			__JS__('GetLocation(LocationCallBack,caller)');//  定位
		}
		//开启定位
		public static function SetLocation(user:*,bIsLocation:Boolean):void 
		{
			user.bIsLocation = bIsLocation;
			user.sAddress = bIsLocation? Constants.sSelfAddress:"没有开启定位";
		}
		////位置信息回调
		//private function LocationCallBack(accuracy:Number,lng:String,lat:String,address:String):void
		//{
			//Constants.sSelfLng = lng;
			//Constants.sSelfLat = lat;
			//Constants.sSelfAddress = address;
			//Constants.bIsLocation = accuracy != null;
			////Constants.bIsLocation = true;
		//}
		//获取某个逻辑对象
		public static function GetLogic(id:int):BaseLogic
		{
			return getInstance().logicManager.GetLogic(id);
		}
		
		//封装使逻辑可用
		public static function ActiveLogic(id:int):void
		{
			return getInstance().logicManager.ActiveLogic(id);
		}
		
		//封装使逻辑不可用
		public static function DectiveLogic(id:int):void
		{
			return getInstance().logicManager.DectiveLogic(id);
		}
		
		//封装弹窗
		public static function GetPopUpDia(title:String,func:Function = null,claller:*=null):PopUpDia
		{
			return getInstance().uiManager.GetPopUpDia(title,func,claller);
		}
		//封装分享成功弹窗
		//html  为html格式
		public static function GetShareSuccessDia(html:String,func:Function = null,claller:*=null):PopUpDia
		{
			return getInstance().uiManager.GetShareSuccessDia(html,func,claller);
		}
		//封装弹窗
		public static function ClosePopUpDia():void
		{
			return getInstance().uiManager.ClosePopUpDia();
		}
		
		//封装获取黑幕
		public static function GetBlackWindowView():BlackWindowView
		{
			return getInstance().uiManager.GetBlackWindowView();
		}
		
		//封装获取透明层
		public static function GetAlphaWindowView():AlphaWindowView
		{
			return getInstance().uiManager.GetAlphaWindowView();
		}
		
		//封装关闭透明层
		public static function CloseAlphaWindowView():void
		{
			getInstance().uiManager.GetAlphaWindowView().visible = false;
		}
		
		//封装关闭黑幕
		public static function CloseBlackWindowView():void
		{
			getInstance().uiManager.GetBlackWindowView().visible = false;
		}
		
		public static function GetDalManager():DalManager
		{
			return getInstance().dalmanager;
		}
		
		//封装设置音量大小
		public static function SetMusicVolume(value:int):void
		{
			 getInstance().configManager.SetMusicVolume(value);
		}
		
		//封装获取音量大小
		public static function GetMusicVolume():int
		{
			 return getInstance().configManager.GetMusicVolume();
		}
		//封装设置音效大小
		public static function SetSoundVolume(value:int):void
		{
			 getInstance().configManager.SetSoundVolume(value);
		}
		
		//封装获取音效大小
		public static function GetSoundVolume():int
		{
			 return getInstance().configManager.GetSoundVolume();
		}
		//封装设置语言类型
		public static function SetBgMusicName(name:String):void 
		{
			getInstance().configManager.SetBgMusicName(name);
		}

		//封装获取语言类型
		public static function GetBgMusicName():String 
		{
			return getInstance().configManager.GetBgMusicName();
		}
		//背景音乐
		public static function GetBgMusic():void 
		{
			getInstance().musicManager.GetBgMusic();
		}
		//播放那张牌的音效
		public static function GetPutPaiSound(pai:Pai,gender:String):void 
		{
			getInstance().musicManager.GetPutPaiSound(pai,gender);
		}
		//播放那个操作的音效
		public static function GetCanPaiSound(type:String,gender:String):void 
		{
			getInstance().musicManager.GetCanPaiSound(type,gender);
		}
		//播放系统的音效
		public static function GetGameSound(type:String):void 
		{
			getInstance().musicManager.GetGameSound(type);
		}
		
		//获取JSON配置文件
		public static function GetJson():Object 
		{
			return getInstance().configManager.json;
		}
		
		
		//获取user对象
		public static function GetUser():User
		{
			return getInstance().dalmanager.daluser.GetUser();
		}
		//获取Room对象
		public static function GetRoom():Room 
		{
			return getInstance().dalmanager.dalRoom.GetRoom();
		}
		
		//------------------------接口----------------------------------------------------------
		//logicManager接口
		public function get logicManager():LogicManager
		{
			return m_logicManager;
		}
		
		public function set logicManager(value:LogicManager):void
		{
			m_logicManager = value;
		}
		
		//uiManager接口
		public function get uiManager():UiManager 
		{
			return m_uiManager;
		}
		
		public function set uiManager(value:UiManager):void 
		{
			m_uiManager = value;
		}
		
		//musicManager接口
		public function get musicManager():MusicManager 
		{
			return m_musicManager;
		}
		
		public function set musicManager(value:MusicManager):void 
		{
			m_musicManager = value;
		}
		
		//configManager接口
		public function get configManager():ConfigManager 
		{
			return m_configManager;
		}
		
		public function set configManager(value:ConfigManager):void 
		{
			m_configManager = value;
		}
		
		//dalmanager接口
		public function get dalmanager():DalManager 
		{
			return m_dalmanager;
		}
		
		public function set dalmanager(value:DalManager):void 
		{
			m_dalmanager = value;
		}
		
		public function get networkManager():NetworkManager 
		{
			return m_networkManager;
		}
		
		public function set networkManager(value:NetworkManager):void 
		{
			m_networkManager = value;
		}
		
	}

}