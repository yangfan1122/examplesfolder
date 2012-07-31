package objects3D.autoparts
{
import away3d.containers.*;
import away3d.entities.*;
import away3d.events.*;
import away3d.library.assets.*;
import away3d.loaders.*;
import away3d.loaders.parsers.*;
import away3d.materials.*;
import away3d.textures.*;
/**
 * 轮胎 
 * @author austin.yue
 * 
 */
public class Wheel extends ObjectContainer3D
{
    [Embed(source="models/wheel.png")]
    private var WheelMapAsset:Class;
    
    [Embed(source="models/Wheel.3DS", mimeType="application/octet-stream")] 
    private var WheelAsset:Class;

    private var texture:BitmapTexture;
    private var _material:TextureMaterial;
    private var wheel:Mesh;
    private var rim:Rim;
    private var _type:String;
    private var _side:String;

    public function Wheel(param1:ColorMaterial, param2:String = "camaro", param3:String = "right")
    {
        this._type = param2;
        this._side = param3;
        this.texture = new BitmapTexture(new WheelMapAsset().bitmapData);
        this._material = new TextureMaterial(texture);
        this._material.alpha = 1;
        this._material.specular = 0.5;
        var wheelLoader:Loader3D = new Loader3D(true, "wheel");
        wheelLoader.addEventListener(AssetEvent.ASSET_COMPLETE, this.complete);
        this.wheel = new Mesh();
        this.rim = new Rim(param1, this._type, this._side);
        switch (this._type)
        {
            case "camaro":
            {
                wheelLoader.loadData(new this.WheelAsset(), null, null, new Max3DSParser());
                break;
            }
            default:
            {
                break;
            }
        }
        super.addChild(this.rim);
    }

    private function complete(event:AssetEvent):void
    {
        switch (event.asset.assetType)
        {
            case AssetType.MESH:
            {
                this.wheel = event.asset as Mesh;
                this.wheel.material = this._material;
                super.addChild(this.wheel);
                if (this._side == "left")
                {
                    this.wheel.rotationY = 180;
                }
                else
                {
                    this.wheel.rotationY = 0;
                }
                break;
            }
            default:
            {
                break;
            }
        }
    }
}
}
