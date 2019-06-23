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
	import model._PaiPool.LeftListPool;
	import tool.Tool;
	import view.ActiveView._gameItem.BasePaiItem;
	import view.ActiveView._gameItem.Gamer1CanPaiItem;
	import view.ActiveView._gameItem.Gamer1PaiItem;
	import view.ActiveView._gameItem.Gamer1PutPaiItem;
	import view.Room.VIPRoomView;
	import laya.utils.Tween;
	/**
	* ...
	* @author dawenhao
	*/
	public class GamerLeft extends Gamer
	{
		protected var m_putPaiArr:Array = [];
		protected var m_paiPoolArr:Array = [];
		protected var m_myCanPaiArr:Array = [];
		
		public function GamerLeft() 
		{
			super();
			nPosGame = 1;
		}
		public override function Init():void 
		{
			InitGamer();
			m_listPool = null;
			m_listPool = new LeftListPool(m_mgrPai, m_vipRoomView);
			//注册所有按钮
			registerEventClick();
			renderInfo();
			
			if (m_tPaiTween == null)
			{
				m_tPaiTween = new Gamer1PutPaiItem();
				m_tPaiTween.visible = false;
				AddPaiTween();
			}
		}
		
		protected function registerEventClick():void 
		{
			vipRoomView.m_btnAvatar1.on(Event.CLICK, this, OnAvatar);
		}
		public override function  Reset():void
		{
			m_state = 0;
			m_bBoss = false;
			m_listPool.renderAllListInit();
			m_mgrPai.Reset();
			m_vipRoomView.m_list1Pai.visible = true;
			vipRoomView.m_gamer1GetPai.visible = false;
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
			vipRoomView.m_img1Avatar.skin = sHeadimg;
			vipRoomView.m_lableScore1.text = m_nScore.toString();
			vipRoomView.m_img1Zhuang.visible = m_bBoss;
			vipRoomView.m_imgOwner1.visible = m_bOwner;
			vipRoomView.m_imgDefaultHeadBg1.visible = false;
			vipRoomView.m_gamerGPS1.visible = true;
			vipRoomView.m_imgGPShead1.skin = sHeadimg;
			vipRoomView.m_labelGPSNick1.text = sNick;
			vipRoomView.m_imgReadyed1.visible = m_nGameState == GameIF.GetJson()["gameState"]["readyed"]?true:false;;

			var binary:String = "00100000";
			if ((m_state & parseInt(binary,2))!= 0)
			{
				vipRoomView.m_imgTingSign1.visible = true;
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
			vipRoomView.m_imgReadyed1.visible = true;
		}
		//离开房间
		public override function OnLeaveRoomNotify():void 
		{
			Reset();
			vipRoomView.m_imgDefaultHeadBg1.visible = true;
			vipRoomView.m_gamerGPS1.visible = false;
			vipRoomView.m_imgReadyed1.visible = false;
			
			vipRoomView.m_boxGPS01.visible = false;
			vipRoomView.m_boxGPS12.visible = false;
			vipRoomView.m_boxGPS13.visible = false;
		}
		//上线
		public override function  OnConnectNotify():void 
		{
			m_bOnLine = true;
			m_vipRoomView.m_labelOffLine1.text = " ";
			m_vipRoomView.m_imgOffLine1.visible = false;
			m_vipRoomView.m_imgOffLineBg1.visible = false;
		}
		//掉线
		public override function  OnDisConnectNotify():void 
		{
			m_bOnLine = false;
			m_vipRoomView.m_labelOffLine1.text = "玩家"+m_sNick+"掉线";
			m_vipRoomView.m_imgOffLine1.visible = true;
			m_vipRoomView.m_imgOffLineBg1.visible = true;
		}
		/////////////////////////////渲染面前的牌（手牌）//////////////////////////////////
		public override function RenderInit():void 
		{
			RenderWall();
			RenderPutPai();
			//m_listPool.renderAllList();
		}
		//面前的牌（手牌）
		public override  function  RenderWall():void 
		{
			var m_paiPoolArr:Array=m_mgrPai.GetPool(m_nPaiPool);
			RenderList(m_vipRoomView.m_list1Pai, Gamer1PaiItem, ListWallRender, m_paiPoolArr);
		}
		//挨个渲染牌
		protected function ListWallRender(item:Component,index:int):void 
		{
			var m_item:Gamer1PaiItem = item as Gamer1PaiItem;
			m_item.x = -8 * (12-index);
			m_item.y = 30 * (12 - index);
			m_item.zOrder = -index;
		}
		//渲染打出去的牌
		protected function RenderPutPai():void 
		{
			m_putPaiArr = m_mgrPai.GetPool(m_nPutPool);
			RenderList(m_vipRoomView.m_list1PutPai, Gamer1PutPaiItem, RenderPutPaiAnmi, m_putPaiArr);
		}
		//挨个渲染牌
		public override function RenderPutPaiAnmi(item:Component,index:int):void
		{
			if (index < m_vipRoomView.m_list1PutPai.length)
			{
				var m_item:Gamer1PutPaiItem = item as Gamer1PutPaiItem;
				var pai:Pai = m_vipRoomView.m_list1PutPai.array[index];
				var repeatY:int = vipRoomView.m_list1PutPai.repeatY;
				m_item.pai = pai;
				m_item.pivot(0.5, 0.5);
				var scale:int = 1+(index % repeatY-repeatY)*0.01;
				m_item.scale(scale,scale);
				m_item.x = 116-Math.floor(index/repeatY)*58 - (index % repeatY)*2 +m_item.width*(1-scale)*2;
				m_item.y = 29 * (index % repeatY);
				m_item.zOrder = -Math.floor(index / repeatY);
			}
			ShowCurPutPai(index);
		}
		/////////////////add by wangn///////////////////////////////////
		//起牌
		public override function OnGetPai(pai:Pai):void
		{
            m_vipRoomView.m_gamer1GetPai.visible = true;
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
			m_vipRoomView.m_imgCur1.visible = true;
			vipRoomView.m_boxAminHead1.visible = true;
		}
		//显示房主
		public override function ShowOwner():void 
		{
			vipRoomView.m_imgOwner1.visible = true;
		}
		//显示刚打的牌的灯
		public  function ShowCurPutPai(index:int):void 
		{
			var lastindex:int = m_mgrPai.GetPool(m_nPutPool).length - 1;
			if (index != lastindex) return;
			var putpai:Gamer1PutPaiItem = vipRoomView.m_list1PutPai.getCell(index) as Gamer1PutPaiItem;
			//var putpai:Gamer1PutPaiItem = vipRoomView.m_list1PutPai.get as Gamer1PutPaiItem;
			var globalPos:Point = putpai.localToGlobal(new Point(0, 0));
			vipRoomView.m_boxCurPutPai.visible = true;
			var x:int = globalPos.x + 6 * Tool.getScale();
			var y:int = globalPos.y - 43 * Tool.getScale();
			vipRoomView.m_boxCurPutPai.pos(x, y);
		}
		public override function GamerInit():void 
		{
			//隐藏getpai
			m_vipRoomView.m_gamer1GetPai.visible = false;
		}
		//摊牌
		public override function OnTanPai():void
		{
			vipRoomView.m_gamer1GetPai.visible = false;
			vipRoomView.m_list1Pai.visible = false;
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
					var shoupai:BasePaiItem = m_vipRoomView.m_list1Pai.getCell(index) as BasePaiItem;
				}
			var putPaiArr:Array = m_mgrPai.GetPool(m_nPutPool);
			
			var globalPos:Point = shoupai.localToGlobal(new Point(0, 0));
			m_tPaiTween.pai = pai;
			m_tPaiTween.x = globalPos.x;
			m_tPaiTween.y = globalPos.y;
			var x:int = m_vipRoomView.m_list1PutPai.localToGlobal(new Point(0, 0)).x + m_vipRoomView.m_list1PutPai.width;
			var y:int = m_vipRoomView.m_list1PutPai.localToGlobal(new Point(0, 0)).y+(putPaiArr.length%m_vipRoomView.m_list1PutPai.repeatY)*m_tPaiTween.height;
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
			vipRoomView.m_gamer1GetPai.visible = false;

			var logic:RoomLogic = GameIF.GetLogic(LogicManager.VIPROOMLOGIC) as RoomLogic;
			logic.stateMsgHandle = false;
			logic.HandleMsgList();
		}
		
		//吃碰杠听胡飘字动画
		public override function CanPaiStart(type:String):void 
		{
			vipRoomView.CanPaiStart(284, 264, type);
			if (type == m_sTing)
			{
				vipRoomView.m_imgTingSign1.visible = true;
			}
		}
		
		//public override function OnChatResponse(message:*):void
		//{
			//if (message.nErrorCode == 0)
			//{
				//var ContentObj:Object = AnalysisMsg(ChatLogic.m_sContent);
			//
				//vipRoomView.m_msgBox1.width = ContentObj.contentLength  + 32;
				//vipRoomView.outPutBox1.y = ContentObj.y;
				//vipRoomView.outPutBox1.innerHTML = ContentObj.content;
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
					vipRoomView.face1.innerHTML = ContentObj.content;
				}
			if(ContentObj.judge==2)
				{
					vipRoomView.m_msgBox1.width = ContentObj.contentLength  + 32;
					vipRoomView.outPutBox1.y = ContentObj.y;
					vipRoomView.outPutBox1.innerHTML = ContentObj.content;
					InPutHideBubbles();
			}
		}
		protected function InPutHideBubbles():void
		{
			vipRoomView.InPutHideBubbles(vipRoomView.outPutBox1,vipRoomView.m_msgBox1);
		}
		//动画函数
		public override function FaceAnimationStart():void 
		{
			vipRoomView.FaceAnimationStart(vipRoomView.face1,vipRoomView.face1.alpha,vipRoomView.m_img1Avatar);
		}
	}
}
