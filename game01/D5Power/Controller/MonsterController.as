package D5Power.Controller 
{
	import D5Power.Objects.ActionObject;
	import D5Power.Objects.gameObject;
	/**
	 * 敌人控制器
	 * @author D5Power
	 */
	public class MonsterController extends basicController
	{
		public function MonsterController() 
		{
			super();
		}
		
		override public function set target(obj:gameObject):void
		{
			_target = obj;
			changeDir();
		}
		
		override public function AutoRun():void
		{
			var me:ActionObject = _target as ActionObject;
			if (!me.nextCanMove) changeDir();
		}
		
		/**
		 * 随机修改方向
		 */
		private function changeDir():void
		{
			var me:ActionObject = _target as ActionObject;
			me.direction = 1+int(Math.random() * 4);
		}
		
	}

}