package
{
	import flash.display.Sprite;
	import flash.external.ExternalInterface;

	/**
	 * ...
	 * @author yangfan1122@gmail.com
	 */
	public class Test
	{
		static public function t(_obj:Object):void
		{
			try
			{
				ExternalInterface.call("test", _obj.toString());
			}
			catch(error:Error)
			{
				//trace(error);	
			}
			trace(_obj);
		}

		static public function tt(_obj:Object):void
		{
			try
			{
				ExternalInterface.call("test1", _obj.toString());
			}
			catch(error:Error)
			{
				//trace(error);	
			}
			trace(_obj);
		}

	}
}