package core 
{
	/**
	 * 此类为常量类
	 * @author ...
	 */
	public class Constants 
	{
		//适配手机时请设置为true，电脑适配时请设置为false
		public static const isAdaptPhone:Boolean = true;
		
		/**
		 * 版本号说明
		 * A.B.C
		 * A 表示大版本号，一般当软件整体重写，或出现不向后兼容的改变时，增加A，A为零时表示软件还在开发阶段。
		 * B 表示功能更新，出现新功能时增加B
		 * C 表示小修改，如修复bug，只要有修改就增加C
		 * 修饰词：
		 * alpha: 内部版本
		 * beta: 测试版
		 */
		public static const str_Version:String = "0.0.1beta";
		
		public static var setUiWidth:Function = GameIF.getInstance().uiManager.setUiWidth;
		public static var setUiHeight:Function = GameIF.getInstance().uiManager.setUiHeight;
		public static var setUiLeft:Function = GameIF.getInstance().uiManager.setUiLeft;
		public static var setUiTop:Function = GameIF.getInstance().uiManager.setUiTop;
		public static var setBGFullScreen:Function = GameIF.getInstance().uiManager.setBGFullScreen;
		
		public static var sSelfAddress:String = "";
		public static var sSelfLat:String = "";//  纬度
		public static var sSelfLng:String = "";//  经度
		public static var bIsLocation:Boolean = false;
		
	}

}