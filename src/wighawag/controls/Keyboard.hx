/****
* Wighawag License:
* - free to use for commercial and non commercial application
* - provided the modification done to it are given back to the community
* - use at your own risk
* 
****/

package wighawag.controls;
import msignal.Signal;
interface Keyboard {
	public var onKeyDown(default, null) : Signal1<Int>;
	public var onKeyUp(default, null) : Signal1<Int>;
    public function isKeyDown(keyCode : Int): Bool;
}
