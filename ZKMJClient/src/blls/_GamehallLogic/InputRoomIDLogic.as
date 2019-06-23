package blls._GamehallLogic 
{
	import blls.BaseLogic;
	import blls.GamehallLogic;
	import core.GameIF;
	import core.LogicManager;
	import core.SdkManager;
	import laya.events.Event;
	import model._Gamer.Gamer;
	import model._Gamer.GamerBottom;
	import model._Gamer.GamerLeft;
	import model._Gamer.GamerRight;
	import model._Gamer.GamerTop;
	import model._Room.Room;
	import network.NetworkManager;
	import tool.Tool;
	import view.ActiveView.InputRoomIDWindow;
	import view.BlackWindowView;
	
	/**
	 * ...
	 * @author ...
	 */
	public class InputRoomIDLogic extends BaseLogic 
	{
		private var m_inputRoomIDWindow:InputRoomIDWindow;
		private var m_inputContent:String="";//输入的房间号
		
		public function InputRoomIDLogic() 
		{
			super();
		}
		
		public override function Init():void
		{
			if (m_inputRoomIDWindow == null)
			{
				m_inputRoomIDWindow = new InputRoomIDWindow;
				m_inputRoomIDWindow.Init();
			}
			m_inputRoomIDWindow.visible = false;
			//注册所有按钮事件
			registerEventClick();
			//初始化输入框
			InitInput();
		
		}
		
		
		public function ShowInputRoomID():void 
		{
			m_inputRoomIDWindow.visible = true;
		}
		public function HideInputRoomID():void 
		{
			m_inputRoomIDWindow.visible = false;
		}
		private function InitInput():void 
		{
			m_inputContent = "";
			for (var i:int = 0; i < 5;i++ )
			{
				switch (i)
				{
					case 0:
						m_inputRoomIDWindow.m_input_1.visible = false;
						break;
					case 1:
						m_inputRoomIDWindow.m_input_2.visible = false;
						break;
					case 2:
						m_inputRoomIDWindow.m_input_3.visible = false;
						break;
					case 3:
						m_inputRoomIDWindow.m_input_4.visible = false;
						break;
					case 4:
						m_inputRoomIDWindow.m_input_5.visible = false;
						break;
				}
			}
		}
		
		private function registerEventClick():void 
		{
			//input按钮
			m_inputRoomIDWindow.btn_1.on(Event.CLICK, this, onbtnInputClick);
			m_inputRoomIDWindow.btn_2.on(Event.CLICK, this, onbtnInputClick);
			m_inputRoomIDWindow.btn_3.on(Event.CLICK, this, onbtnInputClick);
			m_inputRoomIDWindow.btn_4.on(Event.CLICK, this, onbtnInputClick);
			m_inputRoomIDWindow.btn_5.on(Event.CLICK, this, onbtnInputClick);
			m_inputRoomIDWindow.btn_6.on(Event.CLICK, this, onbtnInputClick);
			m_inputRoomIDWindow.btn_7.on(Event.CLICK, this, onbtnInputClick);
			m_inputRoomIDWindow.btn_8.on(Event.CLICK, this, onbtnInputClick);
			m_inputRoomIDWindow.btn_9.on(Event.CLICK, this, onbtnInputClick);
			m_inputRoomIDWindow.btn_reset.on(Event.CLICK, this, onbtnInputClick);
			m_inputRoomIDWindow.btn_0.on(Event.CLICK, this, onbtnInputClick);
			m_inputRoomIDWindow.btn_delete.on(Event.CLICK, this, onbtnInputClick);
			//黑幕被点击
			m_inputRoomIDWindow.m_imgBack.on(Event.CLICK, this, onBlackScreenClicked);
			
		}
		private function onbtnInputClick(e:Event):void 
		{
			if (e.target.name=="reset")
				{
					m_inputContent = "     ";
					showInput(m_inputContent);
					m_inputContent = "";
				}
			else if (e.target.name == "delete")
				{
					m_inputContent = m_inputContent.substr(0, m_inputContent.length -1);
					m_inputContent += " ";
					showInput(m_inputContent);
					m_inputContent = m_inputContent.substr(0, m_inputContent.length -1);
				}
			else if (m_inputContent.length<5)
				{
						m_inputContent = m_inputContent + e.target.name;
						showInput(m_inputContent);
						
						if (m_inputContent.length==5)
						{
							//GameIF.ActiveLogic(LogicManager.NOEXISTLOGIC);
							//连接Socket
							SendJoinRoomMsg();
							}
				}
			else 
				{
					//trace("太多了");
					//m_inputContent为用户输入的房间号
					//发送给后台即可
					
					
				}
		}
		
		private function SendJoinRoomMsg():void 
		{
			GameIF.getInstance().networkManager.InitSocket(this,CreatJoinRoomMessage);
			GameIF.getInstance().networkManager.SocketConnect(GameIF.GetDalManager().daluser.nID);
		}
		public function SendJoninRoom(roomid:String):void
		{
			m_inputContent=roomid;
			SendJoinRoomMsg();
		}
		private function showInput(m_inputContent:String):void 
		{
			for (var i:int = 0; i < m_inputContent.length;i++ )
			{
				switch (i)
				{
					case 0:
						m_inputRoomIDWindow.m_input_1.visible = true;
						m_inputRoomIDWindow.m_input_1.index = parseInt(m_inputContent.substring(i, i + 1));
						break;
					case 1:
						m_inputRoomIDWindow.m_input_2.visible = true;
						m_inputRoomIDWindow.m_input_2.index = parseInt(m_inputContent.substring(i, i + 1));
						break;
					case 2:
						m_inputRoomIDWindow.m_input_3.visible = true;
						m_inputRoomIDWindow.m_input_3.index = parseInt(m_inputContent.substring(i, i + 1));
						break;
					case 3:
						m_inputRoomIDWindow.m_input_4.visible = true;
						m_inputRoomIDWindow.m_input_4.index = parseInt(m_inputContent.substring(i, i + 1));
						break;
					case 4:
						m_inputRoomIDWindow.m_input_5.visible = true;
						m_inputRoomIDWindow.m_input_5.index = parseInt(m_inputContent.substring(i, i + 1));
						break;
				}
			}
		}
		
		//输入房间号黑幕被点击
		private function onBlackScreenClicked():void 
		{
			HideInputRoomID();
			return;
		}
		
		public override function Destroy():void
		{
			m_inputRoomIDWindow.Destroy();
			m_inputRoomIDWindow.visible = false;
			m_inputRoomIDWindow = null;	
		}
		
		//发送加入房间的请求
		private function CreatJoinRoomMessage():void
		{
			var CreateJoinRoomRequest:* = NetworkManager.m_msgRoot.lookupType("JoinRoomRequest");
			var createJoinRoomRequestMsg:* = CreateJoinRoomRequest.create({
				nUserID:GameIF.GetDalManager().daluser.nID,
				sRoomID:m_inputContent
			});
			
			var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
			var requestMsg:* = Request.create({
				joinRoomRequest:createJoinRoomRequestMsg
			});
			
			var Msg:* = NetworkManager.m_msgRoot.lookupType("Msg");
			var MsgMessage:* = Msg.create({
				type:7,
				request:requestMsg
			});
			
			var encodeMessage:* = Msg.encode(MsgMessage).finish();
			GameIF.getInstance().networkManager.SocketSendMessage(encodeMessage);
		}
		
		//加入房间时接收到的消息
		public override function OnReceiveMessage(msg:*):void
		{
			if (msg.type == 8)//joinroomresponse
			{
				OnJoinRoomResponse(msg.response.joinRoomResponse);
			}
		}
		
		private function OnJoinRoomResponse(message:*):void
		{
			if (GameIF.GetRoom()) 
			{
				GameIF.GetRoom().Destroy();
			}
			
			switch(message.nErrorCode)
			{
				case 0://正常加入
					var room:Room = Tool.getNewRoom(message.joinRoom.gamePlay.nType);
					room.sRoomID =  message.joinRoom.sID;
					room.nRound = message.joinRoom.nCardCount+1;
					room.SetGamePlay(message.joinRoom.gamePlay);
					room.nRoomState = message.joinRoom.nState;
					room.sCardType = message.joinRoom.sCardType;
					room.SetPlayers(message.joinRoom.nPlayers);
					room.DalInit();
					//添加一个room
					GameIF.GetDalManager().dalRoom.AddRoom(room);
					var nGID:int = GameIF.GetUser().nUserID;
					
					//找到自己的真实位置
					for each(var gamer:Gamer in message.joinRoom.Gamers)
					{
						if (gamer.nGID == nGID)
						{
							var m_myPos:int = gamer.nPos;
							break;
						}
					}
					var newGamer:Gamer;
					//加入加他玩家
					for each(var otherGamer:* in message.joinRoom.Gamers)
					{
						//计算gamer位置
						var gamerPos:int = otherGamer.nPos;
						////根据位置获取玩家
						newGamer = Tool.getNewGamer(m_myPos, gamerPos);
						newGamer.bBoss = otherGamer.bBoss;
						newGamer.bOwner = otherGamer.bOwner;
						newGamer.nGID = otherGamer.nGID;
						newGamer.nPos = otherGamer.nPos;
						newGamer.sNick = otherGamer.sName;
						newGamer.sRoomID = otherGamer.sRoomID;
						newGamer.state = otherGamer.state;
						newGamer.sHeadimg = otherGamer.sHeadImage;
						newGamer.bOnLine = otherGamer.bOnline;
						newGamer.nScore+= otherGamer.totalScore;
						newGamer.nGameState = otherGamer.gameState;
						
						if (newGamer.nGID < 0)
						{
							//说明是机器人
							newGamer.nAIRandInfo = otherGamer.nAIRandInfo;
							newGamer.nAIRandHead = otherGamer.nAIRandHead;
							newGamer.bIsLocation = false;
							newGamer.sAddress = "";
						}
						else
						{
							newGamer.bIsLocation = otherGamer.location.bIsLocation;
							newGamer.sAddress = otherGamer.location.sAddress;
							newGamer.sLat = otherGamer.location.sLat;
							newGamer.sLng = otherGamer.location.sLng;
						}
						
						//把所有gamer都添加到字典里
						room.AddGamer(newGamer);
						newGamer.vipRoomView = room.vipRoomView;
						newGamer.Init();
						newGamer.InitPaiPool(otherGamer.paipool);
						newGamer.bAI = otherGamer.bAI;
					}
					if (room.nRoomState==GameIF.GetJson()["roomState"]["readyed"])
					{
						room.roomReset();
						if (message.joinRoom.Gamers.length > 1)
						{
							room.ShowOtherGPS();
						}
						else
						{
							room.ShowMyGPS();
						}
					}
					else if (room.nRoomState==GameIF.GetJson()["roomState"]["playing"])
					{
						room.GameStart();
					}
					else if (room.nRoomState==GameIF.GetJson()["roomState"]["over"])
					{
						if (room.GetGamer(GameIF.GetUser().nUserID).nGameState==GameIF.GetJson()["gameState"]["readyed"])
						{
							room.roomReset();
							room.gameReadying();
						}
						else
						{
							room.gameReadying();
						}
						
					}
					
					//进入游戏逻辑
					GameIF.DectiveLogic(LogicManager.GAMEHALLLOGIC);
					GameIF.ActiveLogic(LogicManager.VIPROOMLOGIC);
					
					//测试//
					//room.OnStartGameClicked();
					break;
					
				case 5://房间存在
					GameIF.GetPopUpDia("该房间号不存在(* ￣︿￣)！！");
					break;
				case 6://房间已满
					GameIF.GetPopUpDia("房间人数已满，请创建房间或者\n加入其它房间");
					break;
				case 7://重复的玩家
					GameIF.GetPopUpDia("重复的玩家");
					break;
				case 9://房主离线
					GameIF.GetPopUpDia("房主离线，请稍后再加入");
					break;
				default://无效的错误码
					GameIF.GetPopUpDia("服务器异常");
					break;
			}
			if (message.nErrorCode != 0)
			{
				//初始化输入框
				InitInput();
			}
			
		}
		
	}

}