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
public class Nissan350z extends CarBase
{
    [Embed(source="models/nissan/350z/InteriorSkin.jpg")] 
    private var InteriorMap:Class;
    
    [Embed(source="models/audi/s3/CarShadow.png", mimeType="image/png")] 
    private var ShadowMap:Class;
    
    private var _shadowMaterial:TextureMaterial;

    public function Nissan350z(param1:ColorMaterial, param2:ColorMaterial, param3:ColorMaterial, param4:ColorMaterial)
    {
        super(param1,param2,param3,param4);

        this._interiorMaterial = new TextureMaterial(new BitmapTexture(new this.InteriorMap().bitmapData));
        this._shadowMaterial = new TextureMaterial(new BitmapTexture(new this.ShadowMap().bitmapData));
        this._shadowMaterial.alpha = 0.5;
        this.shadow = new Mesh(new PlaneGeometry(1120, 1120), this._shadowMaterial);
        this.shadow.y = 3;
        
        loadModel("models/nissan/350z/");
        
        frontRightWheel = new Wheel(param4, "camaro", "right");
        frontRightWheel.position = new Vector3D(-148, 70, -265);
        frontLeftWheel = new Wheel(param4, "camaro", "left");
        frontLeftWheel.position = new Vector3D(148, 70, -265);
        backRightWheel = new Wheel(param4, "camaro", "right");
        backRightWheel.position = new Vector3D(-148, 70, 257);
        backLeftWheel = new Wheel(param4, "camaro", "left");
        backLeftWheel.position = new Vector3D(148, 70, 257);
        super.y = -50;
        super.rotationY = -40;
    }
}
}
