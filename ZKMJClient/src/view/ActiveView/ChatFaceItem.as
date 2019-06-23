package view.ActiveView 
{
	import laya.ui.Box;
	import laya.ui.Button;
	import laya.ui.Image;
	import laya.ui.Label;
	import laya.ui.Panel;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ChatFaceItem extends Box 
	{	private var m_box:Panel;
		private var m_bg:Image;
		
		public function ChatFaceItem() 
		{  m_box = new Panel;
			m_box.width = 100;
			m_box.height = 100;
			//m_box.graphics.drawRect(0, 0, 90, 90, "red","blue");
			this.addChild(m_box);
			
			m_bg = new Image;
			m_bg.pos(15, 15);
			m_box.addChild(m_bg);
		}
		
		
		
		public function get bg():Image 
		{
			return m_bg;
		}
		
		public function set bg(value:Image):void 
		{
			m_bg = value;
		}
		
	}

}