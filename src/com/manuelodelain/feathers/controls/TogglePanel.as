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

	import com.manuelodelain.feathers.events.TogglePanelEventType;

	/**
	 * @author Manuel Odelain
	 */
	public class TogglePanel extends Panel implements ITogglePanel
	{
		public static const HEADER_NAME:String = "accordionItemHeader";
		public static const TWEEN_DURATION:Number = 0.5;
		public static const TWEEN_EASE:String = Transitions.EASE_OUT;
		
		protected var _id:String;
		protected var _isSelected:Boolean; 
		protected var _tweenDuration:Number = TWEEN_DURATION;
		protected var _tweenEase:String = TWEEN_EASE;
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
			if (!headerFactory) headerFactory = _defaultHeaderFactory;
		}
		
		protected function _defaultHeaderFactory():Button 
		{
			var header:Button = new Button();
			header.nameList.add(HEADER_NAME);
			header.addEventListener(Event.TRIGGERED, _onHeaderTriggered);
			header.label = headerProperties.title;
			
			return header;
		}
		
		override protected function draw():void
		{
			super.draw();
			
			if (isInvalid(INVALIDATION_FLAG_LAYOUT))
				_container.layout = layout;
		}

		protected function _onHeaderTriggered(event:Event):void
		{
			_onChange();
		}

		protected function _onChange():void
		{
			dispatchEventWith(Event.CHANGE);
		}
		
		protected function _onExpandStart():void
		{
			dispatchEventWith(TogglePanelEventType.EXPAND_START);
		}

		protected function _onExpandComplete():void
		{
			dispatchEventWith(TogglePanelEventType.EXPAND_COMPLETE);
		}

		protected function _onCollapseStart():void
		{
			dispatchEventWith(TogglePanelEventType.COLLAPSE_START);
		}

		protected function _onCollapseComplete():void
		{
			dispatchEventWith(TogglePanelEventType.COLLAPSE_COMPLETE);
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
			if (_isSelected) collapse();
			else expand();
		}
		
		public function resizeViewport(viewportHeight:Number, withAnim:Boolean = true, onComplete:Function = null):void
		{
			if (withAnim) {
				if (onComplete !== null) _tweenViewportCompleteCallback = onComplete;
				
				_tweenViewport = new Tween(viewPort, _tweenDuration, _tweenEase);
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
			if (_isSelected) return;
			
			_isSelected = true;
			
			_onExpandStart();
			resizeViewport(_container.height, withAnim, _onExpandComplete);
		}
		
		public function collapse(withAnim:Boolean = true):void
		{
			if (!_isSelected) return;
			
			_isSelected = false;
			
			if (_tweenViewport){
				Starling.current.juggler.remove(_tweenViewport);
				_tweenViewport = null;
			}
			
			_onCollapseStart();
			resizeViewport(0, withAnim, _onCollapseComplete);
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			if (_tweenViewport){
				Starling.current.juggler.remove(_tweenViewport);
				_tweenViewport = null;
			}
			
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

		public function get tweenDuration():Number
		{
			return _tweenDuration;
		}

		public function set tweenDuration(value:Number):void
		{
			_tweenDuration = value;
		}

		public function get tweenEase():String
		{
			return _tweenEase;
		}

		public function set tweenEase(value:String):void
		{
			_tweenEase = value;
		}

		public function get isSelected():Boolean
		{
			return _isSelected;
		}
	}
}
