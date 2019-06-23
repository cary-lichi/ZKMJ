package blls 
{
	import core.GameIF;
	import core.LogicManager;
	import laya.events.Event;
	import laya.ui.Button;
	import laya.ui.Image;
	import laya.ui.Label;
	import network.NetworkManager;
	import view.ActiveView.PrizeItem;
	import view.TurntableView;
	import laya.utils.Tween;
	import laya.utils.Ease;
	import laya.utils.Handler;
	
	/**
	 * ...
	 * @author dawenhao
	 */
	public class TurntableLogic extends BaseLogic
	{
		
		private var m_turntableView:TurntableView;
		private static var m_rotationInit:int =-18;//转盘旋转角度
		private var m_nSpeed:int = 9;
		private var m_nPrizeID:int;
		private var m_nPianyi:int;
		

		public function TurntableLogic() 
		{
			super();
		}
		
		public override function Init():void
		{
			if (m_turntableView == null)
			{
				m_turntableView = new TurntableView;
				m_turntableView.Init();
			}
			m_turntableView.visible = true;
			//注册所有按钮事件
			registerEventClick();
			//数据初始化
			InitDal();
			
		}
		//接受message
		public override function OnReceiveMessage(msg:*):void
		{
			if (msg.type == 85)//RegisterResponse
			{
				OnluckyResponse(msg.response.luckyResponse);
			}
		}
		
		private function OnluckyResponse(msg:*):void 
		{
			if (msg.nErrorCode == 0)
			{
				GameIF.GetUser().nGold = msg.newAssets.nGold;
				GameIF.GetUser().nMoney = msg.newAssets.nMoney;
				m_nPrizeID =msg.nLucky;
				SetPrizePos();
			}
			else if(msg.nErrorCode==16)
			{
				GameIF.DectiveLogic(LogicManager.TURNTABLELOGIC);
			}
		}
		
		private function SetPrizePos():void 
		{
			for (var i:int = 0; i < m_turntableView.m_listPrize.length;i++ )
			{
				var prize:PrizeItem = m_turntableView.m_listPrize.getCell(i) as PrizeItem;
				if (prize.nPrizeID == m_nPrizeID)
				{
					PrizeAnimate(prize.rotation);
					return;
				}
			}
		}
		
		private function PrizeAnimate(position:int):void
		{
			m_nPianyi = position - 85.5;
			Laya.timer.loop(1, this, PrizeAnimate2);
		}
		
		//匀速
		private function PrizeAnimate2():void 
		{
			m_turntableView.m_imgPointer.rotation += 15;
			var lightPosition:int;
			lightPosition = (m_turntableView.m_imgPointer.rotation + 18) / 36;
			m_turntableView.m_imgSelected.rotation = Math.round(lightPosition)*36-18;
			
			//var pianyi:int;
			//pianyi = date-85.5;
			if (m_turntableView.m_imgPointer.rotation>=1062+m_nPianyi)
			{
				m_turntableView.m_imgPointer.rotation = m_nPianyi-18;
				Stop();
			}
			
		}
		//中转
		private function Stop():void 
		{	
				Laya.timer.clearAll(this);
				Laya.timer.loop(1, this, Decline);
		}
		//速度递减
		private function Decline():void 
		{
			//转805.5,最终85.5
			m_nSpeed = m_nSpeed - 0.05;
			m_turntableView.m_imgPointer.rotation +=m_nSpeed;
			
			var lightPosition:int;
			lightPosition = (m_turntableView.m_imgPointer.rotation + 18) / 36;
			if (m_nSpeed <= 0)
			{
				Laya.timer.clearAll(this);
				//显示奖品
				showWinningView(m_nPrizeID);
				m_nSpeed = 9;
			}
			
			m_turntableView.m_imgSelected.rotation = Math.round(lightPosition) * 36 - 18;
		}
		
		//数据初始化
		private function InitDal():void 
		{
			var PrizeIDArr:Array = [8,5,4,7,4,2,3,1,6,0];
			m_turntableView.InitPrize(PrizeIDArr);
			
			m_turntableView.m_listPrize.rotation = m_rotationInit;
			m_turntableView.m_content.scale(0.1, 0.1);
			Tween.to(m_turntableView.m_content, {"scaleX":1, "scaleY":1}, 1500, Ease.backInOut);
			
		}
		public override function Destroy():void
		{
			m_turntableView.visible = false;
			m_turntableView.Destroy();
			m_turntableView.destroy();
			m_turntableView = null;
			Laya.timer.clearAll(this);
			
		}
		
		private function registerEventClick():void 
		{
			//开始按钮
			m_turntableView.m_btnStart.on(Event.CLICK, this, onStartClick);
		}
		//好友邀请
		private function onInvitaClicked():void 
		{
			GameIF.DectiveLogic(LogicManager.TURNTABLELOGIC);
			GameIF.ActiveLogic(LogicManager.GAMEHALLLOGIC);
			GameIF.ActiveLogic(LogicManager.INVITEWINDOW);
		}
		//创建房间
		private function onCreateRoomClicked():void 
		{
			GameIF.DectiveLogic(LogicManager.TURNTABLELOGIC);
			GameIF.ActiveLogic(LogicManager.GAMEHALLLOGIC);
		}
		//购买房卡
		private function onBuyCardClicked():void 
		{
			GameIF.ActiveLogic(LogicManager.ROOMGOLDLOGIC);
		}
		//开始旋转
		private function onStartClick():void 
		{
			trace("开始旋转");
			//Laya.timer.loop(1, this, PrizeAnimate);
			SendStart();
			m_turntableView.m_btnStart.offAll();
		}
		
		private function SendStart():void 
		{
			var LuckyRequestMsg:* = NetworkManager.m_msgRoot.lookupType("LuckyRequest");
			var luckyRequestMsg:* = LuckyRequestMsg.create({
				nUserID:GameIF.GetUser().nUserID
			});
			//Request当中具体的内容
			var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
			var requestMsg:* = Request.create({
				luckyRequest:luckyRequestMsg
			});
			////包含了Request的内容
			var Msg:* = NetworkManager.m_msgRoot.lookupType("Msg");
			var MsgMessage:* = Msg.create({
				type:84,
				request:requestMsg
			});
			var encodeMessage:* = Msg.encode(MsgMessage).finish();
			GameIF.getInstance().networkManager.HttpSendMessage(encodeMessage, "lucky");
		}
		
		//
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		/////                显示抽中奖品的内容                                                             ///
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		private function showWinningView(id:int):void
		{
			var paize:JSON = GameIF.GetJson()["prize"][id];
			trace("显示中奖内容");
			//GameIF.ActiveLogic(LogicManager.WINNINGLOGIC);
			turntableView.showWinningView(paize);
			m_turntableView.imgWinningBack.on(Event.CLICK, this, onBlackScreenClicked);
			
		}
		
		public function onShowWinningClicked():void 
		{
			Laya.timer.clearAll(this);
			GameIF.DectiveLogic(LogicManager.TURNTABLELOGIC);
			GameIF.ActiveLogic(LogicManager.GAMEHALLLOGIC);
		}
		
		//黑幕被点击不会点到别的按钮。
		private function onBlackScreenClicked():void
		{	
			return;
		}
		
		public function get turntableView():TurntableView 
		{
			return m_turntableView;
		}
		
		public function set turntableView(value:TurntableView):void 
		{
			m_turntableView = value;
		}
	}

}