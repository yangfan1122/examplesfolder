package objects3D.cars
{
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.library.assets.AssetType;
	import away3d.loaders.Loader3D;
	import away3d.materials.ColorMaterial;
	import away3d.materials.TextureMaterial;
	
	import flash.net.URLRequest;
	
	import objects3D.autoparts.Wheel;
	
	/**
	 * 
	 * @author austin.yue
	 * 
	 */
	public class CarBase extends ObjectContainer3D
	{
		//==========================================================================
		//  Constructor
		//==========================================================================
		/**
		 * Constructs a new <code>CarBase</code> instance.
		 * 
		 */
		public function CarBase(param1:ColorMaterial, 
								param2:ColorMaterial, 
								param3:ColorMaterial, 
								param4:ColorMaterial)
		{
			super();
			_bodyMaterial = param1;
			_glassMaterial = param2;
			_bumperMaterial = param3;
		}
		
		//==========================================================================
		//  Variables
		//==========================================================================
		
		public var body:Mesh;
		public var glass:Mesh;
		public var shadow:Mesh;
		public var interior:Mesh;
		public var bumper:Mesh;
		
		protected var _modelLoaded:Boolean = false;
		
		protected var _bodyMaterial:ColorMaterial;
		protected var _glassMaterial:ColorMaterial;
		protected var _bumperMaterial:ColorMaterial;
		protected var _interiorMaterial:TextureMaterial;
		
		public var frontRightWheel:Wheel;
		public var frontLeftWheel:Wheel;
		public var backRightWheel:Wheel;
		public var backLeftWheel:Wheel;
		
		//==========================================================================
		//  Methods
		//==========================================================================
		/**
		 * 根据路径加载3D模型 
		 * @param path
		 */    
		protected function loadModel(path:String):void
		{
			var bodyLoader:Loader3D = new Loader3D();
			bodyLoader.addEventListener(AssetEvent.ASSET_COMPLETE, car_bodyCompleteHandler);
			bodyLoader.load(new URLRequest(path+"body.3DS"));
			
			var glassLoader:Loader3D = new Loader3D();
			glassLoader.addEventListener(AssetEvent.ASSET_COMPLETE, car_glassCompleteHandler);
			glassLoader.load(new URLRequest(path+"glass.3DS"));
			
			var interiorLoader:Loader3D = new Loader3D();
			interiorLoader.addEventListener(AssetEvent.ASSET_COMPLETE, car_interiorCompleteHandler);
			interiorLoader.load(new URLRequest(path+"interior.3DS"));
			
			var bomperLoader:Loader3D = new Loader3D();
			bomperLoader.addEventListener(AssetEvent.ASSET_COMPLETE, car_bomperCompleteHandler);
			bomperLoader.load(new URLRequest(path+"bumper.3dS"));
		}
		
		//    public function replaceReflectionMaps(param1:Array) : void
		//    {
		//        return;
		//    }
		
		/**
		 * 开车 轮子转
		 * @param param1
		 * 
		 */		
		public function driveCar(param1:Boolean = false) : void
		{
			var _speed:Number = 10;
			if(param1)
			{
				frontRightWheel.rotationX -= _speed;
				frontLeftWheel.rotationX -= _speed;
				backRightWheel.rotationX -= _speed;
				backLeftWheel.rotationX -= _speed;
			}
			else if(!param1)
			{
				frontRightWheel.rotationX += _speed;
				frontLeftWheel.rotationX += _speed;
				backRightWheel.rotationX += _speed;
				backLeftWheel.rotationX += _speed;
			}
		}

	
		/**
		 * 转弯
		 * @param _direction
		 * 
		 */		
		public function turns(_direction:String = ""):void
		{
			var _speed:uint = 2;//轮子旋转速度
			
			if(_direction == "left" && frontRightWheel.rotationY > -19)
			{
				frontRightWheel.rotationY -= _speed;
				frontLeftWheel.rotationY -= _speed;
			}
			else if(_direction == "right" && frontRightWheel.rotationY < 19)
			{
				frontRightWheel.rotationY += _speed;
				frontLeftWheel.rotationY += _speed;
			}
			
		}
		
		
		//==========================================================================
		//  Event Handlers
		//==========================================================================
		/**
		 * 车架加载完成后触发  
		 * @param event
		 */    
		protected function car_bodyCompleteHandler(event:AssetEvent) : void
		{
			switch(event.asset.assetType)
			{
				case AssetType.MESH:
				{
					body = event.asset as Mesh;
					body.material = this._bodyMaterial;
					super.addChild(body);
					break;
				}
				default:
				{
					break;
				}
			}
			super.addChildren(frontRightWheel, frontLeftWheel, backRightWheel, backLeftWheel, shadow);
			this._modelLoaded = true;
		}
		
		/**
		 * 玻璃加载完成后触发  
		 * @param event
		 */    
		protected function car_glassCompleteHandler(event:AssetEvent) : void
		{
			switch(event.asset.assetType)
			{
				case AssetType.MESH:
				{
					glass = event.asset as Mesh;
					glass.material = _glassMaterial;
					super.addChild(glass);
					break;
				}
				default:
				{
					break;
				}
			}
		}
		
		protected function car_interiorCompleteHandler(event:AssetEvent) : void
		{
			switch(event.asset.assetType)
			{
				case AssetType.MESH:
				{
					interior = event.asset as Mesh;
					interior.material = _interiorMaterial;
					super.addChild(interior);
					break;
				}
				default:
				{
					break;
				}
			}
		}
		
		/**
		 * 车壳加载完成后触发 
		 * @param event
		 */    
		protected function car_bomperCompleteHandler(event:AssetEvent) : void
		{
			switch(event.asset.assetType)
			{
				case AssetType.MESH:
				{
					bumper = event.asset as Mesh;
					bumper.material = this._bumperMaterial;
					super.addChild(bumper);
					break;
				}
				default:
				{
					break;
				}
			}
		}


		/**
		 * 轮子角度复位 
		 * @param _num
		 * 
		 */		
		public function resumeWheelRotationY():void
		{
			//trace(frontRightWheel.rotationY);
			if(Math.floor(frontRightWheel.rotationY) > 0)
			{
				Math.floor(frontRightWheel.rotationY--);
				Math.floor(frontLeftWheel.rotationY--);
			}
			else if(Math.floor(frontRightWheel.rotationY) < 0)
			{
				Math.floor(frontRightWheel.rotationY++);
				Math.floor(frontLeftWheel.rotationY++);
			}
		}
		
		
		
		
		
	}
}