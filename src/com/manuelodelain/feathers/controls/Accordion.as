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
		
		public function Accordion()
		{
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			layout = new VerticalLayout();
		}

		protected function _onChange():void
		{
			dispatchEventWith(Event.CHANGE);
		}

		protected function _onChangeItem(event:Event):void
		{
			var item:ITogglePanel = ITogglePanel(event.target);
			
			if (item === _selectedItem) {
				_selectedItem.collapse();
				_selectedItem = null;
				return;
			}
			
			if (_isToggle && _selectedItem) _selectedItem.collapse();
				
			_selectedItem = item;
			
			item.expand();
			_onChange();
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
			
			if (!isNaN(_tweenDuration)) item.tweenDuration = _tweenDuration;
			if (_tweenEase) item.tweenEase = _tweenEase;
			
			DisplayObject(item).width = explicitWidth;
			DisplayObject(item).addEventListener(Event.CHANGE, _onChangeItem);
			
			addChild(DisplayObject(item));
		}
		
		public function remove(item:ITogglePanel):void
		{
			var index:int = _items.indexOf(item);
			
			if (index === -1) return;
			
			_items.splice(index, 1);
			DisplayObject(item).removeEventListener(Event.CHANGE, _onChangeItem);
			removeChild(DisplayObject(item));
		}

		public function get isToggle():Boolean
		{
			return _isToggle;
		}

		public function set isToggle(value:Boolean):void
		{
			_isToggle = value;
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

		public function get selectedItem():ITogglePanel
		{
			return _selectedItem;
		}

		public function get items():Vector.<ITogglePanel>
		{
			return _items;
		}
	}
}
