package D5Power.Objects
{
	import flash.display.Sprite;
	import D5Power.Controller.basicController;
	
	/**
	 * ...
	 * @author yangfan1122@gmail.com
	 */
	public class FaceObject extends ActionObject
	{
		
		protected var _face:Sprite;
		
		/**
		 *
		 * @param        ctrl        控制器
		 * @param        face        外观
		 */
		public function FaceObject(ctrl:basicController, face:Sprite)
		{
			super(ctrl);
			_face = face;
			addChild(_face);
		}
	
	}

}