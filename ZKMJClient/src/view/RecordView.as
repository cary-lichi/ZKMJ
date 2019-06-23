package view 
{
	import core.Constants;
	import laya.ui.Button;
	import laya.ui.Component;
	import laya.utils.Browser;
	import laya.utils.Handler;
	import tool.Tool;
	import ui.MahjongRoot.RecordPageUI;
	import view.RecordItem;
	
	/**
	 * ...
	 * @author ...
	 */
	public class RecordView extends RecordPageUI 
	{
		private var m_imgRank:String;
		private var m_imgHead:String;
		private var m_labName:String;
		private var m_labIntegral:String;
		private var m_itemY:int;
		private var m_MyRank:RecordItem;
		
		public function RecordView() 
		{
			super();
		}
		
		public function Init():void
		{
			InitView();
			Laya.stage.addChild(this);
			if (Constants.isAdaptPhone)
			{
				reSetViewUi();
				var recordView:RecordView = this;
				Browser.window.addEventListener("resize", function():void {
				Laya.timer.once(1000, recordView, reSetViewUi);
				
				});
				
			}
		}
		
		private function InitView():void 
		{
			this.m_list.vScrollBarSkin = "";
			this.m_list.spaceY = 6;
			//滚动在头或底回弹时间
            this.m_list.scrollBar.elasticBackTime = 200;
            //滚动在头或底最大距离
            this.m_list.scrollBar.elasticDistance = 400;
			m_MyRank = new RecordItem;
			m_MyRank.MyRank();			
			this.m_imgMyRank.addChild(m_MyRank);
		}
			
		private function reSetViewUi():void
		{
			Tool.Adaptation(this);
			this.m_imgTabBg.width =this.width * (255 / 1136);
			this.m_imgTabBg.height = this.height;
			this.m_imgTopBg.width = this.width;
			this.m_imgTopBg.height = 55 * Tool.getScale();
			this.m_boxTop.scale(Tool.getScale(), Tool.getScale());
			this.m_boxTop.centerX = 0;
			
		}
		public function InitMyRank(myRank:*):void 
		{
			//设置信息
			m_MyRank.SetDal(myRank);
			//排行
			m_MyRank.showRank(myRank.nRank);
			if (myRank.bCanAward)
			{
				m_btnAward.disabled = true;
				m_btnAward.mouseEnabled = false;
			}
		}
		
		public function InitRank(RankArr:Array):void 
		{	
			
			this.m_list.itemRender = RecordItem;
			//商品的信息
			this.m_list.array = RankArr;
			this.m_list.renderHandler = new Handler(this, RenderList);
			this.m_list.repeatY = RankArr.length;
			this.m_list.scrollBar.value = 0;
			
		}
		//渲染方法
		private function RenderList(item:Component,index:int):void 
		{
			if (index < this.m_list.length)
			{
				
				var m_item:RecordItem = item as RecordItem;
				var RankRecord:*= this.m_list.array[index];
				//设置信息
				m_item.SetDal(RankRecord);
				//排行
				m_item.showRank(index);
			}
			
		}
		
		public function Destroy():void
		{
			
			Laya.stage.removeChild(this);
			this.destroy();
		}
	}

}