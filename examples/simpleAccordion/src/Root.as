package simpleAccordion.src
{
	import feathers.controls.ScrollContainer;
	import feathers.controls.Panel;
	import feathers.layout.VerticalLayout;
	import feathers.controls.Button;
	import feathers.controls.Label;

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
			new MetalWorksMobileTheme(this, false);
			
			var accordion:Accordion = new Accordion();
			accordion.width = 400;
			accordion.isToggle = true;
			addChild(accordion);
			
			var item1:AccordionItem = new AccordionItem();
			item1.label = "Item 1";
			accordion.add(item1);
			
			var label1:Label = new Label();
			label1.text = "Utque aegrum corpus quassari etiam levibus solet offensis, ita animus eius angustus et tener, quicquid increpuisset, ad salutis suae dispendium existimans factum aut cogitatum, insontium caedibus fecit victoriam luctuosam.";
			label1.width = 350;
			label1.x = 10;
			label1.y = 10;
			item1.add(label1);
			
			var item2:AccordionItem = new AccordionItem();
			item2.label = "Item 2";
			item2.layout = new VerticalLayout();
			VerticalLayout(item2.layout).horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			VerticalLayout(item2.layout).gap = 10;
			VerticalLayout(item2.layout).paddingTop = VerticalLayout(item2.layout).paddingBottom = 10;
			accordion.add(item2);
			
			var btn1:Button = new Button();
			btn1.label = "Button 1";
			item2.add(btn1);
			
			var btn2:Button = new Button();
			btn2.label = "Button 2";
			item2.add(btn2);
		}

		public function start():void
		{
			_init();
		}
	}
}
