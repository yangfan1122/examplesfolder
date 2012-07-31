package objects3D.autoparts
{
import away3d.containers.*;
import away3d.entities.*;
import away3d.events.*;
import away3d.library.assets.*;
import away3d.loaders.*;
import away3d.loaders.parsers.*;
import away3d.materials.*;
/**
 * 轮壳 
 * @author austin.yue
 * 
 */
public class Rim extends ObjectContainer3D
{
    [Embed(source="models/Rim.3DS", mimeType="application/octet-stream")] 
    private var rimAsset:Class;
    
    private var _material:ColorMaterial;
    private var rim:Mesh;
    private var _type:String;
    private var _side:String;

    public function Rim(param1:ColorMaterial, param2:String = "camaro", param3:String = "right")
    {
        this._type = param2;
        this._side = param3;
        this._material = param1;
        this.rim = new Mesh();
        var rimLoader:Loader3D = new Loader3D(true, "rim");
        rimLoader.addEventListener(AssetEvent.ASSET_COMPLETE, this.complete);
        switch (this._type)
        {
            case "camaro":
            {
                rimLoader.loadData(new this.rimAsset(), null, null, new Max3DSParser());
                break;
            }
            default:
            {
                break;
            }
        }
    }

    private function complete(event:AssetEvent):void
    {
        switch (event.asset.assetType)
        {
            case AssetType.MESH:
            {
                this.rim = event.asset as Mesh;
                this.rim.material = this._material;
                super.addChild(this.rim);
                if (this._side == "left")
                {
                    this.rim.rotationY = 180;
                }
                else
                {
                    this.rim.rotationY = 0;
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
