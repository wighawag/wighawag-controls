package com.wighawag.controls;
import com.wighawag.controls.Accelerometer;
import nme.events.AccelerometerEvent;
import msignal.Signal;
class NMEAccelerometer implements Accelerometer{

    private var accelerometer : nme.sensors.Accelerometer;

    public var onData(default,null) : Signal1<AccelerometerData>;

    public function new() {
        onData = new Signal1();
        this.accelerometer = new nme.sensors.Accelerometer();
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
