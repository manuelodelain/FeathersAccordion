package com.manuelodelain.feathers.controls.accordion
{
	import feathers.controls.Button;
	import feathers.controls.Panel;

	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.events.Event;

	/**
	 * @author Manuel Odelain
	 */
	public class AccordionItem extends Panel
	{
		protected var _id:String;
		protected var _isExpanded:Boolean;
		protected var _expandedHeight:Number;
		protected var _tweenViewport:Tween;
		protected var _tweenViewportCompleteCallback:Function;
		
		public function AccordionItem()
		{
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			viewPort.height = 0;
			headerFactory = _createHeader;
			verticalScrollPolicy = horizontalScrollPolicy = SCROLL_POLICY_OFF;
		}
		
		protected function _createHeader():Button 
		{
			return null;
		}

		protected function _onTriggered(event:Event):void
		{
			_onSelect();
		}

		protected function _onSelect():void
		{
			dispatchEventWith(Event.SELECT, true, {id:_id});
		}
		
		protected function _onExpand():void
		{
		}

		protected function _onExpanded():void
		{
		}

		protected function _onCollapse():void
		{
		}

		protected function _onCollapsed():void
		{
		}

		protected function _onTweenViewportComplete():void
		{
			_tweenViewport = null;
			_tweenViewportCompleteCallback = null;
			
		}

		public function toggle() : void 
		{
			if (_isExpanded) collapse();
			else expand();
		}
		
		public function resizeViewport(viewportHeight:Number, withAnim:Boolean = true, onComplete:Function = null):void
		{
			if (withAnim) {
				if (onComplete)
					_tweenViewportCompleteCallback = onComplete;
				
				_tweenViewport = new Tween(viewPort, .5);
				_tweenViewport.animate('height', viewportHeight);
				_tweenViewport.roundToInt = true;//roundProps for fix the blink when collapsing item
				_tweenViewport.onComplete = _onTweenViewportComplete;
				Starling.current.juggler.add(_tweenViewport);
			}else{
				 viewPort.height = viewportHeight;
				 if (onComplete !== null) onComplete();
			}
		}

		public function expand(withAnim:Boolean = true):void
		{
			if (_isExpanded) return;
			
			_isExpanded = true;
			
			_onExpand();
			resizeViewport(_expandedHeight, withAnim, _onExpanded);
		}
		
		public function collapse(withAnim:Boolean = true):void
		{
			if (!_isExpanded) return;
			
			_isExpanded = false;
			
			if (_tweenViewport){
				Starling.current.juggler.remove(_tweenViewport);
				_tweenViewport = null;
			}
			
			_onCollapse();
			resizeViewport(0, withAnim, _onCollapsed);
		}

		public function get id():String
		{
			return _id;
		}

		public function set id(id:String):void
		{
			_id = id;
		}
	}
}
