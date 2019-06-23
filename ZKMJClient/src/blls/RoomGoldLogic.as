package blls 
{
	import core.GameIF;
	import core.LogicManager;
	import laya.events.Event;
	import laya.utils.Handler;
	import model.User;
	import network.NetworkManager;
	import view.ActiveView.GoodsItem;
	import view.RoomGoldPage;
	/**
	 * ...
	 * @author ...
	 */
	public class RoomGoldLogic extends BaseLogic 
	{
		private var m_roomGoldPage:RoomGoldPage;
		private var m_goodsArr:Array=[];
		
		public function RoomGoldLogic() 
		{
			super();
			
		}
		
		public override function Init():void
		{
			//初始化LoginView
			if (m_roomGoldPage == null)
			{
				m_roomGoldPage = new RoomGoldPage;
				m_roomGoldPage.Init();
			}
			m_roomGoldPage.visible = true;
			
			//注册所有按钮事件
			registerEventClick();
			//初始化数据
			InitDal();
			//初始化设备
			InitEquip();
			
		}
		//接受message
		public override function OnReceiveMessage(msg:*):void
		{
			if (msg.type == 44)//RegisterResponse
			{
				OnbuyResponse(msg.response.buyResponse);
			}
		}
		
		private function OnbuyResponse(msg:*):void 
		{
			if (msg.nErrorCode == 0)
			{
				GameIF.GetUser().nGold = msg.newAssets.nGold;
				GameIF.GetUser().nMoney = msg.newAssets.nMoney;
				GameIF.GetPopUpDia("购买成功");
				InitDal();				
			}
			else if (msg.nErrorCode == 3)
			{
				GameIF.GetPopUpDia("您的余额不足");
			}
		}
		//初始化数据
		private function InitDal():void 
		{
			var user:User = GameIF.GetUser();
			//初始化金币
			GameIF.getInstance().uiManager.showNumber(m_roomGoldPage.m_boxMa, user.nGold);
			//初始化钻石
			GameIF.getInstance().uiManager.showNumber(m_roomGoldPage.m_boxCard, user.nMoney);
			m_goodsArr = [4, 5, 6, 7, 8, 9];
			m_roomGoldPage.btn_tab.selectedIndex = 0;
			renderGoods(m_goodsArr);
			
			var gamehallLogic:GamehallLogic = GameIF.GetLogic(LogicManager.GAMEHALLLOGIC) as GamehallLogic;
			gamehallLogic.InitDal();
		}
		
		
		private function InitEquip():void 
		{
			var json:* = GameIF.GetJson();
			if (json["equipType"] == json["equipEnum"]["Web"])
			{
				//网页
				InitWebEquip();
			}
			else if (json["equipType"] == json["equipEnum"]["Android"])
			{
				//Android
				InitAndroidEquip();
			}
			else if (json["equipType"] == json["equipEnum"]["IOS"])
			{
				//IOS
				InitIOSEquip();
			}
			else if (json["equipType"] == json["equipEnum"]["wxWeb"])
			{
				//微信
				InitwxWebEquip();
			}
			else if (json["equipType"] == json["equipEnum"]["test"])
			{
				//微信
				InitTestEquip();
			}
		}
		private function InitWebEquip():void 
		{
			
		}
		
		private function InitAndroidEquip():void 
		{
			
		}
		
		private function InitIOSEquip():void 
		{
			m_roomGoldPage.sp_viewStack.visible = false;
			m_roomGoldPage.m_boxGoods.centerX = 0;
		}
		
		private function InitwxWebEquip():void 
		{
			
		}
		private function InitTestEquip():void 
		{
			//m_roomGoldPage.sp_viewStack.visible = false;
			//m_roomGoldPage.m_boxGoods.centerX = 0;
		}
		//进入金币界面
		public function JoinMa():void 
		{
			m_roomGoldPage.btn_tab.selectedIndex = 1;
		}
		
		public override function Destroy():void
		{
			m_roomGoldPage.Destroy();
			m_roomGoldPage.destroy();
			m_roomGoldPage = null;
			//Laya.loader.clearRes("res/atlas/roomGold.json", false);
		}
		
		//注册所有按钮事件	
		private function registerEventClick():void 
		{
			m_roomGoldPage.btn_Back .on(Event.CLICK,this,onBackClicked);
			m_roomGoldPage.btn_tab.selectHandler = new Handler(this, onSelecte); 
			//超值推荐房卡
			m_roomGoldPage.m_btnRecommendCard.on(Event.CLICK, this, onRecommendCardClicled);
			//超值推荐金币
			m_roomGoldPage.m_btnRecommendGold.on(Event.CLICK, this, onRecommendGoldClicled);
		}
		//超值推荐金币
		private function onRecommendGoldClicled(e:Event):void 
		{
			SendBuyRequset(GameIF.GetJson()["Recommend"]["Gold"]);
		}
		//超值推荐房卡
		private function onRecommendCardClicled(e:Event):void 
		{
			callpay(GameIF.GetJson()["Recommend"]["Card"]);
		}
		
		private function onBackClicked():void 
		{
			GameIF.DectiveLogic(LogicManager.ROOMGOLDLOGIC);
		}
		
        /**根据选择tab的索引切换页面**/
        private function onSelecte(index:int):void
        {
            //切换ViewStack子页面
            m_roomGoldPage.sp_viewStack.selectedIndex = index;
			switch(index)
			{
				case 0:
					m_goodsArr = [4,5,6,7,8,9];
					renderGoods(m_goodsArr);
					break;
				case 1:
					m_goodsArr = [10,11,12,13,14,15];
					renderGoods(m_goodsArr);
					break;
				default:
					break;
			}
			
        }
		
		////*******商品*********////
				
		public function renderGoods(goodsIdArr:Array):void
		{
			for (var i:int; i < 6;i++ )
			{
				var goods:GoodsItem = getGoods(goodsIdArr[i]);
				goods.x =  395 * (i % 2);
				goods.y = 165*(Math.floor(i/2));
				goods.goodsID = goodsIdArr[i];
				goods.on(Event.CLICK, this, onGoodsClicked);
				m_roomGoldPage.m_boxGoods.addChild(goods);
			}
		}
		
		private function getGoods(goodsId:int):GoodsItem
		{
			var good:JSON = GameIF.GetJson()["goods"][goodsId];
			
			var goods:GoodsItem = new GoodsItem;
			
			goods.numText.text = "X" + good["text"];
			if (good["type"] == 1)
			{
				goods.imgType.skin = "common/img_diamonds.png";
				goods.labelMoney.text = "￥" + good["money"];
				goods.labelMoney.align = "center";
			}
			else if(good["type"]==2)
			{
				goods.imgType.skin = "common/img_ma.png";
				goods.imgDiamonds.skin = "common/img_diamonds.png";
				goods.labelMoney.text = "   "+good["money"];
			}
			
			return goods;
		}
		
		private function onGoodsClicked(e:Event):void 
		{
			var goods:GoodsItem = e.currentTarget as GoodsItem;
			var good:JSON = GameIF.GetJson()["goods"][goods.goodsID];
			var goodsType:JSON = GameIF.GetJson()["goodsType"];
			if (good["type"] == goodsType["diamonds"])
			{
				callpay(goods.goodsID);
			}
			else if (good["type"] == goodsType["gold"])
			{
				SendBuyRequset(goods.goodsID);
			}
			
		}
		
		private function SendBuyRequset(goodsID:int):void 
		{
			var GoodMsg:* = NetworkManager.m_msgRoot.lookupType("Good");
			var goodMsg:* = GoodMsg.create({
				nID:goodsID,
				nCount:1
			});
			
			var BuyRequestMsg:* = NetworkManager.m_msgRoot.lookupType("BuyRequest");
			var buyRequestMsg:* = BuyRequestMsg.create({
				nUserID:GameIF.GetUser().nUserID,
				goods:[goodMsg]
			});
			//Request当中具体的内容
			var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
			var requestMsg:* = Request.create({
				buyRequest:buyRequestMsg
			});
			////包含了Request的内容
			var Msg:* = NetworkManager.m_msgRoot.lookupType("Msg");
			var MsgMessage:* = Msg.create({
				type:84,
				request:requestMsg
			});
			var encodeMessage:* = Msg.encode(MsgMessage).finish();
			GameIF.getInstance().networkManager.HttpSendMessage(encodeMessage, "buy");
		}
		private function callpay(goodsID:*):void
		{
			//buyGoods(goodsID);
			var json:* = GameIF.GetJson();
				if (json["equipType"] == json["equipEnum"]["Web"])
					henderWebGoods(goodsID);
				if (json["equipType"] == json["equipEnum"]["Android"])
					henderAndroidGoods(goodsID);
				if (json["equipType"] == json["equipEnum"]["IOS"])
					henderIOSGoods(goodsID);
				if (json["equipType"] == json["equipEnum"]["wxWeb"])
					henderwxWebGoods(goodsID);
		}
		private function henderWebGoods(goodsID:int):void 
		{
			
		}
		private function henderAndroidGoods(goodsID:int):void 
		{
			//创建Test类
			var Test:*=Laya.PlatformClass.createClass("com.tianhu.majiang.WxAndroid");
			//创建Test 对象
			var testAdd:* = Test.newObject(); //不支持构造函数
			//调用成员函数
			var userID:int = GameIF.GetUser().nUserID;
			testAdd.callWithBack(buyGoods, "wxPay", userID.toString(), goodsID.toString());		
		}
		private function henderIOSGoods(goodsID:int):void 
		{
			//创建Test类
			var Test:*=Laya.PlatformClass.createClass("IosClass");
			//创建Test 对象
			var testAdd:* = Test.newObject(); //不支持构造函数
			//调用成员函数
			var userID:int = GameIF.GetUser().nUserID;
			testAdd.callWithBack(buyGoods,"iosPay:and:",userID,goodsID);
		}
		private function henderwxWebGoods(goodsID:int):void 
		{
			var userId:int = GameIF.GetUser().nUserID;
			__JS__('callpay(userId,goodsID,this)');
		}
		private function buyGoods(id:*=null):void
		{
			if (id)
			{
				GameIF.GetPopUpDia("支付成功");
				var goods:JSON = GameIF.GetJson()["goods"][id];
				var user:User = GameIF.GetUser();
				var goodsType:JSON = GameIF.GetJson()["goodsType"];
				switch(goods["type"])
				{
					//钻石
					case goodsType["diamonds"]:
						user.nMoney += goods["num"];
						break;
					//金币
					case goodsType["glod"]:
						user.nGold += goods["num"];
						break;
					default:
						break;
				}
				var roomGoldLogic:RoomGoldLogic = GameIF.GetLogic(LogicManager.ROOMGOLDLOGIC) as RoomGoldLogic;
				roomGoldLogic.InitDal();
			}
			else
			{
				//alert("laya：支付失败");
				GameIF.GetPopUpDia("支付失败");
			}
		}
		
	}

}