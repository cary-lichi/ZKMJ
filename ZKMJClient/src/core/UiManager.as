package core 
{
	import blls.PopUpLogic;
	import laya.display.Sprite;
	import laya.display.Stage;
	import laya.events.Event;
	import laya.ui.Box;
	import laya.ui.Button;
	import laya.ui.Clip;
	import laya.ui.Image;
	import laya.ui.Label;
	import laya.utils.Browser;
	import laya.utils.Ease;
	import laya.utils.Tween;
	import view.ActiveView.PopUpDia;
	import view.AlphaWindowView;
	import view.BlackWindowView;
	/**
	 * ...
	 * @author ...
	 */
	public class UiManager 
	{
		private var m_alphaWindowView:AlphaWindowView;
		private var m_blackWindowView:BlackWindowView;
		private var m_tipsDia:Image;
		private var m_tipsBg:AlphaWindowView;
		private var m_popUpDia:PopUpDia;
		
		public function UiManager() 
		{
			
		}
		public function GetBlackWindowView():BlackWindowView
		{
			if (m_blackWindowView == null)
			{
				m_blackWindowView = new BlackWindowView;
				Laya.stage.addChild(m_blackWindowView);
				m_blackWindowView.on(Event.CLICK, this, onBlackScreenClicked);//从黑幕源头解决点击问题。
			}
			m_blackWindowView.visible = true;
			//onBlackScreenClicked();
			return m_blackWindowView;
		}
		public function GetAlphaWindowView():AlphaWindowView
		{
			if (m_alphaWindowView == null)
			{
				m_alphaWindowView = new AlphaWindowView;
				Laya.stage.addChild(m_alphaWindowView);
				m_alphaWindowView.on(Event.CLICK, this, onAlphaScreenClicked);//从黑幕源头解决点击问题。
			}
			m_alphaWindowView.visible = true;
			return m_alphaWindowView;
		}
		//获取弹窗
		/*
		 * title:String  弹窗的内容
		 * */
		public function GetPopUpDia(title:String, func:Function = null,caller:*=null):PopUpDia 
		{
			ClosePopUpDia();
			m_popUpDia = new PopUpDia;
			m_popUpDia.Init();
			m_popUpDia.visible = true;
			m_popUpDia.m_btnIsOK.offAll();
			//确定按钮点击
			if (func == null)
			{
				m_popUpDia.m_btnIsOK.on(Event.CLICK, this, ClosePopUpDia);
			}
			else
			{
				m_popUpDia.m_btnIsOK.on(Event.CLICK, caller, func);
			}
			
			//黑幕点击。
			m_popUpDia.m_imgBackBg.on(Event.CLICK, this, onAlphaScreenClicked);
			//设置内容
			m_popUpDia.m_lableTitle.text = title;
			
			return m_popUpDia;
		}
		//确定按钮点击
		public function ClosePopUpDia():void 
		{
			if (m_popUpDia)
			{
				m_popUpDia.Destroy();
				m_popUpDia.visible = false;
				m_popUpDia = null;	
			}
		}
		
			//显示分享成功弹窗
		public function GetShareSuccessDia(html:String,func:Function = null,caller:*=null):PopUpDia 
		{
			ClosePopUpDia();
			m_popUpDia = new PopUpDia;
			m_popUpDia.Init();
			m_popUpDia.m_lableisOK.text = "确定";
			m_popUpDia.m_lableTitle.visible = false;
			m_popUpDia.m_boxShare.visible = true;
			m_popUpDia.m_htmlShare.innerHTML = html;
			m_popUpDia.m_btnIsOK.offAll();
			//确定按钮点击
			if (func == null)
			{
				m_popUpDia.m_btnIsOK.on(Event.CLICK, this, ClosePopUpDia);
			}
			else
			{
				m_popUpDia.m_btnIsOK.on(Event.CLICK, caller, func);
			}
			m_popUpDia.m_imgBackBg.on(Event.CLICK, this, onAlphaScreenClicked);
			return m_popUpDia;
		}
		//显示飘字  
		/*
		 * TipsDia:Image 提示对话框背景
		 * LableTipsDia:Label 提示对话框Label
		 * text:String 提示对话框内容
		 * */
		public function showTipsDia(TipsDia:Image,LableTipsDia:Label=null,text:String=null):void 
		{
			if (m_tipsBg == null)
				{
					m_tipsBg = new AlphaWindowView;
					m_tipsBg.Init();
					m_tipsBg.on(Event.CLICK, this, onAlphaScreenClicked);
				}
			m_tipsBg.visible = true;
			m_tipsDia = TipsDia;
			m_tipsDia.visible = true;
			if (LableTipsDia)
			{
				LableTipsDia.text = text;
			}
			Laya.timer.once(1000, this, visible);
		}
		//显示数字
		/*
		 * box:Box 数字组的容器
		 * number:Number 需要显示的数字
		 * */
		public function showNumber(box:Box,number:Number):void
		{
			number = number?number:0;
			number = Math.floor(number);
			var s_number:String = String(number);
			var clip:Clip;
			var wan:Image=box.getChildAt(4) as Image;
			wan.visible = true;
			if (s_number.length<5)
			{
				for (var i:int = 0; i < s_number.length; i++)
				{
					clip = box.getChildAt(i) as Clip;
					clip.visible = true;
					clip.index = s_number[i];
				}
				for (var j:int = s_number.length; j < 5; j++)
				{
					clip= box.getChildAt(j) as Clip;
					clip.visible = false;
					clip.index = 0;
				}
			}
			else if (s_number.length ==5)
			{
				clip = box.getChildAt(0) as Clip;
				clip.visible = true;
				clip.index = s_number[0];
				
				clip = box.getChildAt(1) as Clip;
				clip.visible = true;
				clip.index = 10;
				
				clip = box.getChildAt(2) as Clip;
				clip.visible = true;
				clip.index = s_number[1];
				
				clip = box.getChildAt(3) as Clip;
				clip.visible = true;
				clip.index = s_number[2];
			}
			else if (s_number.length == 6)
			{
				clip = box.getChildAt(0) as Clip;
				clip.visible = true;
				clip.index = s_number[0];
				
				clip = box.getChildAt(1) as Clip;
				clip.visible = true;
				clip.index = s_number[1];
				
				clip = box.getChildAt(2) as Clip;
				clip.visible = true;
				clip.index = 10;
				
				clip = box.getChildAt(3) as Clip;
				clip.visible = true;
				clip.index = s_number[2];
			}
			else if (s_number.length >= 7 && s_number.length < 9)
			{
				for (var k:int = 0; k < s_number.length-4; k++)
				{
					clip = box.getChildAt(k) as Clip;
					clip.visible = true;
					clip.index = s_number[k];
				}
				for (var l:int = s_number.length-4; l < 4; l++)
				{
					clip= box.getChildAt(l) as Clip;
					clip.visible = false;
					clip.index = 0;
				}
			}
			else if (s_number.length >= 9)
			{
				for (var m:int = 0; m < 4; m++)
				{
					clip = box.getChildAt(m) as Clip;
					clip.visible = true;
					clip.index = 9;
				}
			}
		}
		//透明层点击不被穿透
		public function onAlphaScreenClicked():void 
		{
			return ;
		}
		//隐藏飘字
		private function visible():void 
		{
			m_tipsDia.visible = false;
			m_tipsDia = null;
			m_tipsBg.Destroy();
			m_tipsBg.destroy();
			m_tipsBg.visible = false;
			m_tipsBg = null;	
		}
		
		/**
		 * 此内容块为适配屏幕所用到函数
		 * @return
		 */
		public function getScale():Number
		{
			var scaleX:Number = Laya.stage.width  / 1136;		
			var scaleY:Number = Laya.stage.height  / 640;
			return Math.min(scaleX, scaleY);
		}
		public function getScreenWidth():Number
		{
			return Laya.stage.width;
		}
		
		public function getScreenHeight():Number
		{
			return Laya.stage.height;
		}
		
		public function setUiLeft(uiWidget:*,uiLeft:Number):void
		{
			uiWidget.left = (GameIF.getInstance().uiManager.getScreenWidth() * uiLeft) / 1136;
		}
		
		public function setUiTop(uiWidget:*,uiRight:Number):void
		{
			uiWidget.left = (GameIF.getInstance().uiManager.getScreenHeight() * uiRight) / 640;
		}
		
		public function setUiWidth(uiWidget:*,uiWidth:Number):void
		{
			uiWidget.width = GameIF.getInstance().uiManager.getScale() * uiWidth;
		}
		
		public function setUiHeight(uiWidget:*,uiHeight:Number):void
		{
			uiWidget.height = GameIF.getInstance().uiManager.getScale() * uiHeight;
		}
		
		public function setBGFullScreen(uiWidget:*):void
		{
			uiWidget.width = GameIF.getInstance().uiManager.getScreenWidth();
			uiWidget.height = GameIF.getInstance().uiManager.getScreenHeight();
		}
		///////////////////////////////////////////////////////////////////////////////////////
		
		////
		//黑幕被点击不会点到别的按钮。
		private function onBlackScreenClicked():void
		{
			trace("黑幕被电击");
			return;
		}
		
		public function get alphaWindowView():AlphaWindowView 
		{
			return m_alphaWindowView;
		}
		
		public function set alphaWindowView(value:AlphaWindowView):void 
		{
			m_alphaWindowView = value;
		}
		
		public function get blackWindowView():BlackWindowView 
		{
			return m_blackWindowView;
		}
		
		public function set blackWindowView(value:BlackWindowView):void 
		{
			m_blackWindowView = value;
		}
		
		
		
	}

}