package objects3D.cars
{
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.PlaneGeometry;
	import away3d.textures.BitmapTexture;
	
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	import objects3D.autoparts.Wheel;
	/**
	 * 
	 * @author austin.yue
	 * 
	 */
	public class MercedesMCLarenSLR500 extends CarBase
	{
		[Embed(source="models/mercedes/mclaren-slr500/InteriorSkin.jpg")] 
		private var InteriorMap:Class;
		
		[Embed(source="models/audi/s3/CarShadow.png", mimeType="image/png")] 
		private var ShadowMap:Class;
		
		private var _shadowMaterial:TextureMaterial;
		
		public function MercedesMCLarenSLR500(param1:ColorMaterial, param2:ColorMaterial, param3:ColorMaterial, param4:ColorMaterial)
		{
			super(param1, param2, param3, param4);
			
			this._bodyMaterial = param1;
			this._glassMaterial = param2;
			this._bumperMaterial = param3;
			this._interiorMaterial = new TextureMaterial(new BitmapTexture(new this.InteriorMap().bitmapData));
			this._shadowMaterial = new TextureMaterial(new BitmapTexture(new this.ShadowMap().bitmapData));
			this._shadowMaterial.alpha = 0.5;
			this.shadow = new Mesh(new PlaneGeometry(1120, 1120), this._shadowMaterial);
			this.shadow.y = 3;
			
			loadModel("models/mercedes/mclaren-slr500/");
			
			frontRightWheel = new Wheel(param4, "camaro", "right");
			frontRightWheel.position = new Vector3D(-150, 70, -270);
			frontLeftWheel = new Wheel(param4, "camaro", "left");
			frontLeftWheel.position = new Vector3D(150, 70, -270);
			backRightWheel = new Wheel(param4, "camaro", "right");
			backRightWheel.position = new Vector3D(-154, 70, 265);
			backLeftWheel = new Wheel(param4, "camaro", "left");
			backLeftWheel.position = new Vector3D(154, 70, 265);
			super.y = -50;
			super.rotationY = -40;
			
		}
		
	}
}
