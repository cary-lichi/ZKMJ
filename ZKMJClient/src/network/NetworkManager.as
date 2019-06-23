package network 
{

	import core.GameIF;
	import core.LogicManager;
	import laya.events.Event;
	import laya.net.HttpRequest;
	import laya.net.Socket;
	import laya.utils.Byte;
	import laya.utils.Browser;
	import laya.utils.Handler;
	/**
	 * ...
	 * @author dawenhao
	 */
	public class NetworkManager 
	{
		private var m_ProtoBuf:* = Browser.window.protobuf;
		private var m_socket:Socket;
		private var m_HttpRequest:HttpRequest;
		private static var m_sServerIP:String = "www.cxagile.cn";
		//private static var m_sServerIP:String = "localhost";
		private static var m_sServerPort:String = "8002";
		private static var m_sIsHttps:String = "s";
		private static var m_Msg:*;
		public static var m_msgRoot:*;
		private static var m_time:int = 10;
		
		public function NetworkManager() 
		{
			Init();
		}
		
		public function Init():void
		{
			LoadProto();
			//InitSocket();
			//侦听退出事件
		}
		public function InitSocket(caller:*, onopen:Function = null, onclose:Function =null):void
		{
			if (m_socket == null)
			{
				m_socket = new Socket;
			}
			m_socket.offAll();
			m_socket.on(Event.OPEN, caller, onopen);
			
			m_socket.on(Event.CLOSE, this, onSocketClose);
			m_socket.on(Event.MESSAGE, this, onSocketMessageReceived);
			m_socket.on(Event.ERROR, this, onConnectError);
		}
		//连接只有一次
		public function SocketConnect(userID:int):void
		{
			//eg:m_socket.connectByUrl("ws://122.206.155.128:8001/game?id=12345");
			var serverUrl:String = "ws"+m_sIsHttps+"://" + m_sServerIP +":" + m_sServerPort + "/game?id=" + userID;
			try{
				m_socket.connectByUrl(serverUrl);
			}
			catch (errobject:Error)
			{
				trace("socket连接失败提示错误信息:" + errobject.message);
				trace("error" + errobject.stack);
				SentLog(errobject.stack);
				return;
			}
		}
		public function SocketClose():void 
		{
			try
			{
				m_socket.close();
				m_socket = null;
			}
			catch (errobject:Error)
			{
				trace("error" + errobject.stack);
				SentLog(errobject.stack);
			}
			
		}
		private function onSocketClose(e:*=null):void
		{
			trace("Socket is Closed");
			if (GameIF.GetRoom())
			{
				//网络超时
				NetworkTimeout();
			}
			
		}
		private function Reconnect():void 
		{
			GameIF.ClosePopUpDia();
			GameIF.getInstance().networkManager.InitSocket(this,GameIF.getInstance().networkManager.StartLoginHeart);
			GameIF.getInstance().networkManager.SocketConnect(GameIF.GetDalManager().daluser.nID);
		}
		//我觉得这个接收后的细节处理应该在需要处理的地方。用GameIF来处理
		private function onSocketMessageReceived(message:*= null):void
		{
			try{
				var data:ArrayBuffer = message;
				var byte:Byte = new Byte;
				byte.writeArrayBuffer(message, 0, data.length);
				var data1:Uint8Array = byte.getUint8Array(0, byte.length);
				var msgReceive:* = NetworkManager.m_Msg.decode(data1);
				m_socket.input.clear();
				//分发这个消息
				GameIF.getInstance().logicManager.OnReceiveMessage(msgReceive);
				if (msgReceive.type != 55)
				{
					trace(msgReceive);
				}
			}
			catch (errobject:Error)
			{
				
				trace("error" + errobject.message);
				trace("error" + errobject.stack);
				SentLog(errobject.stack);
			}
		}
		
		private function onSocketOpen(e:*=null):void
		{
			trace("Sever Connected");
		}
		
		//发送数据
		public function SocketSendMessage(message:*):void
		{
			try
			{
				m_socket.send(message);
			}
			catch (errobject:Error)
			{
				trace("error" + errobject.message);
				trace("error" + errobject.stack);
				SentLog(errobject.stack);
			}
		}
		
		
		private function InitHttp(Message:*,root):void 
		{
			HttpConnect(m_sServerIP,m_sServerPort,Message,"post","arraybuffer",root);
		}
		private function HttpConnect(url:String,port:String,message:*,method:String,type:String,root:String):void
		{
			try
			{
				var serverUrl:String = "http" + m_sIsHttps + "://" + url +":" + port + "/"+root;
				m_HttpRequest = new HttpRequest;
				m_HttpRequest.once(Event.PROGRESS, this, onHttpRequestProgress);
				m_HttpRequest.once(Event.COMPLETE, this, onHttpRequestComplete);
				m_HttpRequest.once(Event.ERROR, this, onHttpRequestError);
				m_HttpRequest.send(serverUrl,message, method, type,["Content-Type", "application/octet-stream"]);
			}
			catch (errobject:Error)
			{
				trace("HTTP发送失败提示错误信息:" + errobject.message);
				trace("error" + errobject.stack);
				SentLog(errobject.stack);
				return; 
			}
			
		}
		
		private function HttpSend(encodeMessage:*,root:String):void
		{
			InitHttp(encodeMessage,root);
			
		}
		
		//请求进度
		private function onHttpRequestProgress(e:*=null):void 
		{
			//trace(e);
		}
		
		//收到响应
		private function onHttpRequestComplete(e:*=null):void 
		{
			try
			{
				var data:ArrayBuffer = e;
				var byte:Byte = new Byte;
				byte.writeArrayBuffer(e, 0, data.length);
				var data1:Uint8Array = byte.getUint8Array(0, byte.length);
				if (data1.length != 0)
				{
					var msgReceive:* = NetworkManager.m_Msg.decode(data1);
					//分发这个消息
					GameIF.getInstance().logicManager.OnReceiveMessage(msgReceive);
					//处理心跳函数
					LoginHeart(msgReceive)
					
				}
			}
			catch (errobject:Error)
			{
				trace("HTTP解析小时失败提示错误信息:" + errobject.message);
				trace("error" + errobject.stack);
				SentLog(errobject.stack);
				return; 
			}
		}
		
		private function LoginHeart(message:*):void 
		{
			var nErrorCode:JSON = GameIF.GetJson()["nErrorCode"];
			if (message.type != 96)
			{
				trace(message);		
			}
			if (message.type == 96)
			{
				if (message.response.loginHeartResponse.nErrorCode == nErrorCode["loginExpires"])
				{
					//网络超时
					GameIF.GetPopUpDia("登录超时，请重新登录");
					Laya.timer.once(1000,this,RestartGame)
				}
			}
		}
		//错误
		private function onHttpRequestError(e:*=null):void 
		{
			NetworkTimeout();
		}
		//网络超时
		public function NetworkTimeout():void 
		{
			GameIF.GetPopUpDia("网络超时，请重新登录",RestartGame,this);
			if (m_socket)
			{
				SocketClose();
			}
			Laya.timer.once(3000,this,RestartGame);
			trace("Http error");
		}
		private function RestartGame():void 
		{
			GameIF.ClosePopUpDia();
			StopLoginHeart();
			GameIF.RestartGame();
		}
		//发送数据
		public function HttpSendMessage(message:*,root:String):void
		{
			try
			{
				HttpSend(message,root);
			}
			catch (errobject:Error)
			{
				trace("error" + errobject.message);
				trace("error" + errobject.stack);
				SentLog(errobject.stack);
			}
		}
		//
		private function OnLoadProtoMessage(err:*, root:*):*
		{
			if (err){
				throw  err;
			}
			//
			NetworkManager.m_msgRoot = root;
			NetworkManager.m_Msg = root.lookup("Msg");
		}
		

		
		//加载Proto文件
		private function LoadProto():void
		{
			m_ProtoBuf.load("protobuf/msg.proto",OnLoadProtoMessage);
		}
		
		private function onConnectError(e:Event = null):void
		{
			trace("Socket error");
		}
		
		//心跳函数
		public function StartLoginHeart():void 
		{
			Laya.timer.loop(m_time*1000,this,loginHeart);
		}
		//停止心跳
		public function StopLoginHeart():void
		{
			Laya.timer.clearAll(this);
		}
		
		private function loginHeart():void 
		{
			var userID:int = GameIF.GetUser().nUserID;
			var token:String = GameIF.GetUser().sToken;
			var LoginHeartRequestMsg:* = NetworkManager.m_msgRoot.lookupType("LoginHeartRequest");
			var loginHeartRequestMsg:* = LoginHeartRequestMsg.create({
				nUserID:userID,
				sToken:token
			});
	        //Request当中具体的内容
				var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
				var requestMsg:* = Request.create({
					loginHeartRequest:loginHeartRequestMsg
				});
			////包含了Request的内容
			var Msg:* = NetworkManager.m_msgRoot.lookupType("Msg");
			var MsgMessage:* = Msg.create({
				type:64,
				request:requestMsg
			});
			var encodeMessage:* = Msg.encode(MsgMessage).finish();
			GameIF.getInstance().networkManager.HttpSendMessage(encodeMessage, "loginheart");
		}
		
		//发送log信息
		private function SentLog(content:String):void 
		{
			var userID:int = GameIF.GetUser().nUserID;
			var ClientLogRequestMsg:* = NetworkManager.m_msgRoot.lookupType("ClientLogRequest");
			var clientLogRequestMsg:* = ClientLogRequestMsg.create({
				nUserID:userID,
				sContent:content
			});
	        //Request当中具体的内容
				var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
				var requestMsg:* = Request.create({
					clientLogRequest:clientLogRequestMsg
				});
			////包含了Request的内容
			var Msg:* = NetworkManager.m_msgRoot.lookupType("Msg");
			var MsgMessage:* = Msg.create({
				type:83,
				request:requestMsg
			});
			var encodeMessage:* = Msg.encode(MsgMessage).finish();
			GameIF.getInstance().networkManager.HttpSendMessage(encodeMessage, "clientlog");
		}
	}

}