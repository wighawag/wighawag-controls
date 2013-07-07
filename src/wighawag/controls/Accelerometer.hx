/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.controls;
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
