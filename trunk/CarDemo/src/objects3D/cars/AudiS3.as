package objects3D.cars
{
import away3d.entities.Mesh;
import away3d.materials.ColorMaterial;
import away3d.materials.TextureMaterial;
import away3d.primitives.PlaneGeometry;
import away3d.textures.BitmapTexture;

import flash.geom.Vector3D;

import objects3D.autoparts.Wheel;
/**
 * 
 * @author austin.yue
 * 
 */
public class AudiS3 extends CarBase
{
    [Embed(source="models/audi/s3/InteriorSkin.jpg")] 
    private var InteriorMap:Class;
    
    [Embed(source="models/audi/s3/CarShadow.png", mimeType="image/png")] 
    private var ShadowMap:Class;
    
    private var _shadowMaterial:TextureMaterial;

    public function AudiS3(param1:ColorMaterial, param2:ColorMaterial, param3:ColorMaterial, param4:ColorMaterial)
    {
        super(param1,param2,param3,param4);
        
        this._interiorMaterial = new TextureMaterial(new BitmapTexture(new this.InteriorMap().bitmapData));
        this._shadowMaterial = new TextureMaterial(new BitmapTexture(new this.ShadowMap().bitmapData));
        this._shadowMaterial.alpha = 0.5;
        this.shadow = new Mesh(new PlaneGeometry(1120, 1120), this._shadowMaterial);
        this.shadow.y = 3;
        
        loadModel("models/audi/s3/");
        
        frontRightWheel = new Wheel(param4, "camaro", "right");
        frontRightWheel.position = new Vector3D(-142, 70, -236);
        frontLeftWheel = new Wheel(param4, "camaro", "left");
        frontLeftWheel.position = new Vector3D(142, 70, -236);
        backRightWheel = new Wheel(param4, "camaro", "right");
        backRightWheel.position = new Vector3D(-142, 70, 269);
        backLeftWheel = new Wheel(param4, "camaro", "left");
        backLeftWheel.position = new Vector3D(142, 70, 269);
        super.y = -50;
        super.rotationY = -40;
    }
}
}
