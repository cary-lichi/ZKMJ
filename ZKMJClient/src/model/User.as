package model 
{
	import tool.Tool;
	/**
	 * ...
	 * @author ...
	 */
	public class User 
	{
		  private var  m_nGender:int;//玩家性别 0 未知 1男 2女
		  private var  m_nUserID:int;//用户id
		  private var  m_sICode:String;//验证码
		  private var  m_sNick:String;//用户昵称
		  private var  m_nExp:int;//用户经验值
		  private var  m_nGold:int;//用户游戏币
		  //private var  m_nRommCard:int;//用户房卡
		  private var  m_nMoney:int;//用户钻石
		  private var  m_sHeadimg:String;//用户头像
		  private var  m_sPhone:String;//用户电话
		  private var  m_sRecords:String;//用户对局记录
		  private var  m_sAssets:String;//用户资产
		  private var  m_sRoom:String;//用户当前所在房间（断线重连）
		  private var  m_sName:String;//用户名
		  private var  m_bOffLine:Boolean = false;
		  private var  m_bLuckyToday:Boolean = false;//是否玩过大转盘
		  private var  m_bWelfareToday:Boolean = false;//是领过福利
		  private var  m_bShareAwardWeek:Boolean = false;//是否领过分享奖励
		  private var  m_sToken:String = "";//是否登录的验证
		  private var  m_sLng:String = "";//经度
		  private var  m_sLat:String = "";//纬度
		  private var  m_sAddress:String = "";//用户位置信息
		  private var  m_bIsLocation:Boolean = false;
		
		public function User() 
		{
			
		}
		//////////////////////////////////////////////////////////////////
		///////////////////////////接口//////////////////////////////////
		//////////////////////////////////////////////////////////////////
		public function get nUserID():int 
		{
			return m_nUserID;
		}
		public function set nUserID(value:int):void 
		{
			m_nUserID = value;
		}
		
		public function get nGID():int 
		{
			return m_nUserID;
		}
		
		public function set nGID(value:int):void 
		{
			m_nUserID = value;
		}
		
		public function get sNick():String 
		{
			return m_sNick;
		}
		
		public function set sNick(value:String):void 
		{
			m_sNick = value?value:"我是"+m_nUserID;
		}
		
		public function get nExp():int 
		{
			return m_nExp;
		}
		
		public function set nExp(value:int):void 
		{
			m_nExp = value;
		}
		
		public function get nGold():int 
		{
			return m_nGold;
		}
		
		public function set nGold(value:int):void 
		{
			m_nGold = value;
		}
		
		public function get nMoney():int 
		{
			return m_nMoney;
		}
		
		public function set nMoney(value:int):void 
		{
			m_nMoney = value;
		}
		
		public function get sHeadimg():String 
		{
			return m_sHeadimg;
		}
		
		public function set sHeadimg(value:String):void 
		{
			
			m_sHeadimg = value?value:Tool.getHeadUrl();
		}
		
		public function get sPhone():String 
		{
			return m_sPhone;
		}
		
		public function set sPhone(value:String):void 
		{
			m_sPhone = value;
		}
		
		public function get sRecords():String 
		{
			return m_sRecords;
		}
		
		public function set sRecords(value:String):void 
		{
			m_sRecords = value;
		}
		
		public function get sAssets():String 
		{
			return m_sAssets;
		}
		
		public function set sAssets(value:String):void 
		{
			m_sAssets = value;
		}
		
		public function get sRoom():String 
		{
			return m_sRoom;
		}
		
		public function set sRoom(value:String):void 
		{
			m_sRoom = value;
		}
		
		public function get sName():String 
		{
			return m_sName;
		}
		
		public function set sName(value:String):void 
		{
			m_sName = value;
		}
		
		public function get sICode():String 
		{
			return m_sICode;
		}
		
		public function set sICode(value:String):void 
		{
			m_sICode = value;
		}
		
		public function get bOffLine():Boolean 
		{
			return m_bOffLine;
		}
		
		public function set bOffLine(value:Boolean):void 
		{
			m_bOffLine = value;
		}
		
		public function get bLuckyToday():Boolean 
		{
			return m_bLuckyToday;
		}
		
		public function set bLuckyToday(value:Boolean):void 
		{
			m_bLuckyToday = value;
		}
		
		public function get bWelfareToday():Boolean 
		{
			return m_bWelfareToday;
		}
		
		public function set bWelfareToday(value:Boolean):void 
		{
			m_bWelfareToday = value;
		}
		
		public function get nGender():int 
		{
			return m_nGender;
		}
		
		public function set nGender(value:int):void 
		{
			m_nGender = value;
		}
		
		public function get bShareAwardWeek():Boolean 
		{
			return m_bShareAwardWeek;
		}
		
		public function set bShareAwardWeek(value:Boolean):void 
		{
			m_bShareAwardWeek = value;
		}
		
		public function get sToken():String 
		{
			return m_sToken;
		}
		
		public function set sToken(value:String):void 
		{
			m_sToken = value;
		}
		
		public function get sLng():String 
		{
			return m_sLng;
		}
		
		public function set sLng(value:String):void 
		{
			m_sLng = value;
		}
		
		public function get sLat():String 
		{
			return m_sLat;
		}
		
		public function set sLat(value:String):void 
		{
			m_sLat = value;
		}
		
		public function get sAddress():String 
		{
			return m_sAddress;
		}
		
		public function set sAddress(value:String):void 
		{
			m_sAddress = value;
		}
		
		public function get bIsLocation():Boolean
		{
			return m_bIsLocation;
		}
		
		public function set bIsLocation(value:Boolean):void 
		{
			m_bIsLocation = value;
		}
		//////////////////////////////////////////////////////////////////
		///////////////////////////接口//////////////////////////////////
		//////////////////////////////////////////////////////////////////
		
	}

}