package model._Pai 
{
	import laya.ui.Box;
	import laya.ui.List;
	import model._Pai.Pai;
	/**
	 * ...
	 * @author wangn
	 */
	public class RenderPai 
	{
		protected var m_pai1:Pai;
		protected var m_pai2:Pai;
		protected var m_pai3:Pai;
		protected var m_rendered:Boolean;
		protected var m_view:Box
		
		public function get rendered():Boolean 
		{
			return m_rendered;
		}
		
		public function set rendered(value:Boolean):void 
		{
			m_rendered = value;
		}
		
		public function get pai1():Pai 
		{
			return m_pai1;
		}
		
		public function set pai1(value:Pai):void 
		{
			m_pai1 = value;
		}
		
		public function get pai2():Pai 
		{
			return m_pai2;
		}
		
		public function set pai2(value:Pai):void 
		{
			m_pai2 = value;
		}
		
		public function get pai3():Pai 
		{
			return m_pai3;
		}
		
		public function set pai3(value:Pai):void 
		{
			m_pai3 = value;
		}
		public function get view():Box 
		{
			return m_view;
		}
		
		public function set view(value:Box):void 
		{
			m_view = value;
		}
	}

}