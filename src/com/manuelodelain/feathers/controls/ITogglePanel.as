package com.manuelodelain.feathers.controls
{
	/**
	 * @author Manuel Odelain
	 */
	public interface ITogglePanel
	{
		function toggle() : void;
		
		function resizeViewport(viewportHeight:Number, withAnim:Boolean = true, onComplete:Function = null):void;

		function expand(withAnim:Boolean = true):void;
		
		function collapse(withAnim:Boolean = true):void;

		function get id():String;

		function set id(id:String):void;

		function get tweenDuration():Number;

		function set tweenDuration(value:Number):void;

		function get tweenEase():String;

		function set tweenEase(value:String):void;
	}
	
}
