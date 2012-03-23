package com.framework.demo.view.mediator
{
	import com.framework.demo.view.component.Away3DView;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class Away3DMediator extends Mediator implements IMediator
	{
		public static const NAME:String             = "Away3DMediator";
		
		private var _away3dView:Away3DView;
		
		public function Away3DMediator ( viewComponent:Object = null )
		{
			super( NAME, viewComponent );	
		}
		
		override public function onRegister( ):void
		{
			_away3dView = new Away3DView( );
			this.sendNotification( Away3DView.PASTE3D );
		}
		
		public function get away3dView( ):Away3DView
		{
		    return _away3dView as Away3DView;
		}
	}
}