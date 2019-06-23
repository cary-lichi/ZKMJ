package model._Gamer 
{
	import blls._Game.GamerInfoLogic;
	import core.GameIF;
	import core.LogicManager;
	import dal.DalPai;
	import laya.events.Event;
	import laya.ui.Component;
	import laya.ui.List;
	import laya.utils.Dictionary;
	import laya.utils.Handler;
	import model._Pai.ChiPai;
	import model._Pai.GangPai;
	import model._Pai.Pai;
	import model._Pai.PengPai;
	import model._Pai.RenderPai;
	import model._PaiPool.ListPool;
	import network.NetworkManager;
	import tool.Tool;
	import view.ActiveView._gameItem.BasePaiItem;
	import view.ActiveView._gameItem.Gamer0PaiItem;
	import view.ActiveView._gameItem.Gamer1PaiItem;
	import view.ActiveView._gameItem.Gamer2PaiItem;
	import view.ActiveView._gameItem.Gamer3PaiItem;
	import view.Room.RoomView;
	import view.Room.VIPRoomView;
	/**
	* ...
	* @author dawenhao
	*/
	public class Gamer
	{
		protected var  m_sLng:String = "";//经度
		protected var  m_sLat:String = "";//纬度
		protected var  m_sAddress:String = "";//用户位置信息
		protected var  m_bIsLocation:Boolean = false;
		protected var m_nAIRandInfo:int;//机器人的信息
		protected var m_nAIRandHead:int;//机器人的头像
		protected var m_nGender:int;//玩家性别 0 未知 1男 2女
		protected var m_sSex:String="man"//sex男为man 女为woman
		protected var m_sNick:String;//玩家姓名
		protected var m_sRoomID:String//玩家ID //玩家id，如果id>0说明是玩家，<0说明是机器人
		protected var m_sHeadimg:String;//玩家头像
		protected var m_nScore:int=500;//玩家分数
		protected var m_nGold:int = 500;//玩家游戏币
		protected var m_bBoss:Boolean=false;//是否庄家
		protected var m_bOwner:Boolean=false;//是否房主
		protected var m_nGID:int;//玩家id
		protected var m_nPos:int;//真实方位
		protected var m_nPosGame:int;//游戏方位
		protected var m_mgrPai:DalPai;
		protected var m_state:int//玩家状态
		protected var m_nGameState:int;//玩家游戏状态 0 准备 1正在游戏 2游戏结束 3未开始
		protected var m_bAI:Boolean;////玩家是否托管
		protected var m_bOnLine:Boolean = true;//在线、离线（状态）
		protected var m_bLookInfo:Boolean = false;
		protected var m_vipRoomView:RoomView;
		protected var m_tPaiTween:BasePaiItem;//牌的动画演员
		protected var m_nAgangPool:int;
		protected var m_nChiPool:int;
		protected var m_nMgangPool:int;
		protected var m_nPengPool:int;
		protected var m_nPaiPool:int;
		protected var m_nPutPool:int;
		protected var m_nTanPool:int;
		protected var m_sChi:String;
		protected var m_sPeng:String;
		protected var m_sGang:String;
		protected var m_sTing:String;
		protected var m_sHu:String;
		
		protected var m_listPool:ListPool;//吃碰杠牌列表
		
		public function Gamer() 
		{
			if (m_mgrPai == null)
			{
				m_mgrPai = new DalPai;
			}
			DalInit();
			
		}
		
		private function DalInit():void 
		{
			var json:*=GameIF.GetJson();
			m_nAgangPool = json["poolType"]["agang"];
			m_nChiPool = json["poolType"]["chi"];
			m_nMgangPool = json["poolType"]["mgang"];
			m_nPengPool = json["poolType"]["peng"];
			m_nPaiPool = json["poolType"]["pai"];
			m_nPutPool = json["poolType"]["put"];
			m_nTanPool = json["poolType"]["tan"];
			
			m_sChi = json["canPaiAnmiType"]["chi"];
			m_sPeng = json["canPaiAnmiType"]["peng"];
			m_sGang = json["canPaiAnmiType"]["gang"];
			m_sTing = json["canPaiAnmiType"]["ting"];
			m_sHu = json["canPaiAnmiType"]["hu"];
		}
		
		
		public function Init():void 
		{
			//m_mgrPai = null;
		}
		//初始化玩家类型
		protected function InitGamer():void 
		{
			
		}
		public function Reset():void
		{
			
		}
		
		public function Destroy():void 
		{
			
		}
		//准备
		public function OnReady():void 
		{
			
		}
		public function GameStart():void 
		{
			m_nGameState = GameIF.GetJson()["gameState"]["playing"];
		}
		//添加数据
		public function InitPaiPool(paiInfo:Array):void
		{
			
			for each(var orderPai:* in paiInfo.orderPai)
			{
				var canPai:RenderPai;
				if (orderPai.chipai)
				{
					var pai1:Pai = m_mgrPai.createPai(orderPai.chipai.nType,orderPai.chipai.nValue1) as Pai;
					var pai2:Pai = m_mgrPai.createPai(orderPai.chipai.nType,orderPai.chipai.nValue2) as Pai;
					var pai3:Pai = m_mgrPai.createPai(orderPai.chipai.nType, orderPai.chipai.nValue3) as Pai;
					canPai= new ChiPai;
					canPai.pai1 = pai1;
					canPai.pai2 = pai2;
					canPai.pai3 = pai3;
					canPai.rendered = false;
					m_mgrPai.AddPai(canPai,m_nChiPool);
					canPai = null;
					//需要渲染cnapai
					m_listPool.renderAllList();
				}
				if (orderPai.pengpai)
				{
					canPai= new PengPai;
					canPai.pai1 = m_mgrPai.createPai(orderPai.pengpai.nType, orderPai.pengpai.nValue);
					canPai.pai2 = m_mgrPai.createPai(orderPai.pengpai.nType, orderPai.pengpai.nValue);
					canPai.pai3 = m_mgrPai.createPai(orderPai.pengpai.nType, orderPai.pengpai.nValue);
					canPai.rendered = false;
					m_mgrPai.AddPai(canPai,m_nPengPool);
					canPai = null;
					//需要渲染cnapai
					m_listPool.renderAllList();
				}
				if (orderPai.gangpai)
				{
					var json:JSON = GameIF.GetJson()["GangType"];
					canPai = new PengPai;
					canPai.pai1 = m_mgrPai.createPai(orderPai.gangpai.nType, orderPai.gangpai.nValue);
					canPai.pai2 = m_mgrPai.createPai(orderPai.gangpai.nType, orderPai.gangpai.nValue);
					canPai.pai3 = m_mgrPai.createPai(orderPai.gangpai.nType, orderPai.gangpai.nValue);
					canPai.rendered = false;
					if (orderPai.gangpai.nGangState==json["AnGang"])
					{
						m_mgrPai.AddPai(canPai,m_nAgangPool);
					}
					else
					{
						m_mgrPai.AddPai(canPai,m_nMgangPool);
					}
					canPai = null;
					//需要渲染cnapai
					m_listPool.renderAllList();
				}
				
			}
			for each(var PaiPool4:* in paiInfo.pool)
			{
				for (var m:int = 0; m < PaiPool4.nValue.length; m++ )
				{
					m_mgrPai.AddPai(m_mgrPai.createPai(PaiPool4.nType,PaiPool4.nValue[m]),m_nPaiPool);
				}
				
			}
			for each(var putPaipool:* in paiInfo.putPool)
			{
				m_mgrPai.AddPai(m_mgrPai.createPai(putPaipool.nType,putPaipool.nValue[0]),m_nPutPool);
			}
			renderInfo();
		}
		/////////////////////////////渲染基本信息//////////////////////////////////
				//渲染基本信息
		public function  renderInfo():void 
		{
		}
		//离开房间
		public function OnLeaveRoomNotify():void 
		{
			
		}
		//托管
		public function SetDelegate(value:Boolean):void 
		{
			
		}
		//上线
		public function OnConnectNotify():void 
		{
			
		}
		//掉线
		public function OnDisConnectNotify():void 
		{
			
		}
		/////////////////////////////渲染自己的（手牌）//////////////////////////////////
		public function  RenderInit():void 
		{
			
		}
		//渲染牌
		public function RenderWall():void 
		{
			
		}
		//渲染宝牌
		public function RenderBaoPai(bao:Pai):void 
		{
			var paipool:Array = m_mgrPai.GetPool(m_nPaiPool);
			for (var i:int in paipool) 
			{
				var p:Pai = paipool[i];
				if (bao.nType == p.nType && bao.nValue == p.nValue)
				{
					m_mgrPai.DelPaiIndex(i);
					m_mgrPai.AddPai(p,m_nPaiPool);
				}
			}
			RenderWall();
		}
		//渲染牌列表
		public function RenderList(list:List,itme:*,renderFun:Function,paiArr:Array):void
		{
			list.visible = true;
			list.itemRender = itme;//Item
			list.renderHandler = new Handler(this, renderFun);
			list.array = paiArr;
			list.refresh();
		}
		//获取手牌索引
		public function GetIndex(pai:Pai):int 
		{
			var paipool:Array = m_mgrPai.GetPool(m_nPaiPool);
			var index:int = 0;
			for each (var p:Pai in paipool)
			{
				if (pai.nType == p.nType && pai.nValue == p.nValue)
				{
					return index;
				}
				index++;
			}
			trace("错误提示：手牌中不存在这样的牌 nType="+pai.nType+"nValue="+pai.nValue);
			return -1;
		}
				
		public function OnAvatar():void 
		{
			var logic:GamerInfoLogic = GameIF.GetLogic(LogicManager.GAMEINFOLOGIC) as GamerInfoLogic;
			logic.ShowGamerInfo();
			logic.DalInit(this);
		}
		/////////////////add by wangn///////////////////////////////////
		
		//添加动画演员
		protected function AddPaiTween():void
		{
			vipRoomView.m_boxGameDia.addChild(m_tPaiTween);
		}
		
		//删除动画演员
		protected function DelPaiTween():void
		{
			vipRoomView.m_boxGameDia.removeChild(m_tPaiTween);
		}
		
		//起牌
		public function OnGetPai(pai:Pai):void 
		{
			
		}
		public function RenderGetPaiAnmi(pai:Pai):void {}
		
		//打牌
		public function OnPutPai(message:*):void {}
		public function OnPutPaiResponse(pai:Pai):void {}
		public function OnPutPaiNotify(pai:Pai):void{}
		public function RenderPutPaiAnmi(item:Component,index:int):void {}
		//删掉上次上次打的牌
		public function DelLastputPai(pai:Pai):void 
		{
			
		}
		//关灯
		public  function OffCur():void 
		{
			vipRoomView.m_imgCur0.visible = false;
			vipRoomView.m_boxAminHead0.visible = false;
			
			vipRoomView.m_imgCur1.visible = false;
			vipRoomView.m_boxAminHead1.visible = false;
			
			vipRoomView.m_imgCur2.visible = false;
			vipRoomView.m_boxAminHead2.visible = false;
			
			vipRoomView.m_imgCur3.visible = false;
			vipRoomView.m_boxAminHead3.visible = false;
		}
		//开灯
		public  function OpennCur():void 
		{
		
		}
		//显示房主
		public function ShowOwner():void 
		{
			
		}
		//隐藏房主
		public function HideOwner():void 
		{
			vipRoomView.m_imgOwner0.visible = false;
			vipRoomView.m_imgOwner1.visible = false;
			vipRoomView.m_imgOwner2.visible = false;
			vipRoomView.m_imgOwner3.visible = false;
		}
		public function FaceAnimationStart():void 
		{
			
		}
		//can牌
		public function OnCanPai(message:*):void {}
		public function RenderCanPaiAnmi(item:Component, index:int):void {}
		//渲染飘字
		public function CanPaiStart(type:String):void {}
		//渲染吃牌
		public function RenderChiPai(chipai:*, pai:*):void
		{
			var pai1:Pai = m_mgrPai.createPai(chipai.nType,chipai.nValue1) as Pai;
			var pai2:Pai = m_mgrPai.createPai(chipai.nType,chipai.nValue2) as Pai;
			var pai3:Pai = m_mgrPai.createPai(chipai.nType, chipai.nValue3) as Pai;
			var canPai:ChiPai = new ChiPai;
			canPai.pai1 = pai1;
			canPai.pai2 = pai2;
			canPai.pai3 = pai3;
			canPai.rendered = false;
			m_mgrPai.AddPai(canPai, m_nChiPool);
			m_mgrPai.AddPai(pai, m_nPaiPool);
			m_mgrPai.DelPai(pai1, m_nPaiPool);
			m_mgrPai.DelPai(pai2, m_nPaiPool);
			m_mgrPai.DelPai(pai3, m_nPaiPool);
			//需要渲染cnapai
			m_listPool.renderAllList();
			RenderWall();
		}
		//渲染碰牌
		public function RenderPengPai(pai:*):void 
		{
			var canpai:PengPai = new PengPai;
			canpai.pai1 = pai;
			canpai.pai2 = pai;
			canpai.pai3 = pai;
			canpai.rendered = false;
			m_mgrPai.AddPai(canpai, m_nPengPool);
			for (var j:int = 0; j < 2; j++ )
			{
				m_mgrPai.DelPai(pai, m_nPaiPool);
			}
			//需要渲染cnapai
			m_listPool.renderAllList();
			RenderWall();
		}
		//游戏end摊牌
		public function OnTanPai():void{}
		public function RenderTanPaiAnmi(item:Component, index:int):void{}
		
		public function GamerInit():void 
		{
			
		}
		//过牌
		public function OnGuoPaiResponse():void 
		{
			
		}
		//吃牌
		public function OnDoChiPai(dic:Dictionary):void
		{
			
		}
		public function OnDoChiPaiResponse(message:*):void
		{
			
		}
		public function OnDoChiPaiNotify(chipai:*,pai:*):void 
		{
			CanPaiStart(m_sChi);
			RenderChiPai(chipai, pai);
			RenderWall();
		}
		//碰牌
		public function OnDoPengPai():void 
		{
			
		}
		public function OnDoPengPaiResponse():void 
		{
			
		}
		public function OnDoPengPaiNotify(pai:Pai):void 
		{
			CanPaiStart(m_sPeng);
			RenderPengPai(pai);
			RenderWall();
		}
		//杠牌
		public function OnDoGangPai():void 
		{
			
		}
		public function OnDoGangPaiResponse():void 
		{
			
		}
		public function OnDoMoGangPaiResponse(message:*):void 
		{
			
		}
		public function OnDoAnGangPaiResponse(message:*):void 
		{
			
		}
		public function OnDoGangPaiNotify(message:*):void 
		{
			CanPaiStart(m_sGang);
			
			var pengArr:Array = m_mgrPai.GetPool(m_nPengPool);
			for each(var pengPai:PengPai in pengArr)
			   {
				   if (pengPai.pai1.nType == message.pai.nType)
						if (pengPai.pai1.nValue == message.pai.nValue)
						{
							m_listPool.addMoGang(pengPai.view);
							mgrPai.DelPai(message.pai,m_nPaiPool);
							return;
						}
						
			   }
			
			var canpai:GangPai = new GangPai;
			canpai.pai1 = message.pai;
			canpai.pai2 = message.pai;
			canpai.pai3 = message.pai;
			canpai.rendered = false;
			var type:int = message.bAn?m_nAgangPool:m_nMgangPool;
			m_mgrPai.AddPai(canpai, type);
			for (var j:int = 0; j < 3; j++ )
			{
				m_mgrPai.DelPai(message.pai, m_nPaiPool);
			}
			//需要渲染cnapai
			m_listPool.renderAllList();
			RenderWall();
		}

		//暗杠
		public function OnDoAnGangPaiNotify(message:*):void 
		{
			CanPaiStart(m_sGang);
			
			var canpai:GangPai = new GangPai;
			canpai.pai1 = message.pai;
			canpai.pai2 = message.pai;
			canpai.pai3 = message.pai;
			canpai.rendered = false;
			m_mgrPai.AddPai(canpai, m_nAgangPool);
			for (var j:int = 0; j < 4; j++ )
			{
				m_mgrPai.DelPai(message.pai, m_nPaiPool);
			}
			//需要渲染cnapai
			m_listPool.renderAllList();
			RenderWall();
		}
		//听牌
		public function OnDoTingPai():void 
		{
			
		}
		public function OnDoTingPaiResponse():void 
		{
			
		}
		public function OnDoTingPaiNotify():void 
		{
			CanPaiStart(m_sTing);
		}
		//抢听
		public function OnDoQiangTingPai(dic:Dictionary,type:Boolean):void 
		{
			
		}
		public function OnDoQiangTingPaiResponse(message:*):void 
		{
			
		}
		public function OnDoQiangTingPaiNotify(message:*):void 
		{
			CanPaiStart(m_sTing);
			if (message.pengpai != undefined)
					RenderPengPai(message.pengpai);
			if (message.chipai != undefined)
					RenderChiPai(message.chipai, message.pai);
		}
		//胡牌
		public function OnDoHuPai():void 
		{
			
		}
		public function OnDoHuPaiResponse():void 
		{
			CanPaiStart(m_sHu);
			vipRoomView.m_imgTingSign0.visible = false;
			vipRoomView.m_imgTingSign1.visible = false;
			vipRoomView.m_imgTingSign2.visible = false;
			vipRoomView.m_imgTingSign3.visible = false;
		}
		public function OnDoHuPaiNotify():void 
		{
			CanPaiStart(m_sHu);
			vipRoomView.m_imgTingSign0.visible = false;
			vipRoomView.m_imgTingSign1.visible = false;
			vipRoomView.m_imgTingSign2.visible = false;
			vipRoomView.m_imgTingSign3.visible = false;
		}
		
		public function OnChatResponse(message:*):void
		{
			
		}
		
		public function OnChatNotify(message:*):void
		{
		}
		//隐藏聊天框
		public function InPutHideBubbles(pai:Pai):void 
		{
			
		}
		
		//收到消息解析
		protected function AnalysisMsg(value:String):Object 
		{
			var contentObj:Object = [];
			var str:String = "";
			var contentWidth:int;
			var lineHeight:int;
			var judge:int;
			//当有密码时
			if (value.substring(0, 13) == "@%$>]~*>[;[#@")
			{   
				value=value.substring(13, value.length);
				str = "<span><img src = 'chat/btn_face" + value + ".png' style = 'width:77px; height:77px' ></img></span>"; 
				contentWidth = 43;
				lineHeight = 0;
				judge = 1;
			}
			//没密码时	
			else
			{
				str = "<span style='font-size:20px;font-family:SimHei;color:#6d3f2f;text-align:center;vertical-align:middle;'>" + value+"</span>";
				vipRoomView.lableLength0.text = value;
				contentWidth = vipRoomView.lableLength0.width;
				lineHeight = 10;
				judge = 2;
			}
			
			contentObj = {content:str, contentLength:contentWidth, y:lineHeight,judge:judge};
			
			return contentObj;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////
		//————————————————————————————————————以下是接口————————————————————————————————————///
		///////////////////////////////////////////////////////////////////////////////////////
		public function get nPos():int 
		{
			return m_nPos;
		}
		
		public function set nPos(value:int):void 
		{
			m_nPos = value;
		}
		
		public function get bBoss():Boolean 
		{
			return m_bBoss;
		}
		
		public function set bBoss(value:Boolean):void 
		{
			m_bBoss = value;
		}
		
		public function get sNick():String 
		{
			return m_sNick;
		}
		
		public function set sNick(value:String):void 
		{
			if (!value)
			{
				var name:String = Math.floor(Math.random() * 23).toString();
				var aiInfo:JSON = GameIF.GetJson()["aiInfo"][name];
				value = aiInfo["nick"];
				nGender = aiInfo["gender"];
				
			}
			m_sNick = value;
		}
		
		public function get bOwner():Boolean 
		{
			return m_bOwner;
		}
		
		public function set bOwner(value:Boolean):void 
		{
			m_bOwner = value;
		}
		
		public function get mgrPai():DalPai 
		{
			return m_mgrPai;
		}
		
		public function set mgrPai(value:DalPai):void 
		{
			m_mgrPai = value;
		}
		
		public function get nGID():int 
		{
			return m_nGID;
		}
		
		public function set nGID(value:int):void 
		{
			m_nGID = value;
		}
		
		public function get sRoomID():String 
		{
			return m_sRoomID;
		}
		
		public function set sRoomID(value:String):void 
		{
			m_sRoomID = value;
		}
		
		public function get state():int 
		{
			return m_state;
		}
		
		public function set state(value:int):void 
		{
			m_state = value;
		}
		
		public function get sHeadimg():String 
		{
			return m_sHeadimg;
		}
		
		public function set sHeadimg(value:String):void 
		{
			m_sHeadimg = value?value:Tool.getHeadUrl();
		}
		
		public function get nGold():int 
		{
			return m_nGold;
		}
		
		public function set nGold(value:int):void 
		{
			m_nGold = value;
		}
		
		public function get nScore():int 
		{
			return m_nScore;
		}
		public function set nScore(value:int):void 
		{
			m_nScore = value;
		}	
		
		public function get bOnLine():Boolean 
		{
			return m_bOnLine;
		}
		
		public function set bOnLine(value:Boolean):void 
		{
			m_bOnLine = value;
		}
		
		public function get nGameState():int 
		{
			return m_nGameState;
		}
		
		public function set nGameState(value:int):void 
		{
			m_nGameState = value;
		}
		
		public function get vipRoomView():RoomView 
		{
			return m_vipRoomView;
		}
		
		public function set vipRoomView(value:RoomView):void 
		{
			m_vipRoomView = value;
		}
		
		public function get nGender():int 
		{
			return m_nGender;
		}
		
		public function set nGender(value:int):void 
		{
			if (value == 1)
			{
				sSex = "man";
			}
			else
			{
				sSex = "woman";
			}
			m_nGender = value;
		}
		
		public function get sSex():String 
		{
			return m_sSex;
		}
		
		public function set sSex(value:String):void 
		{
			m_sSex = value;
		}
		
		public function get bAI():Boolean 
		{
			
			return m_bAI;
		}
		
		public function set bAI(value:Boolean):void 
		{
			SetDelegate(value)
			m_bAI = value;
		}
		
		public function get nAIRandHead():int 
		{
			return m_nAIRandHead;
		}
		
		public function set nAIRandHead(value:int):void 
		{
			if (value > 20 || value < 0)
			{
				value = 0;
			}
			sHeadimg = "ai/img_head_t_"+nGender+"_v_"+value+".png";
			m_nAIRandHead = value;
		}
		
		public function get nAIRandInfo():int 
		{
			return m_nAIRandInfo;
		}
		
		public function set nAIRandInfo(value:int):void 
		{
			if (value > 23 || value < 0)
			{
				value = 0;
			}
			var aiInfo:JSON = GameIF.GetJson()["aiInfo"][value];
			sNick = aiInfo["nick"];
			nGender = aiInfo["gender"];
			m_nAIRandInfo = value;
		}
		
		public function get sAddress():String 
		{
			return m_sAddress;
		}
		
		public function set sAddress(value:String):void 
		{
			m_sAddress = bIsLocation?value:"没有开启定位";
		}
		
		public function get bIsLocation():Boolean 
		{
			return m_bIsLocation;
		}
		
		public function set bIsLocation(value:Boolean):void 
		{
			m_bIsLocation = value;
		}
		
		public function get sLat():String 
		{
			return m_sLat;
		}
		
		public function set sLat(value:String):void 
		{
			m_sLat = value;
		}
		
		public function get sLng():String 
		{
			return m_sLng;
		}
		
		public function set sLng(value:String):void 
		{
			m_sLng = value;
		}
		
		public function get nPosGame():int 
		{
			return m_nPosGame;
		}
		
		public function set nPosGame(value:int):void 
		{
			m_nPosGame = value;
		}
	}
}