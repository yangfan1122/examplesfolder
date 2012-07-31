package objects3D.environments
{
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.library.assets.AssetType;
	import away3d.lights.DirectionalLight;
	import away3d.loaders.Loader3D;
	import away3d.materials.TextureMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.methods.TerrainDiffuseMethod;
	import away3d.primitives.PlaneGeometry;
	import away3d.textures.BitmapTexture;
	
	
	public class Garage extends ObjectContainer3D
	{
		[Embed(source="garage/FloorMap.jpg")]
		private var FloorMapAsset:Class;//地板
		
		[Embed(source="garage/GarageMap.jpg")]
		private var GarageMapAsset:Class;
		
		[Embed(source="garage/FloorShadowMap.png", mimeType="image/png")]
		private var FloorShadowMapAsset:Class;//地板上的影子
		
		[Embed(source="garage/Garage.3DS", mimeType="application/octet-stream")]
		private var GarageAsset:Class;
		
		private var garageMesh:Mesh;
		private var floorMesh:Mesh;
		private var floorShadowMesh:Mesh;
		
		public function Garage(param1:DirectionalLight = null)
		{
			//地板
			var floorMapTexture:BitmapTexture = new BitmapTexture(new this.FloorMapAsset().bitmapData);
			var floorMap:TextureMaterial = new TextureMaterial(floorMapTexture, true, true);
			floorMap.specular = 1;//镜面
			floorMap.lightPicker = new StaticLightPicker([param1]);//光
			floorMap.diffuseMethod = new TerrainDiffuseMethod([floorMapTexture], new BitmapTexture(new this.FloorShadowMapAsset().bitmapData), [10]);//漫反射着色。第三个参数：每一长条需要被铺的次数
			
			//地板上的影子
			var floorShadow:TextureMaterial = new TextureMaterial(new BitmapTexture(new this.FloorShadowMapAsset().bitmapData));
			floorShadow.alpha = 0.9;
			this.floorMesh = new Mesh(new PlaneGeometry(3800, 3800), floorMap);
			this.floorMesh.y = -238;
			this.floorMesh.rotationY = -95;
			this.floorShadowMesh = new Mesh(new PlaneGeometry(3800, 3800), floorShadow);
			this.floorShadowMesh.y = -237;
			this.floorShadowMesh.rotationY = -95;
			
			//加载3ds
			var garageLoader:Loader3D = new Loader3D();
			garageLoader.addEventListener(AssetEvent.ASSET_COMPLETE, this.complete);
			garageLoader.loadData(new this.GarageAsset(), null, null);
			super.addChildren(this.floorMesh, this.floorShadowMesh);//地板、地板上的影子。addChildren:添加一组3D对象到scene
		}
		
		private function complete(event:AssetEvent):void
		{
			if (event.asset.assetType == AssetType.MESH)
			{
				garageMesh = event.asset as Mesh;
				garageMesh.material = new TextureMaterial(new BitmapTexture(new this.GarageMapAsset().bitmapData), true);
				garageMesh.roll(180);
				garageMesh.geometry.scale(3);
				//super.addChild(this.garageMesh);//柱子、天棚
				super.y = 188;
			}
		}
		
	}
}
