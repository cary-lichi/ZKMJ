package tool 
{
	import core.Constants;
	import core.GameIF;
	import laya.ui.Box;
	import laya.ui.View;
	import laya.utils.Browser;
	import model._Gamer.Gamer;
	import model._Room.Room;
	import model._Room.RoomHappy;
	import model._Room.RoomCommon;
	import model._Gamer.RoomFourGamerBottom;
	import model._Gamer.RoomFourGamerLeft;
	import model._Gamer.RoomFourGamerRight;
	import model._Gamer.RoomFourGamerTop;
	import model._Gamer.RoomThreeGamerBottom;
	import model._Gamer.RoomThreeGamerLeft;
	import model._Gamer.RoomThreeGamerRight;
	import model._Gamer.RoomTwoGamerBottom;
	import model._Gamer.RoomTwoGamerTop;
	import model._Room.RoomHunzi;
	import view.GameHappySettlementView;
	import view.GameSettlementView;
	import view.GameVipSettlementView;
	/**
	 * ...
	 * @author ...
	 */
	public class Tool 
	{
		
		public function Tool() 
		{
			
		}
		public static function getHeadUrl():String
		{
			var img:String = Math.floor(Math.random() * 10).toString();
			var HeadUrl:String = "ai/img_head_t_1_v_"+img+".png";
			return HeadUrl;
		}
		public static function getNewSettlement(type:int):GameSettlementView
		{
			var settlement:GameSettlementView;
			var cardType:JSON = GameIF.GetJson()["cardType"];
			if (cardType["happyRoom"] == type)
			{
				settlement = new GameHappySettlementView;
			}
			else
			{
				settlement = new GameVipSettlementView;
			}
			return settlement;
		}
		public static function getNewRoom(type:int):Room
		{
			var room:Room;
			var cardType:JSON = GameIF.GetJson()["roomType"];
			switch(type)
			{
				case cardType["common"]:
					room = new RoomCommon;	
					break;
				case cardType["hunzi"]:
					room = new RoomHunzi;	
					break;
				case cardType["happy"]:
					room = new RoomHappy;	
					break;
				default:
					room = new Room;	
					break;
			}
			return room;
		}
		//获取其他玩家相对位置，自己默认为0（下面）
		public static function getNewGamer(m_myPos:int,gamerPos:int):Gamer
		{
			var nPlayers:int = GameIF.GetRoom().nPlayers;
			var targetPos:int = (m_myPos - gamerPos + nPlayers) % nPlayers;
			var newGamer:Gamer;
			if (nPlayers == 2)
			{
				//二人场
				switch(targetPos)
					{
						case 0:
							newGamer = new RoomTwoGamerBottom;
							break;
						case 1:
							newGamer = new RoomTwoGamerTop;
							break;
						default:
							break;
					}
			}
			else if (nPlayers == 3)
			{
				//三人场
				switch(targetPos)
					{
						case 0:
							newGamer = new RoomThreeGamerBottom;
							break;
						case 1:
							newGamer = new RoomThreeGamerLeft;
							break;
						case 2:
							newGamer = new RoomThreeGamerRight;
							break;
						default:
							break;
					}
			}
			else if (nPlayers == 4)
			{
				//四人场
				switch(targetPos)
					{
						case 0:
							newGamer = new RoomFourGamerBottom;
							break;
						case 1:
							newGamer = new RoomFourGamerLeft;
							break;
						case 2:
							newGamer = new RoomFourGamerTop;
							break;
						case 3:
							newGamer = new RoomFourGamerRight;
							break;
						default:
							break;
					}
			}
			newGamer.nPos = targetPos;
			return newGamer;
			
		}
		//获取适配的缩放比例
		public static function getScale():Number
		{
			var scaleX:Number = Laya.stage.width  / 1136;		
			var scaleY:Number = Laya.stage.height  / 640;
			
			//var scaleX:Number = Browser.clientWidth  / 1136;		
			//var scaleY:Number = Browser.clientHeight  / 640;
			
			return Math.min(scaleX, scaleY);
		}
		//动态适配
		public static function Adaptation(page:*):void 
		{
			Constants.setBGFullScreen(page);
			page.centerX = 0;
			page.centerY = 0;
			for (var i:int = 0; i < page.numChildren;i++)
			{
				var node:* = page.getChildAt(i);
				if (node.name == "content")
				{
					var scale:Number =Tool.getScale();
					node.pivot(0.5, 0.5);
					node.scale(scale, scale);
					node.centerX = 0;
					node.centerY = 0;
				}
				else
				{
					Constants.setBGFullScreen(node);
				}
			}
			
		}
		//获取渲染信息
		public static function GetRenderPai(nType:int,nValue:int):String
		{
			if (!nType &&nType!=0 || !nValue)
			{
				trace("错误提示：获取渲染信息时 牌的nType="+nType+"  nValue="+nValue);
			}
			var paiValue:String;
			switch(nType)
			{
				case 0:
					paiValue = "zfb_" + nValue.toString();
					break;
				case 1:
					paiValue = "dxnb_" + nValue.toString();
					break;
				case 2:
					paiValue = "w_" + nValue.toString();
					break;
				case 3:
					paiValue = "tiao_" + nValue.toString();
					break;
				case 4:
					paiValue = "tong_" + nValue.toString();
					break;
			}
			return paiValue;
		}
		
		//通过经纬度计算两个玩家的距离
		public static function GetGamerDistance(gamer1:Gamer,gamer2:Gamer):String
		{
			var distance:String = Tool.GetPointDistance(gamer1.sLng, gamer1.sLat, gamer2.sLng, gamer2.sLat);
			distance = "相距" + distance+"米";
			return distance ;
		}
		//通过经纬度计算两点距离
		public static function GetPointDistance(lng1:String,lat1:String,lng2:String,lat2:String):String
		{
			var distance:String;
			distance = __JS__('GetDistance(lng1,lat1,lng2,lat2)');
			return distance ;
		}
	}

}