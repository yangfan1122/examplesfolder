package com.framework.demo.controller
{
	import com.framework.demo.view.component.Away3DView;
	import com.framework.demo.view.mediator.Away3DMediator;
	import com.framework.demo.view.mediator.DemoWorldMediator;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class Paste3DCommand extends SimpleCommand implements ICommand
	{
		public override function execute( notification:INotification ):void
		{
		   var name:String = notification.getName( );
		   var body:Object = notification.getBody( );
		   
		   switch( name )
		   {
		      case Away3DView.PASTE3D:
				  demoWorldMediator.paste3D( away3dMediator.away3dView );
				  break;
		   }
		}
		
		
		private function get away3dMediator( ):Away3DMediator
		{
		   return facade.retrieveMediator( Away3DMediator.NAME ) as Away3DMediator;
		}
		
		private function get demoWorldMediator( ):DemoWorldMediator
		{
		   return facade.retrieveMediator( DemoWorldMediator.NAME ) as DemoWorldMediator;
		}
		
	}
}