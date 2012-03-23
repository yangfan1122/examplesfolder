package
{
	import com.framework.demo.ApplicationFacade;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	[ SWF( width = "1200", height = "700", frameRate = "30", backgroundColor = "0x344543" ) ]
	
	public class Main extends Sprite
	{
		public function Main ( )
		{
			init( );
		}
		
		private function init( ):void
		{
			ApplicationFacade.getInstance().startup( this );
		}
	}
}