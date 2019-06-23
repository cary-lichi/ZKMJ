
package model._Gamer 
{
	import blls._Game.ChatLogic;
	import blls._Game.RoomLogic;
	import core.GameIF;
	import core.LogicManager;
	import dal.DalPai;
	import laya.events.Event;
	import laya.maths.Point;
	import laya.ui.Component;
	import laya.ui.List;
	import laya.utils.Dictionary;
	import laya.utils.Handler;
	import model._Gamer.Gamer;
	import model._Pai.Pai;
	import model._PaiPool.TopListPool;
	import tool.Tool;
	import view.ActiveView._gameItem.BasePaiItem;
	import view.ActiveView._gameItem.Gamer2CanPaiItem;
	import view.ActiveView._gameItem.Gamer2PaiItem;
	import view.ActiveView._gameItem.Gamer2PutPaiItem;
	import view.Room.VIPRoomView;
	import laya.utils.Tween;
	/**
	* ...
	* @author dawenhao
	*/
	public class GamerTop extends Gamer
	{
		protected var m_putPaiArr:Array = [];
		protected var m_paiPoolArr:Array = [];
		protected var m_myCanPaiArr:Array = [];
		public function GamerTop() 
		{
			super();
			nPosGame = 2;
		}
		public override function Init():void 
		{
			InitGamer();
			m_listPool = null;
			m_listPool = new TopListPool(m_mgrPai, m_vipRoomView);
			//注册所有按钮
			registerEventClick();
			renderInfo();
			
			if (m_tPaiTween == null)
			{
				m_tPaiTween = new Gamer2PutPaiItem();
				m_tPaiTween.visible = false;
				AddPaiTween();
			}
		}
		protected function registerEventClick():void 
		{
			vipRoomView.m_btnAvatar2.on(Event.CLICK, this, OnAvatar);
		}
		public override function  Reset():void
		{
			m_state = 0;
			m_bBoss = false;
			m_listPool.renderAllListInit();
			m_mgrPai.Reset();
			m_vipRoomView.m_list2Pai.visible = true;
			vipRoomView.m_gamer2GetPai.visible = false;
			OffCur();
			renderInfo();
		}
		public override function  Destroy():void
		{
			m_listPool.renderAllListInit();
			m_mgrPai.Destory();
		}
		/////////////////////////////渲染基本信息//////////////////////////////////
				//渲染自己的基本信息
		public override function  renderInfo():void 
		{
			vipRoomView.m_img2Avatar.skin = sHeadimg;
			vipRoomView.m_lableScore2.text = m_nScore.toString();
			vipRoomView.m_img2Zhuang.visible = m_bBoss;
			vipRoomView.m_imgOwner2.visible = m_bOwner;
			vipRoomView.m_imgDefaultHeadBg2.visible = false;
			vipRoomView.m_gamerGPS2.visible = true;
			vipRoomView.m_imgGPShead2.skin = sHeadimg;
			vipRoomView.m_labelGPSNick2.text = sNick;
			vipRoomView.m_imgReadyed2.visible = m_nGameState == GameIF.GetJson()["gameState"]["readyed"]?true:false;;
			var binary:String = "00100000";
			if ((m_state & parseInt(binary,2))!= 0)
			{
				vipRoomView.m_imgTingSign2.visible = true;
			}
			if (m_bOnLine)
			{
				OnConnectNotify();
			}
			else if(!m_bOnLine)
			{
				OnDisConnectNotify();
			}
			RenderInit();
		}
		//准备
		public override function OnReady():void 
		{
			nGameState = GameIF.GetJson()["gameState"]["readyed"];
			vipRoomView.m_imgReadyed2.visible = true;
		}
		//离开房间
		public override function OnLeaveRoomNotify():void 
		{
			Reset();
			vipRoomView.m_imgDefaultHeadBg2.visible = true;
			vipRoomView.m_gamerGPS2.visible = false;
			vipRoomView.m_imgReadyed2.visible = false;
			
			vipRoomView.m_boxGPS02.visible = false;
			vipRoomView.m_boxGPS12.visible = false;
			vipRoomView.m_boxGPS23.visible = false;
		}
		//上线
		public override function  OnConnectNotify():void 
		{
			m_bOnLine = true;
			m_vipRoomView.m_labelOffLine2.text = " ";
			m_vipRoomView.m_imgOffLine2.visible = false;
			m_vipRoomView.m_imgOffLineBg2.visible = false;
		}
		//掉线
		public override function  OnDisConnectNotify():void 
		{
			m_bOnLine = false;
			m_vipRoomView.m_labelOffLine2.text = "玩家"+m_sNick+"掉线";
			m_vipRoomView.m_imgOffLine2.visible = true;
			m_vipRoomView.m_imgOffLineBg2.visible = true;
		}
		/////////////////////////////渲染面前的牌（手牌）//////////////////////////////////
		public override function RenderInit():void 
		{
			RenderWall();
			RenderPutPai();
			//m_listPool.renderAllList();
		}
		//面前的牌（手牌）
		public override function RenderWall():void 
		{
			var m_paiPoolArr:Array=m_mgrPai.GetPool(m_nPaiPool);
			RenderList(m_vipRoomView.m_list2Pai, Gamer2PaiItem, ListWallRender, m_paiPoolArr);
		}
		//渲染打出去的牌
		protected function RenderPutPai():void 
		{
			m_putPaiArr = m_mgrPai.GetPool(m_nPutPool);
			RenderList(m_vipRoomView.m_list2PutPai, Gamer2PutPaiItem, RenderPutPaiAnmi, m_putPaiArr);
		}
		//挨个渲染牌
		protected function ListWallRender(item:Component,index:int):void 
		{
			var m_item:Gamer2PaiItem = item as Gamer2PaiItem;
		}
		public override function RenderPutPaiAnmi(item:Component,index:int):void
		{
			if (index < m_vipRoomView.m_list2PutPai.length)
			{
				var m_item:Gamer2PutPaiItem = item as Gamer2PutPaiItem;
				var pai:Pai = m_vipRoomView.m_list2PutPai.array[index];
				var repeatX:int = vipRoomView.m_list2PutPai.repeatX;
				m_item.pai = pai;
				m_item.x = (repeatX-1)*38 - (index %repeatX) * 38;
				m_item.y = 70 - Math.floor(index / repeatX) * 35;
				m_item.zOrder = -Math.floor(index / repeatX);
			}
			ShowCurPutPai(index);
		}
		/////////////////add by wangn///////////////////////////////////
		//起牌
		public override function OnGetPai(pai:Pai):void
		{
            m_vipRoomView.m_gamer2GetPai.visible = true;
			m_mgrPai.AddPai(pai, m_nPaiPool);
			
				var logic:RoomLogic = GameIF.GetLogic(LogicManager.VIPROOMLOGIC) as RoomLogic;
			logic.stateMsgHandle = false;
			logic.HandleMsgList();
		}
		public override function RenderGetPaiAnmi(pai:Pai):void
		{
            
		}
		
		public override function OnPutPaiNotify(pai:Pai):void
		{
			PutPaiTweenStart(pai);
		}
		//删掉上次上次打的牌
		public override function DelLastputPai(pai:Pai):void 
		{
			m_mgrPai.DelPai(pai, m_nPutPool);
			RenderPutPai();
		}
		public override function OpennCur():void 
		{
			//开灯
			vipRoomView.m_imgCur2.visible = true;
			vipRoomView.m_boxAminHead2.visible = true;
		}
		//显示房主
		public override function ShowOwner():void 
		{
			vipRoomView.m_imgOwner2.visible = true;
		}
		//显示刚打的牌的灯
		public  function ShowCurPutPai(index:int):void 
		{
			var lastindex:int = m_mgrPai.GetPool(m_nPutPool).length - 1;
			if (index != lastindex) return;
			var putpai:Gamer2PutPaiItem = vipRoomView.m_list2PutPai.getCell(index) as Gamer2PutPaiItem;
			var globalPos:Point = putpai.localToGlobal(new Point(0, 0));
			vipRoomView.m_boxCurPutPai.visible = true;
			var x:int = globalPos.x-2 * Tool.getScale();
			var y:int = globalPos.y-43 * Tool.getScale();
			vipRoomView.m_boxCurPutPai.pos(x,y);
		}
		public override function GamerInit():void 
		{
			m_vipRoomView.m_gamer2GetPai.visible = false;
		}
		
		//摊牌
		public override function OnTanPai():void
		{
			vipRoomView.m_gamer2GetPai.visible = false;
			vipRoomView.m_list2Pai.visible = false;
			m_listPool.renderTanPai();
		}
		
		////////////////////////动画/////////////////////////
		//——————————————————————————————————————————————//
		
		//打牌动画
		protected function PutPaiTweenStart(pai:Pai):void 
		{
			var index:int = GetIndex(pai);
				if (index ==-1)
				{
					trace("手牌中没有这张牌");
				}
				else
				{
					var shoupai:BasePaiItem = m_vipRoomView.m_list2Pai.getCell(index) as BasePaiItem;
				}
			var putPaiArr:Array = m_mgrPai.GetPool(m_nPutPool);
			
			var globalPos:Point = shoupai.localToGlobal(new Point(0, 0));
			m_tPaiTween.pai = pai;
			m_tPaiTween.x = globalPos.x;
			m_tPaiTween.y = globalPos.y;
			var x:int = m_vipRoomView.m_list2PutPai.localToGlobal(new Point(0, 0)).x+ m_vipRoomView.m_list2PutPai.width-(putPaiArr.length%m_vipRoomView.m_list2PutPai.repeatX)*m_tPaiTween.width;
			var y:int = m_vipRoomView.m_list2PutPai.localToGlobal(new Point(0, 0)).y+m_vipRoomView.m_list2PutPai.height;
			m_tPaiTween.PaiTweenStart(x,y,this,PutPaiTweenStop);
			shoupai.visible = false;
		}
		protected function PutPaiTweenStop():void 
		{
			m_mgrPai.AddPai(m_tPaiTween.pai, m_nPutPool);
			m_mgrPai.DelPai(m_tPaiTween.pai, m_nPaiPool);
			RenderPutPai();
			m_tPaiTween.visible = false;
			RenderWall();
			vipRoomView.m_gamer2GetPai.visible = false;

			var logic:RoomLogic = GameIF.GetLogic(LogicManager.VIPROOMLOGIC) as RoomLogic;
			logic.stateMsgHandle = false;
			logic.HandleMsgList();
		}
		//吃碰杠听胡飘字动画
		public override function CanPaiStart(type:String):void 
		{
			vipRoomView.CanPaiStart(568, 122, type);
			if (type == m_sTing)
			{      
				vipRoomView.m_imgTingSign2.visible = true;
			}
		}
		
		//public override function OnChatResponse(message:*):void
		//{
			//if (message.nErrorCode == 0)
			//{
				////var sContent:String = AnalysisMsg(ChatLogic.m_sContent);
			//
				////vipRoomView.lableLength2.text = sContent;
				////vipRoomView.m_msgBox2.width =  vipRoomView.lableLength2.width + 32;
				////vipRoomView.outPutBox2.y = 10;
			//}
		//}
		//聊天
		//注释为背景白板,滑动
		public override function OnChatNotify(message:*):void
		{
			var ContentObj:Object = AnalysisMsg(message.sContent);
			if(ContentObj.judge==1)
				{
					FaceAnimationStart();
					vipRoomView.face2.innerHTML = ContentObj.content;
				}
					
			if(ContentObj.judge==2)
				{
					vipRoomView.m_msgBox2.width = ContentObj.contentLength  + 32;
					vipRoomView.outPutBox2.x = vipRoomView.outPutLabel2.x- ContentObj.contentLength-10;
					vipRoomView.outPutBox2.y = ContentObj.y;
					vipRoomView.outPutBox2.innerHTML = ContentObj.content;
					InPutHideBubbles();
				}
		}
		protected function InPutHideBubbles():void
		{
			vipRoomView.InPutHideBubbles(vipRoomView.outPutBox2,vipRoomView.m_msgBox2);
		}
		//动画函数
		public override function FaceAnimationStart():void 
		{
			vipRoomView.FaceAnimationStart(vipRoomView.face2,vipRoomView.face2.alpha,vipRoomView.m_img2Avatar);
		}
	}

}