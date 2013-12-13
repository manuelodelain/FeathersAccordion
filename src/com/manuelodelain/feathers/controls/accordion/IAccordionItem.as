package com.manuelodelain.feathers.controls.accordion
{
	/**
	 * @author Manuel Odelain
	 */
	public interface IAccordionItem
	{
		function toggle() : void;
		
		function resizeViewport(viewportHeight:Number, withAnim:Boolean = true, onComplete:Function = null):void;

		function expand(withAnim:Boolean = true):void;
		
		function collapse(withAnim:Boolean = true):void;

		function get id():String;

		function set id(id:String):void;

		function get label():String;
		
		function set label(label:String):void;
	}
	
}
