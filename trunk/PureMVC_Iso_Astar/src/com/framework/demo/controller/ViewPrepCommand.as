package com.framework.demo.controller
{
	import com.framework.demo.view.mediator.ApplicationMediator;
	import com.framework.demo.view.component.Away3DView;
	import com.framework.demo.view.component.DemoWorldView;
	
	import flash.display.Sprite;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class ViewPrepCommand extends SimpleCommand implements ICommand
	{
	   override public function execute( notification:INotification ):void
	   {
		 facade.registerCommand( Away3DView.PASTE3D, Paste3DCommand );
	     facade.registerMediator( new ApplicationMediator( notification.getBody( ) as Sprite ) );
	   }
	}
}