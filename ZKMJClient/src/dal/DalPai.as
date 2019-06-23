package dal 
{
	import adobe.utils.CustomActions;
	import core.GameIF;
	import laya.utils.Dictionary;
	import model._Pai.ChiPai;
	import model._Pai.Pai;
	import model._Pai.PengPai;
	import model._Pai.RenderPai;
	import model._Room.Room;
	import view.ActiveView._gameItem.Gamer0PaiItem;
	/**
	 * ...
	 * @author ...
	 */
	public class DalPai
	{
		private var m_PaiAGangPool:Array = [];//暗杠牌池
		private var m_PaiChiPool:Array = [];//吃牌牌池
		private var m_PaiMGangPool:Array = [];//明杠牌池
		private var m_PaiPengPool:Array = [];//碰牌牌池
		private var m_PaiPool:Array = [];//手中牌池
		private var m_PaiPutPool:Array = [];//出牌
		private var m_PaiTanPool:Array = [];//游戏结束摊牌
		
		public function DalPai():void
		{
			
		}
		public function Reset():void 
		{
			m_PaiAGangPool = [];//暗杠牌池
			m_PaiChiPool = [];//吃牌牌池
			m_PaiMGangPool = [];//明杠牌池
			m_PaiPengPool = [];//碰牌牌池
			m_PaiPool = [];//手中牌池
			m_PaiPutPool = [];//出牌
			m_PaiTanPool = [];//游戏结束摊牌
		}
		public function Destory():void 
		{
			m_PaiAGangPool =null;//暗杠牌池
			m_PaiChiPool = null;//吃牌牌池
			m_PaiMGangPool = null;//明杠牌池
			m_PaiPengPool = null;//碰牌牌池
			m_PaiPool = null;//手中牌池
			m_PaiPutPool = null;//出牌
			m_PaiTanPool = null;//游戏结束摊牌
		}
		public function createPai(nType:int,nValue:int):Pai 
		{
			if (!nType && nType!=0 || !nValue)
			{
				trace("错误提示：当前构造的牌对象 ntype:"+nType+"nvalue:"+nValue);
			}
			var m_pai:Pai;
			//构造牌对象
			m_pai = new Pai;
			m_pai.nType = nType;
			m_pai.nValue = nValue;
			return m_pai;
		}
		//get牌池
		public function GetPool(poolType:int):Array
		{
			var paiPool:Array;
			var json:JSON = GameIF.GetJson()["poolType"];
			if (poolType == json["agang"])
				paiPool = m_PaiAGangPool;
			else if (poolType == json["chi"])
				paiPool = m_PaiChiPool;
			else if (poolType == json["mgang"])
				paiPool = m_PaiMGangPool;
			else if (poolType == json["peng"])
				paiPool = m_PaiPengPool
			else if (poolType == json["pai"])
				paiPool = m_PaiPool;
			else if (poolType == json["put"])
				paiPool = m_PaiPutPool;
			else if (poolType == json["tan"])
				paiPool = m_PaiTanPool;
			return paiPool;
		}
		
		//Add牌
		public function AddPai(pai:*,poolType:int):void
		{	
			var objPai:Pai=createPai(pai.nType,pai.nValue);
			var json:JSON = GameIF.GetJson()["poolType"];
			if (poolType == json["agang"])
				AddaGang(pai);
			else if (poolType == json["chi"])
				AddChi(pai);
			else if (poolType == json["mgang"])
				AddMGang(pai);
			else if (poolType == json["peng"])
				AddPeng(pai);
			else if (poolType == json["pai"])
				AddPaiPool(createPai(objPai.nType,objPai.nValue));
			else if (poolType == json["put"])
				AddPut(createPai(objPai.nType,objPai.nValue));
			else if (poolType == json["tan"])
				AddTan(createPai(objPai.nType,objPai.nValue));
		}
		
		//删除牌
		public function DelPai(pai:*,poolType:int):void
		{
			var objPai:Pai=createPai(pai.nType,pai.nValue);
			var json:JSON = GameIF.GetJson()["poolType"];
			if (poolType == json["agang"])
				DelaGang(objPai);
			else if (poolType == json["chi"])
				DelChi(objPai);
			else if (poolType == json["mgang"])
				DelMGang(objPai);
			else if (poolType == json["peng"])
				DelPeng(objPai);
			else if (poolType == json["pai"])
				DelPaiPool(objPai);
			else if (poolType == json["put"])
				DelPut(objPai);
			else if (poolType == json["tan"])
				DelTan(objPai);
		}
		//删除暗杠
		private function DelaGang(objPai:*):void 
		{
			
		}
		//删除吃牌
		private function DelChi(objPai:*):void 
		{
			
		}
		//删除明杠
		private function DelMGang(objPai:*):void 
		{
			
		}
		//删除碰
		private function DelPeng(objPai:*):void 
		{
			var index:int = 0;
			for each(var pai:PengPai in m_PaiPengPool)
			{
				if (pai.pai1.nType == objPai.nType&&pai.pai1.nValue == objPai.nValue)
				{
					//删除碰牌
					m_PaiPengPool.splice(index, 1);
					return;
				}
				index++;
			}
		}
		//通过所以删除手牌
		public function DelPaiIndex(index:int):void 
		{
			m_PaiPool.splice(index, 1);
		}
		//删除手牌
		private function DelPaiPool(p:Pai):void 
		{
			if (!p)
			{
				trace("错误提示：当前要删除的牌为"+p);
			}
			var index:int = 0;
			for each(var pai:Pai in m_PaiPool)
			{
				if (p.nType == pai.nType&&p.nValue == pai.nValue)
				{
					//删除牌
					m_PaiPool.splice(index, 1);
					return;
				}
				index++;
			}
		}
		//删除出的牌
		private function DelPut(objPai:Pai):void 
		{
			m_PaiPutPool.pop();
		}
		//删除摊牌
		private function DelTan(objPai:Pai):void 
		{
			
		}
		
		//暗杠
		private function AddaGang(p:*):void
		{
			m_PaiAGangPool.push(p);
		}
		//吃牌
		private function AddChi(p:*):void
		{
			m_PaiChiPool.push(p);
		}
		//明杠
		private function AddMGang(p:*):void
		{
			m_PaiMGangPool.push(p);
		}
		//碰牌
		private function AddPeng(p:*):void
		{
			m_PaiPengPool.push(p);
		}
		private function AddPaiPoo():void 
		{
			
		}
		private function AddPaiPool(p:Pai):void
		{
			var bao:Pai = GameIF.GetRoom().BaoPai;
			if (!p)
			{
				trace("错误提示：加入手牌的pai为"+p);
			}
			if (bao)
			{//如果已经存在宝牌
				if (bao.nType == p.nType && bao.nValue == p.nValue)
				{//当前的牌是宝牌
					//直接将这张牌放到牌paipool的最前端
					p.bBao = true;
					m_PaiPool.splice(0, 0, p);					
					return
				}
			}
			var index:int=0;
			for each(var paiT:* in m_PaiPool)
			{
				if (bao)
				{//如果已经存在宝牌
					if (bao.nType == paiT.nType && bao.nValue == paiT.nValue)
					{//当前的牌是宝牌
						index++;
						continue;
					}
				}
				if (p.nType <= paiT.nType)
				{
					for each(var paiV:* in m_PaiPool)
					{
						if (p.nType == paiV.nType)
						{
							if (p.nValue <= paiV.nValue)
							{
								//插入牌
								m_PaiPool.splice(index, 0, p);
								return;
							}
							index++;
						}
					}
					m_PaiPool.splice(index, 0, p);
					return;
				}
				index++;
			}
			m_PaiPool.push(p);
			
		}
		//出牌
		private function AddPut(p:Pai):void
		{
			m_PaiPutPool.push(p);
		}
		//摊牌
		private function AddTan(p:Pai):void
		{
			m_PaiTanPool.push(p);
		}
		
		private function get PaiAGangPool():Array 
		{
			return m_PaiAGangPool;
		}
		
		private function set PaiAGangPool(value:Array):void 
		{
			m_PaiAGangPool = value;
		}
		
	}
}