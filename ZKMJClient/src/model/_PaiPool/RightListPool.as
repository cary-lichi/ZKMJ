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
	import view.ActiveView._gameItem.Gamer3CanPaiItem;
	import view.Room.RoomView;
	import view.Room.VIPRoomView;
	/**
	 * ...
	 * @author ...
	 */
	public class RightListPool extends ListPool
	{
		
		public function RightListPool(dalPai:DalPai,vipRoomView:RoomView) 
		{
			super(dalPai, vipRoomView);
			Reset();
		}
		protected override function Reset():void
		{
			m_posStart.x = 1030;
			m_posStart.y = 415;
		}
		//计算渲染位置
		protected override function calcRenderPos():Point 
		{
			m_posStart.x -= 7/3;
			m_posStart.y -= 24/3 ;
			var targetPos:Point = new Point;
			targetPos.x = m_posStart.x;
			targetPos.y = m_posStart.y;
			return targetPos;
		}
		protected override function SetPaiPos(pai:BasePaiItem,index:int):void 
		{
			pai.zOrder = - index;
			pai.x = -7 * index;
			pai.y = -24 * index;
			m_posStart.x -= 7 ;
			m_posStart.y -= 24 ;
		}
		protected override function SetGangPaiPos(pai:BaseFacePaiItem):void 
		{
			pai.paiBg.x += 2;
			pai.paiBg.y -= 18;
			pai.imgPaiValue.x += 3;
		}
		//为了解决层级问题动态设置box层级
		protected override function GetBox():Box
		{
			var box:Box = new Box;
			box.zOrder =10-m_Canlist.length;
			return box;
		}
		//获取牌对象
		protected override function GetPaiItem():* 
		{
			return new Gamer3CanPaiItem;
		}
		//渲染摊牌
		public override function renderTanPai():void 
		{
			m_newBox = new Box;
			var newPos:Point = calcRenderPos();
			m_newBox.pos(newPos.x, newPos.y);
			var paiPoolArr:Array = m_dalPai.GetPool(m_nPaiPool);
			for (var index:int = 0; index < paiPoolArr.length; index++ )
			{
				var i:BasePaiItem = GetPaiItem();
				var pai:Pai = paiPoolArr[index];
				i.pai = pai;
				SetPaiPos(i, index);
				m_newBox.addChild(i);
			}
			m_Canlist.push(m_newBox);
			m_vipView.m_listCanPai.addChild(m_newBox);
		}
		//渲染吃
		public override function addChiList(object:ChiPai):void 
		{
			m_newBox = GetBox();
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
			for (var index:int = 0; index < 3; index++)
			{
				var i:Gamer3CanPaiItem = new Gamer3CanPaiItem;
				i.pai = data[index];
				SetPaiPos(i, index);
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
				var i:Gamer3CanPaiItem = new Gamer3CanPaiItem;
				i.pai = data[index];
				SetPaiPos(i, index);
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
				var i:Gamer3CanPaiItem = new Gamer3CanPaiItem;
				i.pai = data[index];
				SetPaiPos(i, index);
				if (index == 1)
				{
					SetGangPaiPos(i);
					i.paiBg.skin = "game/pai/btn_3gangPai.png";
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
				var i:Gamer3CanPaiItem = new Gamer3CanPaiItem;
				
				SetPaiPos(i, index);
				i.paiBg.skin = "game/pai/img_3anGang.png";
				if (index == 1)
				{
					i.pai = data[index];
					SetGangPaiPos(i);
					i.paiBg.skin = "game/pai/img_3anGang2.png";
				}
				newbox.addChild(i);
			}
		}
		//摸杠
		public override function addMoGang(gangPaiBox:Box):void 
		{
			var i:Gamer3CanPaiItem = gangPaiBox.getChildAt(1) as Gamer3CanPaiItem;
			SetGangPaiPos(i);
			i.paiBg.skin = "game/pai/btn_3gangPai.png";
		}
	}

}