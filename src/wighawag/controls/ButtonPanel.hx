/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.controls;
import wighawag.controls.StageButtonPanel;
import msignal.Signal;

class ButtonPanelNetworkData{
	// Constants used for network communication
	public static var TYPE : String = "ButtonPanel";
	public static var BUTTON_RELEASE : Int = 0;
	public static var BUTTON_PRESS : Int = 1;
}


typedef ButtonPlacement = {
	x : Float,
	y: Float,
	radius : Float
};


interface ButtonPanel {
	public var onButtonPressed(default, null) : Signal1<Int>;
	public var onButtonReleased(default, null) : Signal1<Int>;
    function isButtonPressed(buttonId : Int) : Bool;
}
