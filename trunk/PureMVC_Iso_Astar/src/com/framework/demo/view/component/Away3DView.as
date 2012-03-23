package com.framework.demo.view.component
{
	import away3d.cameras.Camera3D;
	import away3d.cameras.lenses.OrthogonalLens;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.primitives.SeaTurtle;
	import away3d.primitives.Sphere;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Away3DView extends Sprite
	{
		public static const NAME:String         = "Away3dView";
		public static const PASTE3D:String      = NAME + "Paste3D";
		private const OFFSET_X:int               = -30;
		private const OFFSET_Y:int               = -10;
		
		private var _scene:Scene3D;
		private var _cam:Camera3D;
		private var _view:View3D;
		private var _sphere:Sphere
		
		public function Away3DView ( )
		{
			init( );
			this.x = OFFSET_X;
			this.y = OFFSET_Y;
		}
		
		private function init( ):void
		{
			_sphere = new Sphere({material:"blue#",radius:180,segmentsW:6,segmentsH:4});
			
			_scene = new Scene3D( );
			_scene.addChild( _sphere );
			
			_view = new View3D( { x:30, y:30 } );
			_view.scene = _scene;
			_view.camera.lens = new OrthogonalLens( );
			
			addChild( _view );
			this.addEventListener( Event.ENTER_FRAME, onEnterFrame );
		}
		
		private function onEnterFrame( evt:Event ):void
		{
		  _sphere.rotationY += 1;
		  _view.render( );
		}
		
	}
}