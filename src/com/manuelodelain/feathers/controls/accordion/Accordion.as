package com.manuelodelain.feathers.controls.accordion
{
	import feathers.layout.VerticalLayout;
	import starling.events.Event;
	import feathers.controls.ScrollContainer;

	/**
	 * @author Manuel Odelain
	 */
	public class Accordion extends ScrollContainer
	{
		protected var _items:Vector.<IAccordionItem>;
		protected var _selectedItem:IAccordionItem;
		protected var _isToggle:Boolean;
		
		public function Accordion()
		{
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			_items = new Vector.<IAccordionItem>();
			
			layout = new VerticalLayout();

			addEventListener(Event.SELECT, _onSelectItem);
		}

		protected function _onSelectItem(event:Event):void
		{
			event.stopImmediatePropagation();
			
			var item:IAccordionItem = IAccordionItem(event.target);
			
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

		public function add(item:AccordionItem):void
		{
			_items.push(item);
			item.width = explicitWidth;
			addChild(item);
		}
		
		public function remove(item:AccordionItem):void
		{
			var index:int = _items.indexOf(item);
			
			if (index === -1)
				return;
			
			_items.splice(index, 1);
			removeChild(item);
		}

		public function get isToggle():Boolean
		{
			return _isToggle;
		}

		public function set isToggle(isToggle:Boolean):void
		{
			_isToggle = isToggle;
		}

	}
}
