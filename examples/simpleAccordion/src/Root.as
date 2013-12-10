package simpleAccordion.src
{
	import feathers.controls.Button;

	import simpleAccordion.src.feathers.themes.MetalWorksMobileTheme;

	import starling.display.Sprite;
	import starling.utils.AssetManager;

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
			trace('_init: ' + (_init));
			new MetalWorksMobileTheme();
			
			var btn:Button = new Button();
			btn.label = "test";
			addChild(btn);
		}

		private function _onLoadProgress(ratio:Number):void
		{
			trace('_onLoadProgress: ' + (_onLoadProgress));
			if (ratio === 1) _onLoadComplete();
		}

		private function _onLoadComplete():void
		{
			trace('_onLoadComplete: ' + (_onLoadComplete));
		}

		public function start(assets:AssetManager):void
		{
			_assets = assets;
			_assets.loadQueue(_onLoadProgress);
			
			_init();
		}
	}
}
