/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.controls;
import wighawag.controls.Accelerometer;
import flash.events.AccelerometerEvent;
import msignal.Signal;
class OpenFLAccelerometer implements Accelerometer{

    private var accelerometer : flash.sensors.Accelerometer;

    public var onData(default,null) : Signal1<AccelerometerData>;

    public function new() {
        onData = new Signal1();
        this.accelerometer = new flash.sensors.Accelerometer();
        this.accelerometer.addEventListener(AccelerometerEvent.UPDATE, onUpdate);
    }

    private var data : AccelerometerData;
    private function onUpdate(event : AccelerometerEvent) : Void{
        data = {x : event.accelerationX, y : event.accelerationY, z : event.accelerationZ, timestamp: event.timestamp};
        onData.dispatch(data);
    }

    public function setRequestedUpdateInterval(ms:Int) {
        accelerometer.setRequestedUpdateInterval(ms);
    }
}
