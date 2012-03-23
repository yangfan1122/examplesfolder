package D5Power.Objects
{
	import flash.display.Sprite;
	import D5Power.Controller.basicController;
	
	/**
	 * ...
	 * @author yangfan1122@gmail.com
	 */
	public class Monster extends FaceObject
	{
		
		/**
		 * 上一次的运行日期对象
		 */
		private var _lastAction:Date;
		/**
		 * 运行频率
		 */
		private var _fps:uint = 8;
		
		public function Monster(ctrl:basicController, face:Sprite)
		{
			super(ctrl, face);
			_lastAction = new Date();
		}
		
		override public function Do():void
		{
			var date:Date = new Date();
			// 如果运行时间已经超过频率所指定的时间间隔，那么运行程序
			if (date.time - _lastAction.time > 1000 / _fps)
			{
				_lastAction = date;
				controller.AutoRun();
				super.Do();
			}
		}
	
	}

}