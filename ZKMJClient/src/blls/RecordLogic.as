package blls 
{
	import core.GameIF;
	import core.LogicManager;
	import laya.events.Event;
	import laya.ui.Box;
	import laya.ui.List;
	import laya.utils.Handler;
	import model.User;
	import network.NetworkManager;
	import view.ActiveView.PopUpDia;
	import view.RecordView;
	/**
	 * ...
	 * @author ...
	 */
	public class RecordLogic extends BaseLogic 
	{
		private var m_recordView:RecordView;
		private var m_message:*;
		
		public function RecordLogic() 
		{
			super();
			
		}	
		public override function Init():void
		{
			if (m_recordView == null)
			{
				m_recordView = new RecordView;
				m_recordView.Init();
			}
			m_recordView.visible = true;
			
			//注册所有按钮事件
			registerEventClick();
			//请求排行榜数据
			SendRankRequest();
		}
		//接受message
		public override function OnReceiveMessage(msg:*):void
		{
			if (msg.type == 90)//welfareResponse
			{
				OnRankResponse(msg.response.rankResponse);
			}
			else if (msg.type == 92)//rankAwardResponse
			{
				OnRankAwardResponse(msg.response.rankAwardResponse);
			}
		}
		
		private function OnRankAwardResponse(message:*):void 
		{
			if (message.nErrorCode == 0)
			{
				var user:User = GameIF.GetUser();
				user.nGold = message.newAssets.nGold;
				user.nMoney = message.newAssets.nMoney;
				
				GameIF.GetPopUpDia("恭喜你获得排行奖励");
			}
			else if(message.nErrorCode == 18)
			{
				GameIF.GetPopUpDia("你已经领过该奖品");
			}
		}
		
		private function OnRankResponse(message:*):void 
		{
			if (message.nErrorCode == 0)
			{
				m_message = message;
				m_recordView.InitMyRank(m_message.rankDayRecords.rankRequster);
				m_recordView.InitRank(m_message.rankDayRecords.rankRecords);
			}	
		}
		private function registerEventClick():void 
		{
			//返回按钮
			m_recordView.m_btnBack.on(Event.CLICK, this, onBackClick);
			//Tab选择按钮
			m_recordView.tab_record.selectHandler = new Handler(this, onSelecte); 
			//领奖
			m_recordView.m_btnAward.on(Event.CLICK, this, onAwardClick);
			//规则
			m_recordView.m_rule.on(Event.CLICK, this, onRuleClick);
		}
		
		//规则
		private function onRuleClick():void 
		{
			GameIF.ActiveLogic(LogicManager.RECORDRULELOGIC);
		}
		
		//领取奖励
		private function onAwardClick():void
		{
			SendRankAwardRequest();
			//if (m_recordView.tab_record.selectedIndex == 0)
			//{
				//if(m_Rank==1)
				//{
					//GameIF.GetPopUpDia("恭喜获得排行奖励10个钻石");
				//}
				//if(m_Rank==2)
				//{
					//GameIF.GetPopUpDia("恭喜获得排行奖励8个钻石");
				//}
				//if(m_Rank==3)
				//{
					//GameIF.GetPopUpDia("恭喜获得排行奖励6个钻石");
				//}
				//if(m_Rank>=4&&m_Rank<=10)
				//{
					//GameIF.GetPopUpDia("恭喜获得排行奖励4个钻石");
				//}
				//if(m_Rank>=11&&m_Rank<=20)
				//{
					//GameIF.GetPopUpDia("恭喜获得排行奖励2个钻石");
				//}
				//if(m_Rank>=21&&m_Rank<=50)
				//{
					//GameIF.GetPopUpDia("恭喜获得排行奖励15000金币");
				//}
				//if(m_Rank>=51&&m_Rank<=100)
				//{
					//GameIF.GetPopUpDia("恭喜获得排行奖励8800金币");
				//}
				//if(m_Rank>100)
				//{
					//GameIF.GetPopUpDia("很遗憾,没有上榜");
				//}
				//m_state1 = false;
				//judge();
				//
			//}
			//if (m_recordView.tab_record.selectedIndex == 1)
			//{
				//if(m_Rank==1)
				//{
					//GameIF.GetPopUpDia("恭喜获得排行奖励50个钻石");
				//}
				//if(m_Rank==2)
				//{
					//GameIF.GetPopUpDia("恭喜获得排行奖励40个钻石");
				//}
				//if(m_Rank==3)
				//{
					//GameIF.GetPopUpDia("恭喜获得排行奖励30个钻石");
				//}
				//if(m_Rank>=4&&m_Rank<=10)
				//{
					//GameIF.GetPopUpDia("恭喜获得排行奖励20个钻石");
				//}
				//if(m_Rank>=11&&m_Rank<=20)
				//{
					//GameIF.GetPopUpDia("恭喜获得排行奖励10个钻石");
				//}
				//if(m_Rank>=21&&m_Rank<=50)
				//{
					//GameIF.GetPopUpDia("恭喜获得排行奖励6个钻石");
				//}
				//if(m_Rank>=51&&m_Rank<=100)
				//{
					//GameIF.GetPopUpDia("恭喜获得排行奖励60000金币");
				//};
				//if(m_Rank>100)
				//{
					//GameIF.GetPopUpDia("很遗憾,没有上榜");
				//}
				//m_state2 = false;
				//judge();
			//}
			//if (m_recordView.tab_record.selectedIndex == 2)
			//{
				//if(m_Rank==1)
				//{
					//GameIF.GetPopUpDia("恭喜获得排行奖励300个钻石");
				//}
				//if(m_Rank==2)
				//{
					//GameIF.GetPopUpDia("恭喜获得排行奖励240个钻石");
				//}
				//if(m_Rank==3)
				//{
					//GameIF.GetPopUpDia("恭喜获得排行奖励180个钻石");
				//}
				//if(m_Rank>=4&&m_Rank<=10)
				//{
					//GameIF.GetPopUpDia("恭喜获得排行奖励120个钻石");
				//}
				//if(m_Rank>=11&&m_Rank<=20)
				//{
					//GameIF.GetPopUpDia("恭喜获得排行奖励60个钻石");
				//}
				//if(m_Rank>=21&&m_Rank<=50)
				//{
					//GameIF.GetPopUpDia("恭喜获得排行奖励36个钻石");
				//}
				//if(m_Rank>=51&&m_Rank<=100)
				//{
					//GameIF.GetPopUpDia("恭喜获得排行奖励360000金币");
				//}
				//if(m_Rank>100)
				//{
					//GameIF.GetPopUpDia("很遗憾,没有上榜");
				//}
				//m_state3 = false;
				//judge();
			//}
			
		}
		
		//private function judge():void
		//{
			//m_recordView.m_award.on(Event.CLICK, this, onAwardClick);
			//m_recordView.m_awardLabel.text = "领取奖励";
			//m_recordView.m_awardLabel.left = 45;
			//if (m_state1 ==false)
			//{
				//if(m_recordView.tab_record.selectedIndex==0)
					//{
						//m_recordView.m_awardLabel.text = "已领取";
						//m_recordView.m_awardLabel.left = 55;
						//m_recordView.m_award.offAll();
					//}
			//}
			//if (m_state2 ==false)
			//{
				//if(m_recordView.tab_record.selectedIndex==1)
					//{
						//m_recordView.m_awardLabel.text = "已领取";
						//m_recordView.m_awardLabel.left = 55;
						//m_recordView.m_award.offAll();
					//}
			//}
			//if (m_state3 ==false)
			//{
				//if(m_recordView.tab_record.selectedIndex==2)
					//{
						//m_recordView.m_awardLabel.text = "已领取";
						//m_recordView.m_awardLabel.left = 55;
						//m_recordView.m_award.offAll();
					//}
			//}
		//}
		
		 //点击Tab选择按钮的处理
        private function onSelecte(index:int):void
        {
			//judge();
		   switch(index)
		   {
				case 0:
					m_recordView.InitMyRank(m_message.rankDayRecords.rankRequster);
					m_recordView.InitRank(m_message.rankDayRecords.rankRecords);
					break;
				case 1:
					m_recordView.InitMyRank(m_message.rankWeekRecords.rankRequster);
					m_recordView.InitRank(m_message.rankWeekRecords.rankRecords);
					break;
				case 2:
					m_recordView.InitMyRank(m_message.rankMonthRecords.rankRequster);
					m_recordView.InitRank(m_message.rankMonthRecords.rankRecords);
					break;
				default:
					break;
		   }
        }
		
		private function onBackClick():void 
		{
			GameIF.DectiveLogic(LogicManager.RECORDLOGIC);
			GameIF.ActiveLogic(LogicManager.GAMEHALLLOGIC);
		}
		//发送领取奖励请求
		private function SendRankAwardRequest():void 
		{
			var RankAwardRequestMsg:* = NetworkManager.m_msgRoot.lookupType("RankAwardRequest");
			var rankAwardRequestMsg:* = RankAwardRequestMsg.create({
				nUserID:GameIF.GetUser().nUserID,
				nRankType:0
			});
			//Request当中具体的内容
			var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
			var requestMsg:* = Request.create({
				rankAwardRequest:rankAwardRequestMsg
			});
			////包含了Request的内容
			var Msg:* = NetworkManager.m_msgRoot.lookupType("Msg");
			var MsgMessage:* = Msg.create({
				type:91,
				request:requestMsg
			});
			var encodeMessage:* = Msg.encode(MsgMessage).finish();
			GameIF.getInstance().networkManager.HttpSendMessage(encodeMessage, "rankAward");
		}
		//发送请求排行数据请求
		private function SendRankRequest():void 
		{
			var RankRequestMsg:* = NetworkManager.m_msgRoot.lookupType("RankRequest");
			var rankRequestMsg:* = RankRequestMsg.create({
				nUserID:GameIF.GetUser().nUserID
			});
			//Request当中具体的内容
			var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
			var requestMsg:* = Request.create({
				rankRequest:rankRequestMsg
			});
			////包含了Request的内容
			var Msg:* = NetworkManager.m_msgRoot.lookupType("Msg");
			var MsgMessage:* = Msg.create({
				type:89,
				request:requestMsg
			});
			var encodeMessage:* = Msg.encode(MsgMessage).finish();
			GameIF.getInstance().networkManager.HttpSendMessage(encodeMessage, "rank");
		}
		
		public override function Destroy():void
		{		
			m_recordView.Destroy();
			m_recordView.destroy();
			//m_recordView.visible = false;
			m_recordView = null;
		}
	}

}