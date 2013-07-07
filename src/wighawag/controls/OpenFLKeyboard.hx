/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.controls;

import flash.events.KeyboardEvent;
import flash.Lib;
import msignal.Signal;

class OpenFLKeyboard implements Keyboard{

    private var keysPressed : Map<Int,Bool>;

    public function new() {
        keysPressed = new Map();

        onKeyDown = new Signal1();
        onKeyUp = new Signal1();

        Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDown);
        Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP,keyUp);
    }

    private function keyDown(event : KeyboardEvent):Void{
        keysPressed.set(event.keyCode,true);
    }

    private function keyUp(event : KeyboardEvent):Void{
        keysPressed.remove(event.keyCode);
    }

    public var onKeyDown:Signal1<Int>;

    public var onKeyUp:Signal1<Int>;

    public function isKeyDown(keyCode:Int):Bool {
        return keysPressed.exists(keyCode);
    }


}
