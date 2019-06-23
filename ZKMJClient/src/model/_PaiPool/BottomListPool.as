package model._PaiPool 
{
	import dal.DalPai;
	import laya.maths.Point;
	import laya.ui.Box;
	import laya.ui.Component;
	import laya.ui.List;
	import laya.utils.Dictionary;
	import laya.utils.Handler;
	import model._Pai.ChiPai;
	import model._Pai.GangPai;
	import model._Pai.Pai;
	import model._Pai.PengPai;
	import view.ActiveView._gameItem.BaseFacePaiItem;
	import view.ActiveView._gameItem.BasePaiItem;
	import view.ActiveView._gameItem.Gamer0CanPaiItem;
	import view.Room.RoomView;
	import view.Room.VIPRoomView;
	/**
	 * ...
	 * @author ...
	 */
	public class BottomListPool extends ListPool
	{
		public function BottomListPool(dalPai:DalPai,vipRoomView:RoomView) 
		{
			super(dalPai, vipRoomView);
			Reset();
		}
		protected override function Reset():void
		{
			m_posStart.x = 80;
			m_posStart.y = 504;
		}
		//计算渲染位置
		protected override function calcRenderPos():Point 
		{
			var targetPos:Point = new Point;
			m_posStart.x += 10;
			targetPos.x = m_posStart.x;
			targetPos.y = m_posStart.y;
			return targetPos;
		}
		protected override function SetPaiPos(pai:BasePaiItem,index:int):void 
		{
			pai.x = 49 * index;
			m_posStart.x += 49 ;
		}
		protected override function SetGangPaiPos(pai:BaseFacePaiItem):void 
		{
			pai.x -= 2;
			pai.y -= 16;
		}
		//为了解决层级问题动态设置box层级
		protected override function GetBox():Box
		{
			var box:Box = new Box;
			box.zOrder =-10;
			return box;
		}
		//获取牌对象
		protected override function GetPaiItem():* 
		{
			return new Gamer0CanPaiItem;
		}
		//渲染吃
		public override function addChiList(object:ChiPai):void 
		{
			m_newBox = new Box;
			var newPos:Point = calcRenderPos();
			m_newBox.pos(newPos.x,newPos.y);
			var arr:Array = [];
			arr.push(object.pai1);
			arr.push(object.pai2);
			arr.push(object.pai3);
			RenderChiPaiHandler(arr,m_newBox);
			m_Canlist.push(m_newBox);
			m_vipView.m_listCanPai.addChild(m_newBox);
			object.view = m_newBox;
		}	
		private function RenderChiPaiHandler(data:Array,newbox:Box):void
		{
			for (var index:int = 0; index < 3; index++ )
			{
				var i:Gamer0CanPaiItem = new Gamer0CanPaiItem;
				i.pai = data[index];
				SetPaiPos(i,index);
				newbox.addChild(i);
			}
		}
		//渲染碰
		public override function addPengList(object:PengPai):void 
		{	
			m_newBox = GetBox();
			var newPos:Point = calcRenderPos();
			m_newBox.pos(newPos.x,newPos.y);
			var arr:Array = [];
			arr.push(object.pai1);
			arr.push(object.pai2);
			arr.push(object.pai3);
			RenderPengPaiHandler(arr,m_newBox);
			m_Canlist.push(m_newBox);
			m_vipView.m_listCanPai.addChild(m_newBox);
			object.view = m_newBox;
		}
		private function RenderPengPaiHandler(data:Array,newbox:Box):void
		{
			for (var index:int = 0; index < 3; index++ )
			{
				var i:Gamer0CanPaiItem = new Gamer0CanPaiItem;
				i.pai = data[index];
				SetPaiPos(i,index);
				newbox.addChild(i);
			}
		}
		//渲染杠
		public override function addGangList(object:GangPai):void 
		{
			m_newBox = GetBox();
			var newPos:Point = calcRenderPos();
			m_newBox.pos(newPos.x,newPos.y);
			var arr:Array = [];
			arr.push(object.pai1);
			arr.push(object.pai2);
			arr.push(object.pai3);
			RenderGangPaiHandler(arr,m_newBox);
			m_Canlist.push(m_newBox);
			m_vipView.m_listCanPai.addChild(m_newBox);
			object.view = m_newBox;
			
		}
		
		private function RenderGangPaiHandler(data:Array,newbox:Box):void
		{
			for (var index:int = 0; index < 3; index++ )
			{
				var i:Gamer0CanPaiItem = new Gamer0CanPaiItem;
				i.pai = data[index];
				SetPaiPos(i,index);
				if (index == 1)
				{
					SetGangPaiPos(i);
					i.paiBg.skin = "game/pai/btn_0gangPai.png";
				}
				newbox.addChild(i);
			}
		}
		//暗杠
		public override function addAGangList(object:GangPai):void 
		{
			m_newBox = GetBox();
			var newPos:Point = calcRenderPos();
			m_newBox.pos(newPos.x,newPos.y);
			var arr:Array = [];
			arr.push(object.pai1);
			arr.push(object.pai2);
			arr.push(object.pai3);
			RenderAGangPaiHandler(arr,m_newBox);
			m_Canlist.push(m_newBox);
			m_vipView.m_listCanPai.addChild(m_newBox);
			object.view = m_newBox;
		}
		private function RenderAGangPaiHandler(data:Array,newbox:Box):void
		{
			for (var index:int = 0; index < 3; index++ )
			{
				var i:Gamer0CanPaiItem = new Gamer0CanPaiItem;
				SetPaiPos(i,index);
				i.paiBg.skin = "game/pai/img_0anGang.png";
				if (index == 1)
				{
					i.pai = data[index];
					SetGangPaiPos(i);
					i.paiBg.skin = "game/pai/img_0anGang2.png";
				}
				newbox.addChild(i);
			}
		}
		//摸杠
		public override function addMoGang(gangPaiBox:Box):void 
		{
			var i:Gamer0CanPaiItem = gangPaiBox.getChildAt(1) as Gamer0CanPaiItem;
			SetGangPaiPos(i);
			i.paiBg.skin = "game/pai/btn_0gangPai.png";
		}
	}
}