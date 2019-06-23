package core
{
	import laya.display.Animation;
	import laya.display.Sprite;
	import laya.net.Loader;
	import laya.ui.Image;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;
	
	/**
	 * ...
	 * @author wangn
	 */
	public class AnimationAltas extends Sprite
	{
		private var m_Ghost:Image;
		private var m_Entity:Image;
		protected var m_animName:String;
		protected var m_animCount:int;
		protected var m_animInner:Animation;
		
		public function AnimationAltas()
		{
		    m_animInner = new Animation;
			this.addChild(m_animInner);
		}
		
		public function LoadAinmation(animName:String, animCount:int):void
		{
			m_animName = animName;
			m_animCount = animCount;
			var urls:Array = [];
			
			//将图片添加进图片地址集合
			for (var i:int = 0; i < m_animCount; i++)
			{
				var index:String = i < 10 ? ("0" + i) : (i + "");
				urls.push( animName + "/" + animName + "00" + index + ".png");
			}
			
			//加载图片地址集合，组成动画
			m_animInner.loadImages(urls);
			m_animInner.size(27, 27);
			//当前播放索引
			m_animInner.index = 1;
		}

		public function Pos(x:Number,y:Number):void
		{
			m_animInner.pos(x,y);
		}
		
		public function Play(loop:Boolean):void
		{
			m_animInner.visible = true;
			m_animInner.play();
			//trace("effect play-----------------------------");
			if (!loop)
			{		
                //Laya.timer.once((1/m_animInner.interval)*1000*m_animInner.count, this, OnLoopEnd);
				Laya.timer.once(m_animInner.interval * m_animInner.count, this, OnLoopEnd);
			}
		}
		
		//设置混合模式
		public function SetMixedMode(type:String):void
		{
			m_animInner.blendMode = type;// "lighter";
		}
		
		protected function OnLoopEnd():void
		{
			//trace("effect play stop-----------------------------");
			Stop();
		}
		
		public function Stop():void
		{
			m_animInner.visible = false;
			m_animInner.stop();
		}
		//———————————————————————————————————————//
		//—————————————————接口——————————————————//
		//———————————————————————————————————————//
		public function get animName():String
		{
			return m_animName;
		}
		
		public function set animName(value:String):void
		{
			m_animName = value;
		}
		
		public function get animInner():Animation
		{
			return m_animInner;
		}
		
		public function set animInner(value:Animation):void
		{
			m_animInner = value;
		}
		
		public function get animCount():int 
		{
			return m_animCount;
		}
		
		public function set animCount(value:int):void 
		{
			m_animCount = value;
		}
	
	}

}