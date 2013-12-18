package com.manuelodelain.feathers.controls
{
	import starling.display.DisplayObject;
	import feathers.layout.VerticalLayout;
	import starling.events.Event;
	import feathers.controls.ScrollContainer;

	/**
	 * @author Manuel Odelain
	 */
	public class Accordion extends ScrollContainer
	{
		protected var _items:Vector.<ITogglePanel> = new Vector.<ITogglePanel>();
		protected var _selectedItem:ITogglePanel;
		protected var _isToggle:Boolean;
		protected var _tweenDuration:Number;
		protected var _tweenEase:String;
		protected var _expandDuration:Number = TogglePanel.TWEEN_DURATION;
		protected var _collapseDuration:Number = TogglePanel.TWEEN_DURATION;
		protected var _expandEase:String = TogglePanel.TWEEN_EASE;
		protected var _collapseEase:String = TogglePanel.TWEEN_EASE;
		
		public function Accordion()
		{
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			layout = new VerticalLayout();

			addEventListener(Event.SELECT, _onSelectItem);
		}

		protected function _onSelectItem(event:Event):void
		{
			event.stopImmediatePropagation();
			
			var item:ITogglePanel = ITogglePanel(event.target);
			
			if (item === _selectedItem) {
				_selectedItem.collapse();
				_selectedItem = null;
				return;
			}
			
			if (_isToggle && _selectedItem) _selectedItem.collapse();
				
			_selectedItem = item;
			
			item.expand();
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			_items.length = 0;
			_items = null;
			
			_selectedItem = null;
		}

		public function add(item:ITogglePanel):void
		{
			_items.push(item);
			
			item.expandDuration = _expandDuration;
			item.expandEase = _expandEase;
			item.collapseDuration = _expandDuration;
			item.collapseEase = _collapseEase;
			if (!isNaN(_tweenDuration)) item.tweenDuration = _tweenDuration;
			if (!_tweenEase) item.tweenEase = _tweenEase;
			
			DisplayObject(item).width = explicitWidth;
			
			addChild(DisplayObject(item));
		}
		
		public function remove(item:ITogglePanel):void
		{
			var index:int = _items.indexOf(item);
			
			if (index === -1) return;
			
			_items.splice(index, 1);
			removeChild(DisplayObject(item));
		}

		public function get isToggle():Boolean
		{
			return _isToggle;
		}

		public function set isToggle(isToggle:Boolean):void
		{
			_isToggle = isToggle;
		}

		public function get tweenDuration():Number
		{
			return _tweenDuration;
		}

		public function set tweenDuration(value:Number):void
		{
			_tweenDuration = value;
			
			var n:int = _items.length;
			
			for (var i:int = 0; i < n; i++){
				_items[i].tweenDuration = _tweenDuration;
			}
		}

		public function get tweenEase():String
		{
			return _tweenEase;
		}

		public function set tweenEase(value:String):void
		{
			_tweenEase = value;
			
			var n:int = _items.length;
			
			for (var i:int = 0; i < n; i++){
				_items[i].tweenEase = _tweenEase;
			}
		}

		public function get expandDuration():Number
		{
			return _expandDuration;
		}

		public function set expandDuration(value:Number):void
		{
			_expandDuration = value;
			
			var n:int = _items.length;
			
			for (var i:int = 0; i < n; i++){
				_items[i].expandDuration = _expandDuration;
			}
		}

		public function get collapseDuration():Number
		{
			return _collapseDuration;
		}

		public function set collapseDuration(value:Number):void
		{
			_collapseDuration = value;
			
			var n:int = _items.length;
			
			for (var i:int = 0; i < n; i++){
				_items[i].collapseDuration = _collapseDuration;
			}
		}

		public function get expandEase():String
		{
			return _expandEase;
		}

		public function set expandEase(value:String):void
		{
			_expandEase = value;
			
			var n:int = _items.length;
			
			for (var i:int = 0; i < n; i++){
				_items[i].expandEase = _expandEase;
			}
		}

		public function get collapseEase():String
		{
			return _collapseEase;
		}

		public function set collapseEase(value:String):void
		{
			_collapseEase = value;
			
			var n:int = _items.length;
			
			for (var i:int = 0; i < n; i++){
				_items[i].collapseEase = _collapseEase;
			}
		}

	}
}
