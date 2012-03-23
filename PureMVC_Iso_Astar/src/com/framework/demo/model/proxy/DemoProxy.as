package com.framework.demo.model.proxy
{	
	import com.framework.demo.model.vo.DemoVO;
	import com.framework.demo.view.component.DemoWorldView;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import pathing.AStar;
	import pathing.Grid;

	public class DemoProxy extends Proxy implements IProxy
	{
		public static const NAME:String                   = "DempProxy"
		public static const LOAD_SUCCESSFUL:String        = NAME + "LoadSuccessful"
		
		public function DemoProxy ( )
		{
		  super( NAME, new DemoVO( ) );	
		}
		
		override public function onRegister( ):void
		{
		   initData( );
		}
		
		private function initData( ):void
		{
		   demoVO.aStar = new AStar( );
		   demoVO.grid = new Grid( 10, 10 );
		   
		   for( var i:int = 0; i<20; i++ )
		   {
		      demoVO.grid.setWalkable( Math.floor( Math.random( ) * 8 ) + 2, Math.floor( Math.random( ) * 8 )+2, false )
		   }
		}
		
		public function get demoVO( ):DemoVO
		{
		  return data as DemoVO;
		}
	}
}