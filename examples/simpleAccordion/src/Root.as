package simpleAccordion.src
{
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
		}
	}
}
