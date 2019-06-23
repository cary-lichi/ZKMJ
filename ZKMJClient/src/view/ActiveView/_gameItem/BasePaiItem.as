package view.ActiveView._gameItem
{
	import core.GameIF;
	import laya.ui.Box;
	import laya.ui.Button;
	import laya.ui.Image;
	import laya.utils.Tween;
	import model._Pai.Pai;
	import tool.Tool;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BasePaiItem extends Box
	{
		protected var m_paiBg:Button;
		protected var m_pai:Pai;
		protected var m_nSpaceX:int;
		protected var m_nSpaceY:int;
		public function BasePaiItem()
		{
			m_paiBg = new Button;
			m_paiBg.stateNum = 1;
			this.addChild(m_paiBg);
		}
		public function GetPaiTween():void
		{
		
		}
		
		public function PaiTweenStart(x:int, y:int, caller:*, complete:Function):void
		{
		
		}
		
		public function ZhuangPaiTween(x:int, y:int, caller:*, complete:Function):void
		{
		
		}
		public function get pai():Pai
		{
			return m_pai;
		}
		
		public function set pai(value:Pai):void
		{
			m_pai = value;
		}
		public function get paiBg():Button
		{
			return m_paiBg;
		}
		
		public function set paiBg(value:Button):void
		{
			m_paiBg = value;
		}
		
		public function get nSpaceX():int 
		{
			return m_nSpaceX;
		}
		
		public function set nSpaceX(value:int):void 
		{
			m_nSpaceX = value;
		}
		
		public function get nSpaceY():int 
		{
			return m_nSpaceY;
		}
		
		public function set nSpaceY(value:int):void 
		{
			m_nSpaceY = value;
		}
	
	}

}