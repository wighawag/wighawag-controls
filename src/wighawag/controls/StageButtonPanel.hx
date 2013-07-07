/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.controls;

import flash.display.Stage;
import flash.events.MouseEvent;
import flash.events.TouchEvent;
import flash.ui.Multitouch;
import msignal.Signal;
import de.polygonal.ds.IntHashSet;

import wighawag.controls.ButtonPanel;

class StageButtonPanel implements ButtonPanel{

	public var onButtonPressed(default, null) : Signal1<Int>;
	public var onButtonReleased(default, null) : Signal1<Int>;
	public var buttonPlacements(default,null) : Array<ButtonPlacement>;

	private var buttonsState : IntHashSet;
	private var currentlyPressedList : Array<Int>; //so that we can cancel them dispatch release

	private var stage : Stage;
    public function new(buttons : Array<ButtonPlacement>) {
	    onButtonPressed = new Signal1();
	    onButtonReleased = new Signal1();
	    currentlyPressedList = new Array();

	    this.stage = flash.Lib.current.stage;
	    this.buttonPlacements = buttons;
	    buttonsState = new IntHashSet(nextPowOf2(buttons.length));


	    if(Multitouch.supportsTouchEvents){
		    stage.addEventListener(TouchEvent.TOUCH_BEGIN,onTouchBegin);
	    }else{
		    stage.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
	    }
    }

	// TODO move this into utils
	private function nextPowOf2(n : Int) : Int{
		n--;
		n |= n >> 1;
		n |= n >> 2;
		n |= n >> 4;
		n |= n >> 8;
		n |= n >> 16;
		n++;
		return n;
	}

	private function onTouchBegin(event : TouchEvent) : Void{
		stage.removeEventListener(TouchEvent.TOUCH_BEGIN,onTouchBegin);
		stage.addEventListener(TouchEvent.TOUCH_END,onTouchEnd);
		process(stage.mouseX, stage.mouseY);
	}

	private function onTouchEnd(event : TouchEvent) : Void{
		stage.removeEventListener(TouchEvent.TOUCH_END, onTouchEnd);
		stage.addEventListener(TouchEvent.TOUCH_BEGIN,onTouchBegin);
		buttonsState.clear();       // TODO check multi touch ?
		for(buttonId in currentlyPressedList){
			onButtonReleased.dispatch(buttonId);
		}
		currentlyPressedList = new Array();
	}


	private function onMouseDown(event : MouseEvent) : Void{
		stage.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
		stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
		process(stage.mouseX, stage.mouseY);
	}

	private function onMouseUp(event : MouseEvent) : Void{
		stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
		stage.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
		buttonsState.clear();
		for(buttonId in currentlyPressedList){
			onButtonReleased.dispatch(buttonId);
		}
		currentlyPressedList = new Array();
	}

	private function process(x : Float, y : Float) : Void{
		// TODO optimize with quad tree or grid?
		var counter : Int = 1; // start with index 1
		for(buttonPlacement in buttonPlacements){
			var diffX = stage.mouseX - buttonPlacement.x;
			var diffY = stage.mouseY - buttonPlacement.y;
			var distance = Math.sqrt(diffX * diffX + diffY * diffY);
			if (distance < buttonPlacement.radius){
				buttonsState.set(counter);
				currentlyPressedList.push(counter);
				onButtonPressed.dispatch(counter);
			}
			counter ++;
		}
	}

	public function isButtonPressed(buttonId:Int):Bool {
		return buttonsState.hasFront(buttonId);
	}

	public function dispose() : Void{
		if(Multitouch.supportsTouchEvents){
			stage.removeEventListener(TouchEvent.TOUCH_BEGIN,onTouchBegin);
			stage.removeEventListener(TouchEvent.TOUCH_END,onTouchEnd);
		}else{
			stage.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
		}
		buttonPlacements = null;
		buttonsState = null;
	}


}
