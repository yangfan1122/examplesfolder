package D5Power.Objects
{
	import D5Power.Controller.basicController;
	
	/**
	 * ...
	 * @author yangfan1122@gmail.com
	 */
	public class ActionObject extends gameObject
	{
		
		/**
		 * 移动速度
		 */
		protected var speed:Number = 1.2;
		/**
		 * 移动方向
		 */
		protected var walkDirection:uint = 0
		
		public static const UP:uint = 1;
		public static const DOWN:uint = 2;
		public static const LEFT:uint = 3;
		public static const RIGHT:uint = 4;
		
		/**
		 * 修改移动方向
		 */
		public function set direction(dir:uint):void
		{
			walkDirection = dir;
		}
		
		/**
		 * 移动
		 */
		protected function move():void
		{
			if (!nextCanMove)
				return; // 增加了这句代码
			// 根据不同的方向进行移动
			switch (walkDirection)
			{
				case UP: 
					y -= speed;
					break;
				case DOWN: 
					y += speed;
					break;
				case LEFT: 
					x -= speed;
					break;
				case RIGHT: 
					x += speed;
					break;
				default: 
					break;
			}
		}
		
		/**
		 * 覆盖父类的Do方法
		 */
		override public function Do():void
		{
			if (walkDirection != 0)
				move();
			super.Do();
		}
		
		/**
		 * 控制器
		 */
		protected var controller:basicController;
		
		/**
		 * 在建立对象的时候，需要传递控制器进来
		 * @param        ctrl
		 */
		public function ActionObject(ctrl:basicController)
		{
			controller = ctrl;
			controller.target = this; // 将控制器的控制目标设置为自己
		}
		
		override public function die():void
		{
			controller.die(); //当自己被删除的时候，通知控制器卸载侦听，以释放内存
		}
		
		/**
		 * 下一目标点是否可以移动
		 */
		public function get nextCanMove():Boolean
		{
			// 下一X位置
			var nx:uint = 0;
			// 下一Y位置
			var ny:uint = 0;
			// 根据移动方向进行处理，计算出下一目标点位置
			switch (walkDirection)
			{
				case UP: 
					ny = y - speed;
					break;
				case DOWN: 
					ny = y + speed;
					break;
				case LEFT: 
					nx = x - speed;
					break;
				case RIGHT: 
					nx = x + speed;
					break;
				default: 
					break;
			}
			
			// 如果下一目标点超出屏幕范围，则不能移动
			if (nx > Global.stage.stageWidth - width || nx < 0)
				return false;
			if (ny > Global.stage.stageHeight - height || ny < 0)
				return false;
			
			// 检测通过
			return true;
		}
	
	}

}