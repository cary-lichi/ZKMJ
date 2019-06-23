package blls._Game 
{
	import blls.BaseLogic;
	import core.GameIF;
	import core.LogicManager;
	import laya.display.Text;
	import laya.events.Event;
	import laya.ui.Component;
	import laya.ui.Label;
	import laya.utils.Handler;
	import network.NetworkManager;
	import view.ActiveView.ChatFaceItem;
	import view.ActiveView.ChatWindow;
	import view.AlphaWindowView;
	
	/**
	 * ...
	 * @author dawenhao
	 */
	public class ChatLogic extends BaseLogic 
	{
		private var m_chatWindow:ChatWindow;
		public static var m_sContent:String;
		
		public function ChatLogic() 
		{
			super();
			
		}
		
		public override function Init():void
		{
			if (m_chatWindow == null)
			{
				m_chatWindow = new ChatWindow;
				m_chatWindow.Init();
			}
			m_chatWindow.visible = true;
			//注册所有按钮事件
			registerEventClick();
			//表情list
			InitList();
			
		}
		
		private function registerEventClick():void 
		{
			//确定按钮点击
			m_chatWindow.m_btnSubmit.on(Event.CLICK, this, OnSubmitClicked);
			//黑幕被电击
			m_chatWindow.m_imgBack.on(Event.CLICK, this, onAlphaScreenClicked);
			m_chatWindow.tab_notice.selectHandler = new Handler(this, onSelecte);
			//快捷语句被点击
			m_chatWindow.m_boxText.on(Event.CLICK, this, OnTextClicked);
			
		}
		//快捷语句点击事件
		private function OnTextClicked(e:Event):void 
		{
			if (e.target.name!="box")
			{
				var text:Label = e.target.getChildAt(0) as Label;
				var ssmit:String;
				SocketSendChat(text.text);
			}
		}
	
		//黑幕被点击
		private function onAlphaScreenClicked():void 
		{
			GameIF.DectiveLogic(LogicManager.CHATLOGIC);
			return;
		}
		
		//确定按钮点击
		private function OnSubmitClicked():void 
		{  	
			if (m_chatWindow.m_labelInput.text != "")
			{
				SocketSendChat(m_chatWindow.m_labelInput.text);
				m_chatWindow.m_labelInput.text = "";
			}
		}
		
		//通信
		private function SocketSendChat(sContent:String):void 
		{
			m_sContent = sContent;
			
			var ChatRequest:* = NetworkManager.m_msgRoot.lookupType("ChatRequest");
			var ChatRequestMsg:* = ChatRequest.create({
				nUserID:GameIF.GetDalManager().daluser.nID,
				sRoomID:GameIF.GetRoom().sRoomID,
				sContent:sContent
				
			});
			var Request:* = NetworkManager.m_msgRoot.lookupType("Request");
			var requestMsg:* = Request.create({
				chatRequest:ChatRequestMsg
			});
			
			var Msg:* = NetworkManager.m_msgRoot.lookupType("Msg");
			var MsgMessage:* = Msg.create({
				type:79,
				request:requestMsg
			});      
			
			var encodeMessage:* = Msg.encode(MsgMessage).finish();
			GameIF.getInstance().networkManager.SocketSendMessage(encodeMessage);
		}

		private function InitList():void 
		{
			var data:Array = [];
			for (var m:int = 0; m <= 53; m++)
			{
				data.push({faceUrl:"chat/btn_face" + m + ".png"});
			}
			m_chatWindow.m_list.itemRender = ChatFaceItem;//Item
			m_chatWindow.m_list.renderHandler = new Handler(this, renderFun);
			
			m_chatWindow.m_list.array = data;
			//m_chatWindow.m_list.repeatY = data.length / 3 + 1;
			//使用但隐藏垂直滚动条
			m_chatWindow.m_list.vScrollBarSkin = "";
            //滚动在头或底回弹时间
            m_chatWindow.m_list.scrollBar.elasticBackTime = 200;
            //滚动在头或底最大距离
            m_chatWindow.m_list.scrollBar.elasticDistance = 200;
			
			m_chatWindow.m_list.mouseHandler = new Handler(this, OnListClicked);
		
		}
		
		//表情list点击事件
		private function OnListClicked(e:Event,index:Number):void 
		{
			if (e.type == Event.CLICK)
			{
				//无关变量s转index为string
				var s:String;
				s=index.toString();
				SocketSendChat(Encrypt(s));
				
			}
		}
			
		private function renderFun(item:Component,index:int):void 
		{
			var m_item:ChatFaceItem = item as ChatFaceItem;
			var data:* = m_chatWindow.m_list.array[index];
			m_item.bg.skin = data.faceUrl;
			
		}
		
		////收到消息解析
		//private function showChatBubble(value:String):void 
		//{
			////当有密码时
			//if (value.substring(0, 13) == "@%$>]~*>[;[#@")
			//{   value=value.substring(13, value.length);
				//m_chatWindow.outPutBox.innerHTML = "<span><img src = 'chat/btn_face" + value + ".png' style = 'width:40px; height:40px' ></img></span>"; 
			//}
			////没密码时	
			//else
			//{	
			    //m_chatWindow.lableLength.text = value;
				//m_chatWindow.m_imgChat.width =  m_chatWindow.lableLength.width + 32;
				//m_chatWindow.m_labelInput.text = "";
				//m_chatWindow.outPutBox.y = 10;
				//m_chatWindow.outPutBox.innerHTML = "<span style='font-size:20px;font-family:SimHei;color:#6d3f2f;text-align:center;vertical-align:middle;'>"+value+"</span>";
			//}
		//}
		//
		//表情加密
		private function Encrypt(value:String):String
		{	
			var encryPtionKey:String = "@%$>]~*>[;[#@";
		    value = encryPtionKey + value;
			return value;
		}
		
		
		private function onSelecte(index:int):void
        {
            //切换ViewStack子页面
			m_chatWindow.vs_notic.selectedIndex = index;
		   
        }
		
		public override function Destroy():void
		{
			m_chatWindow.Destroy();
			m_chatWindow.destroy();
			m_chatWindow.visible = false;
			m_chatWindow = null;
			
		}
	}
}