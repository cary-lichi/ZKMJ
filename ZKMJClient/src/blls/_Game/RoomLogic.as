package blls._Game 
{
	import adobe.utils.CustomActions;
	import blls.BaseLogic;
	import blls._GamehallLogic.SetLogic;
	import core.GameIF;
	import core.LogicManager;
	import laya.events.Event;
	import laya.ui.Component;
	import laya.ui.Image;
	import laya.ui.List;
	import laya.utils.Dictionary;
	import model._Gamer.Gamer;
	import model._Gamer.GamerLeft;
	import model._Gamer.GamerRight;
	import model._Gamer.GamerTop;
	import model._Pai.Pai;
	import model._Room.Room;
	import model.User;
	import network.NetworkManager;
	import tool.Tool;
	/**
	 * ...
	 * @author ...
	 */
	public class RoomLogic extends BaseLogic
	{			
		private var m_room:Room;
		private var m_listMsg:Array=[];
		private  var m_stateMsgHandle:Boolean = false;
		
		public function RoomLogic() 
		{
			super();
		}
		public override function Init():void
		{
			//获得room实例
			m_room = GameIF.GetRoom();
			//初始化房间
			m_room.DalInit();
			//激活结算逻辑
			GameIF.ActiveLogic(LogicManager.GAMESETTLEMENTLOGIC);
			//激活设置逻辑
			GameIF.ActiveLogic(LogicManager.ROOMSETLOGIC);
			//激活玩家信息逻辑
			GameIF.ActiveLogic(LogicManager.GAMEINFOLOGIC);
			//规则
			GameIF.ActiveLogic(LogicManager.REGULARLOGIC);
			
			StartListenNetwork();
		}
		
		
		//封装Request和发送函数
		private function CreateMsgSend(type:int,requestMsg:*):void
		{
			//最终发送的是这个Msg，它里面包含了所嵌套的消息
			var Msg:* = NetworkManager.m_msgRoot.lookupType("Msg");
			var MsgMessage:* = Msg.create({
				type:type,
				request:requestMsg
			});
			//发送之前需要编码，编码使用具体发送时用于查找的那个lookup的变量
			var encodeMessage:* = Msg.encode(MsgMessage).finish();
			GameIF.getInstance().networkManager.SocketSendMessage(encodeMessage);
		}
		//处理服务器发来的消息
		public override function OnReceiveMessage(msg:*):void
		{
			if (GameIF.GetRoom())
			{
				m_listMsg.push(msg);
				HandleMsgList();
			}
			
		}	
		//处理服务器发来的消息
		public function HandleMsgList():void
		{
			if (m_listMsg.length <= 0) return;
			if (m_stateMsgHandle) return;
			var msg:* = m_listMsg.shift();
			HandelMsgInner(msg);
		}
		//开始侦听
		private function StartListenNetwork():void 
		{
			Laya.timer.loop(2000,this,ListenNetwork);
		}
		private function ListenNetwork():void 
		{
			if (m_room.bNetWeak)
			{
				m_room.ShowNetWeak();
			}
		}
		private function OutputLog(type:String,content:*):void
		{
			trace(type + "==  ");
			trace(content);
			trace("\r\n");
			trace("\r\n");
		}
		
		private function HandelMsgInner(msg:*):void 
		{
			m_stateMsgHandle = true;
			////////////////////////
			if (msg.type == 4)
			{
				OutputLog("loginResponse", msg.response.loginResponse);
			}
			else if (msg.type == 8)
			{	
				OutputLog("joinroomresponse", msg.response.joinRoomResponse.joinRoom);
			}
			else if (msg.type == 9)//joinRoomNotify
			{
				OutputLog("joinRoomNotify",msg.notify.joinRoomNotify.joinGamer);
				OnJoinRoomNotify(msg.notify.joinRoomNotify.joinGamer);
			}
			else if (msg.type == 11)//leaveroomresponse
			{
				OutputLog("leaveroomresponse",msg.response.leaveRoomResponse);
				OnLeaveRoomResponse(msg.response.leaveRoomResponse);
			}
			else if (msg.type == 12)//leaveroomnotify
			{
				OutputLog("leaveroomnotify",msg.notify.leaveRoomNotify);
				OnLeaveRoomNotify(msg.notify.leaveRoomNotify);
			}
			else if (msg.type == 13)//startgamenotify
			{
				OutputLog("startGameNotify",msg.notify.startGameNotify);
				OnStartGameNotify(msg.notify.startGameNotify);
			}
			else if (msg.type == 14)//initpainotify
			{
				OutputLog("initpainotify",msg.notify.initPaiNotify);
				//initPaiNotify的内容是一个gamer
				OnInitPaiNotify(msg.notify.initPaiNotify);
			}
			else if (msg.type == 17)//getpainotify
			{
				OutputLog("getpainotify", msg.notify.getPaiNotify);
				OutputLog("牌为", msg.notify.getPaiNotify.getPai);
				
				OnGetPaiNotify(msg.notify.getPaiNotify);
				return;
			}
			else if (msg.type == 19)//putPaiResponse
			{
				OutputLog("putPaiResponse",msg.response.putPaiResponse);
				OnPutPaiResponse(msg.response.putPaiResponse);
				m_room.bNetWeak = false;
				return;
			}
			else if (msg.type == 20)//putPaiNotify
			{
				OutputLog("putPaiNotify", msg.notify.putPaiNotify);
				OutputLog("牌为", msg.notify.putPaiNotify.putPai);
				//应该是个动画
				OnPutPaiNotify(msg.notify.putPaiNotify);
				return;
			}
			else if (msg.type == 21)//canPaiNotify
			{
				OutputLog("canPaiNotify",msg.notify.canPaiNotify);
				OnCanPaiNotify(msg.notify.canPaiNotify);
			}
			else if (msg.type == 23)//dochipairesponse
			{
				OutputLog("dochipairesponse",msg.response.doChiPaiResponse);
				OnDoChiPaiResponse(msg.response.doChiPaiResponse);
				m_room.bNetWeak = false;
			}
			else if (msg.type == 24)//doChiPaiNotify
			{
				OutputLog("doChiPaiNotify",msg.notify.doChiPaiNotify);
				OnDoChiPaiNotify(msg.notify.doChiPaiNotify);
			}
			else if (msg.type == 26)//doGangPaiResponse
			{
				OutputLog("doGangPaiResponse",msg.response.doGangPaiResponse);
				OnDoGangPaiResponse(msg.response.doGangPaiResponse);
				m_room.bNetWeak = false;
			}
			else if (msg.type == 27)//doGangPaiNotify
			{
				OutputLog("doGangPaiNotify",msg.notify.doGangPaiNotify);
				OnDoGangPaiNotify(msg.notify.doGangPaiNotify);
			}
			else if (msg.type == 29)//29doHuPaiResponse
			{
				OutputLog("doHuPaiResponse",msg.response.doHuPaiResponse);
				OnDoHuPaiResponse(msg.response.doHuPaiResponse);
				m_room.bNetWeak = false;
			}
			else if (msg.type == 30)//30doHuPaiNotify
			{
				OutputLog("doHuPaiNotify",msg.notify.doHuPaiNotify);
				OnDoHuPaiNotify(msg.notify.doHuPaiNotify);
			}
			else if (msg.type == 32)//doPengPaiResponse
			{
				OutputLog("doPengPaiResponse",msg.response.doPengPaiResponse);
				OnDoPengPaiResponse(msg.response.doPengPaiResponse);
				m_room.bNetWeak = false;
			}
			else if (msg.type == 33)//doPengPaiNotify
			{
				OutputLog("doPengPaiNotify",msg.notify.doPengPaiNotify);
				OnDoPengPaiNotify(msg.notify.doPengPaiNotify);
			}
			else if (msg.type == 35)//dotingpairesponse
			{
				OutputLog("dotingpairesponse",msg.response.doTingPaiResponse);
				OnDoTingPaiResponse(msg.response.doTingPaiResponse);
				m_room.bNetWeak = false;
			}
			else if (msg.type == 36)//doTingPaiNotify
			{
				OutputLog("doTingPaiNotify",msg.notify.doTingPaiNotify);
				OnDoTingPaiNotify(msg.notify.doTingPaiNotify);
			}
			else if (msg.type == 37)//gameEndNotify
			{
				OutputLog("gameEndNotify", msg.notify.gameEndNotify);
				
				OnGameEndNotify(msg.notify.gameEndNotify);
			}
			else if (msg.type == 39)//guoPaiResponse
			{
				OutputLog("guoPaiResponse",msg.response.guoPaiResponse);
				OnGuoPaiResponse(msg.response.guoPaiResponse);
				m_room.bNetWeak = false;
			}
			else if (msg.type == 40)//guoPaiNotify
			{
				//
			}
			else if (msg.type == 42)//doPutPaiNotify
			{
				OutputLog("doPutPaiNotify",msg.notify.doPutPaiNotify);
				OnDoPutPaiNotify(msg.notify.doPutPaiNotify);
			}
			else if (msg.type == 47)//baopaiShowNotify
			{
				OnBaopaiShowNotify(msg.notify.baopaiShowNotify);
				return;
			}
			else if (msg.type == 55)//gametimeticknotify
			{
				OnGameTimeTickNotify(msg.notify.gameTimeTickNotify);
			}
			else if (msg.type == 66)//doqiangtingpairesponse
			{
				OutputLog("doqiangtingpairesponse",msg.response.doQiangTingPaiResponse);
				OnDoQiangTingPaiResponse(msg.response.doQiangTingPaiResponse);
				m_room.bNetWeak = false;
			}
			else if (msg.type == 67)//doqiangtingpainotify
			{
				OutputLog("doqiangtingpainotify",msg.notify.doQiangTingPaiNotify);
				OnDoQiangTingPaiNotify(msg.notify.doQiangTingPaiNotify);
			}
			else if (msg.type == 71)//readygameresponse
			{
				OutputLog("readygameresponse",msg.response.readyGameResponse);
				OnReadygameresponse(msg.response.readyGameResponse);
			}
			else if (msg.type == 72)//readygamenotify
			{
				OutputLog("readygamenotify",msg.notify.readyGameNotify);
				OnReadygamenotify(msg.notify.readyGameNotify);
			}
			else if (msg.type == 73)//connectnotify
			{
				OutputLog("connectNotify",msg.notify.connectNotify);
				OnConnectNotify(msg.notify.connectNotify);
			}
			else if (msg.type == 74)//disConnectNotify
			{
				OutputLog("disConnectNotify",msg.notify.disConnectNotify);
				OnDisConnectNotify(msg.notify.disConnectNotify);
			}
			else if (msg.type == 76)//dissRoomResponse
			{
				OutputLog("dissRoomResponse",msg.response.dissRoomResponse);
				onDissRoomResponse(msg.response.dissRoomResponse);
			}
			else if (msg.type == 77)//dissRoomNotify
			{
				OutputLog("dissRoomNotify", msg.notify.dissRoomNotify);
				OnDissRoomNotify(msg.notify.dissRoomNotify);
			}
			else if (msg.type == 78)//gameOverNotify
			{
				OutputLog("gameOverNotify", msg.notify.gameOverNotify);
				OnGameOverNotify(msg.notify.gameOverNotify);
			}
			else if (msg.type == 80)//chatresponse
			{
				OnChatResponse(msg.response.chatResponse);
			}
			else if (msg.type == 81)//chatnotify
			{
				OnChatNotify(msg.notify.chatNotify);
			}
			
			else if (msg.type == 94)//delegateResponse
			{
				onDelegateResponse(msg.response.delegateResponse);
			}
			else if (msg.type == 95)//delegateNotify
			{
				OnDelegateNotify(msg.notify.delegateNotify);
			}
			else if (msg.type == 103)//ownerChangeNotify
			{
				OnOwnerChangeNotify(msg.notify.ownerChangeNotify);
			}
			
			m_stateMsgHandle = false;
			HandleMsgList();
		}
		//得到的就是一个gamer(joinRoomNotify)
		private function OnJoinRoomNotify(gamer:*):void
		{
			var room:Room = GameIF.GetRoom();
			var myGamer:Gamer = room.GetGamer(GameIF.GetUser().nUserID);
			var m_myPos:int = myGamer.nPos;
			var gamerPos:int = gamer.nPos;
			var newGamer:Gamer;
			////根据位置获取玩家
			newGamer = Tool.getNewGamer(m_myPos, gamerPos);
			
			newGamer.nGID = gamer.nGID;
			newGamer.bBoss = gamer.bBoss;
			newGamer.bOwner = gamer.bOwner;
			newGamer.sNick = gamer.sName;
			newGamer.sHeadimg = gamer.sHeadImage;
			newGamer.nGameState = gamer.gameState;
			newGamer.nScore+= gamer.totalScore;
			if (newGamer.nGID < 0)
			{
				//说明是机器人
				newGamer.nAIRandInfo = gamer.nAIRandInfo;
				newGamer.nAIRandHead = gamer.nAIRandHead;
				newGamer.bIsLocation = false;
				newGamer.sAddress = "";
			}
			else
			{
				newGamer.bIsLocation = gamer.location.bIsLocation;
				newGamer.sAddress = gamer.location.sAddress;
				newGamer.sLat = gamer.location.sLat;
				newGamer.sLng = gamer.location.sLng;
			}
			room.AddGamer(newGamer);
			newGamer.Init();
			room.ShowOtherGPS();
		}
		
		//离开房间
		private function OnLeaveRoomResponse(message:*):void 
		{
			if (message.nErrorCode == 0)
			{
				
				if (message.bKick == true)
				{
					GameIF.GetPopUpDia("由于您长时间未准备，已被系统\n踢出房间，请重新加入",OnQuitRoomClick,this);
				}
				else
				{
					QuitRoom();
				}
			}
			else if (message.nErrorCode==11)
			{
				GameIF.GetPopUpDia("游戏开始就不能退出了\n您可以关闭游戏由机器人带打");
			}
			
		}
		private function OnQuitRoomClick():void 
		{
			GameIF.ClosePopUpDia();
			QuitRoom();
		}
		private function QuitRoom():void 
		{
			GameIF.DectiveLogic(LogicManager.VIPROOMLOGIC);
			GameIF.ActiveLogic(LogicManager.GAMEHALLLOGIC);
		}
		//别人离开房间
		private function OnLeaveRoomNotify(message:*):void 
		{
			m_room.OnLeaveRoomNotify(message);
		}
		//上线线
		private function OnConnectNotify(message:*):void 
		{
			m_room.OnConnectNotify(message);
		}
		//掉线
		private function OnDisConnectNotify(message:*):void 
		{
			m_room.OnDisConnectNotify(message);
		}
		//准备
		private function OnReadygameresponse(message:*):void 
		{
			if (message.nErrorCode == 0)
			{
				m_room.OnReadygameresponse();
			}
		}
		private function OnReadygamenotify(message:*):void 
		{
			m_room.OnReadygamenotify(message);
		}
		
		//解散房间
		private function onDissRoomResponse(message:*):void 
		{
			var nErrorCode:JSON = GameIF.GetJson()["nErrorCode"];
			if (message.nErrorCode == nErrorCode["success"])
			{
				GameIF.DectiveLogic(LogicManager.VIPROOMLOGIC);
				GameIF.ActiveLogic(LogicManager.GAMEHALLLOGIC);
			}
			else if (message.nErrorCode == nErrorCode["notroomowner"])
			{
				var logic:RoomSetLogic = GameIF.GetLogic(LogicManager.ROOMSETLOGIC) as RoomSetLogic;
					logic.HideRoomSet();
			
				GameIF.GetPopUpDia("您你不是房主，不能解散房间");
			}
		}
		private function OnDissRoomNotify(message:*):void 
		{
			var logic:RoomSetLogic = GameIF.GetLogic(LogicManager.ROOMSETLOGIC) as RoomSetLogic;
			logic.HideRoomSet();
			
			GameIF.DectiveLogic(LogicManager.VIPROOMLOGIC);
			GameIF.ActiveLogic(LogicManager.GAMEHALLLOGIC);
			GameIF.GetPopUpDia("房主解散房间");
		}
		
		private function OnGameOverNotify(message:*):void 
		{
			
		}
		
		//开始游戏startgamenotify
		private function OnStartGameNotify(message:*):void
		{
			//判断roomID是否相同，不相同不能开游戏
			if (message.sRoomID == GameIF.GetDalManager().dalRoom.myRoomID)
			{
				m_room.roomReset();
				m_room.OnStartGameNotify(message);
				trace("游戏开始！\r\n");
				trace("\r\n");
			}
		}
		
		//初始化牌列表initpainotify
		private function OnInitPaiNotify(message:*):void
		{
			m_room.vipRoomView.m_labPaiNum.text = message.nLeft.toString();
			m_room.InitPaipool(message.paiPool);
		}
		
		//修改时间
		private function OnGameTimeTickNotify(message:*):void 
		{
			if (m_room)
			{
				var time:int = message.nLeft;
				var shi:int = Math.floor(time / 10);
				var ge:int = time % 10;
				m_room.vipRoomView.m_clipTimeShi.index = shi;
				m_room.vipRoomView.m_clipTimeGe.index = ge;
			}
			
		}
		//起牌
		private function OnGetPaiNotify(message:*):void
		{
			m_room.OnGetPai(message);
			
		}
    	//出牌通知
		private function OnDoPutPaiNotify(message:*):void
  		{
			m_room.OnPutPai(message);
		}
		//宝牌出场动画
		private function OnBaopaiShowNotify(message:*):void 
		{
			m_room.OnBaopaiShow(message);
		}
		//确认出牌putPaiResponse
		private function OnPutPaiResponse(message:*):void
		{
			if (message.nErrorCode == 0)
			{
				m_room.OnPutPaiResponse(message);
			}
			
		}
		//出牌成功
		private function OnPutPaiNotify(message:*):void 
		{
			m_room.OnPutPaiNotify(message);
			
			if (message.putPai)
			{
				trace("ID=" + message.nUserID + "的人出了一张nType=" + message.putPai.nType+"nValue=" + message.putPai.nValue+"的牌\r\n");
			}
			else
			{
				trace("OnPutPaiNotify中pai为空\r\n");
			}
		}
		//吃碰杠听胡
		private function OnCanPaiNotify(message:*):void
		{
			m_room.OnCanPai(message);
		}
		//过
		private function OnGuoPaiResponse(message:*):void 
		{
			if (message.nErrorCode == 0)
			{
				m_room.OnGuoPaiResponse(message);
			}
		}
		//吃牌
		private function OnDoChiPaiResponse(message:*):void
		{
			if (message.nErrorCode == 0)
			{
				m_room.OnDoChiPaiResponse(message);
			}
		}
		private function OnDoChiPaiNotify(message:*):void
		{
			m_room.OnDoChiPaiNotify(message);
		}
		//碰
		private function OnDoPengPaiResponse(message:*):void 
		{
			if (message.nErrorCode == 0)
			{
				m_room.OnDoPengPaiResponse(message);
			}
		
		}
		private function OnDoPengPaiNotify(message:*):void 
		{
			m_room.OnDoPengPaiNotify(message);
			
			
		}
		//杠
		private function OnDoGangPaiResponse(message:*):void
		{
			if (message.nErrorCode == 0)
			{
				m_room.OnDoGangPaiResponse(message);
			}
			
		}
		private function OnDoGangPaiNotify(message:*):void
		{
			m_room.OnDoGangPaiNotify(message);
		}
		//听
		private function OnDoTingPaiResponse(message:*):void 
		{
			if (message.nErrorCode == 0)
				m_room.OnDoTingPaiResponse(message);
		}
		private function OnDoTingPaiNotify(message:*):void 
		{
			m_room.OnDoTingPaiNotify(message);
		}
		//抢听
		private function OnDoQiangTingPaiResponse(message:*):void 
		{
			if (message.nErrorCode == 0)
				m_room.OnDoQiangTingPaiResponse(message);
		}
		private function OnDoQiangTingPaiNotify(message:*):void 
		{
			m_room.OnDoQiangTingPaiNotify(message);
		}
		//胡
		private function OnDoHuPaiNotify(message:*):void
		{
			m_room.OnDoHuPaiNotify(message);
		}
		private function OnDoHuPaiResponse(message:*):void 
		{
			if (message.nErrorCode == 0)
			{
				m_room.OnDoHuPaiResponse(message);
				trace("胡啦 胡啦\r\n");
				trace("\r\n");
			}
		}
		
		
		//游戏结束  处理gameEndNotify
		private function OnGameEndNotify(message:*):void 
		{
			m_room.OnGameEndNotify(message);
			
			Laya.timer.once(1500, this, ShowGameSettingView);
		}
		
		private function ShowGameSettingView():void 
		{
			var logic:GameSettlementLogic = GameIF.GetLogic(LogicManager.GAMESETTLEMENTLOGIC) as GameSettlementLogic;
			logic.ShowView();
		}
		//聊天
		private function OnChatResponse(message:*):void 
		{
			if (message.nErrorCode == 0)
			{
				m_room.OnChatResponse(message);	
			}
			
		}
		
		private function OnChatNotify(message:*):void 
		{
			m_room.OnChatNotify(message);
		}
		//托管
		private function onDelegateResponse(message:*):void 
		{
			if (message.nErrorCode == 0)
			{
				m_room.onDelegateResponse(message);
			}
		
		}
		private function OnDelegateNotify(message:*):void 
		{
			
		}
		//房主变更
		private function OnOwnerChangeNotify(message:*):void 
		{
			m_room.SetOwner(message);
		}
		public override function Destroy():void
		{
			if (m_room)
			{
				m_room.Destroy();
				m_room = null;
				//断开连接
				GameIF.getInstance().networkManager.SocketClose();
				//分享
				GameIF.DectiveLogic(LogicManager.SHAREPROMPTLOGIC);
				Laya.timer.clearAll(this);
			}
			else
			{
				trace("error:m_room\r\n");
				trace("\r\n");
			}
			
		}
		public function get stateMsgHandle():Boolean 
		{
			return m_stateMsgHandle;
		}
		
		public function set stateMsgHandle(value:Boolean):void 
		{
			m_stateMsgHandle = value;
		}
		
	}
}