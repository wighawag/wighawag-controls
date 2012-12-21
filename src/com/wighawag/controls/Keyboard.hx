package com.wighawag.controls;
import msignal.Signal;
interface Keyboard {
	public var onKeyDown(default, null) : Signal1<Int>;
	public var onKeyUp(default, null) : Signal1<Int>;
    public function isKeyDown(charCode : Int): Bool;
}
