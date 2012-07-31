package controllers
{
import away3d.cameras.*;
import away3d.containers.*;
import away3d.controllers.*;
import flash.display.*;
import flash.events.*;

public class OrbitControllerExtended extends Object
{
    private var _camera:Camera3D;
    private var _stage:DisplayObject;
    private var _target:ObjectContainer3D;
    private var isMouseDown:Boolean = false;
    private var lastPanAngle:Number;
    private var lastTiltAngle:Number;
    private var lastMouseX:Number;
    private var lastMouseY:Number;
    public var fov:Number = 800;
    public var mainController:HoverController;
    private var _activate:Boolean = true;

    public function OrbitControllerExtended(param1:Camera3D, param2:DisplayObject, param3:ObjectContainer3D = null)
    {
        this._camera = param1;
        this._stage = param2;
        this._target = param3;
        this.mainController = new HoverController(this._camera, this._target, 180, 20, this.fov, 0, 35, NaN, NaN, 6, 1);
    }

    public function set activate(param1:Boolean):void
    {
        this._activate = param1;
    }

    public function get activate():Boolean
    {
        return this._activate;
    }

    private function activateController(param1:Boolean):void
    {
        if (param1)
        {
            this._stage.addEventListener(MouseEvent.MOUSE_DOWN, this.stageMouseDown);
            this._stage.addEventListener(MouseEvent.MOUSE_UP, this.stageMouseUp);
            this._stage.addEventListener(MouseEvent.MOUSE_WHEEL, this.stageMouseWheel);
        }
        else
        {
            this._stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.stageMouseDown);
            this._stage.removeEventListener(MouseEvent.MOUSE_UP, this.stageMouseUp);
            this._stage.removeEventListener(MouseEvent.MOUSE_WHEEL, this.stageMouseWheel);
        }
    }

    private function stageMouseDown(event:MouseEvent):void
    {
        this.lastPanAngle = this.mainController.panAngle;
        this.lastTiltAngle = this.mainController.tiltAngle;
        this.lastMouseX = this._stage.mouseX;
        this.lastMouseY = this._stage.mouseY;
        this.isMouseDown = true;
    }

    private function stageMouseUp(event:MouseEvent):void
    {
        this.isMouseDown = false;
    }

    private function stageMouseWheel(event:MouseEvent):void
    {
        var value:Number = this.fov - event.delta / 0.5;
        if (value < 590)
        {
            value = 590;
        }
        if (value > 950)
        {
            value = 950;
        }
        this.fov = value;
    }

	/**
	 * CarDemo.renderScene调用 
	 * 
	 */	
    public function update():void
    {
        if (this._activate)
        {
            this.activateController(true);
            this.mainController.update();
            this.mainController.distance = this.mainController.distance + (this.fov - this.mainController.distance) / 8;
            if (this.isMouseDown)
            {
                this.mainController.panAngle = 0.3 * (this._stage.mouseX - this.lastMouseX) + this.lastPanAngle;
                this.mainController.tiltAngle = 0.3 * (this._stage.mouseY - this.lastMouseY) + this.lastTiltAngle;
            }
        }
        else
        {
            this.activateController(false);
        }
    }

}
}
