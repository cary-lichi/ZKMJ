package model._Pai 
{
	/**
	 * ...
	 * @author wangn
	 */


	public class GangPai extends RenderPai
	{
	    protected var m_pai4:Pai;
		
		public function get pai4():Pai 
		{
			return m_pai4;
		}
		
		public function set pai4(value:Pai):void 
		{
			m_pai4 = value;
		}
	}

}