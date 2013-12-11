package simpleAccordion.src
{
	import simpleAccordion.src.feathers.themes.MetalWorksMobileTheme;

	import starling.display.Sprite;
	import starling.utils.AssetManager;

	import com.manuelodelain.feathers.controls.accordion.Accordion;
	import com.manuelodelain.feathers.controls.accordion.AccordionItem;

	/**
	 * @author Manuel Odelain
	 */
	public class Root extends Sprite
	{
		protected var _assets:AssetManager;
		
		public function Root()
		{
		}

		private function _init():void
		{
			new MetalWorksMobileTheme();
			
			var accordion:Accordion = new Accordion();
			addChild(accordion);
			
			var item1:AccordionItem = new AccordionItem();
			item1.label = "Item 1";
			accordion.add(item1);
			
			var item2:AccordionItem = new AccordionItem();
			item2.label = "Item 2";
			accordion.add(item2);
		}

		public function start():void
		{
			_init();
		}
	}
}
