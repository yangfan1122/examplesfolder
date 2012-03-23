package D5Power.Scene
{
	import D5Power.Objects.gameObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;

	
	/**
	 * ...
	 * @author yangfan1122@gmail.com
	 */
	public class gameScene extends Sprite
	{
		/**
		 * 舞台中的对象列表
		 */
		protected var objectList:Array;
		
		/**
		 * 创建游戏基本场景需要传递基本舞台这个参数
		 * @param        _stage        舞台
		 */
		public function gameScene(_stage:Stage)
		{
			Global.stage = _stage;
			objectList = new Array();
			Global.stage.addEventListener(Event.ENTER_FRAME, render);
		}
		
		/**
		 * 向游戏世界中增加新的游戏对象
		 * @param        obj
		 */
		public function addObject(obj:gameObject):void
		{
			if (objectList.indexOf(obj) != -1)
				return; // 不重复添加
			objectList.push(obj);
			addChild(obj);
		}
		
		/**
		 * 从游戏世界中删除游戏对象
		 * @param        obj
		 */
		public function removeObject(obj:gameObject):void
		{
			var id:int = objectList.indexOf(obj);
			if (id == -1)
				return;
			objectList.splice(id, 1);
			removeChild(obj);
			obj.die();
		}
		
		/**
		 * 渲染函数，通过本函数逐个计算游戏中各对象的动作
		 */
		public function render(e:Event):void
		{
			for each (var obj:gameObject in objectList)
				obj.Do();
		}
	
	}

}