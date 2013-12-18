package com.manuelodelain.feathers.controls
{
	/**
	 * @author Manuel Odelain
	 */
	public interface ITogglePanel
	{
		function toggle() : void;
		
		function resizeViewport(viewportHeight:Number, withAnim:Boolean = true, options:Object = null):void;

		function expand(withAnim:Boolean = true):void;
		
		function collapse(withAnim:Boolean = true):void;

		function get id():String;

		function set id(id:String):void;

		function get label():String;
		
		function set label(label:String):void;
		
		function get expandDuration():Number;

		function set expandDuration(value:Number):void;

		function get collapseDuration():Number;

		function set collapseDuration(value:Number):void;

		function get expandEase():String;

		function set expandEase(value:String):void;

		function get collapseEase():String;

		function set collapseEase(value:String):void;

		function get tweenDuration():Number;

		function set tweenDuration(value:Number):void;

		function get tweenEase():String;

		function set tweenEase(value:String):void;
	}
	
}
