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
public class AstonMartinVintage extends CarBase
{
    [Embed(source="models/aston-martin/vantage/InteriorSkin.jpg")] 
    private var InteriorMap:Class;
    
    [Embed(source="models/aston-martin/vantage/CarShadow.png", mimeType="image/png")] 
    private var ShadowMap:Class;
    
    private var _shadowMaterial:TextureMaterial;

    public function AstonMartinVintage(param1:ColorMaterial, param2:ColorMaterial, param3:ColorMaterial, param4:ColorMaterial)
    {
        super(param1,param2,param3,param4);
        
        this._interiorMaterial = new TextureMaterial(new BitmapTexture(new this.InteriorMap().bitmapData));
        this._shadowMaterial = new TextureMaterial(new BitmapTexture(new this.ShadowMap().bitmapData));
        this._shadowMaterial.alpha = 0.5;
        this.shadow = new Mesh(new PlaneGeometry(1120, 1120), this._shadowMaterial);
        this.shadow.y = 3;
        
        loadModel("models/aston-martin/vantage/");

        this.frontRightWheel = new Wheel(param4, "camaro", "right");
        this.frontRightWheel.position = new Vector3D(-160, 70, -270);
        this.frontLeftWheel = new Wheel(param4, "camaro", "left");
        this.frontLeftWheel.position = new Vector3D(160, 70, -270);
        this.backRightWheel = new Wheel(param4, "camaro", "right");
        this.backRightWheel.position = new Vector3D(-155, 70, 245);
        this.backLeftWheel = new Wheel(param4, "camaro", "left");
        this.backLeftWheel.position = new Vector3D(155, 70, 245);
        super.y = -50;
        super.rotationY = -40;
        return;
    }
}
}
