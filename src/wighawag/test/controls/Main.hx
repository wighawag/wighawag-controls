/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.test.controls;

import wighawag.controls.OpenFLKeyboard;
import wighawag.controls.Key;
import wighawag.controls.Keyboard;
import flash.events.Event;
class Main extends flash.display.Sprite{

    private var keyboard : Keyboard;

    static public function main() : Void{
        var app = new Main();
        flash.Lib.current.addChild(app);
    }

    public function new() {
        super();
        this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
    }

    private function addedToStage(event : Event) : Void{
        keyboard = new OpenFLKeyboard();

        addEventListener(Event.ENTER_FRAME, enterFrame);
    }

    private function enterFrame(event : Event) : Void{
        trace("Key.LEFT : " , keyboard.isKeyDown(Key.LEFT));
        if(keyboard.isKeyDown(Key.LEFT)){
            stage.color = 0x000000;
        }else{
            stage.color = 0xFFFFFF;
        }
    }

}
