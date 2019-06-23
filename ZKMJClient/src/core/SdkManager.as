package core 
{
	import laya.utils.Browser;
	/**
	 * ...
	 * @author ...
	 */
	public class SdkManager 
	{
		public static var mOpenId:String = null;
		public static var mUserName:String = null;
		public static var mAvatarUrl:String = null;
		public static var mRoomId:String = null;
		public static var mSex:int = 2;
		public static var minviterID:String = null;
		public function SdkManager() 
		{
			
		}
		
		public function Init():void
		{
			var UserInfo:* = __JS__('setUserInfo()');
			
			mOpenId = UserInfo.openid;
			mUserName = UserInfo.name;
			mAvatarUrl = UserInfo.headimgurl;
			mRoomId = UserInfo.roomid;
			mSex = parseInt(UserInfo.sex);
			minviterID = UserInfo.inviterID;
		}
		
	}

}