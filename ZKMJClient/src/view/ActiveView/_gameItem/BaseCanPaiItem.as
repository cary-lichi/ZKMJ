package view.ActiveView._gameItem 
{
	import laya.ui.Box;
	import laya.ui.Button;
	import laya.ui.Image;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BaseCanPaiItem extends Box 
	{
		protected var m_btnBg:Button;
		protected var m_canPaiArr:Array=[];
		public function BaseCanPaiItem() 
		{
			
		}
		public function createItem(n:int):void 
		{
			m_btnBg = new Button;
			m_btnBg.skin = "game/img_chiBg.png";
			m_btnBg.width = 210;
			m_btnBg.height = 93;
			m_btnBg.stateNum = 1;
			m_btnBg.sizeGrid = "15,15,15,15";
			this.addChild(m_btnBg);
			var posX:int = 16;
			var interval:int = 62;
			for (var i:int = 0; i < n;i++ )
			{
				var m_imgBg:Image = new Image;
				m_imgBg.skin = "game/pai/img_chiPaiBg.png";
				m_imgBg.pos(posX, 10);
				posX += interval;
				m_btnBg.addChild(m_imgBg);
				var m_imgValue:Image = new Image;
				m_imgValue.width = 57;
				m_imgValue.height = 77;
				m_imgBg.addChild(m_imgValue);
				m_canPaiArr.push(m_imgValue);
			}
		}
		public function renderItem(paiobj:Object):void
		{
			
		}
		
		public function get btnBg():Button 
		{
			return m_btnBg;
		}
		
		public function set btnBg(value:Button):void 
		{
			m_btnBg = value;
		}
		
	}

}