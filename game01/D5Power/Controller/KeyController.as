package D5Power.Controller
{
	import D5Power.Objects.ActionObject;
	import D5Power.Objects.gameObject;
	import flash.events.KeyboardEvent;
	
	/**
	 * ...
	 * @author yangfan1122@gmail.com
	 */
	public class KeyController extends basicController
	{
		
		public function KeyController()
		{
			super();
			setupListener();
		}
		
		/**
		 * 安装侦听器
		 */
		public function setupListener():void
		{
			Global.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			Global.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		/**
		 * 消亡
		 */
		override public function die():void
		{
			Global.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			Global.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		/**
		 * 当按键按下时触发
		 * @param        e
		 */
		protected function onKeyDown(e:KeyboardEvent):void
		{
			var me:ActionObject = _target as ActionObject;
			switch (e.keyCode)
			{
				case 38: 
					me.direction = ActionObject.UP;
					break;
				case 40: 
					me.direction = ActionObject.DOWN;
					break;
				case 37: 
					me.direction = ActionObject.LEFT;
					break;
				case 39: 
					me.direction = ActionObject.RIGHT;
					break;
				default: 
					break;
			}
		}
		
		/**
		 * 当按键弹起时触发
		 * @param        e
		 */
		protected function onKeyUp(e:KeyboardEvent):void
		{
			var me:ActionObject = _target as ActionObject;
			var active:Array = new Array(37, 38, 39, 40);
			if (active.indexOf(e.keyCode) != -1)
				me.direction = 0;
		}
	
	}

}