/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.controls;
import haxe.Timer;
import wighawag.controls.Accelerometer;
import msignal.Signal;
class FakeAccelerometer implements Accelerometer {

    public var onData(default,null) : Signal1<AccelerometerData>;

    private var keyboard : Keyboard;
    private var timer : Timer;

    public function new(keyboard : Keyboard) {
        this.keyboard = keyboard;
        onData = new Signal1();
        timer = new Timer(20);
        timer.run = this.updateData;
    }

    private function updateData() : Void{
        //TODO fill CPP BUG when not Type declaration for this three float (fill a bug)
        var x : Float = -0.4; //neutral // TODO get it from Controller settings
        var y : Float = 0.0;
        var z : Float = 0.0;
        var timestamp : Float = Timer.stamp() / 1000;

	    if (keyboard == null){
		    var stage = flash.Lib.current.stage;
		    var computedX :Float = (stage.mouseX - stage.stageWidth /2) /(stage.stageWidth/2);
		    var computedY :Float = - (stage.mouseY - stage.stageHeight /2) /(stage.stageHeight/2);
		    onData.dispatch( {x : computedY, y : - computedX, z : 0, timestamp : Timer.stamp() / 1000});
	    }else{
		    if (keyboard.isKeyDown(Key.LEFT)){
			    y = 1;
		    }else if(keyboard.isKeyDown(Key.RIGHT)){
			    y = -1;
		    }

		    if (keyboard.isKeyDown(Key.UP)){
			    x = 1;
		    }else if(keyboard.isKeyDown(Key.DOWN)){
			    x = -1;
		    }

		    onData.dispatch({x:x,y:y,z:0,timestamp:timestamp});
	    }
    }

    public function setRequestedUpdateInterval(ms:Int):Void {
        if(timer != null){
            timer.stop();
        }
        timer = new Timer(ms);
        timer.run = updateData;
    }



}
