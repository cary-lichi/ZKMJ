package view.Room 
{
	import core.AnimationAltas;
	import core.Constants;
	import core.GameIF;
	import laya.html.dom.HTMLDivElement;
	import laya.maths.Point;
	import laya.ui.Component;
	import laya.ui.Image;
	import laya.ui.List;
	import laya.utils.Browser;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;
	import model._Pai.Pai;
	import tool.Tool;
	import ui.MahjongRoot.VIPRoomPageUI;
	import view.ActiveView._gameItem.Gamer0PaiItem;
	/**
	 * ...
	 * @author ...
	 */
	public class RoomView extends VIPRoomPageUI 
	{
		//protected var m_listPai:List;
		protected var m_aminCurPaiCircle:AnimationAltas;
		protected var m_nCurPaiArrowY:Number = 0;
		protected var m_nCurPaiArrowOffsetY:Number = 0.48;
		
		protected var m_aminChiCircle:AnimationAltas;
		protected var m_aminChiRotate:AnimationAltas;
		
		protected var m_aminPengCircle:AnimationAltas;
		protected var m_aminPengRotate:AnimationAltas;
		//
		protected var m_aminGangCircle:AnimationAltas;
		protected var m_aminGangRotate:AnimationAltas;
		//
		protected var m_aminTingCircle:AnimationAltas;
		protected var m_aminTingRotate:AnimationAltas;
		
		protected var m_aminHuCircle:AnimationAltas;
		protected var m_aminHuRotate:AnimationAltas;
		
		protected var m_aminHead0:AnimationAltas;
		protected var m_aminHead1:AnimationAltas;
		protected var m_aminHead2:AnimationAltas;
		protected var m_aminHead3:AnimationAltas;
		//getpai
		protected var m_btnGetPaiP:Gamer0PaiItem;
		//表情
		public var m_faceFloat:HTMLDivElement;
		public var m_faceFloatAlpha:int;
		public var m_faceFloatY:int;
		public var outPutBox:HTMLDivElement;
		public var msgBox:Image;
		
		public function RoomView() 
		{
			super();
		}
		
		public function Init():void
		{
			
			//初始化页面
			InitView();
			m_nCurPaiArrowY = m_imgCurPutPai.y;
			//初始化出牌箭头
			RenderCurArrow();
			//初始化出牌箭头上的特效
			InitCurPaiCircle();
			
			InitGetPai();
			
			m_btnPeng.addChild(InitCircle(m_aminPengCircle));
			m_btnPeng.addChild(InitRotate(m_aminPengRotate));
			
			m_btnChi.addChild(InitCircle(m_aminChiCircle));
			m_btnChi.addChild(InitRotate(m_aminChiRotate));
			
			m_btnGang.addChild(InitCircle(m_aminGangCircle));
			m_btnGang.addChild(InitRotate(m_aminGangRotate));
			
			m_btnTing.addChild(InitCircle(m_aminTingCircle));
			m_btnTing.addChild(InitRotate(m_aminTingRotate));
			
			m_btnHu.addChild(InitCircle(m_aminHuCircle));
			m_btnHu.addChild(InitRotate(m_aminHuRotate));
			
			m_boxAminHead0.addChild(InitHead(m_aminHead0));
			m_boxAminHead1.addChild(InitHead(m_aminHead1));
			m_boxAminHead2.addChild(InitHead(m_aminHead2));
			m_boxAminHead3.addChild(InitHead(m_aminHead3));
			
			m_imgCurPutPai.addChild(m_aminCurPaiCircle);
			
			if (Constants.isAdaptPhone)
			{
				reSetGamehallViewUi();
				var viproomView:RoomView = this;
			
				Browser.window.addEventListener("resize", function():void {
					Laya.timer.once(1000, viproomView, reSetGamehallViewUi);
					
				});
			}
			
			Laya.stage.addChild(this);
		}
		
		protected function InitView():void 
		{
			//putpai的牌池渲染成 3X8
			m_listPutPai.repeatX = 8;
			m_listPutPai.repeatY = 3;
			
			m_list1PutPai.repeatX = 3;
			m_list1PutPai.repeatY = 8;
			
			m_list2PutPai.repeatX = 8;
			m_list2PutPai.repeatY = 3;
			m_list2PutPai.x -= 80;
			
			m_list3PutPai.repeatX = 3;
			m_list3PutPai.repeatY = 8;
			m_list3PutPai.y -= 60 ;
		}
		protected function reSetGamehallViewUi():void 
		{
			
			Tool.Adaptation(this);
			this.m_imgOtherGPSBg.width = this.width;
			this.m_boxCurPutPai.width = this.width;
			this.m_imgSetBlackBg.width = this.width * (400 / 1136);
			this.m_boxDelegateContent.pivot(0.5,0.5);
			this.m_boxDelegateContent.scale(Tool.getScale(), Tool.getScale());
			this.m_boxDelegateContent.centerX = 0;
			this.m_imgDedgateBg.width = this.width;
			this.m_imgDedgateBg.scaleY=Tool.getScale();
			this.m_imgDedgateBg.y = this.m_listPai.localToGlobal(new Point(0, 0)).y;
		}
		protected function InitGetPai():void 
		{
			if (m_btnGetPaiP == null)
			{
				m_btnGetPaiP = new Gamer0PaiItem;
			}
			m_btnGetPaiP.visible = false;
			m_btnGetPaiP.y = 0;
			m_btnGetPaiP.x = 933;
			
			this.m_listPai.addChild(m_btnGetPaiP);
		}
		protected function RenderCurArrow():void 
		{
			//传入函数，判断
			//Laya.timer.loop(1, this, SetCurArrowPos);
			SetCurArrowPosUp();
			
		}
		protected function SetCurArrowPosUp():void 
		{
			var y:int = m_imgCurPutPai.y + 10;
			Tween.to(m_imgCurPutPai, { "y":y  }, 300,null,new Handler(this,SetCurArrowPosDown));
		}
		protected function SetCurArrowPosDown():void 
		{
			var y:int = m_imgCurPutPai.y - 10;
			Tween.to(m_imgCurPutPai, { "y": y }, 300,null,new Handler(this,SetCurArrowPosUp));
		}
		protected function SetCurArrowPos():void 
		{
			m_imgCurPutPai.y += m_nCurPaiArrowOffsetY;
			
			if (m_imgCurPutPai.y >= m_nCurPaiArrowY+6)
			{
				m_nCurPaiArrowOffsetY = -m_nCurPaiArrowOffsetY;
			}
			if (m_imgCurPutPai.y <= m_nCurPaiArrowY - 6)
			{
				m_nCurPaiArrowOffsetY = -m_nCurPaiArrowOffsetY;
			}
		}
		protected function InitCurPaiCircle():void 
		{
			m_aminCurPaiCircle = new AnimationAltas;
			m_aminCurPaiCircle.pos( -17, 4);
			m_aminCurPaiCircle.LoadAinmation("effectCircle", 16);
			m_aminCurPaiCircle.animInner.interval = 50;
			//设置混合模式
			m_aminCurPaiCircle.SetMixedMode("lighter");
			m_aminCurPaiCircle.Play(true);
		}
		
		protected function InitCircle(amin:AnimationAltas):AnimationAltas 
		{
			amin = new AnimationAltas;
			amin.pos( -15, -10);
			amin.LoadAinmation("effectCanPaiCircle", 17);
			amin.animInner.interval = 70;
			//设置混合模式
			amin.SetMixedMode("lighter");
			amin.Play(true);
			return amin;
		}
		
		protected function InitRotate(amin:AnimationAltas):AnimationAltas 
		{
			amin = new AnimationAltas;
			amin.pos( 5, 5);
			amin.LoadAinmation("effectCanPaiRotate", 12);
			amin.animInner.interval = 50;
			//设置混合模式
			amin.SetMixedMode("lighter");
			amin.Play(true);
			return amin;
		}
		protected function InitHead(amin:AnimationAltas):AnimationAltas 
		{
			amin = new AnimationAltas;
			amin.pos(-9,-6);
			amin.LoadAinmation("effectHead", 52);
			amin.animInner.interval = 100;
			//设置混合模式
			amin.SetMixedMode("lighter");
			amin.Play(true);
			return amin;
		}
		//—————————————————混子出场动画—————————————————————//
		public function BaoPaiShowStart(pai:Pai, callback:Function, caller:*):void 
		{
		
		}
		//—————————————————吃碰杠听胡———飘字动画——————————————————//
		public function CanPaiStart(x:int,y:int,type:String):void 
		{
			this.m_boxCanPaiAmi.pos(x, y);
			this.m_boxCanPaiAmi.visible = true;
			this.m_imgEntity.skin = "game/img_CanPaiAmi_"+type+".png";
			this.m_imgGhost.skin = "game/img_CanPaiAmi_"+type+".png";
			Tween.to(this.m_imgEntity, {"scaleX":1.2, "scaleY":1.2}, 300, Ease.linearIn, Handler.create(this, CanPai1));
			Tween.to(this.m_imgGhost, {"scaleX":1.2, "scaleY":1.2}, 300,Ease.linearIn);
			
		}
		protected function CanPai1():void
		{
			Tween.to(this.m_imgEntity, {"scaleX":0.8, "scaleY":0.8}, 300,Ease.linearIn,Handler.create(this, CanPai2));
			Tween.to(this.m_imgGhost, {"scaleX":0.8, "scaleY":0.8}, 300);
		}
		protected function CanPai2():void
		{
			Tween.to(this.m_imgEntity, {"scaleX":1.2, "scaleY":1.2}, 800,Ease.linearIn,Handler.create(this, CanPai3));
			Tween.to(this.m_imgGhost, {"scaleX":2, "scaleY":2,alpha:0}, 800);
		}
		protected function CanPai3():void
		{
			Tween.to(this.m_imgEntity, {"scaleX":1, "scaleY":1,alpha:0.6}, 600,Ease.linearIn,Handler.create(this, CanPaiStop));
		}
		protected function CanPaiStop():void 
		{
			this.m_imgEntity.scale(1, 1);
			this.m_imgEntity.alpha = 1;
			this.m_imgGhost.scale(1, 1);
			this.m_imgGhost.alpha = 1;
			this.m_boxCanPaiAmi.visible = false;
		}
		
		//表情上下浮动动画
		public function FaceAnimationStart(faceFloat:HTMLDivElement,faceFloatAlpha:int,faceFloatY:Image):void
		{	
			m_faceFloat = faceFloat;
			m_faceFloatAlpha = faceFloatAlpha;
			m_faceFloatY = faceFloatY.y-3;
			m_faceFloat.x =faceFloatY.x-5;
			m_faceFloat.y = faceFloatY.y;
			
			m_faceFloat.visible = true;
			m_faceFloat.alpha = 0.01;
			
			if(m_faceFloatAlpha != 0)
			{
				Tween.clearAll(m_faceFloat);
				Tween.to(m_faceFloat, {alpha:1}, 200);
				Tween.to(m_faceFloat, {y:m_faceFloatY - 10}, 450, Ease.linearIn, Handler.create(this, AnimationTwo));
				Laya.timer.once(3000,this,HideBubblesOne); 
			}	
		}
		protected function AnimationTwo():void
		{  
			if(m_faceFloatAlpha != 0)
			{
			Tween.to(m_faceFloat, {y:m_faceFloatY + 10}, 900, Ease.linearIn, Handler.create(this, AnimationThree));
			}
		}
		protected function AnimationThree():void
		{  
			if(m_faceFloatAlpha != 0)
			{
			Tween.to(m_faceFloat, {y:m_faceFloatY - 10}, 900, Ease.linearIn, Handler.create(this, AnimationTwo));
			}
		}
		protected function HideBubblesOne():void
		{
			Tween.to(m_faceFloat, {alpha:0}, 200);
			if (m_faceFloat.alpha == 0)
			{
			m_faceFloat.visible = false;
			}
		}
		
		//输入框隐藏
		public function InPutHideBubbles(VoutPutBox:HTMLDivElement,VmsgBox:Image):void
		{
			outPutBox = VoutPutBox;
			msgBox = VmsgBox;
			outPutBox.visible = true;
			msgBox.visible = true;
			outPutBox.alpha = 0.01;
			msgBox.alpha = 0.01;
			Tween.to(outPutBox, {alpha:1}, 300);
			Tween.to(msgBox, {alpha:1}, 300);
			Laya.timer.once(3000,this,HideBubblesTwo); 
		}
		
		protected function HideBubblesTwo():void
		{
			Tween.to(outPutBox, {alpha:0}, 300);
			Tween.to(msgBox, {alpha:0}, 300);
			if (outPutBox.alpha == 0 && msgBox.alpha == 0)
			{
			outPutBox.visible = false;
			msgBox.visible = false;
			}
		}
		public function Destroy():void
		{
			try
			{
				//Laya.loader.clearRes("res/atlas/game/pai.json", false);
				//Laya.loader.clearRes("res/atlas/game.json", false);
			}
			catch(errobject:Error){
				trace(errobject.stack);
			}
			
			m_btnGetPaiP = null;
			
			Laya.stage.removeChild(this);
			this.destroy();
		}
		
		public function get btnGetPaiP():Gamer0PaiItem 
		{
			return m_btnGetPaiP;
		}
		
		public function set btnGetPaiP(value:Gamer0PaiItem):void 
		{
			m_btnGetPaiP = value;
		}
		
	}

}