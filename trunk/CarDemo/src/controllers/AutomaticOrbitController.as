package controllers
{
import away3d.cameras.*;
import away3d.containers.*;
import flash.display.*;
import flash.events.*;
import flash.geom.*;
import flash.utils.*;

public class AutomaticOrbitController extends Object
{
    private var _camara:Camera3D;
    private var _stage:DisplayObject;
    private var _target:ObjectContainer3D;
    private var _direction:String = "right";
    private var _distance:Number = 800;
    private var _orbitSpeed:Number = 12;
    private var _yTopLimit:Number = 400;
    private var _yBottomLimit:Number = 0;
    private var _activate:Boolean = true;
    private var yDirection:String = "down";
    private var _sin:Number;
    private var _cos:Number;

    public function AutomaticOrbitController(param1:Camera3D, param2:DisplayObject, param3:ObjectContainer3D = null)
    {
        this._camara = param1;
        this._stage = param2;
        this._target = param3;
        this._orbitSpeed = this._orbitSpeed * 1000;
    }

    public function set target(param1:ObjectContainer3D):void
    {
        this._target = param1;
    }

    public function set distance(param1:Number):void
    {
        this._distance = param1;
    }

    public function get distance():Number
    {
        return this._distance;
    }

    public function set orbitSpeed(param1:Number):void
    {
        this._orbitSpeed = param1;
    }

    public function get orbitSpeed():Number
    {
        return this._orbitSpeed;
    }

    public function set yTopLimit(param1:Number):void
    {
        this._yTopLimit = param1;
    }

    public function set yBottomLimit(param1:Number):void
    {
        this._yBottomLimit = param1;
    }

    public function set activate(param1:Boolean):void
    {
        this._activate = param1;
    }

    public function get activate():Boolean
    {
        return this._activate;
    }

    private function mouseWheel(event:MouseEvent):void
    {
        var value:Number = this._distance - event.delta * 0.5;
        if (value < 590)
        {
            value = 590;
        }
        if (value > 950)
        {
            value = 950;
        }
        this._distance = value;
    }

    public function update():void
    {
        if (this._activate)
        {
            this._stage.addEventListener(MouseEvent.MOUSE_WHEEL, this.mouseWheel);
            this._sin = Math.sin(getTimer() / this._orbitSpeed) * this._distance;
            this._cos = Math.cos(getTimer() / this._orbitSpeed) * this._distance;
            switch (this._direction)
            {
                case "right":
                {
                    this._camara.x = this._cos;
                    this._camara.z = this._sin;
                    break;
                }
                case "left":
                {
                    this._camara.x = this._sin;
                    this._camara.z = this._cos;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._camara.y < this._yTopLimit && this.yDirection == "down")
            {
                this._camara.y = this._camara.y + 0.2;
            }
            else if (this._camara.y > (this._yTopLimit - 1) && this.yDirection == "down")
            {
                this.yDirection = "up";
            }
            else if (this._camara.y > this._yBottomLimit && this.yDirection == "up")
            {
                this._camara.y = this._camara.y - 0.2;
            }
            else if (this._camara.y < (this._yBottomLimit + 1) && this.yDirection == "up")
            {
                this.yDirection = "down";
            }
            if (this._target != null)
            {
                this._camara.lookAt(new Vector3D(this._target.x, this._target.y, this._target.z));
            }
            else
            {
                this._camara.lookAt(new Vector3D(0, 0, 0));
            }
        }
        else
        {
            this._stage.removeEventListener(MouseEvent.MOUSE_WHEEL, this.mouseWheel);
        }
    }

}
}
