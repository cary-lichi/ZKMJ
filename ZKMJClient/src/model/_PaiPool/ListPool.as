package model._PaiPool 
{
	import core.GameIF;
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
	import view.Room.VIPRoomView;
	/**
	 * ...
	 * @author ...
	 */
	public class ListPool
	{
		protected var m_dalPai:DalPai;
		protected var m_vipView:VIPRoomView;
		
		protected var m_newBox:Box;
		protected var m_Canlist:Array = [];
		protected var m_posStart:Point;
		
		protected  var m_nAgangPool:int;
		protected  var m_nChiPool:int;
		protected  var m_nMgangPool:int;
		protected  var m_nPengPool:int;
		protected  var m_nPaiPool:int;
		protected  var m_nPutPool:int;
		protected  var m_nTanPool:int;
		
		public function ListPool(dalPai:DalPai,vipRoomView:VIPRoomView) 
		{
			m_dalPai = dalPai
			m_vipView = vipRoomView;
			m_posStart = new Point;
			
			var json:*=GameIF.GetJson();
			m_nAgangPool = json["poolType"]["agang"];
			m_nChiPool = json["poolType"]["chi"];
			m_nMgangPool = json["poolType"]["mgang"];
			m_nPengPool = json["poolType"]["peng"];
			m_nPaiPool = json["poolType"]["pai"];
			m_nPutPool = json["poolType"]["put"];
			m_nTanPool = json["poolType"]["tan"];
			
			
		}
		protected function Reset():void 
		{
			
		}
		public function renderAllListInit():void 
		{
			Reset();
			for each(var box:Box in m_Canlist)
			{
				m_vipView.m_listCanPai.removeChild(box);
				box.visible = false;
				box = null;
			}
			m_Canlist = [];
		}
		
		public function renderAllList():void 
		{
           //这里对dal_pai里面的数据做统一渲染
		   //dal_pai里面存的是吃，碰，杠的对象,如果发现m_rendered为true，则不再重新渲染
		   //因此，只需要保证dal_pai里面的数据正确，每次数据变动的时候调用一次renderAllList即可
		   var pengArray:Array = m_dalPai.GetPool(m_nPengPool);
		   var chiArray:Array = m_dalPai.GetPool(m_nChiPool);
		   var aGangArray:Array = m_dalPai.GetPool(m_nAgangPool);
		   var mGangArray:Array = m_dalPai.GetPool(m_nMgangPool);
		   
		   for each(var pengPai:PengPai in pengArray)
		   {
			   if (pengArray.length == 0)
			   {
				   break;
			   }
			   
			   if (pengPai.rendered)
			   {
				   continue;
			   }
			   addPengList(pengPai);
			   pengPai.rendered = true;
		   }
		   
		   for each(var chiPai:ChiPai in chiArray)
		   {
			   if (chiArray.length == 0)
			   {
				   break;
			   }
			   
			   if (chiPai.rendered)
			   {
				   continue;
			   }
			   addChiList(chiPai);
			   chiPai.rendered = true;
		   }
		   
		   for each(var agang:GangPai in aGangArray)
		   {
			   if (aGangArray.length == 0)
			   {
				   break;
			   }
			   
			   if (agang.rendered)
			   {
				   continue;
			   }
			   addAGangList(agang);
			   agang.rendered = true;
		   }
		   
		   for each(var mgang:GangPai in mGangArray)
		   {
			   if (mGangArray.length == 0)
			   {
				   break;
			   }
			   
			   if (mgang.rendered)
			   {
				   continue;
			   }
			   addGangList(mgang);
			   mgang.rendered = true;
		   }
		}
		
		//计算渲染位置
		protected function calcRenderPos():Point 
		{
           return m_posStart;
		}
		protected function SetPaiPos(pai:BasePaiItem,index:int):void 
		{
			
		}
		protected function SetGangPaiPos(pai:BaseFacePaiItem):void 
		{
			
		}
		protected function GetBox():Box
		{
			return new Box;
		}
		//获取牌对象
		protected function GetPaiItem():* 
		{
			
		}
		//渲染摊牌
		public function renderTanPai():void 
		{
			m_newBox = GetBox();
			var newPos:Point = calcRenderPos();
			m_newBox.pos(newPos.x, newPos.y);
			var paiPoolArr:Array = m_dalPai.GetPool(m_nPaiPool);
			for (var index:int = 0; index < paiPoolArr.length; index++ )
			{
				var i:BasePaiItem = GetPaiItem();
				var pai:Pai = paiPoolArr[index];
				i.pai = pai;
				SetPaiPos(i,index);
				m_newBox.addChild(i);
			}
			m_Canlist.push(m_newBox);
			m_vipView.m_listCanPai.addChild(m_newBox);
		}
		//渲染吃
		public function addChiList(paiObject:ChiPai):void {}
	
		//渲染碰
		public function addPengList(paiObject:PengPai):void {}
		
		//渲染杠
		public function addGangList(paiObject:GangPai):void {}
		//暗杠
		public function addAGangList(paiObject:GangPai):void {}
		//摸杠
		public function addMoGang(gangPaiList:Box):void {}
	}

}