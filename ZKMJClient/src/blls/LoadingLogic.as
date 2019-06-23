package blls 
{
	import core.GameIF;
	import core.LogicManager;
	import view.LoadingView;
	/**
	 * ...
	 * @author dawenhao
	 */
	public class LoadingLogic extends BaseLogic
	{
		private var m_loadingView:LoadingView;
		
		public function LoadingLogic() 
		{
			super();
		}
		
		public override function Init():void
		{
			if (m_loadingView == null)
			{
				m_loadingView = new LoadingView;
				m_loadingView.Init();
			}
			m_loadingView.visible = true;
		}
		
		//根据加载进度更改进度条
		public function changeValue(progress:Number):void 
		{
			 m_loadingView.m_progressBar.value =Math.floor(progress*100)/100;
			 m_loadingView.m_lable.text =Math.floor(progress*100)+"%";
		}
		
		public override function Destroy():void
		{
			Laya.timer.clearAll(this);
			m_loadingView.Destroy();
			m_loadingView.destroy();
			m_loadingView.visible = false;
			m_loadingView = null;
		}
		
		public function get loadingView():LoadingView 
		{
			return m_loadingView;
		}
		
		public function set loadingView(value:LoadingView):void 
		{
			m_loadingView = value;
		}
		
	}

}