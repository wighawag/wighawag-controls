package com.wighawag.controls;
import msignal.Signal;

typedef AccelerometerData = {
    x : Float,
    y: Float,
    z : Float,
    timestamp : Float
}

// Constants used for network communication
class AccelerometerNetworkData {
	public static var TYPE = "AccelerometerData";
}

interface Accelerometer {
    var onData(default,null) : Signal1<AccelerometerData>;
    function setRequestedUpdateInterval(ms : Int) : Void;
}
