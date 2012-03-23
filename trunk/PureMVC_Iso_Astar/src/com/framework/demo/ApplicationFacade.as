package com.framework.demo
{
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	import org.puremvc.as3.patterns.observer.Notification;
	
	import com.framework.demo.controller.StartUpCommand;
	
	public class ApplicationFacade extends Facade implements IFacade
	{
		public static const NAME:String                 = "ApplicationFacade";
		public static const STARTUP:String              = NAME + "StartUp";
		
		public static function getInstance( ):ApplicationFacade
		{
			return ( instance ? instance : new ApplicationFacade( ) ) as ApplicationFacade
		}
		
		override protected function initializeController():void
		{
			super.initializeController( );
			registerCommand( STARTUP, StartUpCommand );
		}
		
		/**
		 *	 
		 * @param app:舞台对象
		 * 
		 */		
		public function startup( app:Object ):void
		{
			sendNotification( STARTUP, app );
		}
		
		override public function sendNotification( notificationName:String, body:Object = null, type:String = null ):void
		{
			trace( "Sent: " + notificationName );
			notifyObservers( new Notification( notificationName, body, type ) );
		}
		
	}
}