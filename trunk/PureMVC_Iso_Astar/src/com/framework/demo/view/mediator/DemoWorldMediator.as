package com.framework.demo.view.mediator
{
	import com.framework.demo.model.proxy.DemoProxy;
	import com.framework.demo.view.component.DemoWorldView;
	
	import flash.display.Sprite;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class DemoWorldMediator extends Mediator implements IMediator
	{
		public static const NAME:String                = "DemoWorldMediator"; 
		
		private var _demoWorld:DemoWorldView;
		
		public function DemoWorldMediator ( viewComponent:Object = null )
		{
			super( NAME, viewComponent );
		}
		
		override public function onRegister( ):void
		{
		    _demoWorld = new DemoWorldView( demoProxy.demoVO.grid, demoProxy.demoVO.aStar );
			viewComponent.addChild( _demoWorld );
			_demoWorld.initMap( );
		}
		
		public function paste3D( sprite3d:Sprite ):void
		{
		  _demoWorld._box.sprites = [ sprite3d ];
		  _demoWorld._box.render( );
		}
		
		private function get demoProxy( ):DemoProxy
		{
			return facade.retrieveProxy( DemoProxy.NAME ) as DemoProxy;
		}
	}
}