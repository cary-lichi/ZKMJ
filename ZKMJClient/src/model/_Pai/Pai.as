package model._Pai 
{
	import view.ActiveView._gameItem.Gamer0PaiItem;
	/**
	 * ...
	 * @author dawenhao
	 */
	 //  m_Type      m_Value
 //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-//
 //  0       |   中   1   发2  白3
 //          |
 //  1       |   东 1 西2  南 3    北4
 //          |
 //  2       |   一万  二万  ……  九万
 //          |
 //  3       |   一条  二条  ……  九条
 //          |
 //  4       |   一饼  二饼  ……  九饼
 //          |
 //  5       |   春       夏       秋       冬      竹       兰       梅       菊
 //          |
 //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-//

	public class Pai 
	{
		private var m_nType:int;
		private var m_nValue:int;
		private var m_bBao:Boolean = false;
		//0正常 1碰牌 2吃牌 3杠牌
		//private var m_nCanPState:int;
		
		public function Pai() 
		{
			
		}
		
		public function get nType():int 
		{
			return m_nType;
		}
		
		public function set nType(value:int):void 
		{
			m_nType = value;
		}
		
		public function get nValue():int 
		{
			return m_nValue;
		}
		
		public function set nValue(value:int):void 
		{
			m_nValue = value;
		}
		
		public function get bBao():Boolean 
		{
			return m_bBao;
		}
		
		public function set bBao(value:Boolean):void 
		{
			m_bBao = value;
		}
	
	}

}