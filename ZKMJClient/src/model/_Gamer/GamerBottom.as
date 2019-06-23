package model._Gamer 
{
	import adobe.utils.CustomActions;
	import blls.BaseLogic;
	import blls._Game.ChatLogic;
	import blls._Game.GamerInfoLogic;
	import blls._Game.RoomLogic;
	import core.GameIF;
	import core.LogicManager;
	import model._Pai.ChiPai;
	import model._Pai.GangPai;
	import model._Pai.Pai;
	import model._Pai.PengPai;
	import model._PaiPool.BottomListPool;
	import model._PaiPool.ListPool;
	import dal.DalPai;
	import laya.events.Event;
	import laya.events.Event;
	import laya.maths.Point;
	import laya.ui.Component;
	import laya.ui.List;
	import laya.utils.Dictionary;
	import laya.utils.Handler;
	import model._Gamer.Gamer;
	import network.NetworkManager;
	import tool.Tool;
	import view.ActiveView._gameItem.BaseCanPaiItem;
	import view.ActiveView._gameItem.BasePaiItem;
	import view.ActiveView._gameItem.ChiPaiItem;
	import view.ActiveView._gameItem.Gamer0CanPaiItem;
	import view.ActiveView._gameItem.Gamer0PaiItem;
	import view.ActiveView._gameItem.Gamer0PutPaiItem;
	import view.ActiveView._gameItem.GangPaiItem;
	import view.ActiveView._gameItem.HuTipItem;
	import view.ActiveView._gameItem.QiangTingPaiItem;
	import view.ActiveView._gameSettlementItem.BaseItem;
	import view.Room.VIPRoomView;
	import laya.utils.Tween;
	import laya.utils.Ease;
	/**
	* ...
	* @author dawenhao
	*/
	public class GamerBottom extends Gamer
	{
		protected var m_ClickPai:Gamer0PaiItem;
		protected var m_putPaiTimers:Number=0;
		protected var m_message:*;
		protected var m_SelectedIndex:Number;
		protected var m_bTing:Boolean = false;
		protected var m_nCanPaiPos:int;
		
		public function GamerBottom() 
		{
			super();
			nPosGame = 0;
			
		}
		public override function Init():void
		{
			InitGamer();
			m_listPool = null;
			m_listPool = new BottomListPool(m_mgrPai, vipRoomView);
			//注册所有按钮
			registerEventClick();
			renderInfo();
			
			if (m_tPaiTween == null)
			{
				m_tPaiTween = new Gamer0PaiItem();
				m_tPaiTween.visible = false;
				AddPaiTween();
			}
		}
		public override function  Reset():void
		{
			m_bBoss = false;
			m_bTing = false;
			m_state = 0;
			m_ClickPai = null;
			m_message = null;
			TingPaiInit();
			m_listPool.renderAllListInit();
			m_mgrPai.Reset();
			vipRoomView.m_listPai.visible = true;
			vipRoomView.btnGetPaiP.visible = false;
			OffCur();
			InitButton();
			renderInfo();
		}
		public override function  Destroy():void
		{
			m_listPool.renderAllListInit();
			m_ClickPai = null;
			m_message = null;
			m_mgrPai.Destory();
		}
		public override function GamerInit():void 
		{
			//隐藏打的牌
			//vipRoomView.m_imgPutPaiCircle.visible = false;
			//把上次点击的牌致空
			m_ClickPai = null;
			//Laya.timer.clear(this, PutpaiTimer);
		}
		protected function registerEventClick():void 
		{
			//点击手牌
			vipRoomView.m_listPai.mouseHandler = new Handler(this, onPaiSelected);
			vipRoomView.m_listPai.mouseEnabled = false;
			//点击geipai
			vipRoomView.btnGetPaiP.on(Event.CLICK, this, onPaiSelected);
			vipRoomView.btnGetPaiP.mouseEnabled = false;

			vipRoomView.m_btnPeng.on(Event.CLICK, this, onPengClicked);
			vipRoomView.m_btnGang.on(Event.CLICK, this, onGangClicked);
			vipRoomView.m_btnChi.on(Event.CLICK , this, onChiClicked);
			vipRoomView.m_btnHu.on(Event.CLICK, this, onHuClicked);
			
			vipRoomView.m_btnAvatar0.on(Event.CLICK, this, OnAvatar);
		}
		protected function InitButton():void 
		{
			vipRoomView.m_listChiPai.visible = false;
			vipRoomView.m_btnPeng.visible = false;
			vipRoomView.m_btnChi.visible = false;
			vipRoomView.m_btnGang.visible = false;
			vipRoomView.m_btnGuo.visible = false;
			vipRoomView.m_btnTing.visible = false;
			vipRoomView.m_btnHu.visible = false;
		}
		/////////////////////////////渲染基本信息//////////////////////////////////
				//渲染自己的基本信息
		public override function renderInfo():void 
		{
			vipRoomView.m_img0Avatar.skin = sHeadimg;
			vipRoomView.m_lableScore0.text = m_nScore.toString();
			vipRoomView.m_img0Zhuang.visible = m_bBoss;
			vipRoomView.m_imgOwner0.visible = m_bOwner;
			
			vipRoomView.m_gamerGPS0.visible = true;
			vipRoomView.m_imgGPShead0.skin = sHeadimg;
			vipRoomView.m_labelGPSNick0.text = sNick;
			
			SetGameState();
			var binary:String = "00100000";
			if ((m_state & parseInt(binary,2))!= 0)
			{
				vipRoomView.m_imgTingSign0.visible = true;
				m_bTing = true;
				ResetItems();
			}
			
			RenderInit();
		}
		
		private function SetGameState():void 
		{
			var gameState:JSON = GameIF.GetJson()["gameState"];
			vipRoomView.m_imgReadyed0.visible = m_nGameState == gameState["readyed"]?true:false;
			if(m_nGameState == gameState["join"])
			{
				vipRoomView.m_btnStartGame.visible = true;
				vipRoomView.m_btnAvatar0.visible = false;
			}
			else 
			{
				vipRoomView.m_btnStartGame.visible = false;
				vipRoomView.m_btnAvatar0.visible = true;
			}
		}
		//准备
		public override function OnReady():void 
		{
			nGameState = GameIF.GetJson()["gameState"]["readyed"];
			vipRoomView.m_btnAvatar0.visible = true;
			vipRoomView.m_imgReadyed0.visible = true;
			vipRoomView.m_btnStartGame.visible = false;
		}
		//托管
		public override function SetDelegate(value:Boolean):void 
		{
			vipRoomView.m_boxDelegate.visible = value;
		}
		/////////////////////////////渲染牌//////////////////////////////////
		public override function RenderInit():void 
		{			
			RenderWall();
			RenderPutPai();
			//m_listPool.renderAllList();
		}
		
		
		//面前的牌
		public override function RenderWall():void 
		{
			//起的牌
			vipRoomView.btnGetPaiP.visible = false;
			vipRoomView.btnGetPaiP.y = 0;
			//手牌
			var paiPoolArr:Array = m_mgrPai.GetPool(m_nPaiPool);
			RenderList(vipRoomView.m_listPai, Gamer0PaiItem, ListWallRender, paiPoolArr);
		}
		
		//挨个渲染牌
		protected function ListWallRender(item:Component,index:int):void 
		{
			var m_item:Gamer0PaiItem = item as Gamer0PaiItem;
			var pai:Pai = vipRoomView.m_listPai.array[index];
			m_item.pai = pai;
			
			m_item.y = 0;
			if (vipRoomView.m_listPai.length == 14)
			{
				m_item.x = (14 - vipRoomView.m_listPai.length + index) * m_item.paiBg.width;
			}
			else
			{
				m_item.x = (13 - vipRoomView.m_listPai.length + index) * m_item.paiBg.width;
			}
			
			
			if (index==vipRoomView.m_listPai.array.length-1)
			{
				if (vipRoomView.btnGetPaiP.visible == false && vipRoomView.m_listPai.mouseEnabled==true)
				{
					if (!m_item.backBg.visible)
					{
						ReadyputPaiStart();
					}
					
				}
			}
		}
		//渲染出的牌
		protected function RenderPutPai():void 
		{
			var putPaiArr:Array = m_mgrPai.GetPool(m_nPutPool);
			RenderList(vipRoomView.m_listPutPai, Gamer0PutPaiItem, RenderPutPaiAnmi, putPaiArr);
		}
		
		public override function RenderPutPaiAnmi(item:Component,index:int):void
		{
			if (index < vipRoomView.m_listPutPai.length)
			{
				var m_item:Gamer0PutPaiItem = item as Gamer0PutPaiItem;
				var pai:Pai = vipRoomView.m_listPutPai.array[index];
				m_item.pai = pai;
				m_item.y = Math.floor(index/vipRoomView.m_listPutPai.repeatX) * 49;
				m_item.zOrder = index;
			}
		}
		//渲染吃选择的牌
		protected function RenderSelectPai():void 
		{
			trace("执行RenderSelectPai");
			vipRoomView.m_listChiPai.visible = true;
			RenderList(vipRoomView.m_listChiPai, ChiPaiItem, RenderSelectPaiAnmi, m_message.canChiPool);
		}
		//渲染抢听选择的牌
		protected function RenderQtSelectPai():void 
		{
			var Qiangting:Array = [];
			for each(var pai:Pai in m_message.canPengPool)
			{
				Qiangting.push({nType:pai.nType,nValue1:pai.nValue,nValue2:pai.nValue,nValue3:pai.nValue});
			}
			for each(var pai2:Pai in m_message.canChiPool)
			{
				Qiangting.push(pai2);
			}
			RenderList(vipRoomView.m_listChiPai, QiangTingPaiItem, RenderSelectPaiAnmi, Qiangting);
			vipRoomView.m_listChiPai.visible = true;
		}
		protected function RenderSelectPaiAnmi(item:Component,index:int):void 
		{
			trace("渲染第" + index + "张牌");
			var chiItem:BaseCanPaiItem = item as BaseCanPaiItem;
			if (index < vipRoomView.m_listChiPai.length)
			{	
				var data:* = vipRoomView.m_listChiPai.array[index];
				var chipai:ChiPai = new ChiPai;
				chipai.pai1 = m_mgrPai.createPai(data.nType, data.nValue1);
				chipai.pai2 = m_mgrPai.createPai(data.nType, data.nValue2);
				chipai.pai3 = m_mgrPai.createPai(data.nType, data.nValue3);
				trace("构造chipai");
				chiItem.renderItem(chipai);
			}
			//动态设置居中奇偶数分开设置
			if (vipRoomView.m_listChiPai.length % 2 != 0)
			{
				var OddNum:int = Math.floor( vipRoomView.m_listChiPai.length / 2);
				chiItem.centerX = (OddNum - index) * (-chiItem.btnBg.width);
			}
			else if (vipRoomView.m_listChiPai.length % 2 == 0)
			{
				var evenNum:int = vipRoomView.m_listChiPai.length / 2;
				chiItem.centerX = ( evenNum - index) * ( -chiItem.btnBg.width) + (chiItem.btnBg.width / 2);
			}
			//设置间隔
			if (vipRoomView.m_listChiPai.length >= 2)
			{
				switch(vipRoomView.m_listChiPai.length)
				{
					case 2:
						if (index == 0)
						{
							chiItem.x -= 2;
						}
						else if(index == 1)
						{
							chiItem.x += 2;
						}
						break;
					case 3:
						if (index == 0)
						{
							chiItem.x -= 4;
						}
						else if (index == 2)
						{
							chiItem.x += 4;
						}
						break;
				}
			}
			trace("RenderSelectPaiAnmi m_listChiPai X:"+vipRoomView.m_listChiPai.x+" Y:"+vipRoomView.m_listChiPai.y);
			trace("RenderSelectPaiAnmi chiItem X:" + chiItem.x + " Y:" + chiItem.y);
			trace(vipRoomView.m_listChiPai);
		}
		//渲染抢听选择的牌
		protected function RenderGangSelectPai():void 
		{
			vipRoomView.m_listChiPai.visible = true;
			RenderList(vipRoomView.m_listChiPai, GangPaiItem, RenderGangSelectPaiAnmi, m_message.canGangPool);
		}
		
		protected function RenderGangSelectPaiAnmi(item:Component,index:int):void 
		{
			var chiItem:BaseCanPaiItem = item as BaseCanPaiItem;
			if (index < vipRoomView.m_listChiPai.length)
			{	
				var data:* = vipRoomView.m_listChiPai.array[index];
				var gangpai:Pai = new Pai;
				gangpai = m_mgrPai.createPai(data.nType, data.nValue);
				chiItem.renderItem(gangpai);
			}
			//动态设置居中奇偶数分开设置
			if (vipRoomView.m_listChiPai.length % 2 != 0)
			{
				var OddNum:int = Math.floor( vipRoomView.m_listChiPai.length / 2);
				chiItem.centerX = (OddNum - index) * (-chiItem.btnBg.width);
			}
			else if (vipRoomView.m_listChiPai.length % 2 == 0)
			{
				var evenNum:int = vipRoomView.m_listChiPai.length / 2;
				chiItem.centerX = ( evenNum - index) * ( -chiItem.btnBg.width) + (chiItem.btnBg.width / 2);
			}
			//设置间隔
			if (vipRoomView.m_listChiPai.length >= 2)
			{
				switch(vipRoomView.m_listChiPai.length)
				{
					case 2:
						if (index == 0)
						{
							chiItem.x -= 2;
						}
						else if(index == 1)
						{
							chiItem.x += 2;
						}
						break;
					case 3:
						if (index == 0)
						{
							chiItem.x -= 4;
						}
						else if (index == 2)
						{
							chiItem.x += 4;
						}
						break;
				}
			}
		}
		//渲染能胡什么牌
		public  function RenderCanHu():void 
		{
			if (m_ClickPai.canHuPai != null)
			{
				vipRoomView.m_listCanHuPaiBg.visible = true;
				vipRoomView.m_listCanHuPai.repeatY = m_ClickPai.canHuPai.length;
				vipRoomView.m_listCanHuPaiBg.width = 54 + 137 * m_ClickPai.canHuPai.length;
				vipRoomView.m_listCanHuPaiBg.centerX = 0;
				RenderList(vipRoomView.m_listCanHuPai, HuTipItem, ListRenderCanHu, m_ClickPai.canHuPai);
			}
		
		}
		protected function ListRenderCanHu(item:Component,index:int):void 
		{
			var m_item:HuTipItem = item as HuTipItem;
			var CanHuPai:* = vipRoomView.m_listCanHuPai.array[index];
			m_item.pai = CanHuPai.pai;
			m_item.paiNum.text = CanHuPai.count.toString();
			m_item.y = 0;
			m_item.x = 133*index;
		}
		/////////////////add by wangn///////////////////////////////////
		//起牌
		public override function OnGetPai(pai:Pai):void
		{
			//显示刚起牌
			//vipRoomView.btnGetPaiP.visible = true;
			
			vipRoomView.btnGetPaiP.pai = pai;
			GetPaiTweenStart();
		}

		public override function RenderGetPaiAnmi(pai:Pai):void
		{
            
		}
		
		//打牌
		public override function OnPutPai(message:*):void
		{
			m_message = message;
			handleCanPutPai();
			handleRenderTingPai();
		}
		public override function OnPutPaiResponse(pai:Pai):void
		{
			trace("收到打牌响应");
			if (vipRoomView.btnGetPaiP.visible)
			{
				trace("把起的牌加到牌墙里面");
				if(vipRoomView.btnGetPaiP.pai)
				{
					
					m_mgrPai.AddPai(vipRoomView.btnGetPaiP.pai, m_nPaiPool);
				}
				else
				{
					trace("起的pai为null");
				}
				
			}
			//隐藏可以胡的牌
			vipRoomView.m_listCanHuPaiBg.visible = false;
			//不能打牌
			vipRoomView.m_listPai.mouseEnabled = false;
			vipRoomView.btnGetPaiP.mouseEnabled = false;
			
			PutPaiTweenStart(pai);
		}
		//摸听
		protected function handleCanMoTing():void 
		{
			if (m_message.canTing)
			{
				vipRoomView.m_btnGuo.visible = true;
				vipRoomView.m_btnGuo.offAll();
				vipRoomView.m_btnGuo.on(Event.CLICK, this, OnMoTingGuoClicked);
				vipRoomView.m_btnTing.visible = true;
				vipRoomView.m_btnTing.x = GetCanPaiPos();
				vipRoomView.m_btnTing.offAll();
				vipRoomView.m_btnTing.on(Event.CLICK, this, onTingClicked);
			}
			
		}
		
		protected function handleCanPutPai():void 
		{
			if (m_message.nPutState==GameIF.GetJson()["PutState"]["putpai"])
			{
				//可以打牌
				vipRoomView.m_listPai.mouseEnabled = true;
				vipRoomView.btnGetPaiP.mouseEnabled = true;
			}
			
		}
		protected function handleRenderTingPai():void 
		{
			if (0!=m_message.huPais.length)
			{
				RenderTing(m_message.huPais);
				//可以打牌
				vipRoomView.m_listPai.mouseEnabled = true;
				vipRoomView.btnGetPaiP.mouseEnabled = true;
			}
			
		}
		//删掉上次上次打的牌
		public override function DelLastputPai(pai:Pai):void 
		{
			m_mgrPai.DelPai(pai, m_nPutPool);
			RenderPutPai();
		}
		//开灯
		public override function OpennCur():void 
		{
			vipRoomView.m_imgCur0.visible = true;
			vipRoomView.m_boxAminHead0.visible = true;
		}
		//显示房主
		public override function ShowOwner():void 
		{
			vipRoomView.m_imgOwner0.visible = true;
		}
		//显示刚打的牌的灯
		public  function ShowCurPutPai():void 
		{
			var index:int = m_mgrPai.GetPool(m_nPutPool).length - 1;
			var putpai:Gamer0PutPaiItem = vipRoomView.m_listPutPai.getCell(index) as Gamer0PutPaiItem;
			var globalPos:Point = putpai.localToGlobal(new Point(0, 0));
			vipRoomView.m_boxCurPutPai.visible = true;
			var x:int = globalPos.x;
			var y:int = globalPos.y-43 * Tool.getScale();
			vipRoomView.m_boxCurPutPai.pos(x,y);
		}
		/////////////////////////////吃碰杠听胡//////////////////////////////////
		public override function  OnCanPai(message:*):void
		{
			vipRoomView.m_btnGuo.visible = true;
			vipRoomView.m_btnGuo.offAll();
			vipRoomView.m_btnGuo.on(Event.CLICK, this, OnGuoClicked);
			
			m_message = message;
			m_nCanPaiPos = 0;
			handleCanHuPai();
			handleCanChiPai();
			handleCanPengPai();
			handleCanGangPai();
			handleCanMoTing();
            handleCanQiangTingPai();
		}
		
		protected function handleCanHuPai():void
		{
			if (m_message.canHu != true)
			    return;
			var json:JSON = GameIF.GetJson()["lastHuType"];
			if (m_message.lastHuType == json['bao'])
			{
				vipRoomView.btnGetPaiP.ShowBaoTip();
			}
			if (m_message.bZm)
			{
				vipRoomView.m_btnGuo.offAll();
				vipRoomView.m_btnGuo.on(Event.CLICK, this, OnZiMoClicked);
			}
			vipRoomView.m_btnHu.visible = true;
		}
		protected function handleCanChiPai():void
		{
			if (m_message.canChiPool.length == 0)
				return;
			if (m_message.canChi != true)
				return;
			vipRoomView.m_btnChi.x = GetCanPaiPos();
			vipRoomView.m_btnChi.visible = true;
		}

		protected function handleCanPengPai():void
		{
			if (m_message.canPengPool.length == 0)
				return;
			if (m_message.canPeng != true)
				return;
			vipRoomView.m_btnPeng.visible = true;
			vipRoomView.m_btnPeng.x = GetCanPaiPos();
		}
		protected function handleCanGangPai():void
		{
			var json:JSON = GameIF.GetJson()["GangType"];
			if (m_message.canGangPool.length == 0)
				return;
			if (m_message.canGang != true)
				return;
			vipRoomView.m_btnGang.visible = true;
			vipRoomView.m_btnGang.x = GetCanPaiPos();
			
			if (m_message.canGangPool[0].nGangState == json["AnGang"]
				||m_message.canGangPool[0].nGangState==json["MoGang"])
			{
				vipRoomView.m_btnGuo.offAll();
				vipRoomView.m_btnGuo.on(Event.CLICK, this, OnMoGangGuoClicked);
			}
		}
		protected function handleCanQiangTingPai():void
		{
			if (m_message.canQiangTing != true)
			    return;
			vipRoomView.m_btnTing.visible = true;
			vipRoomView.m_btnTing.x = GetCanPaiPos();
			vipRoomView.m_btnTing.offAll();
			vipRoomView.m_btnTing.on(Event.CLICK, this, onQiangTingClicked);
		}	
		protected function GetCanPaiPos():int 
		{
			var pos:int = 750 - 170 * m_nCanPaiPos;
			m_nCanPaiPos++;
			return pos;
		}
		//过牌
		public override function OnGuoPaiResponse():void 
		{
			InitButton();
		}
		//吃牌
		public override function OnDoChiPaiResponse(message:*):void
		{
			CanPaiStart(m_sChi);
			//var chipaiobj:*= m_message.canChiPool[message.nChiIndex];
			//渲染吃牌
			RenderChiPai(message.pai,m_message.lastPai);
			RenderWall();
			InitButton();
			m_message.canChiPool = null;
			vipRoomView.m_listChiPai.mouseHandler = null;
			
		}
		//碰牌
		public override function OnDoPengPaiResponse():void 
		{
			CanPaiStart(m_sPeng);
			RenderPengPai(m_message.lastPai);
			RenderWall();
			InitButton();
		}
		//杠牌
		public override function OnDoGangPaiResponse():void 
		{
			CanPaiStart(m_sGang);
			
			vipRoomView.m_btnGang.visible = true;
			var canpai:GangPai = new GangPai;
			canpai.pai1 = m_message.canGangPool[0];
			canpai.pai2 = m_message.canGangPool[0];
			canpai.pai3 = m_message.canGangPool[0];
			canpai.rendered = false;
			m_mgrPai.AddPai(canpai, m_nMgangPool);
			for (var j:int = 0; j < 3; j++ )
			{
				m_mgrPai.DelPai(m_message.lastPai, m_nPaiPool);
			}
			//需要渲染cnapai
			m_listPool.renderAllList();
			RenderWall();
			InitButton();
			//打牌准备
			//ReadyputPaiStart();
			
		}
		//摸杠牌
		public override function OnDoMoGangPaiResponse(message:*):void 
		{
			CanPaiStart(m_sGang);
			InitButton();
			var pengArr:Array = m_mgrPai.GetPool(m_nPengPool);
			for each(var pengPai:PengPai in pengArr)
			   {
				   if (pengPai.pai1.nType == message.pai.nType)
						if (pengPai.pai1.nValue == message.pai.nValue)
						{
							m_listPool.addMoGang(pengPai.view);
							mgrPai.AddPai(vipRoomView.btnGetPaiP.pai, m_nPaiPool);
							mgrPai.DelPai(message.pai, m_nPaiPool);
							RenderWall();
							return;
						}
			   }
		}
		//暗杠
		public override function OnDoAnGangPaiResponse(message:*):void 
		{
			CanPaiStart(m_sGang);
			InitButton();
			//vipRoomView.m_btnGang.visible = true;
			var canpai:GangPai = new GangPai;
			canpai.pai1 = message.pai;
			canpai.pai2 = message.pai;
			canpai.pai3 = message.pai;
			canpai.rendered = false;
			if (vipRoomView.btnGetPaiP.pai)
			{
				m_mgrPai.AddPai(vipRoomView.btnGetPaiP.pai, m_nPaiPool);
			}
			m_mgrPai.AddPai(canpai, m_nAgangPool);
			for (var j:int = 0; j < 4; j++ )
			{
				m_mgrPai.DelPai(message.pai, m_nPaiPool);
			}
			//需要渲染cnapai
			m_listPool.renderAllList();
			RenderWall();
			m_message.canGangPool = null;
			RenderGangSelectPai();
			vipRoomView.m_listChiPai.visible = false;
			vipRoomView.m_listChiPai.mouseHandler = null;

		}
		//听牌
		public override function OnDoTingPaiResponse():void 
		{
			CanPaiStart(m_sTing);
			
			RenderTing(m_message.huPais);
			vipRoomView.m_listPai.mouseEnabled = true;
			vipRoomView.btnGetPaiP.mouseEnabled = true;
			InitButton();
			m_bTing = true;
		}
		//抢听
		public override function OnDoQiangTingPaiResponse(message:*):void 
		{
			CanPaiStart(m_sTing);
			vipRoomView.m_listPai.mouseEnabled = true;
			vipRoomView.btnGetPaiP.mouseEnabled = true;
			
			if (message.pengpai != undefined)
			{
				RenderPengPai(message.pengpai);
			}
			if (message.chipai != undefined)
			{
				RenderChiPai(message.chipai, message.lastPai);
			}
			RenderWall();
			InitButton();
			m_bTing = true;
		}
		//胡牌
		public override function OnDoHuPai():void 
		{
			vipRoomView.m_btnHu.visible=true;
		}
		public override function OnDoHuPaiResponse():void 
		{
			CanPaiStart(m_sHu);
			InitButton();
		}
		
		public override function OnTanPai():void
		{
			vipRoomView.btnGetPaiP.visible = false;
			vipRoomView.m_listPai.visible = false;
			m_listPool.renderTanPai();
		}
		/////////////////////动画//////////////////////
		//起牌动画
		protected function GetPaiTweenStart():void 
		{
			var globalPos:Point = vipRoomView.btnGetPaiP.localToGlobal(new Point(0, 0));
			var x:int = globalPos.x;
			var y:int = globalPos.y;
			m_tPaiTween.pai = vipRoomView.btnGetPaiP.pai;
			m_tPaiTween.x = vipRoomView.m_listPai.localToGlobal(new Point(0, 0)).x;
			m_tPaiTween.y = vipRoomView.m_listPai.localToGlobal(new Point(0, 0)).y-100;
			m_tPaiTween.PaiTweenStart(x, m_tPaiTween.y, this, GetPaiTweenDown);
			m_tPaiTween.visible = true;
		}
		protected function GetPaiTweenDown():void 
		{
			m_tPaiTween.PaiTweenStart(m_tPaiTween.x,m_tPaiTween.y+100,this,GetPaiTweenStop);
		}
		protected function GetPaiTweenStop():void 
		{
			m_tPaiTween.visible = false;	
			vipRoomView.btnGetPaiP.visible = true;
			
			var logic:RoomLogic = GameIF.GetLogic(LogicManager.VIPROOMLOGIC) as RoomLogic;
			logic.stateMsgHandle = false;
			logic.HandleMsgList();
		}
		//吃碰杠听之后做打牌准备动画
		protected function ReadyputPaiStart():void 
		{
			var putPaiArr:Array = m_mgrPai.GetPool(m_nPaiPool);
			//找到最后一张牌
			var pai:Gamer0PaiItem = vipRoomView.m_listPai.getCell(putPaiArr.length - 1) as Gamer0PaiItem;
			//var globalPos:Point = pai.localToGlobal(new Point(0, 0));
			//pai.x = globalPos.x;
			//pai.y = globalPos.y;
			pai.PutPaiTweenRight();
			pai.index =-1;

		}
		protected function ReadyputPaiStop():void 
		{
			//vipRoomView.btnGetPaiP.visible = true;
			//vipRoomView.btnGetPaiP.pai = m_tPaiTween.pai;
			
			//Laya.stage.removeChild(m_tPaiTween);
			//m_tPaiTween = null;
			//m_tPaiTween.visible = false;
		}
		//打牌动画
		protected function PutPaiTweenStart(pai:Pai):void 
		{
			var putPaiArr:Array = m_mgrPai.GetPool(m_nPutPool);
			if (m_ClickPai == null)
			{
				if (this.vipRoomView.btnGetPaiP.visible&&vipRoomView.btnGetPaiP.pai)
				{
					//用户有起的牌，优先考虑
					if (pai.nType == vipRoomView.btnGetPaiP.pai.nType && pai.nValue == vipRoomView.btnGetPaiP.pai.nValue)
					{
						m_ClickPai = vipRoomView.btnGetPaiP;
						m_ClickPai.index = undefined;
					}
					else
					{						
						m_ClickPai = vipRoomView.m_listPai.getCell(GetIndex(pai)) as Gamer0PaiItem ;
						m_ClickPai.index = GetIndex(pai);
					}
				}
				else
				{					
					m_ClickPai = vipRoomView.m_listPai.getCell(GetIndex(pai)) as Gamer0PaiItem ;
					m_ClickPai.index = GetIndex(pai);
				}
			}
			var globalPos:Point = m_ClickPai.localToGlobal(new Point(0, 0));
			m_tPaiTween.pai = pai;
			m_tPaiTween.x = globalPos.x;
			m_tPaiTween.y = globalPos.y;
			var x:int = vipRoomView.m_listPutPai.localToGlobal(new Point(0, 0)).x+(putPaiArr.length%vipRoomView.m_listPutPai.repeatX)*m_tPaiTween.width;
			var y:int = vipRoomView.m_listPutPai.localToGlobal(new Point(0, 0)).y;
			m_tPaiTween.PaiTweenStart(x, y, this, PutPaiTweenStop);
			m_tPaiTween.visible = true;
			m_ClickPai.visible = false;
		}
		protected function PutPaiTweenStop():void 
		{
			m_mgrPai.AddPai(m_tPaiTween.pai, m_nPutPool);
			m_mgrPai.DelPai(m_tPaiTween.pai, m_nPaiPool);
			RenderPutPai();
			m_tPaiTween.visible = false;
			//显示打牌的指针
			ShowCurPutPai();
			//装牌
			ZhuangPaiTweenStart();
		}
		//装牌动画
		protected function ZhuangPaiTweenStart():void 
		{
			//没有起牌
			if (vipRoomView.btnGetPaiP.visible == false)
			{
				ZhuangPaiTweenStop();
				return;
			}
			var index:* = GetIndex(vipRoomView.btnGetPaiP.pai);
			var ClickPaiIndex:*= m_ClickPai.index;
			//点击的是起的牌
			if (ClickPaiIndex == undefined)
			{
				ZhuangPaiTweenStop();
				return;
			}
			m_tPaiTween.pai = vipRoomView.btnGetPaiP.pai;
			var globalPos:Point = vipRoomView.btnGetPaiP.localToGlobal(new Point(0, 0));
			m_tPaiTween.x = globalPos.x;
			m_tPaiTween.y = globalPos.y;
			m_tPaiTween.PaiTweenStart(m_tPaiTween.x, m_tPaiTween.y - 100, this, ZhuangPaiLeft);
			m_tPaiTween.visible = true;
			vipRoomView.btnGetPaiP.visible = false;
		}
		protected function ZhuangPaiLeft():void 
		{
			if (vipRoomView.btnGetPaiP.pai)
			{
				var index:int = GetIndex(vipRoomView.btnGetPaiP.pai);
				if (index ==-1)
				{
					ZhuangPaiTweenStop();
					return;
				}
				var pai:Gamer0PaiItem = vipRoomView.m_listPai.getCell(index) as Gamer0PaiItem;
				var paiPos:Point = pai.localToGlobal(new Point(0, 0));
				var x:int = paiPos.x;
				var y:int = paiPos.y;
				m_tPaiTween.PaiTweenStart(x, m_tPaiTween.y, this, ZhuangPaiDown);
				m_tPaiTween.visible = true;
			}
			else
			{
				index = 0;
			}
			if (m_ClickPai.index < index )
			{
				for (var i:int = m_ClickPai.index; i <= index ; i++ )
				{
					pai = vipRoomView.m_listPai.getCell(i) as Gamer0PaiItem;
					pai.ZhuangPaiTweenLeft();
				}
			}
			else if(index< m_ClickPai.index)
			{
				for (var j:int = index; j <= m_ClickPai.index ; j++ )
				{
					pai = vipRoomView.m_listPai.getCell(j) as Gamer0PaiItem;
					pai.ZhuangPaiTweenRight();
				}
			}
		}
		protected function ZhuangPaiDown():void 
		{
			m_tPaiTween.PaiTweenStart(m_tPaiTween.x,m_tPaiTween.y+100,this,ZhuangPaiTweenStop);
		}
		protected function ZhuangPaiTweenStop():void 
		{
			m_tPaiTween.visible = false;
			//做初始化
			GamerInit();
			RenderWall();
			
			if (m_bTing)
			{
				ResetItems();
				vipRoomView.btnGetPaiP.hideArrow();
				vipRoomView.btnGetPaiP.hideBlack();
			}
			
			var logic:RoomLogic = GameIF.GetLogic(LogicManager.VIPROOMLOGIC) as RoomLogic;
			logic.stateMsgHandle = false;
			logic.HandleMsgList();
		}
		//吃碰杠听胡飘字动画
		protected function CanPaiStart(type:String):void 
		{
		
			vipRoomView.CanPaiStart(535, 405, type);
			if (type == m_sTing)
			{
				vipRoomView.m_imgTingSign0.visible = true;
			}
		}
		/////////////////////avatar event by dawenhao//////////////////////
		protected function GamerInfoClicked():void 
		{
			
		}
		
		////////////////////viproom button event by lisj///////////////////////////
		//protected function PutpaiTimer():void 
		//{
			//m_putPaiTimers += 1;
			//if (m_putPaiTimers >= 5000)
			//{
				////m_bPutPai =true;
				//Laya.timer.clear(this, PutpaiTimer);
			//}
		//}
		
		//点击手牌
		protected function onPaiSelected(e:Event,index:Number):void
		{
			if (e.type==Event.CLICK && e.target.name != "backBg")
			{
				var m_newGetPai:Gamer0PaiItem = e.currentTarget as Gamer0PaiItem;
				
				if (m_ClickPai != null)
				{
					trace("点击第"+index+"张牌状态为"+m_newGetPai.bPaiStae);
					if (m_newGetPai.bPaiStae)
					{
						//计时器
						//Laya.timer.loop(1,this, PutpaiTimer);
						//打的牌
						//vipRoomView.m_imgPutPaiCircle.visible = true;
						//vipRoomView.m_imgPutPaiV.skin = m_newGetPai.imgPaiValue.skin;
						m_newGetPai.bPaiStae = false;
						if (m_newGetPai.pai)
						{
							SentToServerPutPai(m_newGetPai.pai);
						}
						else
						{
							trace("发送的牌为空，消息没有发送成功");
						}
						//限制手牌和刚起的牌
						vipRoomView.m_listPai.mouseEnabled = false;
						vipRoomView.btnGetPaiP.mouseEnabled = false;
						return;
					}
					m_ClickPai.bPaiStae = false;
					m_ClickPai.ClickPaiTweenDown();		
				}
				m_newGetPai.ClickPaiTweenUp();
				m_newGetPai.bPaiStae = true;
				m_ClickPai = m_newGetPai;
				m_ClickPai.index =m_ClickPai.index==-1?undefined:index;
				RenderCanHu();
			}
		}
		//过
		protected function OnGuoClicked():void 
		{
			var type:int = GameIF.GetJson()["GuoType"]["canPai"];
			SendGuoMsg(type);
		}
		protected function OnMoTingGuoClicked():void 
		{
			InitButton();
			//可以打牌
				vipRoomView.m_listPai.mouseEnabled = true;
				vipRoomView.btnGetPaiP.mouseEnabled = true;
		}
		protected function OnMoGangGuoClicked():void 
		{
			var type:int = GameIF.GetJson()["GuoType"]["moGang"];
			SendGuoMsg(type);
		}
		protected function OnZiMoClicked():void 
		{
			var type:int = GameIF.GetJson()["GuoType"]["ziMo"];
			SendGuoMsg(type);
		}
		protected function SendGuoMsg(type:int):void 
		{
			var CreateGuoPaiMessage:* = NetworkManager.m_msgRoot.lookupType("GuoPaiRequest");
			var createGuoPaiMessage:* = CreateGuoPaiMessage.create({
				nUserID:GameIF.GetUser().nUserID,
				sRoomID:GameIF.GetRoom().sRoomID,
				nType:type
			});
			//包含了Request的内容
			var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
			var requestMsg:* = Request.create({
				guoPaiRequest:createGuoPaiMessage
			});
			//发送要发的数据
			CreateMsgSend(38, requestMsg);
		}
		//吃
		protected function onChiClicked():void 
		{
			trace("点击吃牌");
			if (m_message.canChiPool.length == 1)
			{
				m_SelectedIndex = 0;
				CreateChiRequest(m_SelectedIndex);
			}
			else
			{
				InitButton();
				RenderSelectPai();
				vipRoomView.m_listChiPai.mouseHandler = new Handler(this, onChiPaiSelected);
			}
		}
		//碰
		protected function onPengClicked():void 
		{
			var CreatePengPaiMessage:* = NetworkManager.m_msgRoot.lookupType("DoPengPaiRequest");
			var createPengPaiMessage:* = CreatePengPaiMessage.create({
				nUserID:GameIF.GetDalManager().daluser.nID,
				sRoomID:GameIF.GetDalManager().dalRoom.myRoomID,
				pai:m_message.canPengPool[0]
			});
			
			//包含了Request的内容
			var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
			var requestMsg:* = Request.create({
				doPengPaiRequest:createPengPaiMessage
			});
			//发送要发的数据
			CreateMsgSend(31, requestMsg);
		}
		//杠
		protected function onGangClicked():void 
		{
			trace("点击吃牌");
			if (m_message.canGangPool.length == 1)
			{
				CreateGangRequest(m_message.canGangPool[0]);
			}
			else
			{
				InitButton();
				RenderGangSelectPai();
				vipRoomView.m_listChiPai.mouseHandler = new Handler(this, onGangPaiSelected);
			}
		}

		//听
		protected function onTingClicked():void 
		{
				var CreateTingPaiMsg:* = NetworkManager.m_msgRoot.lookupType("DoTingPaiRequest");
				var createTingPaiMsg:* = CreateTingPaiMsg.create({
					nUserID:GameIF.GetDalManager().daluser.nID,
					sRoomID:GameIF.GetDalManager().dalRoom.myRoomID
				});
				//包含了Request的内容
				var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
				var requestMsg:* = Request.create({
					doTingPaiRequest:createTingPaiMsg
				});
				//发送要发的数据
				CreateMsgSend(34, requestMsg);
		}
		//抢听
		protected function onQiangTingClicked():void 
		{
			
			var  num:int = m_message.canChiPool.length + m_message.canPengPool.length;
			if (num == 1 )
			{
				m_SelectedIndex = 0;
				if (m_message.canPengPool.length > 0)
					m_SelectedIndex -= 1;
				CreateQiangTingRequest(m_SelectedIndex);
			}
			else
			{
				InitButton();
				RenderQtSelectPai();
				vipRoomView.m_listChiPai.mouseHandler = new Handler(this, onTingPaiSelected);
			}
		}
		//胡
		protected function onHuClicked():void 
		{
			var CreateHuPaiMessage:* = NetworkManager.m_msgRoot.lookupType("DoHuPaiRequest");
			var createHuPaiMessage:* = CreateHuPaiMessage.create({
				nUserID:GameIF.GetDalManager().daluser.nID,
				sRoomID:GameIF.GetDalManager().dalRoom.myRoomID,
				pai:m_message.lastPai
			});
			
			//包含了Request的内容
			var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
			var requestMsg:* = Request.create({
				doHuPaiRequest:createHuPaiMessage
			});
			//发送要发的数据
			CreateMsgSend(28, requestMsg);
		}

		protected function onChiPaiSelected(e:Event,index:Number):void 
		{
			if (e.type == Event.CLICK) 
			{
				m_SelectedIndex = index;
				CreateChiRequest(index);
			}
		}
		protected function onGangPaiSelected(e:Event,index:Number):void 
		{
			if (e.type == Event.CLICK) 
			{
				CreateGangRequest(m_message.canGangPool[index]);
			}
		}
		protected function onTingPaiSelected(e:Event,index:Number):void 
		{
			if (e.type == Event.CLICK)
			{
				m_SelectedIndex = index;
				if (m_message.canPengPool.length > 0)
					m_SelectedIndex = index - 1;
				CreateQiangTingRequest(m_SelectedIndex);
				InitButton();
			}
		}
		//发送抢听
		protected function CreateQiangTingRequest(index:int):void
		{
			var CreateQiangTingMsg:* = NetworkManager.m_msgRoot.lookupType("DoQiangTingPaiRequest");
				var createQiangTingMsg:* = CreateQiangTingMsg.create({
					nUserID:GameIF.GetDalManager().daluser.nID,
					sRoomID:GameIF.GetDalManager().dalRoom.myRoomID,
					pai:m_message.lastPai,
					nChiIndex:index
				});
				
				//包含了Request的内容
				var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
				var requestMsg:* = Request.create({
					doQiangTingPaiRequest:createQiangTingMsg
				});
				//发送要发的数据
				CreateMsgSend(65, requestMsg);
		}
		//发送吃牌请求
		protected function CreateChiRequest(chiIndex:int):void
		{	
			var CreateChiPaiMessage:* = NetworkManager.m_msgRoot.lookupType("DoChiPaiRequest");
			var createChiPaiMessage:* = CreateChiPaiMessage.create({
				nUserID:GameIF.GetDalManager().daluser.nID,
				sRoomID:GameIF.GetDalManager().dalRoom.myRoomID,
				pai:m_message.lastPai,
				nChiIndex:chiIndex
			});
			
			//包含了Request的内容
			var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
			var requestMsg:* = Request.create({
				doChiPaiRequest:createChiPaiMessage
			});
			//发送要发的数据
			CreateMsgSend(22, requestMsg);
		}
		protected function CreateGangRequest(gangpai:*):void 
		{
			var CreateGangPaiMessage:* = NetworkManager.m_msgRoot.lookupType("DoGangPaiRequest");
			var createGangPaiMessage:* = CreateGangPaiMessage.create({
				nUserID:GameIF.GetDalManager().daluser.nID,
				sRoomID:GameIF.GetDalManager().dalRoom.myRoomID,
				pai:gangpai
			});
			
			//包含了Request的内容
			var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
			var requestMsg:* = Request.create({
				doGangPaiRequest:createGangPaiMessage
			});
			//发送要发的数据
			CreateMsgSend(25, requestMsg);
		}
		//封装Request和发送函数
		protected function CreateMsgSend(type:int,requestMsg:*):void
		{
			//发送消息开始检查网络
			GameIF.GetRoom().bNetWeak = true;
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
		
		///////////////////////协议请求//////////////////////////////////
		protected function SentToServerPutPai(p:Pai):void
		{	
			//Pai当中具体的内容
			var CreatePaiMessage:* = NetworkManager.m_msgRoot.lookupType("Pai");
			var createPaiMessage:* = CreatePaiMessage.create({
				nType:p.nType,
				nValue:p.nValue
			});
			
			var CreatePutPaiMessage:* = NetworkManager.m_msgRoot.lookupType("PutPaiRequest");
			var createPutPaiMessage:* = CreatePutPaiMessage.create({
				nUserID : GameIF.GetDalManager().daluser.nID,
				sRoomID : GameIF.GetDalManager().dalRoom.myRoomID,
				putPai : createPaiMessage
			});
			
			//包含了Request的内容
			var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
			var requestMsg:* = Request.create({
				putPaiRequest:createPutPaiMessage
			});
			//发送要发的数据
			CreateMsgSend(18, requestMsg);
		}	
		
		//渲染听的牌
		protected function RenderTing(canTingPool:*):void 
		{
			ResetItems();
			//手里的牌
			for each (var CanHuPaiPool:* in canTingPool)
			{
				var index:int = GetIndex(CanHuPaiPool.pai);
				if (index ==-1)
				{
					trace("手牌中没有这张牌");
				}
				else
				{
					var tingPai:Gamer0PaiItem = vipRoomView.m_listPai.getCell(index) as Gamer0PaiItem;
					tingPai.canHuPai = CanHuPaiPool.pool;
					
					tingPai.showArrow();
					tingPai.hideBlack();
				}
				
			}
			//只有摸听的时候才去渲染起的牌
			//if (m_message.nPutState == GameIF.GetJson()["PutState"]["moting"]&&!GameIF.GetUser().bOffLine)
			if(vipRoomView.btnGetPaiP.visible)
			{
				//起的牌
				for each (var p2:* in canTingPool)
				{
					if (vipRoomView.btnGetPaiP.pai.nType == p2.pai.nType && vipRoomView.btnGetPaiP.pai.nValue == p2.pai.nValue)
					{
						vipRoomView.btnGetPaiP.canHuPai = p2.pool;
						vipRoomView.btnGetPaiP.showArrow();
						vipRoomView.btnGetPaiP.hideBlack();
					}
				}
			}
			
			
		}
		
		//获取pai对象
		public function GetItem(pai:Pai):BaseItem 
		{
			var paipool:Array = m_vipRoomView.m_list1Pai.array;
			var index:int = 0;
			for each (var p:Pai in paipool)
			{
				if (pai.nType == p.nType && pai.nValue == p.nValue)
				{
					return m_vipRoomView.m_list1Pai.getCell(index) as BaseItem;
				}
				index++;
			}
			return null;
		}
		//所以的都加上黑幕
		protected function ResetItems():void 
		{
			for (var j:int = 0; j < vipRoomView.m_listPai.length; j++ )
			{
				var tingPai:Gamer0PaiItem = vipRoomView.m_listPai.getCell(j) as Gamer0PaiItem;
				tingPai.showBlack();
				tingPai.hideArrow();
				tingPai.canHuPai = null;
			}
			//起的牌
			vipRoomView.btnGetPaiP.showBlack();
			vipRoomView.btnGetPaiP.hideArrow();
			vipRoomView.btnGetPaiP.canHuPai = null;
		}
		//所以的都加初始化
		protected function TingPaiInit():void 
		{
			for (var j:int = 0; j < 13; j++ )
			{
				var tingPai:Gamer0PaiItem = vipRoomView.m_listPai.getCell(j) as Gamer0PaiItem;
				tingPai.hideBlack();
				tingPai.hideArrow();
				tingPai.canHuPai = null;
			}
			//起的牌
			vipRoomView.btnGetPaiP.hideBlack();
			vipRoomView.btnGetPaiP.hideArrow();
			vipRoomView.btnGetPaiP.canHuPai = null;
		}
		
		//聊天
		//注释为背景白板,滑动
		public override function OnChatResponse(message:*):void
		{	
			if (message.nErrorCode == 0)
			{
				var ContentObj:Object = AnalysisMsg(ChatLogic.m_sContent);
				if(ContentObj.judge==1)
				{	
					FaceAnimationStart();
					vipRoomView.face0.innerHTML = ContentObj.content;
					//FaceHideBubbles();
				}
				
				if(ContentObj.judge==2)
				{
					vipRoomView.m_msgBox0.width = ContentObj.contentLength  + 32;
					vipRoomView.outPutBox0.y = ContentObj.y;
					vipRoomView.outPutBox0.innerHTML = ContentObj.content;
					InPutHideBubbles();
				}
			}
		}
		//输入框隐藏
		protected function InPutHideBubbles():void
		{
			vipRoomView.InPutHideBubbles(vipRoomView.outPutBox0, vipRoomView.m_msgBox0);
			
		}
		//动画函数
		public override function FaceAnimationStart():void 
		{
			vipRoomView.FaceAnimationStart(vipRoomView.face0, vipRoomView.face0.alpha, vipRoomView.m_img0Avatar);
			
		}
		public override function OnChatNotify(message:*):void
		{
			var ContentObj:Object = AnalysisMsg(message.sContent);
			
			vipRoomView.m_msgBox0.width = ContentObj.contentLength  + 32;
			vipRoomView.outPutBox0.y = ContentObj.y;
			vipRoomView.outPutBox0.innerHTML = ContentObj.content;
		}
	}
}
