package D5Power.Controller
{
	import D5Power.Objects.gameObject;
	
	/**
	 * ...
	 * @author yangfan1122@gmail.com
	 */
	public class basicController
	{
		
		/**
		 * 控制对象
		 */
		protected var _target:gameObject;
		
		public function basicController()
		{
		
		}
		
		/**
		 * 设置控制对象
		 */
		public function set target(obj:gameObject):void
		{
			_target = obj;
		}
		
		/**
		 * 消亡
		 */
		public function die():void
		{
		}
		
		/**
		 * 自动运行
		 */
		public function AutoRun():void
		{
		}
	
	}

}