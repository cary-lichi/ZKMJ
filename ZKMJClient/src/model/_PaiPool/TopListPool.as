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
	import view.ActiveView._gameItem.Gamer2CanPaiItem;
	import view.Room.RoomView;
	import view.Room.VIPRoomView;
	/**
	 * ...
	 * @author ...
	 */
	public class TopListPool extends ListPool
	{
		
		public function TopListPool(dalPai:DalPai,vipRoomView:RoomView) 
		{
			super(dalPai, vipRoomView);
			Reset();
		}
		protected override function Reset():void
		{
			m_posStart.x = 782;
			m_posStart.y = 20;
		}
		
		//计算渲染位置
		protected override function calcRenderPos():Point 
		{
			m_posStart.x -= 8;
			return m_posStart;
		}
		protected override function SetPaiPos(pai:BasePaiItem,index:int):void 
		{
			pai.x = 33 *(2- index);
			pai.y = 0;
			m_posStart.x -= 33;
		}
		protected override function SetGangPaiPos(pai:BaseFacePaiItem):void 
		{
			pai.y -= 20;
		}
		//获取牌对象
		protected override function GetPaiItem():* 
		{
			return new Gamer2CanPaiItem;
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
				var i:Gamer2CanPaiItem = new Gamer2CanPaiItem;
				i.pai = data[index];
				SetPaiPos(i,index);
				newbox.addChild(i);
			}
		}
		//渲染碰
		public override function addPengList(object:PengPai):void 
		{	
			m_newBox = new Box;
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
				var i:Gamer2CanPaiItem = new Gamer2CanPaiItem;
				i.pai = data[index];
				SetPaiPos(i,index);
				newbox.addChild(i);
			}
		}
		//渲染杠
		public override function addGangList(object:GangPai):void 
		{
			m_newBox = new Box;
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
				var i:Gamer2CanPaiItem = new Gamer2CanPaiItem;
				i.pai = data[index];
				SetPaiPos(i,index);
				if (index == 1)
				{
					SetGangPaiPos(i);
					i.paiBg.skin = "game/pai/btn_2gangPai.png";
				}
				newbox.addChild(i);
			}
		}
		//暗杠
		public override function addAGangList(object:GangPai):void 
		{
			m_newBox = new Box;
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
				var i:Gamer2CanPaiItem = new Gamer2CanPaiItem;
				SetPaiPos(i,index);
				i.paiBg.skin = "game/pai/img_2anGang.png";
				if (index == 1)
				{
					i.pai = data[index];
					i.paiBg.y -= 15;
					i.paiBg.skin = "game/pai/img_2anGang2.png";
				}
				newbox.addChild(i);
			}
		}
		//摸杠
		public override function addMoGang(gangPaiBox:Box):void 
		{
			var i:Gamer2CanPaiItem = gangPaiBox.getChildAt(1) as Gamer2CanPaiItem;
			SetGangPaiPos(i);
			i.paiBg.skin = "game/pai/btn_2gangPai.png";
		}
		
	}

}