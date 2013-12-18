package com.manuelodelain.feathers.controls
{
	import feathers.controls.Button;
	import feathers.controls.Panel;
	import feathers.controls.ScrollContainer;

	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Event;

	/**
	 * @author Manuel Odelain
	 */
	public class TogglePanel extends Panel implements ITogglePanel
	{
		public static const HEADER_NAME:String = "accordionItemHeader";
		public static const TWEEN_DURATION:Number = 0.5;
		public static const TWEEN_EASE:String = Transitions.EASE_OUT;
		
		protected var _id:String;
		protected var _label:String;
		protected var _tweenDuration:Number;
		protected var _tweenEase:String;
		protected var _expandDuration:Number = TWEEN_DURATION;
		protected var _collapseDuration:Number = TWEEN_DURATION;
		protected var _expandEase:String = TWEEN_EASE;
		protected var _collapseEase:String = TWEEN_EASE;
		protected var _header:Button;
		protected var _isExpanded:Boolean; 
		protected var _tweenViewport:Tween;
		protected var _tweenViewportCompleteCallback:Function;
		protected var _container:ScrollContainer = new ScrollContainer();
		
		public function TogglePanel()
		{
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			_container.verticalScrollPolicy = _container.horizontalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;
			addChild(_container);
			if (_container.numChildren) _container.validate();
			
			viewPort.height = 0;
			headerFactory = _createHeader;
			verticalScrollPolicy = horizontalScrollPolicy = SCROLL_POLICY_OFF;
		}
		
		protected function _createHeader():Button 
		{
			_header = new Button();
			_header.nameList.add(HEADER_NAME);
			_header.addEventListener(Event.TRIGGERED, _onHeaderTriggered);
			if (_label) _header.label = _label;
			
			return _header;
		}
		
		override protected function draw():void
		{
			super.draw();
			
			if (isInvalid(INVALIDATION_FLAG_LAYOUT))
				_container.layout = layout;
		}

		protected function _onHeaderTriggered(event:Event):void
		{
			_onSelect();
		}

		protected function _onSelect():void
		{
			dispatchEventWith(Event.SELECT, true, {id:_id});
		}
		
		protected function _onExpandStart():void
		{
		}

		protected function _onExpandComplete():void
		{
		}

		protected function _onCollapseStart():void
		{
		}

		protected function _onCollapseComplete():void
		{
		}

		protected function _onTweenViewportComplete():void
		{
			_tweenViewport = null;
			_tweenViewportCompleteCallback = null;
		}

		public function add(child:DisplayObject):void
		{
			_container.addChild(child);
			if (_container.parent) _container.validate();
		}

		public function toggle() : void 
		{
			if (_isExpanded) collapse();
			else expand();
		}
		
		public function resizeViewport(viewportHeight:Number, withAnim:Boolean = true, options:Object = null):void
		{
			var onComplete:Function = (options && options.onComplete) ? options.onComplete : null;
			
			if (withAnim) {
				var duration:Number = (options && options.duration) ? options.duration : TWEEN_DURATION;
				var ease:String = (options && options.ease) ? options.ease : TWEEN_EASE;
				
				if (onComplete !== null) _tweenViewportCompleteCallback = onComplete;
				
				_tweenViewport = new Tween(viewPort, duration, ease);
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
			
			_onExpandStart();
			resizeViewport(_container.height, withAnim, {onComplete:_onExpandComplete, duration:_expandDuration, ease:_expandEase});
		}
		
		public function collapse(withAnim:Boolean = true):void
		{
			if (!_isExpanded) return;
			
			_isExpanded = false;
			
			if (_tweenViewport){
				Starling.current.juggler.remove(_tweenViewport);
				_tweenViewport = null;
			}
			
			_onCollapseStart();
			resizeViewport(0, withAnim, {onComplete:_onCollapseComplete, duration:_collapseDuration, ease:_collapseEase});
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			if (_tweenViewport){
				Starling.current.juggler.remove(_tweenViewport);
				_tweenViewport = null;
			}
			
			_header = null;
			_tweenViewportCompleteCallback = null;
		}

		public function get id():String
		{
			return _id;
		}

		public function set id(id:String):void
		{
			_id = id;
		}

		public function get label():String
		{
			return _label;
		}

		public function set label(label:String):void
		{
			_label = label;
		}

		public function get expandDuration():Number
		{
			return _expandDuration;
		}

		public function set expandDuration(value:Number):void
		{
			_expandDuration = value;
		}

		public function get collapseDuration():Number
		{
			return _collapseDuration;
		}

		public function set collapseDuration(value:Number):void
		{
			_collapseDuration = value;
		}

		public function get expandEase():String
		{
			return _expandEase;
		}

		public function set expandEase(value:String):void
		{
			_expandEase = value;
		}

		public function get collapseEase():String
		{
			return _collapseEase;
		}

		public function set collapseEase(value:String):void
		{
			_collapseEase = value;
		}

		public function get tweenDuration():Number
		{
			return _tweenDuration;
		}

		public function set tweenDuration(value:Number):void
		{
			_tweenDuration = value;
			expandDuration = collapseDuration = _tweenDuration;
		}

		public function get tweenEase():String
		{
			return _tweenEase;
		}

		public function set tweenEase(value:String):void
		{
			_tweenEase = value;
			expandEase = collapseEase = _tweenEase;
		}
	}
}
