package view 
{
	import blls.TurntableLogic;
	import core.Constants;
	import core.GameIF;
	import laya.ui.Button;
	import laya.ui.Label;
	import laya.utils.Browser;
	import tool.Tool;
	import ui.MahjongRoot.TurntablePageUI;
	import laya.ui.Box;
	import laya.ui.Component;
	import laya.ui.Image;
	import laya.ui.List;
	import laya.utils.Handler;
	import view.ActiveView.PrizeItem;
	import laya.events.Event;
	import core.LogicManager;
	import laya.utils.Tween;
	import laya.utils.Ease;
	/**
	 * ...
	 * @author dawenhao
	 */
	public class TurntableView  extends TurntablePageUI
	{
		private var scaleDelta:Number = 0;
		private var rotation:Number = 0;
		private var m_PrizeIDArr:Array;
		
		private var m_boxWinning:Box;
		private var m_imgWinningBack:Image;
		private var title:Image = new Image;
		private var mcbg:Image = new Image;
		private var Vbutton:Button = new Button;
		private var concent:Label = new Label;
		private var mc:Image = new Image;
		private var m_labelPriceNum:Label;
		//public var aaa:int;
	
		public function TurntableView() 
		{
			super();
		}
		
		public function Init():void
		{		
			//RenderCircle();
			//ZoomCircle();
			//InitPrize();
			//m_content.x = 241;
			//m_content.y = 241;
			//Tween.to(m_content, {"y":500,"x":1136},1000, Ease.quintOut,Handler.create(this, aaa));
			Laya.stage.addChild(this);
			if (Constants.isAdaptPhone)
			{
				reSetViewUi();
				var turntableView:TurntableView = this;
				Browser.window.addEventListener("resize", function():void {
				Laya.timer.once(1000, turntableView, reSetViewUi);
				
				});
			}
		}
		
		//转盘炉石传说大表哥动画
		//private function aaa():void
		//{
			//Tween.to(m_content, {"rotation":1080}, 1500, Ease.quintOut);
			//Tween.to(m_content, {"x":100,"y":100}, 500, Ease.quintOut,Handler.create(this, bbb));
		//}
		//
		//
		//private function bbb():void
		//{
			//Tween.to(m_content, {"scaleX":0.1,"scaleY":0.1}, 300, Ease.quintOut,Handler.create(this, ccc));
			//Tween.to(m_content, {"x":562, "y":320}, 500, Ease.quintOut);
		//}
		//
		//private function ccc():void
		//{
			//Tween.to(m_content, {"scaleX":0.7,"scaleY":0.7}, 1000, Ease.elasticInOut);
		//}
		
		private function reSetViewUi():void
		{
			Tool.Adaptation(this);
		}
		public function Destroy():void
		{
			Laya.stage.removeChild(this);
			//Laya.timer.clearAll(this);
		}
		///奖品初始化
		public function InitPrize(m_PrizeIDArr:Array):void 
		{
			this.m_listPrize.itemRender = PrizeItem;
			
			//奖品高宽
			//this.this.m_listPrize.height = 50;
			//this.this.m_listPrize.width = 50;
			this.m_listPrize.repeatX = 10;//X轴10个
			this.m_listPrize.repeatY = 1;//Y轴1个
			
			var arr:Array = [];
			for (var i:int = 0; i < m_PrizeIDArr.length;i++ )
			{
				var type:String = GameIF.GetJson()["prize"][m_PrizeIDArr[i]]["type"];
				var title:String = GameIF.GetJson()["prize"][m_PrizeIDArr[i]]["title"];
				var typeurl:String = "common/img_" + type+".png"
				arr.push({typeurl:typeurl, labname:title,prizeID:m_PrizeIDArr[i]});
			}
			
			//商品的信息
			this.m_listPrize.array = arr;
			this.m_listPrize.renderHandler = new Handler(this, RenderPrizeList);
		}
		//
		//渲染方法
		private function RenderPrizeList(item:Component,index:int):void 
		{
			
			if (index < this.m_listPrize.length)
			{
				
				var m_item:PrizeItem = item as PrizeItem;
				var data:* = this.m_listPrize.array[index];
				
				m_item.nPrizeID = data.prizeID;
				//添加皮肤
				m_item.imgPrizeType.skin = data.typeurl;
				//奖品数量
				m_item.labName.text = data.labname;
				//奖品初始位置
				m_item.x = 240;
				m_item.y = 240;
				//奖品旋转角度
				m_item.rotation +=rotation;
				rotation += 36;
				//奖品旋转中心轴
				//trace(rotation);
				m_item.pivot(40, 201);
			}
			
		}
		
		
		public function showWinningView(paize:JSON):void
		{
			m_imgWinningBack = new Image;
			m_imgWinningBack.width = 1136;
			m_imgWinningBack.height = 640;
			m_imgWinningBack.skin = "comp/blank.png";
			this.addChild(m_imgWinningBack);
			
			m_boxWinning = new Box;
			m_boxWinning.width = 1136;
			m_boxWinning.height = 640;
			m_boxWinning, name = "content";
			this.addChild(m_boxWinning);
			
			title.skin = "turntable/img_lable.png";
			title.centerX = 0;
			title.anchorX = 0;
			title.anchorY = 0;
			title.top = 55;
			m_boxWinning.addChild(title);
			
			mcbg.skin = "turntable/img_bg.png";
			mcbg.centerX = 0;
			//mcbg.centerY = 0;
			mcbg.top = 170;
			mcbg.anchorX = 0.5;
			mcbg.anchorY = 0.5;
			m_boxWinning.addChild(mcbg);
			mcbg.alpha = 0;
			Laya.timer.loop(1, this, PrizeAnimate2);
			Tween.to(mcbg, {"alpha":1}, 1000);
			
			
			mc.skin = "common/img_" + paize["type"] + ".png";
			mc.centerX = 0;
			mc.centerY = 0;
			mc.width = 190;
			mc.height = 190;
			mc.pivot(0.5,0.5);
			mc.scale(0.1,0.1);
			m_boxWinning.addChild(mc);
			Tween.to(mc, {"scaleX":1, "scaleY":1}, 500, Ease.backInOut);
			
			m_labelPriceNum = new Label;
			m_labelPriceNum.text = paize["title"];
			m_labelPriceNum.centerX = 0;
			m_labelPriceNum.top = 435;
			m_labelPriceNum.fontSize = 32;
			m_labelPriceNum.color = "#ff6637";
			m_labelPriceNum.stroke = 2;
			m_labelPriceNum.strokeColor = "#ffffff";
			m_boxWinning.addChild(m_labelPriceNum);
			
			Vbutton.skin = "common/btn_Bg.png";
			Vbutton.centerX = 0;
			Vbutton.anchorX = 0;
			Vbutton.anchorY = 0;
			Vbutton.top = 500;
			m_boxWinning.addChild(Vbutton);
			
			concent.fontSize = 30;
			concent.text = "领取";
			concent.color = "#FFFFFF";
			concent.centerX = 0;
			concent.centerY = 0;
			concent.anchorX = 0;
			concent.anchorY = 0;
			concent.top = 500;
			Vbutton.addChild(concent);
			
			Vbutton.on(Event.CLICK,this,onShowWinningClicked)
			
			reSetViewUi();
		}
		
		
		private function PrizeAnimate2():void
		{
			mcbg.rotation += 1;
		}
		
		private function onShowWinningClicked():void 
		{	var tur:TurntableLogic = new TurntableLogic;
			tur.onShowWinningClicked();
		}
		
		public function get imgWinningBack():Image 
		{
			return m_imgWinningBack;
		}
		
		public function set imgWinningBack(value:Image):void 
		{
			m_imgWinningBack = value;
		}
		
		public function get boxWinning():Box 
		{
			return m_boxWinning;
		}
		
		public function set boxWinning(value:Box):void 
		{
			m_boxWinning = value;
		}


		//
		////旋转背景光
		//private function RenderCircle():void
		//{
		//
		////	m_spXuanZhuan.pivot = (m_spXuanZhuan.x+m_spXuanZhuan.width/2,m_spXuanZhuan.y+m_spXuanZhuan.height);
			//Laya.timer.loop(1, this, RenderCircleAnimate);
			//
		//}
		////缩放背景光
		//private function ZoomCircle():void 
		//{
			//
			//Laya.timer.loop(25, this, ZoomCircleAnimate);
		//}
		//
		//private function ZoomCircleAnimate():void 
		//{
			//
			//scaleDelta += 0.01;
			//m_spZoom.alpha -= 0.02;
			//if (scaleDelta >= 0.8)
			//{
				//scaleDelta = 0.43;
				//m_spZoom.alpha = 1;
			//}
//
			//m_spZoom.scale(scaleDelta,scaleDelta);
		//}
		//
		//
		//private function RenderCircleAnimate():void 
		//{
			//m_spRotate.rotation += 4;
			//
		//}
		//
		//public function get imgBg():Image 
		//{
			//return m_imgBg;
		//}
		//
		//public function set imgBg(value:Image):void 
		//{
			//m_imgBg = value;
		//}
		//
	}

}