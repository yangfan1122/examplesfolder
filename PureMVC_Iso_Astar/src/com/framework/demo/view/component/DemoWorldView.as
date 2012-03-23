package com.framework.demo.view.component
{
	import as3isolib.display.IsoSprite;
	import as3isolib.display.IsoView;
	import as3isolib.display.primitive.IsoBox;
	import as3isolib.display.primitive.IsoPrimitive;
	import as3isolib.display.scene.IsoScene;
	import as3isolib.events.IsoEvent;
	import as3isolib.enum.RenderStyleType;
	import as3isolib.graphics.SolidColorFill
	
	import eDpLib.events.ProxyEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import pathing.AStar;
	import pathing.Grid;
	import pathing.Node;
	
	public class DemoWorldView extends Sprite
	{
		public static const NAME:String                = "DemoWorldView";
		public static const MAKE_GRID_MAP:String       = NAME + "MakeGridMap";
		
		private const CELLSIZE:int          = 50;
		
		public var _box:IsoSprite;
		
		private var _view:IsoView;
		private var _scene:IsoScene;
		private var _pathGrid:Grid;
		private var _astar:AStar;
		private var _path:Array;
		private var _index:int;
		private var _playerCopy:IsoPrimitive;
		
		public function DemoWorldView( pathGrid:Grid, astar:AStar )
		{
			_pathGrid = pathGrid;
			_astar = astar;
			initWorld( );
		}
		
		private function initWorld( ):void
		{
			_scene = new IsoScene;
			
			_view = new IsoView( );
			_view.setSize( 1199, 690 );
			_view.y +=5;
			_view.clipContent = true;
			_view.addScene( _scene );
			addChild( _view );
			
			init3DCharacter( );//小球
		}
		
		public function initMap( ):void
		{
			for( var i:int = 0; i<_pathGrid.numCols; i++ )
			{
				for(var j:int = 0; j<_pathGrid.numRows; j++)
				{
					var node:Node = _pathGrid.getNode( i, j );
					var box:IsoBox = new IsoBox( );
					
					if( node.walkable )
					{
						box.setSize( CELLSIZE, CELLSIZE, 0 );
						box.addEventListener( MouseEvent.CLICK, onGridItemClicked );//点地图网格
					}
					else
					{
						box.setSize( CELLSIZE, CELLSIZE, 40 ); 
						box.fills = [ new SolidColorFill(0x0000ff, .5), new SolidColorFill(0x0000ff, .5), new SolidColorFill(0x0000ff, .5), new SolidColorFill(0x0000ff, .5), new SolidColorFill(0x0000ff, .5), new SolidColorFill(0x0000ff, .5) ];
					}
					box.moveTo( i*CELLSIZE, j*CELLSIZE, 0);
					_scene.addChild( box );
				}
			}
			_playerCopy.setSize( CELLSIZE, CELLSIZE, 10 );
			_scene.render( );
		}
		
		/**
		 * 点击地图上的grid 
		 * @param evt
		 * 
		 */		
		private function onGridItemClicked( evt:ProxyEvent ):void
		{
			var box:IsoBox = evt.target as IsoBox;
			
			var xPos:int = Math.floor( box.x / CELLSIZE );
			var yPos:int = Math.floor( box.y / CELLSIZE );
			_pathGrid.setEndNode( xPos, yPos );
			
			xPos = Math.floor( _box.x / CELLSIZE );
			yPos = Math.floor( _box.y / CELLSIZE );
			
			_pathGrid.setStartNode( xPos, yPos );

			findPath( );
		}
		
		private function findPath( ):void
		{
			if( _astar.findPath( _pathGrid ) )
			{
				_path = _astar.path;
				_index = 0;
				this.addEventListener( Event.ENTER_FRAME, onEnterFrame );
			}
		}
		
		private function onEnterFrame( evt:Event ):void
		{
			var targetX:Number = _path[_index].x * 50;
			var targetY:Number = _path[_index].y * 50;
			var dx:Number = targetX - _box.x;
			var dy:Number = targetY - _box.y;
			var dist:Number = Math.sqrt( dx * dx + dy * dy);
			
			if( dist < 1)
			{
				_index++;
				if( _index >= _path.length )
				{
					this.removeEventListener( Event.ENTER_FRAME, onEnterFrame );
					_view.centerOnIso( _box );
				}
			}
			else
			{
				_box.x += dx;
				_box.y += dy;
				_scene.render( );
			}
		}
		
		/**
		 * 小球 
		 * 
		 */		
		public function init3DCharacter( ):void
		{
			_playerCopy = new IsoPrimitive( );
			
			_box = new IsoSprite( );
			_box.setSize( 50, 50, 50 );
			_box.moveTo( 0, 0, 0 );
			_scene.addChild( _box );
			_scene.render( );
		}
	}
}