package
{
	import away3d.containers.View3D;
	import away3d.library.AssetLibrary;
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;
	import away3d.loaders.parsers.Max3DSParser;
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.methods.EnvMapMethod;
	import away3d.textures.BitmapCubeTexture;
	import away3d.textures.BitmapTexture;
	
	import controllers.AutomaticOrbitController;
	import controllers.OrbitControllerExtended;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import objects3D.cars.AstonMartinVintage;
	import objects3D.cars.AudiS3;
	import objects3D.cars.CarBase;
	import objects3D.cars.ChevroletCamaro;
	import objects3D.cars.FerrariCalifornia;
	import objects3D.cars.MercedesMCLarenSLR500;
	import objects3D.cars.MitsubishiLancerX;
	import objects3D.cars.Nissan350z;
	import objects3D.environments.Garage;
	
	/**
	 * 
	 * @author austin.yue
	 * 
	 */
	[SWF(width="800", height="600")]
	public class CarDemo extends Sprite
	{
		[Embed(source="garage/EnvPosXGarage.jpg")]
		private var EnvPosXGarage:Class;
		[Embed(source="garage/EnvPosYGarage.jpg")]
		private var EnvPosYGarage:Class;
		[Embed(source="garage/EnvPosZGarage.jpg")]
		private var EnvPosZGarage:Class;
		
		[Embed(source="garage/EnvNegXGarage.jpg")]
		private var EnvNegXGarage:Class;
		[Embed(source="garage/EnvNegYGarage.jpg")]
		private var EnvNegYGarage:Class;
		[Embed(source="garage/EnvNegZGarage.jpg")]
		private var EnvNegZGarage:Class;
		//==========================================================================
		//  Constructor
		//==========================================================================
		/**
		 * Constructs a new <code>CarDemo</code> instance.
		 * 
		 */
		public function CarDemo()
		{
			addEventListener(Event.ADDED_TO_STAGE, this.addedToStage);
		}
		
		//==========================================================================
		//  Variables
		//==========================================================================
		
		private var viewport:View3D;
		private var bodyMaterial:ColorMaterial;
		private var glassMaterial:ColorMaterial;
		private var bumperMaterial:ColorMaterial;
		private var rimsMaterial:ColorMaterial;
		private var cubeTextures:BitmapCubeTexture;
		private var bodyReflection:EnvMapMethod;
		private var glassReflection:EnvMapMethod;
		private var rimsReflection:EnvMapMethod;
		private var bitmapTexture:BitmapTexture;
		private var garage:Garage;
		private var orbitController:OrbitControllerExtended;
		private var selfController:AutomaticOrbitController;
		private var light:DirectionalLight;
		private var cameraLight:PointLight;
		private var lightPicker:StaticLightPicker;
		private var carNum:int;//当前显示的车序号
		private var key_obj:Object=new Object;//同时按下两个键盘按钮时用
		
		private var carLib:Array = [];//汽车实例
		
		
		private var _carDirection:String = "";//转向
		private var _carStart:String = "";//前进 后退
		private var speedObj:Object = {x:10, z:null};//速度对象，默认x方向速度0.1
		private var wheelRotationY:Number;//转弯时轮子的弧度，左前轮右前轮一样
		
		
		//==========================================================================
		//  Methods
		//==========================================================================
		
		private function init3D() : void
		{
			//        Parsers.enableAllBundled();
			//允许解析所有支持格式的3d模型文件,但不推荐使用会让swf变大
			//        Parsers.enableAllBundled();
			//仅允许解析3ds格式的模型文件
			AssetLibrary.enableParser(Max3DSParser);
			
			this.viewport = new View3D();
			this.viewport.antiAlias = 0;//抗锯齿
			addChild(this.viewport);
			
			this.light = new DirectionalLight(0, -1, 0);//像太阳一样无穷远的光源，x y z
			this.light.color = 0xEEEEEE;
			this.cameraLight = new PointLight();//全方位多向光（点光源）
			this.cameraLight.color = 0x777777;
			this.lightPicker = new StaticLightPicker([this.light, this.cameraLight]);//选择器？ 将“光”告诉给场景中的物体？
			
			//实例化车库
			this.garage = new Garage(this.light);
			
			//车库贴图
			this.cubeTextures = 
				new BitmapCubeTexture(new this.EnvPosXGarage().bitmapData, 
					new this.EnvNegXGarage().bitmapData, 
					new this.EnvPosYGarage().bitmapData, 
					new this.EnvNegYGarage().bitmapData, 
					new this.EnvPosZGarage().bitmapData, 
					new this.EnvNegZGarage().bitmapData);//六张图 	BitmapCubeTexture继承自CubeTextureBase
			
			//环境贴图模式,让车身可以有镜面效果
			this.bodyReflection = new EnvMapMethod(this.cubeTextures, .3);//EnvMapMethod(envMap:CubeTextureBase, alpha:Number = 1) 车身
			this.glassReflection = new EnvMapMethod(this.cubeTextures);//玻璃
			this.rimsReflection = new EnvMapMethod(this.cubeTextures, 0.5);//轮子
			
			//车架贴图
			this.bodyMaterial = new ColorMaterial(0x242424);//车身颜色
			this.bodyMaterial.specular = 1;//镜面反射 效果？
			this.bodyMaterial.lightPicker = this.lightPicker;
			this.bodyMaterial.addMethod(this.bodyReflection);
			
			//玻璃贴图
			this.glassMaterial = new ColorMaterial(0xFFFFFF, 0.4);
			this.glassMaterial.specular = 1;
			this.glassMaterial.lightPicker = this.lightPicker;
			this.glassMaterial.addMethod(this.glassReflection);
			
			//车轮壳贴图
			this.rimsMaterial = new ColorMaterial(0xEEEEEE);
			this.rimsMaterial.specular = 0.5;
			this.rimsMaterial.lightPicker = this.lightPicker;
			this.rimsMaterial.addMethod(this.rimsReflection);
			
			//车壳贴图
			this.bumperMaterial = new ColorMaterial(0x444444);
			this.bumperMaterial.specular = 0.1;
			this.bumperMaterial.lightPicker = this.lightPicker;
			this.bumperMaterial.addMethod(this.rimsReflection);
			
			//实例化汽车模型，几辆不同的车
			createCar(FerrariCalifornia).visible = true;
			createCar(MercedesMCLarenSLR500);
			createCar(MitsubishiLancerX);
			createCar(ChevroletCamaro);
			createCar(AstonMartinVintage);
			createCar(Nissan350z);
			createCar(AudiS3);
			
			for(var i:Object in carLib)
			{
				if(carLib[i].visible)
				{
					carNum = int(i);
					break;
				}
			}
			
			//速度
			var _temp:Number = ((carLib[carNum].getRotationY / Math.PI) * 180) % 360;
			speedObj.z = speedObj.x * Math.sin(360 - Math.abs(_temp));
			
			//手动视角控制器
			orbitController = new OrbitControllerExtended(viewport.camera, this.viewport);
			orbitController.activate = true;
			//orbitController.activate = false;
			
			//自动视角控制器
			selfController = new AutomaticOrbitController(viewport.camera, this.viewport);
			//selfController.activate = true;
			
			viewport.scene.addChild(light);
			viewport.scene.addChild(cameraLight);
			viewport.scene.addChild(garage);
		}
		
		private function createCar(carClz:Class):CarBase
		{
			var car:CarBase = new carClz(bodyMaterial, glassMaterial, bumperMaterial, rimsMaterial);
			car.visible = false;
			viewport.scene.addChild(car);
			carLib.push(car);

			return car;
		}
		
		//==========================================================================
		//  Event Handlers
		//==========================================================================
		
		private function addedToStage(event:Event) : void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.frameRate = 60;
			addEventListener(Event.ENTER_FRAME, this.renderScene);
			removeEventListener(Event.ADDED_TO_STAGE, this.addedToStage);
			stage.addEventListener(Event.RESIZE, this.stageResize);

			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyHandler);
			
			this.init3D();
		}
		
		private function stageResize(event:Event) : void
		{
			viewport.width = stage.stageWidth;
			viewport.height = stage.stageHeight;
		}
		
		/**
		 * 渲染 
		 * @param event
		 * 
		 */		
		private function renderScene(event:Event) : void
		{
			cameraLight.position = viewport.camera.position;//从“眼睛”的方向发出的光
			viewport.render();
			this.selfController.update();
			this.orbitController.update();
			//        this.bodyMaterial.color = this.gui.bodyColorPicker.getColor;
			//        this.rimsMaterial.color = this.gui.rimsColorPicker.getColor;
			//        switch(this.gui.cameraType)
			//        {
			//            case "auto":
			//            {
			//                this.selfController.activate = true;
			//                this.orbitController.activate = false;
			//                break;
			//            }
			//            case "free":
			//            {
			//                this.orbitController.activate = true;
			//                this.selfController.activate = false;
			//                break;
			//            }
			//            default:
			//            {
			//                break;
			//            }
			//        }

			carCtrl();

			trace(carLib[carNum].getFrontRightWheel);

		}
		
		/**
		 * 键盘 
		 * @param event
		 * 
		 */		
		private function keyHandler(event:KeyboardEvent):void
		{
			if(event.type == KeyboardEvent.KEY_DOWN)
			{
				if(event.keyCode == 37)
				{
					_carDirection = "left";
				}
				if(event.keyCode == 39)
				{
					_carDirection = "right";
				}
				if(event.keyCode == 38)
				{
					_carStart = "forward";
				}
				if(event.keyCode == 40)
				{
					_carStart = "back";
				}
			}
			else if(event.type == KeyboardEvent.KEY_UP)
			{
				if(event.keyCode == 37 || event.keyCode == 39)
				{
					_carDirection = "";
				}
				if(event.keyCode == 38 || event.keyCode == 40)
				{
					_carStart = "";
				}
			}
			
		}
		
		private function carCtrl():void
		{
			wheelRotationY = carLib[carNum].getFrontRightWheelRotationY;//轮子弧度
			
			if(_carDirection == "left" && _carStart == "forward")
			{
				carLib[carNum].turns("left");
				carLib[carNum].driveCar(true);//向前
			}
			else if(_carDirection == "right" && _carStart == "forward")
			{
				carLib[carNum].turns("right");
				carLib[carNum].driveCar(true);//向前
			}
			else if(_carDirection == "left" && _carStart == "back")
			{
				carLib[carNum].turns("left");
				carLib[carNum].driveCar(false);//向后
			}
			else if(_carDirection == "right" && _carStart == "back")
			{
				carLib[carNum].turns("right");
				carLib[carNum].driveCar(false);//向后
			}
			else if(_carDirection == "left" && _carStart == "")
			{
				carLib[carNum].turns("left");
			}
			else if(_carDirection == "right" && _carStart == "")
			{
				carLib[carNum].turns("right");
			}
			else if(_carStart == "forward" && _carDirection == "")
			{
				carLib[carNum].driveCar(true);//向前
				
				carLib[carNum].x += speedObj.x;
				carLib[carNum].z -= speedObj.z;
			}
			else if(_carStart == "back" && _carDirection == "")
			{
				carLib[carNum].driveCar(false);//向后
				
				carLib[carNum].x -= speedObj.x;
				carLib[carNum].z += speedObj.z;
			}
			else if(_carStart == "" && _carDirection == "")
			{
				//trace("空 空");
			}
			else
			{
				trace("carCtrl error");
			}
			
			
		}
		
		
		
		
		
	}
}