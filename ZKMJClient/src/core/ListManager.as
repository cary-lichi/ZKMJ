package core 
{
	import laya.ui.Component;
	import laya.ui.List;
	import laya.utils.Handler;
	import model._Pai.Pai;
	/**
	 * ...
	 * @author ...
	 */
	public class ListManager
	{
		
		private var m_item:*;
		private var m_list:List;
		
		public function ListManager(x:Number,y:Number,item:*,arr:Array) 
		{
			m_list = new List;
			m_list.pos(x, y);
			m_item = item;
			m_list.itemRender = item;
			m_list.array = arr;
			m_list.renderHandler = new Handler(this, renderList);
			Laya.stage.addChild(m_list);
		}
		
		private function renderList(item:Component, index:int):void 
		{
			var cell:* = item as * ;
			var data:* = m_list.array[index];
			cell.pai = data;
		}
		
	}

}