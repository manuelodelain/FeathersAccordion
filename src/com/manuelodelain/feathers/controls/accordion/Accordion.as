package com.manuelodelain.feathers.controls.accordion
{
	import starling.events.Event;
	import feathers.controls.ScrollContainer;

	/**
	 * @author Manuel Odelain
	 */
	public class Accordion extends ScrollContainer
	{
		protected var _items:Vector.<AccordionItem>;
		
		public function Accordion()
		{
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			_items = new Vector.<AccordionItem>();

			addEventListener(Event.SELECT, _onSelectItem);
		}

		protected function _onSelectItem(event:Event):void
		{
			event.stopImmediatePropagation();
		}

		public function add(item:AccordionItem):void
		{
			_items.push(item);
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
	}
}
